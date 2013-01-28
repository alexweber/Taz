<?php

/**
 * Implements hook_views_data_alter().
 *
 * Add field handlers to display links to inspect entities using Devel.
 * We add the handler regardless of whether Devel is enabled or not in order
 * to avoid breaking views when it's not.
 */
function taz_core_views_data_alter(&$data) {
  $data['views_entity_node']['devel_node']['field'] = array(
    'title' => t('Devel link'),
    'help' => t('Provide a simple link to inspect the content using Devel.'),
    'handler' => 'views_handler_field_node_link_devel',
  );

  $data['users']['devel_user']['field'] = array(
    'title' => t('Devel link'),
    'help' => t('Provide a simple link to inspect the user using Devel.'),
    'handler' => 'views_handler_field_user_link_devel',
  );
}