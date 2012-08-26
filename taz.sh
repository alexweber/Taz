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


####################################
### Create MySQL User & Database ###
####################################

echo "What's your database user?"
read -i "taz" DBUSER

# Create database user.
mysql -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBUSER';"

echo "What's your database name?"
read -i "taz" DBNAME

# Create database.
mysql -e "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

# Set permissions.
mysql -e "GRANT USAGE ON * . * TO '$DBUSER'@'localhost' IDENTIFIED BY '$DBUSER' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -e "GRANT ALL PRIVILEGES ON $DBNAME . * TO '$DBUSER'@'localhost';


####################
### Install site ###
####################

# Get site name.
echo "What's your site name?"
read -i "Taz" SITENAME

# Get site email.
echo "What's your site's email?"
read EMAIL

# Install site.
# We use a purpously unconventional name for user 1.
drush si taz --db-url=mysql://$DBUSER:$DBUSER@127.0.0.1/$DBNAME --account-name=root_$DBNAME --account-pass=$DBUSER --account-email=$EMAIL --site-name="$SITENAME"

# Make settings read-only.
chmod 644 sites/default/settings.php


#############################
### Create Omega Subtheme ###
#############################

echo "Create Omega Subtheme?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "What's your subtheme's name?"; read SUBTHEME; drush en omega_tools -y; omega subtheme $SUBTHEME -y;
        No ) return;;
    esac
done
