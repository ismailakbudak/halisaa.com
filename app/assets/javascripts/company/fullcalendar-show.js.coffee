$(document).ready ->
  Halisaa.check_configs()

  # Create calendar
  $('#calendar-show').fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,agendaWeek,agendaDay'
    editable: false
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
    droppable: false
    businessHours: false
    events: [ ]

  # Get all events from database
  $.getJSON app.publicApiTimetablesIndexUrl, (data) ->
    if data.success
      $('#calendar-show').fullCalendar( 'addEventSource', data.events)
      return
