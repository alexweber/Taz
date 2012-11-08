#!/bin/bash

################################################################################
#
#   This simple script gets a Drupal 7 site installed in seconds:
#
#   * Starts by building the makefile; taz.make
#
#   * Automatically creates settings file and files directories and sets
#     the correct permissions on them.
#
#   * Creates mysql user and database (if necessary) and sets permissions
#
#   * Asks for site name, email and url
#
#   * Installs the site using the Taz profile
#
#   * Makes settings.php read-only
#
#   * Asks for theme name and creates Omega Subtheme (optional)
#
#   * Opens the website on password recovery screen
#
#   The entire process only takes a few seconds and can save your team hours
#   of work, time and time again.
#
#   Be awesome: Use it with Vagrant.
#
################################################################################

# @TODO download makefile automatically from git repo
drush make taz.make .

#################################
### Directories & Permissions ###
#################################

read -p "Create files directories and settings file? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  # Create modules contrib subdirectory.
  if [ ! -d "sites/all/modules/contrib" ]; then
    mkdir sites/all/modules/contrib
  fi

  # Create modules custom subdirectory.
  if [ ! -d "sites/all/modules/custom" ]; then
    mkdir sites/all/modules/custom
  fi

  # Create default files directory.
  if [ ! -d "sites/default/files" ]; then
    mkdir sites/default/files
  fi

  # Set permissions on default files directory.
  chmod -R 777 sites/default/files

  # Create private files directory.
  if [ ! -d "private" ]; then
    mkdir private
  fi

  # Set permissions on private files directory.
  chmod -R 777 private

  # Copy settings file.
  if [ ! -f "sites/default/settings.php" ]; then
    cp sites/default/default.settings.php sites/default/settings.php
    chmod -R 777 sites/default/settings.php
  fi
fi

# Remove makefile.
rm -rf taz.make

####################################
### Create MySQL User & Database ###
####################################

read -p "Create MySQL database and user? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  # Get MySQL root username & password.
  read -p "Enter your MySQL admin user: " MYROOT
  read -p "Enter your MySQL admin password: " MYPASS

  # Create database user.
  read -p "Enter your database user [taz]: " DBUSER
  DBUSER=${DBUSER:-taz}
  mysql -u$MYROOT -p$MYPASS -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBUSER';"

  # Create database.
  read -p "Enter your database name [taz]: " DBNAME
  DBNAME=${DBNAME:-taz}
  mysql -u$MYROOT -p$MYPASS -e "CREATE DATABASE IF NOT EXISTS $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

  # Set permissions.
  mysql -u$MYROOT -p$MYPASS -e "GRANT USAGE ON * . * TO '$DBUSER'@'localhost' IDENTIFIED BY '$DBUSER' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
  mysql -u$MYROOT -p$MYPASS -e "GRANT ALL PRIVILEGES ON $DBNAME . * TO '$DBUSER'@'localhost'";

  ####################
  ### Install site ###
  ####################

  read -p "Install site? (y/n) " RESP
  if [ "$RESP" = "y" ]; then
    # Get site name.
    read -p "Enter your site name [Taz]: " SITENAME
    SITENAME=${SITENAME:-Taz}

    # Get site email.
    read -p "Enter your site email: " EMAIL

    # Install site.
    # We use a purpously unconventional name for user 1.
    drush si taz --db-url=mysql://$DBUSER:$DBUSER@127.0.0.1/$DBNAME --account-name=root_$DBNAME --account-pass=$DBUSER --account-mail=$EMAIL --site-name=$SITENAME

    # Make settings read-only.
    chmod 644 sites/default/settings.php

    # Display message.
    echo "Drupal has been installed! User #1 is 'root_$DBNAME' and password is '$DBUSER'."
    echo "Please change your password!"

    #############################
    ### Create Omega Subtheme ###
    #############################

    read -p "Create Omega Subtheme? (y/n) " RESP
    if [ "$RESP" = "y" ]; then
      read -p "Enter your subtheme name [Taz Theme]: " SUBTHEME
      SUBTHEME=${SUBTHEME:-Taz Theme}
      drush en omega_tools -y
      drush omega-subtheme "$SUBTHEME" -y
    fi

    # Login as admin.
    open `drush user-login root_$DBNAME`
  fi
fi

# Remove the script when we're done.
rm $0