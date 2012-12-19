<?php
/**
 * @file
 * Taz profile.
 */

/**
 * Role ID for administrator users; should match what's in the "role" table.
 */
define('TAZ_ADMIN_RID', 3);

/**
 * Implements hook_admin_paths().
 *
 * Make user pages use admin theme.
 */
function taz_admin_paths() {
  return array(
    'user' => TRUE,
    'user/*' => TRUE,
  );
}

/**
 * Implements hook_admin_paths_alter().
 * A trick to enforce page refresh when theme is changed from an overlay.
 */
function taz_admin_paths_alter(&$paths) {
  $paths['admin/appearance/default*'] = FALSE;
}

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function taz_form_install_configure_form_alter(&$form, $form_state) {
  // Many modules set messages during installation that are very annoying.
  // Lets remove these and read the only message that should be set.
  drupal_get_messages('status');
  drupal_get_messages('warning');

  // Warn about settings.php permissions risk
  $settings_dir = conf_path();
  $settings_file = $settings_dir . '/settings.php';
  // Check that $_POST is empty so we only show this message when the form is
  // first displayed, not on the next page after it is submitted. (We do not
  // want to repeat it multiple times because it is a general warning that is
  // not related to the rest of the installation process; it would also be
  // especially out of place on the last page of the installer, where it would
  // distract from the message that the Drupal installation has completed
  // successfully.)
  if (empty($_POST) && (!drupal_verify_install_file(DRUPAL_ROOT . '/' . $settings_file, FILE_EXIST | FILE_READABLE | FILE_NOT_WRITABLE) || !drupal_verify_install_file(DRUPAL_ROOT . '/' . $settings_dir, FILE_NOT_WRITABLE, 'dir'))) {
    drupal_set_message(st('All necessary changes to %dir and %file have been made, so you should remove write permissions to them now in order to avoid security risks. If you are unsure how to do so, consult the <a href="@handbook_url">online handbook</a>.', array('%dir' => $settings_dir, '%file' => $settings_file, '@handbook_url' => 'http://drupal.org/server-permissions')), 'warning');
  }

  // Pre-populate some fields.
  $form['site_information']['site_name']['#default_value'] = 'Taz'; // We don't use t() intentionally.
  $form['site_information']['site_mail']['#default_value'] = 'admin@' . $_SERVER['HTTP_HOST'];
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@' . $_SERVER['HTTP_HOST'];
}

/**
 * Implements hook_backup_migrate_profiles().
 */
function taz_backup_migrate_profiles() {
  return array(
    'dev_snapshot' => backup_migrate_crud_create_item('profile', array(
      'name' => t("Dev Snapshot"),
      'profile_id' => 'dev_snapshot',
      'filename' => '[site:name]',
      'append_timestamp' => '0',
      'filters' => array(
        'compression' => 'gzip',
        'notify_success_enable' => 0,
        'notify_failure_enable' => 0,
        'utils_site_offline' => 0,
        'utils_site_offline_message' => 'This website is currently under maintenance. We should be back shortly. Thank you for your patience.',
        'utils_description' => '',
        'destinations' => array(
          'db' => array(
            'exclude_tables' => array(),
            'nodata_tables' => array(
              'cache' => 'cache',
              'cache_admin_menu' => 'cache_admin_menu',
              'cache_block' => 'cache_block',
              'cache_bootstrap' => 'cache_bootstrap',
              'cache_field' => 'cache_field',
              'cache_filter' => 'cache_filter',
              'cache_form' => 'cache_form',
              'cache_image' => 'cache_image',
              'cache_l10n_update' => 'cache_l10n_update',
              'cache_libraries' => 'cache_libraries',
              'cache_media_xml' => 'cache_media_xml',
              'cache_menu' => 'cache_menu',
              'cache_page' => 'cache_page',
              'cache_path' => 'cache_path',
              'cache_token' => 'cache_token',
              'cache_update' => 'cache_update',
              'cache_views' => 'cache_views',
              'cache_views_data' => 'cache_views_data',
              'ctools_css_cache' => 'ctools_css_cache',
              'ctools_object_cache' => 'ctools_object_cache',
              'search_dataset' => 'search_dataset',
              'search_index' => 'search_index',
              'search_total' => 'search_total',
              'sessions' => 'sessions',
              'watchdog' => 'watchdog',
            ),
            'utils_lock_tables' => 0,
            'use_mysqldump' => 0,
          ),
        ),
      ),
    )),
  );
}

/**
 * Implements hook_backup_migrate_schedules().
 */
function taz_backup_migrate_schedules() {
  return array(
    'daily' => backup_migrate_crud_create_item('schedule', array(
      'name' => 'Daily Backup',
      'source_id' => 'db',
      'destination_id' => 'scheduled',
      'profile_id' => 'default',
      'keep' => 90,
      'period' => 28800,
      'enabled' => 1,
      'cron' => 1,
    )),
    'snapshot' => backup_migrate_crud_create_item('schedule', array(
      'name' => 'Dev Snapshopt',
      'source_id' => 'db',
      'destination_id' => 'manual',
      'profile_id' => 'dev_snapshot',
      'keep' => 7,
      'period' => 43200,
      'enabled' => 1,
      'cron' => 1,
    )),
  );
}

/**
 * Determine whether a user has a particular role.
 * Accepts both the role's ID (recommended) or name.
 * If no user is specified we use the current user.
 *
 * @param int|string The role's ID or name.
 * @param int The user's ID.
 * @return boolean Whether the user has the role.
 */
function user_has_role($rid, $uid = NULL) {
  $user = user_uid_optional_load($uid);

  // Make sure we have a valid user object.
  if (is_object($user) && isset($user->roles) && is_array($user->roles)) {
    return (is_numeric($rid)) ? in_array($rid, array_keys($user->roles)) : in_array($rid, $user->roles);
  }

  return FALSE;
}

/**
 * Converts a string to a slug, for use in URLs or CSS classes.
 *
 * @param string The string to convert.
 * @return string The slug.
 */
function string_to_slug($string) {
  $string = str_replace(array('/', ' '), '-', $string);
  $accents = '/&([A-Za-z]{1,2})(tilde|grave|acute|circ|cedil|uml|lig);/';
  return urlencode(strtolower(preg_replace($accents, '$1', htmlentities(utf8_decode($string)))));
}