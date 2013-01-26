<?php
/**
 * @file
 * taz_admin.features.menu_custom.inc
 */

/**
 * Implements hook_menu_default_menu_custom().
 */
function taz_admin_menu_default_menu_custom() {
  $menus = array();

  // Exported menu: menu-taz-admin.
  $menus['menu-taz-admin'] = array(
    'menu_name' => 'menu-taz-admin',
    'title' => 'Taz Admin',
    'description' => 'Menu used to create administrative dashboards.',
  );
  // Translatables
  // Included for use with string extractors like potx.
  t('Menu used to create administrative dashboards.');
  t('Taz Admin');


  return $menus;
}
