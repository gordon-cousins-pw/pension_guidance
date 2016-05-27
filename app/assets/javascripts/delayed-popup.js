(function($) {
  'use strict';

  var delayedPopup = {
    trigger: '.js-calculator',
    triggered: false,
    delay: 30000,

    init: function() {
      this._addListeners();
    },

    _addListeners: function() {
      $('.js-calculator').on('submit', 'form', $.proxy(this._setDelay, this))
    },

    _setDelay: function(popup) {
      if(this.triggered) return;
      this.triggered = true;

      var delay = this.delay;
      $('.js-delayed-popup').each(function(i, popup) {
        setTimeout(function() {
          $(popup).modal()
        }, delay);
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.delayedPopup = delayedPopup;

})(jQuery);
