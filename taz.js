// Initialize namespace
var Taz = {};

(function ($) {
  "use strict";

  /**
   * Trims and returns a string.
   * Equivalent to PHP's trim().
   *
   * @param str string
   * @return String
   */
  Taz.trim = function (str) {
    return str.replace(/\s+$/, '').replace(/^\s+/, '');
  };

  /**
   * Find index of element in an array
   * Optionally starts from an index
   * Optionally use non-strict comparison
   *
   * @param arr array
   * @param element mixed
   * @param startFrom int
   * @param strict bool
   */
  Taz.indexOf = function (arr, element, startFrom, strict) {
    var i, j;
    strict = strict || true;

    if (startFrom === null) {
      startFrom = 0;
    } else if (startFrom < 0) {
      startFrom = Math.max(0, arr.length + startFrom);
    }

    for (i = startFrom, j = arr.length; i < j; i += 1) {
      if (strict) {
        if (arr[i] === element) {
          return i;
        }
      } else {
        if (arr[i] == element) {
          return i;
        }
      }
    }

    return -1;
  };

  /**
   * Console.log wrapper to avoid errors when console is not present
   * usage: Taz.log('inside coolFunc', this, arguments);
   *
   * @link http://paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
   */
  Taz.log = function () {
    Taz.log.history = Taz.log.history || [];
    Taz.log.history.push(arguments);
    if (window.console) {
      console.log(Array.prototype.slice.call(arguments));
    }
  };

}(jQuery));