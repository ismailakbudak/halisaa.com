$(document).ready ->
  Halisaa.check_configs()

  # Delete event from database
  deleteEvent = (event, callback) ->
    if  typeof event.id != 'undefined'
      obj =
        id: event.id
      $.ajax
        url: app.timetablesUrl
        type: 'DELETE'
        data: obj
        dataType: 'JSON'
        success: (result) ->
          $('#calendar').fullCalendar 'removeEvents', event._id
          return
        error: (result) ->
          alert app.error_occurred_text
          console.log result
          return
    return

  # Update event on database
  updateEvent = (event, callback, revertFunc) ->
    if  typeof event.id != 'undefined'
      if event.end == null
        event.end = moment(event.start).add(2, 'hours')
      obj =
        id: event.id
        start:  moment(event.start).format(app.datetime_format)
        finish:  moment(event.end).format(app.datetime_format)
        allday: event.allDay
      $.ajax
        url: app.timetablesUrl
        type: 'PUT'
        data: obj
        dataType: 'JSON'
        success: (result) ->
          return
        error: (result) ->
          alert app.error_occurred_text
          if revertFunc != null
            revertFunc()
          console.log result
          return
    return

  # Add new element to database
  addNewEventElement = ->
    $.post app.timetablesUrl, (data) ->
      if data.success
        $('#external-events .fc-event').data('id',data.timetable.id)
        setEventPrototype()
      else
        alert app.error_occurred_text
    return

  # Set event prototype make it draggable
  setEventPrototype = ->
    $('#external-events .fc-event').each ->
      $(this).data 'event',
        id: $(this).data('id')
        title: $.trim($(this).text())
        stick: true
        color: '#3A87AD'
        destroyAble: true
      # make the event draggable using jQuery UI
      $(this).draggable
        zIndex: 999
        revert: true
        revertDuration: 0
      return
    return
  setEventPrototype()

  # Create calendar
  $('#calendar').fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,agendaWeek,agendaDay'
    editable: true
    lang: app.locale
    #contentHeight: 'auto'
    defaultView: 'agendaWeek'
    slotDuration: app.slotDuration
    slotLabelFormat: app.slotLabelFormat
    titleFormat: app.titleFormat
    columnFormat: app.columnFormat
    scrollTime: app.scrollTime
    forceEventDuration: true
    allDaySlot: true
    slotEventOverlap: false
    eventOverlap: false
    droppable: true
    businessHours: false
    events: [ # Make undropable  calendar for past dates
      {
        start: moment().add(app.previousWeekCount, 'weeks'),
        end: moment(),
        overlap: false,
        rendering: 'background',
        color: '#ff9f89'
      }
      {
        start: moment().add(app.previousWeekCount, 'weeks').format(app.date_format),
        end: moment().format(app.date_format),
        overlap: false,
        rendering: 'background',
        color: '#ff9f89'
      }
    ]
    viewRender: (currentView) ->
      minDate = moment().add(app.previousWeekCount, 'weeks')
      maxDate = moment().add(app.featureWeekCount, 'weeks')
      # Past
      if minDate >= currentView.start and minDate <= currentView.end
        $('.fc-prev-button').prop 'disabled', true
        $('.fc-prev-button').addClass 'fc-state-disabled'
      else
        $('.fc-prev-button').removeClass 'fc-state-disabled'
        $('.fc-prev-button').prop 'disabled', false
      # Future
      if maxDate >= currentView.start and maxDate <= currentView.end
        $('.fc-next-button').prop 'disabled', true
        $('.fc-next-button').addClass 'fc-state-disabled'
      else
        $('.fc-next-button').removeClass 'fc-state-disabled'
        $('.fc-next-button').prop 'disabled', false
      return
    drop: ->
      addNewEventElement()
      return
    eventReceive: (event) ->
      updateEvent(event, 'receive', null)
      return
    eventDrop: ( event, delta, revertFunc ) ->
      updateEvent(event, 'drop', revertFunc)
      return
    eventResize: (event, delta, revertFunc) ->
      updateEvent(event, 'resize', revertFunc)
      return
    eventAfterRender: (event, element, view ) ->
      if view.name == 'month'
        if event.destroyAble
          check = moment(event.end).format(app.date_format)
          today = moment(new Date).format(app.date_format)
          if check >= today
            element.append("<button class='btn btn-sm btn-danger closon'><i class='fa fa-trash'> #{app.remove_text} </i></button>")
            element.find('.closon').on 'click',->
              deleteEvent(event, 'delete')
              return
          return
        return
      return

  # Get all events from database
  $.getJSON app.timetablesIndexUrl, (data) ->
    if data.success
      $('#calendar').fullCalendar( 'addEventSource', data.events)
      return
