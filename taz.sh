#!/bin/bash

################################################################################
#
#   This simple script gets a Drupal 7 site installed in seconds:
#
#   * Starts by fetching & building the makefile; taz.make
#
#   * Automatically creates private file directory and contrib/custom modules
#     subdirectories.
#
#   * Creates mysql user and database (if necessary) and sets permissions
#
#   * Asks for site name, email and url and installs the site using the Taz
#     profile
#
#   * Makes settings.php read-only
#
#   * Moves files folder to "sites" root (optional)
#
#   * Choose between Search API or Core Drupal Search and download extra modules
#
#   * Downloads modules for multilingual sites (optional)
#
#   * Downloads and creates subthemes for Omega, Zen or Aurora
#
#   * Opens the website on password recovery screen
#
#   The entire process only takes a few seconds and can save your team hours
#   of work, time and time again.
#
#   Be awesome: Use it with Vagrant.
#
################################################################################

##################
### Drush Make ###
##################

read -p "Download makefile and build website using Drush make? (y/n) " RESP
if [ "$RESP" = "y" ]; then

  if [ ! -f taz.make ]; then
    curl -0 https://raw.github.com/alexweber/Taz/bin/taz.make > taz.make
  fi

  drush make taz.make .

  # Remove profile's default .gitignore (used for dev only)
  rm -rf profiles/taz/.gitignore
fi

#################################
### Directories & Permissions ###
#################################

# Create modules contrib subdirectory.
if [ ! -d "sites/all/modules/contrib" ]; then
  mkdir sites/all/modules/contrib
fi

# Create modules custom subdirectory.
if [ ! -d "sites/all/modules/custom" ]; then
  mkdir sites/all/modules/custom
fi

# Create private files directory.
if [ ! -d "private" ]; then
  mkdir private
  chmod -R 777 private
fi

# Set permissions on private files directory.
chmod -R 777 private

#############################
### MySQL User & Database ###
#############################

read -p "Setup MySQL database and user? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  # Get Drupal database user.
  read -p "Enter your Drupal database user [taz]: " DBUSER
  DBUSER=${DBUSER:-taz}

  # Get Drupal database password.
  read -p "Enter your Drupal database password [taz123]: " DBPASS
  DBPASS=${DBPASS:-taz123}

  # Get Drupal database name.
  read -p "Enter your Drupal database name [taz]: " DBNAME
  DBNAME=${DBNAME:-taz}

  read -p "Create Drupal database user? (y/n) " RESP
  if [ "$RESP" = "y" ]; then
    # Get MySQL root username.
    read -p "Enter your MySQL root user: " MYROOT

    # Get MySQL root password (hidden user input).
    echo "Enter your MySQL root password:"
    stty -echo
    read MYPASS
    stty echo

    # Create user.
    mysql -u$MYROOT -p$MYPASS -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBUSER';"
    mysql -u$MYROOT -p$MYPASS -e "GRANT USAGE ON * . * TO '$DBUSER'@'localhost';"

    # Create database.
    mysql -u$MYROOT -p$MYPASS -e "CREATE DATABASE IF NOT EXISTS $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

    # Set permissions.
    mysql -u$MYROOT -p$MYPASS -e "GRANT ALL PRIVILEGES ON $DBNAME .* TO '$DBUSER'@'localhost';"
  fi

  ####################
  ### Install site ###
  ####################

  read -p "Install site? (y/n) " RESP
  if [ "$RESP" = "y" ]; then
    DIRNAME=${PWD##*/}

    # Get site name.
    read -p "Enter your site name [Taz]: " SITENAME
    SITENAME=${SITENAME:-Taz}

    # Get site email.
    read -p "Enter your site email [alexweber15@gmail.com]: " EMAIL
    EMAIL=${EMAIL:-alexweber15@gmail.com}

    # Get site vhost.
    read -p "Enter your site's virtual host [$DIRNAME]: " VHOST
    VHOST=${VHOST:-$DIRNAME}

    # Install site.
    drush si taz --db-url=mysql://$DBUSER:$DBPASS@127.0.0.1/$DBNAME --account-name="User One" --account-pass="$DBUSER" --account-mail="$EMAIL" --site-name="$SITENAME"

    # Make settings read-only.
    chmod 644 sites/default/settings.php

    # Display message.
    echo "Drupal has been installed! User #1 is 'User One' and password is '$DBUSER'."
    echo "Please change your password!"

    ################################
    ### Refactor files directory ###
    ################################

    read -p "Move files directory to sites root? Note: This will prompt you for your root password. (y/n): " RESP
    if [ "$RESP" = "y" ]; then
      sudo mv sites/default/files sites
      sudo chmod -R 777 sites/files
      drush vset file_public_path "sites/files" -l $VHOST
    fi

    ####################
    ### Search Setup ###
    ####################

    read -p "Use Search API? (y/n): " RESP
    if [ "$RESP" = "y" ]; then
      drush dl search_api search_api_solr search_api_db search_api_page facetapi --destination=profiles/taz/modules/contrib -y
      drush en search_api -y
    else
      drush dl search404 search_config --destination=profiles/taz/modules/contrib -y
      drush en search -y
    fi

    ##################
    ### i18n Setup ###
    ##################

    read -p "Setup multilingual site? (y/n): " RESP
    if [ "$RESP" = "y" ]; then
      drush dl i18n l10n_update language_cookie languageicons i18nviews translation_overview l10n_client i18n_contrib --destination=profiles/taz/modules/contrib -y
      drush en i18n l10n_update -y
    fi

    ###################
    ### Theme Setup ###
    ###################

    read -p "Pick a base theme: Omega (o), Zen (z), Aurora (a) or None (n) [z]: " BASETHEME
    BASETHEME=${BASETHEME:-z}

    if [ "$BASETHEME" = "z" ]; then
        drush dl zen --destination=profiles/taz/themes
    elif [ "$BASETHEME" = "o" ]; then
      drush dl omega --destination=profiles/taz/themes
      drush dl omega_tools delta --destination=profiles/taz/modules/contrib
    elif [ "$BASETHEME" = "a" ]; then
      drush dl aurora --destination=profiles/taz/themes
    fi

    if [ "$BASETHEME" != "n" ]; then
      read -p "Create a Subtheme? (y/n) " RESP
      if [ "$RESP" = "y" ]; then
        read -p "Enter your subtheme machine name [taz_theme]: " SUBTHEME
        SUBTHEME=${SUBTHEME:-taz_theme}

        if [ "$BASETHEME" = "z" ]; then
          drush zen "$SUBTHEME" --without-rtl -y
        elif [ "$BASETHEME" = "o" ]; then
          drush en omega_tools -y
          drush omega-subtheme "$SUBTHEME" -y
        elif [ "$BASETHEME" = "a" ]; then
          read -p "Pick a grid system: Susy (su), Singularity (si) or None (n) [su] (Requires Aurora Compass extension): " AURORAGRID
          AURORAGRID=${AURORAGRID:-su}

          if [ "$AURORAGRID" = "su" ]; then
            compass create "$SUBTHEME" -r aurora --using aurora/susy
          elif [ "$AURORAGRID" = "si" ]; then
            compass create "$SUBTHEME" -r aurora --using aurora/singularity
          else
            compass create "$SUBTHEME" -r aurora --using aurora
          fi
        fi
      fi
    fi

    # Login as admin.
    open `drush user-login "User One" -l $VHOST`
  fi
fi

# Remove the scripts when we're done.

if [ -f taz.make ]; then
  rm taz.make
fi

rm $0