<?php
/**
 * @file
 * Definition of views_handler_field_node_link_devel.
 */

/**
 * A handler to provide a field with a link to inspect a node using Devel.
 *
 * @ingroup views_field_handlers
 */
class views_handler_field_node_link_devel extends views_handler_field_node_link {
  /**
   * Renders the link.
   */
  function render_link($node, $values) {
    // Ensure Devel is enabled and user has access to view devel information.
    if (!module_exists('devel') || !user_access('access devel information')) {
      return;
    }

    $this->options['alter']['make_link'] = TRUE;
    $this->options['alter']['path'] = "node/$node->nid/devel";
    $this->options['alter']['query'] = drupal_get_destination();

    $text = !empty($this->options['text']) ? $this->options['text'] : t('inspect');
    return $text;
  }
}