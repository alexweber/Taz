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

  // Context for Administrative pages.
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
  $context->reactions = array();
  $context->condition_mode = 0;

  // Translatables
  // Included for use with string extractors like potx.
  t('Context for all administrative pages.');
  $export['taz_admin'] = $context;

  // Context for the front page.
  $context = new stdClass();
  $context->disabled = TRUE; /* Edit this to true to make a default context disabled initially */
  $context->api_version = 3;
  $context->name = 'taz_front';
  $context->description = 'Context for the front page.';
  $context->tag = 'taz';
  $context->conditions = array(
    'path' => array(
      'values' => array(
        '<front>' => '<front>',
      ),
    ),
  );
  $context->reactions = array();
  $context->condition_mode = 0;

  // Translatables
  // Included for use with string extractors like potx.
  t('Context for the front page.');
  $export['taz_front'] = $context;

  // Context for all pages except administrative pages.
  $context = new stdClass();
  $context->disabled = FALSE; /* Edit this to true to make a default context disabled initially */
  $context->api_version = 3;
  $context->name = 'taz_pages';
  $context->description = 'Context for all pages excluding administrative ones.';
  $context->tag = 'taz';
  $context->conditions = array(
    'context' => array(
      'values' => array(
        '~taz_admin' => '~taz_admin',
      ),
    ),
    'sitewide' => array(
      'values' => array(
        1 => 1,
      ),
    ),
  );
  $context->reactions = array();
  $context->condition_mode = 1;

  // Translatables
  // Included for use with string extractors like potx.
  t('Context for all pages excluding administrative ones.');
  $export['taz_pages'] = $context;

  return $export;
}