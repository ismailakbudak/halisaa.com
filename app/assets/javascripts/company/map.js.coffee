$(document).ready ->
  marker_position = new (google.maps.LatLng)(halisaa.longitude, halisaa.latitude)
  geocoder = new (google.maps.Geocoder)
  marker = undefined
  map = undefined

  initialize = ->
    mapOptions =
      zoom: halisaa.zoom
      center: marker_position
    map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
    marker = new (google.maps.Marker)(
      map: map
      draggable: halisaa.draggable
      animation: google.maps.Animation.DROP
      position: marker_position)
    google.maps.event.addListener marker, 'dragend', (e) ->
      lat = undefined
      lng = undefined
      address = undefined
      geocoder.geocode { 'latLng': marker.getPosition() }, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          lat = marker.getPosition().lat()
          lng = marker.getPosition().lng()
          address = results[0].formatted_address
          $('.longitude').val lat
          $('.latitude').val lng
          $('.address').html address
          $('#astroturf_address').val address
        return
      return
    return

  google.maps.event.addDomListener window, 'load', initialize
  return
