(function($, Drupal){
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
