<?php
/**
 * @file
 * taz_admin.context.inc
 */

/**
 * Implements hook_context_default_contexts().
 */
function taz_admin_context_default_contexts() {
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
        'admin*' => 'admin*',
        'batch' => 'batch',
        'node/add*' => 'node/add*',
        'node/*/*' => 'node/*/*',
        'devel*' => 'devel*',
        'help*' => 'help*',
        'taxonomy/term/*/*' => 'taxonomy/term/*/*',
        'user*' => 'user*',
      ),
    ),
  );
  $context->reactions = array(
    'block' => array(
      'blocks' => array(
        'menu-menu-taz-admin' => array(
          'module' => 'menu',
          'delta' => 'menu-taz-admin',
          'region' => 'sidebar_first',
          'weight' => '-10',
        ),
      ),
    ),
  );
  $context->condition_mode = 0;

  // Translatables
  // Included for use with string extractors like potx.
  t('Context for all administrative pages.');
  t('taz');
  $export['taz_admin'] = $context;

  return $export;
}
