# This is a manifest file that will be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require hierapolis
#= require chosen-jquery

class @Halisaa
  @check_configs = ->
    if typeof app.locale == 'undefined'
      app.locale = 'en'
    if typeof app.slotDuration == 'undefined'
      app.slotDuration = '00:30:00'
    if typeof app.slotLabelFormat == 'undefined'
      app.slotLabelFormat = 'H:mm'
    if typeof app.titleFormat == 'undefined'
      app.titleFormat = 'MMMM DD YYYY'
    if typeof app.columnFormat == 'undefined'
      app.columnFormat = 'dddd MM/DD'
    if typeof app.scrollTime == 'undefined'
      app.scrollTime = '10:00:00'
    if typeof app.remove_text == 'undefined'
      app.remove_text = 'Remove'
    if typeof app.available_text == 'undefined'
      app.available_text = 'Available'
    if typeof app.error_occurred_text == 'undefined'
      app.error_occurred_text = 'Error occurred'
    app.previousWeekCount  = -5
    app.featureWeekCount   = 10
    app.date_format        = "YYYY-MM-DD"
    app.datetime_format    = "YYYY-MM-DD HH:mm:ss"
    return

ready = ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
  $('.city_id').change ->
    url ='/api/cities/' + $(this).val()
    $('.town_id option').nextAll().remove()
    if $(this).val() != ''
      $.get url, (response) ->
        if !response.error
          $.each response.data, ( index, value ) ->
            $('.town_id').append '<option value="'+value.id+'">'+value.name+'</option>'
          $('.town_id').trigger("chosen:updated");
    else
      $('.town_id').trigger("chosen:updated");
    return
  $('.phone').on 'change', ->
    val1 = $(this).val()
    array = val1.split(' ')
    val = ''
    i = 0
    while i < array.length
      val += array[i]
      i++
    $(this).val '+'
    p = jQuery.trim(val.substring(1, val.length))
    i = 0
    j = 1
    while i <= p.length and j < 13
      p1 = val.substring(i, i+1);
      if IntegerKontrol(p1)
        v = $(this).val() + p1;
        if j == 2 or j == 5 or j == 8
          v = v + ' '
        $(this).val v;
        j++
      i++;
    if j < 13
      $(this).val ''
    return
  IntegerKontrol = (val) ->
    if isNaN(val) == true or val == ''
      false
    else
      true

$(document).ready(ready)
$(document).on('page:load', ready)
$(window).on('page:load', ready)