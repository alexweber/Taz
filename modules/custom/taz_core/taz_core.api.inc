<?php
/**
 * @file
 * Taz Core API helper functions.
 */

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

/**
 * Utility function for debugging queries using DBTNG. Accepts a query object
 * and returns a string with all parameters filled in and curly brackets
 * stripped out.
 *
 * @param SelectQueryInterface
 *   An object that implements the SelectQueryInterface interface.
 * @return string
 */
function tpq(SelectQueryInterface $query) {
  // Make sure we have devel module loaded. Since this is a debugging function
  // we don't care about performance here.
  include_once drupal_get_path('module', 'devel') . '/devel.module';
  return str_replace(array('{', '}'), '', dpq($query, TRUE));
}

/**
 * Wrapper around krumo().
 * This will manually include the Krumo class and is useful when:
 *  - Testing as an anonymous user.
 *  - Testing as a user without permissions to access krumo.
 *  - Testing in certain places where krumo is not normally available.
 */
function tkr() {
  include_once drupal_get_path('module', 'devel') . '/krumo/class.krumo.php';
  krumo(func_get_args());
}

/**
 * Wrapper around dpm().
 * This will manually include the Krumo class and is useful when:
 *  - Testing as an anonymous user.
 *  - Testing as a user without permissions to access dpm.
 *  - Testing in certain places where dpm is not normally available.
 */
function tpm() {
  include_once drupal_get_path('module', 'devel') . '/devel.module';
  dpm(func_get_args());
}