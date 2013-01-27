<?php
/**
 * @file
 * Taz Admin pages.
 */

/**
 * Creates a dashboard landing page.
 */
function taz_admin_page_dashboard() {
  // @TODO does this need to be customizable?
  return taz_admin_menu_table('menu-taz-admin', 4);
}

/**
 * Helper function.
 * Converts a Drupal menu into a table layout for creating Dashboards.
 *
 * @param string
 *   The $menu_name.
 * @param int
 *   The number of columns per row.
 *
 * @return string
 *   The rendered markup of the table.
 */
function taz_admin_menu_table($menu_name, $cols_per_row = 4) {
  if ($menu = menu_load_links($menu_name)) {
    $rows = array();
    $cols = array();
    $col = 0;

    $custom_classes = taz_admin_custom_classes();
    $exclude = taz_admin_exclude_paths();

    // Generate table markup.
    foreach ($menu as $link) {
      $item = menu_get_item($link['link_path']);

      // Check for permission.
      if ($item['access']) {
        if (array_key_exists($url, $custom_classes)) {
          $classname = $custom_classes[$url];
        }
        else if (!in_array ($link['link_path'], $exclude)) {
          $path = explode('/', $link['link_path']);
          $classname = array_pop($path);
        }

        $cols[] = array(
          'class' => array($classname),
          'data' => '<div class="link-wrapper">' . l(
            str_replace('Manage ', '', $link['link_title']), url($link['link_path'], array(
              'absolute' => TRUE)), array('html' => TRUE, 'attributes' => array(
              'class' => 'taz_admin_link'))
          ) . '</div>',
        );

        // X columns per row.
        if (++$col == $cols_per_row) {
          $rows[] = array(
            'no_striping' => TRUE,
            'data' => $cols,
          );
          $col = 0;
          $cols = array();
        }
      }
    }

    // Pad to desired number of columns.
    if (!empty($cols)) {
      $cols = array_pad($cols, $cols_per_row, array('class' => 'taz_admin_filler',
        'data' => array()));

      $rows[] = array(
        'no_striping' => TRUE,
        'data' => $cols,
      );
    }

    $variables = array(
      'rows' => $rows,
      'attributes' => array('class' => array('taz_dashboard')),
      'sticky' => FALSE,
    );
    return theme('table', $variables);
  }

  return drupal_not_found();
}