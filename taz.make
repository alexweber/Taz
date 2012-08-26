api = 2
core = 7.x

projects[drupal][type] = core
projects[drupal][version] = 7.15
projects[drupal][patch][] = http://drupal.org/files/issues/object_conversion_menu_router_build-972536-1.patch
projects[drupal][patch][] = http://drupal.org/files/issues/992540-3-reset_flood_limit_on_password_reset-drush.patch
projects[drupal][patch][] = http://drupal.org/files/drupal-actions-985814-11-D7.patch
projects[drupal][patch][] = http://drupal.org/files/1356276-make-D7-21.patch

; Recursion will build the drupal-org makefiles found there
projects[taz][type] = profile
projects[taz][download][type] = git
projects[taz][download][url] = git@github.com:alexweber/Taz.git