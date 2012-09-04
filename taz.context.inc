<?php
/**
 * @file
 * Taz default Contexts.
 */

/**
 * Implements hook_context_default_contexts().
 */
function taz_context_default_contexts() {
  $export = array();

  $context = new stdClass();
  $context->disabled = FALSE; /* Edit this to true to make a default context disabled initially */
  $context->api_version = 3;
  $context->name = 'taz_admin';
  $context->description = 'Context for all administrative pages.';
  $context->tag = 'taz';
  $context->conditions = array(
    'path' => array(
      'values' => array(
        'admin' => 'admin',
        'admin/*' => 'admin/*',
        'batch' => 'batch',
        'node/add' => 'node/add',
        'node/add/*' => 'node/add/*',
        'node/*/edit' => 'node/*/edit',
        'node/*/delete' => 'node/*/delete',
        'node/*/devel' => 'node/*/devel',
        'node/*/nodequeue' => 'node/*/nodequeue',
        'node/*/simplenews' => 'node/*/simplenews',
        'node/*/webform' => 'node/*/webform',
        'node/*/webform/*' => 'node/*/webform/*',
        'devel' => 'devel',
        'devel/*' => 'devel/*',
        'help' => 'help',
        'help/*' => 'help/*',
        'taxonomy/term/*/edit' => 'taxonomy/term/*/edit',
        'taxonomy/term/*/delete' => 'taxonomy/term/*/delete',
        'user' => 'user',
        'user/*' => 'user/*',
      ),
    ),
  );
  $context->reactions = array();
  $context->condition_mode = 0;

  // Translatables
  // Included for use with string extractors like potx.
  t('Context for all administrative pages.');
  $export['taz_admin'] = $context;

  return $export;
}