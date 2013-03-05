<?php
/**
 * @file
 * Taz profile.
 */

/**
 * Define the current profile version.
 */
define('TAZ_VERSION', '7.0-dev');

/**
 * Role ID for administrator users; should match what's in the "role" table.
 */
define('TAZ_ADMIN_RID', 3);

/**
 * Set Taz as default install profile.
 *
 * Must use system as the hook module because taz is not active yet
 */
function system_form_install_select_profile_form_alter(&$form, $form_state) {
  foreach($form['profile'] as $key => $element) {
    $form['profile'][$key]['#value'] = 'taz';
  }
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
//  $default_email = 'admin@' . $_SERVER['HTTP_HOST'];
  $default_email = 'alexweber15@gmail.com';
  $form['site_information']['site_name']['#default_value'] = 'Taz'; // We don't use t() intentionally.
  $form['site_information']['site_mail']['#default_value'] = $default_email;
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = $default_email;

  $form['server_settings']['site_default_country']['#default_value'] = 'BR';
  $form['server_settings']['date_default_timezone']['#default_value'] = 'America/Sao_Paulo';

  $form['update_notifications']['update_status_module']['#default_value'] = array(1);

  // Add elements for Taz install options.
  $form['taz'] = array(
    '#type' => 'fieldset',
    '#title' => st('Taz settings'),
    '#collapsible' => FALSE,
    '#tree' => TRUE,
  );

  $form['taz']['search'] = array(
    '#type' => 'select',
    '#title' => st('Search settings'),
    '#options' => array(
      'core' => st('Drupal core'),
      'search_api' => st('Search API'),
    ),
  );

  $form['taz']['i18n'] = array(
    '#type' => 'select',
    '#title' => st('Internationalization'),
    '#options' => array(
      'none' => st('English only'),
      'foreign' => st('Single language but not English'),
      'i18n' => st('Multilingual'),
    ),
  );

  $form['taz']['wysiwyg'] = array(
    '#type' => 'select',
    '#title' => st('WYSIWYG settings'),
    '#options' => array(
      'ckeditor' => st('CKEditor'),
      'tinymce' => st('Tiny MCE'),
    ),
  );


  // Add checkboxes to enable submodules.
  $form['taz']['submodules'] = array(
    '#type' => 'fieldset',
    '#title' => t('Submodules'),
    '#description' => t('Enable additional Taz submodules'),
    '#collapsible' => FALSE,
    '#tree' => TRUE,
  );

  foreach (taz_get_modules() as $module => $info) {
    $form['taz']['submodules'][$module] = array(
      '#type' => 'checkbox',
      '#title' => $info->info['name'],
      '#description' => $info->info['description'],
      '#default_value' => FALSE,
    );
  }

  $form['#submit'][] = 'taz_install_configure_form_submit';
}

/**
 * Submit callback.
 *
 * Adds extra modules to installation queue.
 */
function taz_install_configure_form_submit(&$form, &$form_state) {
  // Alias for convenience.
  $values =& $form_state['values']['taz'];

  $modules = array();

  if ($values['search'] === 'core') {
    $modules[] = 'search';
    $modules[] = 'search_config';
    $modules[] = 'search404';
  }
  elseif ($values['search'] === 'search_api') {
    $modules[] = 'search_api';
    $modules[] = 'search_api_db';
    $modules[] = 'facetapi';
  }

  if ($values['i18n'] === 'foreign') {
    $modules[] = 'locale';
    $modules[] = 'l10n_update';
  }
  elseif ($values['i18n'] === 'i18n') {
    $modules[] = 'locale';
    $modules[] = 'i18n';
    $modules[] = 'i18n_node';
    $modules[] = 'i18n_path';
    $modules[] = 'i18n_redirect';
    $modules[] = 'i18n_select';
    $modules[] = 'l10n_update';
  }

  // Enable additional modules.
  if ($values['submodules']) {
    $modules = array();

    foreach ($values['submodules'] as $module => $enabled) {
      if ($enabled) {
        $modules[] = $module;
      }
    }
  }

  // Set variables for other install steps.
  variable_set('taz_install_extra_modules', $modules);
  variable_set('taz_install_wysiwyg', $values['wysiwyg']);
}
