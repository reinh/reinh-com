/*
 * Facebox (for jQuery)
 * version: 1.0 (12/19/2007)
 * @requires jQuery v1.2 or later
 *
 * Examples at http://famspam.com/facebox/
 *
 * Licensed under the MIT:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Copyright 2007 Chris Wanstrath [ chris@ozmm.org ]
 *
 * Usage:
 *  
 *  jQuery(document).ready(function() {
 *    jQuery('a[@rel*=facebox]').facebox() 
 *  })
 *
 *  <a href="#terms" rel="facebox">Terms</a>
 *    Loads the #terms div in the box
 *
 *  <a href="terms.html" rel="facebox">Terms</a>
 *    Loads the terms.html page in the box
 *
 *  <a href="terms.png" rel="facebox">Terms</a>
 *    Loads the terms.png image in the box
 *
 *
 *  You can also use it programmatically:
 * 
 *    jQuery.facebox('some html')
 *
 *  This will open a facebox with "some html" as the content.
 *    
 *    jQuery.facebox(function() { ajaxes })
 *
 *  This will show a loading screen before the passed function is called,
 *  allowing for a better ajax experience.
 *
 */
(function($) {
  $.facebox = function(data) {
    $.facebox.init()
    $.facebox.loading()
    $.isFunction(data) ? data.call() : $.facebox.reveal(data)
  }

  $.facebox.settings = {
    loading_image : '/images/loading.gif',
    close_image   : '/images/closelabel.gif',
    image_types   : [ 'png', 'jpg', 'jpeg', 'gif' ],
    overlay       : true,
    overlay_html  : '<div id="jq-facebox-backdrop" class="close"></div>',
    facebox_html  : '\
  <div id="jq-facebox" style="display:none;"> \
    <div class="popup"> \
      <table> \
        <tbody> \
          <tr> \
            <td class="tl"/><td class="b"/><td class="tr"/> \
          </tr> \
          <tr> \
            <td class="b"/> \
            <td class="body"> \
              <div class="content"> \
              </div> \
              <div class="footer"> \
                <a href="#" class="close"> \
                  <img src="" title="close" class="close_image" /> \
                </a> \
              </div> \
            </td> \
            <td class="b"/> \
          </tr> \
          <tr> \
            <td class="bl"/><td class="b"/><td class="br"/> \
          </tr> \
        </tbody> \
      </table> \
    </div> \
  </div>'
  }

  $.facebox.loading = function() {
    if ($('#jq-facebox .loading').length == 1) return true

    $('#jq-facebox .content').empty()
    $('#jq-facebox .body').children().hide().end().
      append('<div class="loading"><img src="'+$.facebox.settings.loading_image+'"/></div>')

    $('#jq-facebox').show().center()

    $(document).bind('keydown.facebox', function(e) {
      if (e.keyCode == 27) $.facebox.close()
    })
  }

  $.facebox.reveal = function(data, klass) {
    if (klass) $('#jq-facebox .content').addClass(klass)
    $('#jq-facebox .content').append(data)
    $('#jq-facebox .loading').remove()
    $('#jq-facebox .body').children().fadeIn('normal')
    $('#jq-facebox').center()
  }

  $.facebox.close = function() {
    $(document).unbind('keydown.facebox')
    $('#jq-facebox').fadeOut(function() {
      $('#jq-facebox .content').removeClass().addClass('content')
    })
    return false
  }

  $.fn.facebox = function() {
    $.facebox.init()

    var image_types = $.facebox.settings.image_types.join('|')
    image_types = new RegExp('\.' + image_types + '$', 'i')

    function click_handler() {
      $.facebox.loading(true)

      // support for rel="facebox[.inline_popup]" syntax, to add a class
      var klass = this.rel.match(/facebox\[\.(\w+)\]/)
      if (klass) klass = klass[1]

      // div
      if (this.href.match(/#/)) {
        var url    = window.location.href.split('#')[0]
        var target = this.href.replace(url,'')
        $.facebox.reveal($(target).clone().show(), klass)

      // image
      } else if (this.href.match(image_types)) {
        var image = new Image()
        image.onload = function() {
          $.facebox.reveal('<div class="image"><img src="' + image.src + '" /></div>', klass)
        }
        image.src = this.href

      // ajax
      } else {
        $.get(this.href, function(data) { $.facebox.reveal(data, klass) })
      }

      return false
    }

    this.click(click_handler)
    return this
  }

  $.facebox.init = function() {
    if ($.facebox.settings.inited) {
      return true
    } else {
      $.facebox.settings.inited = true
    }

    $('body').append($.facebox.settings.facebox_html);
    if ($.facebox.settings.overlay) {
      $($.facebox.settings.overlay_html).appendTo($('#jq-facebox'));
    };

    var preload = [ new Image(), new Image() ]
    preload[0].src = $.facebox.settings.close_image
    preload[1].src = $.facebox.settings.loading_image

    $('#jq-facebox').find('.b:first, .bl, .br, .tl, .tr').each(function() {
      preload.push(new Image())
      preload.slice(-1).src = $(this).css('background-image').replace(/url\((.+)\)/, '$1')
    })

    $('#jq-facebox .close').click($.facebox.close)
    $('#jq-facebox .close_image').attr('src', $.facebox.settings.close_image)
  }
})(jQuery);
