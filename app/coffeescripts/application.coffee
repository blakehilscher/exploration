NS_EF = @NS_EF =

  construct: -> 
    @.slideshow('.slideshow')
    @.sortable('.is-sortable')
    $("a[rel='photo-gallery']").colorbox({
      slideshow:        true
      maxWidth:         '85%'
      maxHeight:        '85%'
      slideshowSpeed:   '4000'
    })
    $(".datepicker").datepicker({ 
      beforeShowDay: $.datepicker.noWeekends
    })
    $( ".datepicker-year-month" ).datepicker({
      changeMonth: true
      changeYear: true
      yearRange: '1920:2010'
      })
    $('.read-only-form').find('input, textarea, select').attr('disabled','true').closest('.bh-field').addClass('bh-disabled')
    $('.list-trip-itinerary ul').accordion({ autoHeight: false })
    $('.has-dependant').each ->
      cb = $(this)
      dependant = cb.data('dependant')
      if cb.is(':checked')
        cb.closest('.contains-dependant').addClass('dependant-active')
        $(dependant).show()
      else
        cb.closest('.contains-dependant').removeClass('dependant-active')
        $(dependant).hide()
        
      cb.change ->
        if cb.is(':checked')
          cb.closest('.contains-dependant').addClass('dependant-active')
          $(dependant).show()
        else
          cb.closest('.contains-dependant').removeClass('dependant-active')
          $(dependant).hide()
        
    
  sortable: (target) ->
    target = $(target)
    url = target.data('sortable')
    table = target.find('.sortable-content')
    table.sortable {
      axis: 'y'
      dropOnEmpty: false
      handle: '.sortable-handle'
      items: 'tr'
      helper: NS_EF.retainWidth
      opacity: 0.4
      scroll: true
      update: ->
        $.ajax {
          type: 'post'
          data: table.sortable('serialize')
          dataType: 'script'
          url: url
          complete: (request) ->
            table.find('.position').effect('highlight')
        }
    }
  
  retainWidth: (e, ui) ->
    ui.children().each ->
      $(@).width $(@).width()
    return ui;
    
  slideshow: (target) ->
    target = $(target)
    target.slides {
      preload: true
      play: 5000
      pause: 2500
      hoverPause: true
      generateNextPrev: true
    } unless target.length <= 0
  
$ -> NS_EF.construct()