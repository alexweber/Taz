#!/bin/bash

# Create default files directory if it doesn't already exist.
if [ ! -d "sites/default/files" ]; then
  mkdir sites/default/files
fi

# Set permissions on default files directory.
chmod -R 777 sites/default/files

# Create private files directory if it doesn't already exist.
if [ ! -d "private" ]; then
  mkdir private
fi

# Set permissions on private files directory.
chmod -R 777 private

if [ ! -f "sites/default/settings.php" ]; then
  cp sites/default/default.settings.php sites/default/settings.php
chmod -R 777 sites/default/settings.php
fi

#drush si --db-url=mysql://drupal:drupal123@127.0.0.1/drupaltest --account-name=admin --account-pass=drupal123 --account-email=example@domain.com --site-name="Taz"