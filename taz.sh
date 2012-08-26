#!/bin/bash

################################################################################
#
#   This simple script gets a Drupal 7 site installed in seconds:
#
#   * Starts by building the makefile; taz.make (soon)
#
#   * Automatically creates settings file and files directories and sets
#     the correct permissions on them.
#
#   * Creates mysql user and database and sets permissions
#
#   * Asks for site name and email
#
#   * Installs the site using the Taz profile
#
#   * Makes settings.php read-only
#
#   * Asks for theme name and creates Omega Subtheme
#
#   The entire process only takes a few seconds and can save your team hours
#   of work, time and time again.
#
#   Be awesome: Use it with Vagrant.
#
################################################################################

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


####################################
### Create MySQL User & Database ###
####################################

read -p "Create MySQL database and user? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  # Create database user.
  read -e -p "Enter your database user:" -i "taz" DBUSER
  mysql -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBUSER';"

  # Create database.
  read -e -p "Enter your database name:" -i "taz" DBNAME
  mysql -e "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

  # Set permissions.
  mysql -e "GRANT USAGE ON * . * TO '$DBUSER'@'localhost' IDENTIFIED BY '$DBUSER' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
  mysql -e "GRANT ALL PRIVILEGES ON $DBNAME . * TO '$DBUSER'@'localhost';
fi


####################
### Install site ###
####################

read -p "Install site? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  # Get site name.
  read -e -p "Enter your site name?" -i "Taz" SITENAME

  # Get site email.
  read -e -p "Enter your site email?" EMAIL

  # Install site.
  # We use a purpously unconventional name for user 1.
  drush si taz --db-url=mysql://$DBUSER:$DBUSER@127.0.0.1/$DBNAME --account-name=root_$DBNAME --account-pass=$DBUSER --account-email=$EMAIL --site-name="$SITENAME"

  # Make settings read-only.
  chmod 644 sites/default/settings.php
fi

#############################
### Create Omega Subtheme ###
#############################

read -p "Create Omega Subtheme? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  read -e -p "Enter your subtheme name?" -i "Taz Theme" SUBTHEME
  drush en omega_tools -y
  omega subtheme $SUBTHEME -y
fi