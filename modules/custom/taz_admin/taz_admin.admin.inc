<?php
/**
 * @file
 * Taz Admin Admin pages.
 */

/**
 * Form callback.
 *
 * Displays main Taz Admin settings form.
 *
 * @see taz_admin_menu()
 */
function taz_admin_settings_form($form, $form_state) {
  $form['wrapper'] = array(
    '#type' => 'fieldset',
    '#title' => t('Dashboard settings'),
    '#collapsible' => FALSE,
    '#tree' => TRUE,
  );

  $form['wrapper']['url'] = array(
    '#type' => 'textfield',
    '#title' => t('URL'),
    '#description' => t('Specify at which relative URL the administrative dashboard will be acessible.'),
    '#default_value' => variable_get('taz_admin_url', 'admin/taz'),
    '#size' => 25,
  );

  $form['wrapper']['title'] = array(
    '#type' => 'textfield',
    '#title' => t('Title'),
    '#description' => t('Specify the title for the administrative dashboard.'),
    '#default_value' => variable_get('taz_admin_title', 'Admin Dashboard'),
    '#size' => 25,
  );

  $form['wrapper']['cols'] = array(
    '#type' => 'textfield',
    '#title' => t('Columns per row'),
    '#description' => t('Specify how many columns each row will have in the dashboard will have.'),
    '#default_value' => variable_get('taz_admin_cols', 4),
    '#size' => 1,
  );

  $form['actions'] = array('#type' => 'actions');
  $form['actions']['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Save'),
    '#weight' => 200,
  );

  return $form;
}

/**
 * Submit callback.
 *
 * @see taz_admin_settings_form()
 */
function taz_admin_settings_form_submit(&$form, &$form_state) {
  $values = &$form_state['values'];

  foreach ($values['wrapper'] as $key => $value) {
    $varname = 'taz_admin_' . $key;
    variable_set($varname, $value);
  }
}