<?php
/**
 * @file
 * Taz Env Admin pages.
 */

/**
 * Form callback.
 *
 * Displays main Taz Env settings form.
 *
 * @see taz_env_menu()
 */
function taz_env_settings_form($form, $form_state) {
  $form['wrapper'] = array(
    '#type' => 'fieldset',
    '#title' => t('Taz Env'),
    '#collapsible' => FALSE,
    '#tree' => TRUE,
  );

  $form['wrapper']['taz_env'] = array(
    '#title' => t('Current environment.'),
    '#type' => 'select',
    '#options' => array(
      TAZ_ENV_DEV => t('Development'),
      TAZ_ENV_STAGE => t('Staging'),
      TAZ_ENV_PROD => t('Production'),
    ),
    '#default_value' => variable_get('taz_env', TAZ_ENV_DEV),
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
 * @see taz_env_settings_form()
 */
function taz_env_settings_form_submit(&$form, &$form_state) {
  $values = &$form_state['values'];
  $new_env = $values['wrapper']['taz_env'];
  $old_env = variable_get('taz_env');

  foreach ($values['wrapper'] as $name => $value) {
    variable_set($name, $value);
  }

  // If there was actually an environment change, make it happen.
  if ($new_env !== $old_env) {
    taz_env_set($new_env);
  }
}