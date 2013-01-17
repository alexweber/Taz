api = 2
core = 7.x

projects[drupal][type] = core
projects[drupal][version] = 7.19
projects[drupal][patch][] = http://drupal.org/files/issues/object_conversion_menu_router_build-972536-1.patch
projects[drupal][patch][] = http://drupal.org/files/issues/992540-3-reset_flood_limit_on_password_reset-drush.patch
projects[drupal][patch][] = http://drupal.org/files/drupal-actions-985814-11-D7.patch
projects[drupal][patch][] = http://drupal.org/files/1356276-base-profile-d7-39-do-not-test.patch
projects[drupal][patch][] = https://raw.github.com/alexweber/Taz/profile/patches/htaccess-rewrite-base.patch
projects[drupal][patch][] = https://raw.github.com/alexweber/Taz/profile/patches/gitignore-override.patch