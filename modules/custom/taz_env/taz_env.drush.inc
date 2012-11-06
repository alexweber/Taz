<?php
/**
 * @file
 * Taz Env Drush commands.
 */

/**
 * Implements hook_drush_help().
 */
function taz_env_drush_help($section) {
  switch ($section) {
    case 'env':
      return 'Switches website environment between development, staging and production mode.';
  }
}

/**
 * Implements hook_drush_command().
 */
function taz_env_drush_command() {
  return array(
    'env' => array(
      'callback' => '_taz_env_drush_env',
      'description' => "Switches website environment between development, staging and production mode. Specify the environment as an argument: press 'd' for development, 's' for staging or 'p' for production. If you type '?' or leave out the argument the function will inform what is the current environment.",
      'arguments' => array(
        'env' => "Optional. Specify the environment: press 'd' for development, 's' for staging or 'p' for production. If you type '?' or leave out the argument the function will inform what is the current environment.",
      ),
      'examples' => array(
        'drush env d' => 'Put the site in development mode',
        'drush env s' => 'Put the site in staging mode',
        'drush env t' => 'Put the site in production mode',
      ),
    ),
  );
}

/**
 * Router for 'env' drush command.
 *
 * @param string $env
 * @return bool
 */
function _taz_env_drush_env($env = NULL) {
  switch ($env) {
    case 'd':
    case 'dev':
    case 'development':
      $return = taz_env_set(TAZ_ENV_DEV);
      drush_log('Environment set to: Development', 'ok');
      $flush = TRUE;
      break;
    case 's':
    case 'stage':
    case 'staging':
      $return = taz_env_set(TAZ_ENV_STAGE);
      drush_log('Environment set to: Staging', 'ok');
      $flush = TRUE;
      break;
    case 'p':
    case 'prod':
    case 'production':
      $return = taz_env_set(TAZ_ENV_PROD);
      drush_log('Environment set to: Production', 'ok');
      $flush = TRUE;
      break;
    default:
      $env = variable_get('taz_env', '-undefined-');
      drush_log('Current environment is: ' . $env, 'ok');
      $flush = FALSE;
  }

  if ($flush) {
    // Flush all caches; no need to re-implement this.
    drush_cache_clear('all');
    // And again.
    drush_cache_clear('all');
  }

  return TRUE;
}