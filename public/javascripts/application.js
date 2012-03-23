/* DO NOT MODIFY. This file was compiled Wed, 14 Dec 2011 01:13:12 GMT from
 * /Users/blake/www/explorationfitness.com/app/coffeescripts/application.coffee
 */

(function() {
  var NS_EF;

  NS_EF = this.NS_EF = {
    construct: function() {
      this.slideshow('.slideshow');
      this.sortable('.is-sortable');
      $("a[rel='photo-gallery']").colorbox({
        slideshow: true,
        maxWidth: '85%',
        maxHeight: '85%',
        slideshowSpeed: '4000'
      });
      $(".datepicker").datepicker({
        beforeShowDay: $.datepicker.noWeekends
      });
      $(".datepicker-year-month").datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: '1920:2010'
      });
      $('.read-only-form').find('input, textarea, select').attr('disabled', 'true').closest('.bh-field').addClass('bh-disabled');
      $('.list-trip-itinerary ul').accordion({
        autoHeight: false
      });
      return $('.has-dependant').each(function() {
        var cb, dependant;
        cb = $(this);
        dependant = cb.data('dependant');
        if (cb.is(':checked')) {
          cb.closest('.contains-dependant').addClass('dependant-active');
          $(dependant).show();
        } else {
          cb.closest('.contains-dependant').removeClass('dependant-active');
          $(dependant).hide();
        }
        return cb.change(function() {
          if (cb.is(':checked')) {
            cb.closest('.contains-dependant').addClass('dependant-active');
            return $(dependant).show();
          } else {
            cb.closest('.contains-dependant').removeClass('dependant-active');
            return $(dependant).hide();
          }
        });
      });
    },
    sortable: function(target) {
      var table, url;
      target = $(target);
      url = target.data('sortable');
      table = target.find('.sortable-content');
      return table.sortable({
        axis: 'y',
        dropOnEmpty: false,
        handle: '.sortable-handle',
        items: 'tr',
        helper: NS_EF.retainWidth,
        opacity: 0.4,
        scroll: true,
        update: function() {
          return $.ajax({
            type: 'post',
            data: table.sortable('serialize'),
            dataType: 'script',
            url: url,
            complete: function(request) {
              return table.find('.position').effect('highlight');
            }
          });
        }
      });
    },
    retainWidth: function(e, ui) {
      ui.children().each(function() {
        return $(this).width($(this).width());
      });
      return ui;
    },
    slideshow: function(target) {
      target = $(target);
      if (!(target.length <= 0)) {
        return target.slides({
          preload: true,
          play: 5000,
          pause: 2500,
          hoverPause: true,
          generateNextPrev: true
        });
      }
    }
  };

  $(function() {
    return NS_EF.construct();
  });

}).call(this);
