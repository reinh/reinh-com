/* jQuery Center Plugin 
* source: http://www.affiliatetips.com/how-to-create-a-jquery-plugin.html
* requires dimensions plugin
*/
(function($) { 
  $.fn.center = function() {
    return this.each(function() {
      var self = $(this);

      // Set its position to absolute
      self.css({position: 'absolute'});

      // Calculate its new position based on the browser-window's dimensions, the element's dimensions and the scroll-position
      var leftPos = ($(window).width() - self.outerWidth()) / 2 + $(window).scrollLeft();
      var topPos = ($(window).height() - self.outerHeight()) / 2 + $(window).scrollTop();

      // Make sure it's not positioned outside the screen
      if(topPos < 0) topPos = 0;
      if(leftPos < 0) leftPos = 0;

      // Apply top and left values based on calculated new position
      self.css({left: '' +leftPos +'px', top: '' +topPos +'px'});
    });
  }
})(jQuery);