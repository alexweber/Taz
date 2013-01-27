<?php
/**
 * @file
 * Taz Admin pages.
 */

/**
 * Creates a dashboard landing page.
 */
function taz_admin_page_dashboard() {
  $cols = variable_get('taz_admin_cols', 4);
  return taz_admin_menu_table('menu-taz-admin', $cols);
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
        if (in_array($link['link_path'], $exclude)) {
          continue;
        }
        else if (array_key_exists($link['link_path'], $custom_classes)) {
          $classname = $custom_classes[$link['link_path']];
        }
        else {
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