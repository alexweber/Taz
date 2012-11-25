#!/bin/bash

################################################################################
#
#   This simple script gets a Drupal 7 site installed in seconds:
#
#   * Starts by building the makefile; taz.make
#
#   * Automatically creates private file directory and contrib/custom modules
#     subdirectories.
#
#   * Creates mysql user and database (if necessary) and sets permissions
#
#   * Asks for site name, email and url
#
#   * Installs the site using the Taz profile
#
#   * Makes settings.php read-only
#
#   * Asks for theme name and creates Omega or Zen Subtheme
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
    drush si taz --db-url=mysql://$DBUSER:$DBPASS@127.0.0.1/$DBNAME --account-name="User One" --account-pass=$DBUSER --account-mail=$EMAIL --site-name=$SITENAME

    # Make settings read-only.
    chmod 644 sites/default/settings.php

    # Display message.
    echo "Drupal has been installed! User #1 is 'User One' and password is '$DBUSER'."
    echo "Please change your password!"

    ################################
    ### Refactor files directory ###
    ################################

    sudo mv sites/default/files sites
    drush vset file_public_path "sites/files" -l $VHOST

    #######################
    ### Create Subtheme ###
    #######################

    read -p "Create a Subtheme? (y/n) " RESP
    if [ "$RESP" = "y" ]; then
      read -p "Enter your subtheme name [Taz Theme]: " SUBTHEME
      SUBTHEME=${SUBTHEME:-Taz Theme}

      read -p "Pick either Omega (o) or Zen (z) [z]: " BASETHEME
      BASETHEME=${BASETHEME:-z}

      if [ "$BASETHEME" = "z" ]; then
        drush zen "$SUBTHEME" -y
      else
        drush en omega_tools -y
        drush omega-subtheme "$SUBTHEME" -y
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