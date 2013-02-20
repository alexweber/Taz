(function($, Drupal){
  // Use strict mode to reduce development errors.
  // @link http://www.nczonline.net/blog/2012/03/13/its-time-to-start-using-javascript-strict-mode/
  "use strict";

  Drupal.behaviors.taz_env_banner = {
    attach: function(context, settings) {
      var $button = $('#taz-env-notify-close');

      if ($button.length) {
        $button.click(function() {
          $(this).parent('#taz-env-notify').slideUp('fast');
        });
      }
    }
  };
})(jQuery, Drupal);