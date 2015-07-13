$(document).ready( function(){
    var marker_position = new google.maps.LatLng(halisaa.longitude, halisaa.latitude);
    var geocoder = new google.maps.Geocoder();
    var marker;
    var map;
    function initialize() {
        var mapOptions = {
            zoom: halisaa.zoom,
            center: marker_position
        };
        map = new google.maps.Map(document.getElementById('map-canvas'),
            mapOptions);
        marker = new google.maps.Marker({
            map:map,
            draggable: halisaa.draggable,
            animation: google.maps.Animation.DROP,
            position: marker_position
        });
        google.maps.event.addListener(marker, "dragend", function (e) {
            var lat, lng, address;
            geocoder.geocode({ 'latLng': marker.getPosition() }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    lat = marker.getPosition().lat();
                    lng = marker.getPosition().lng();
                    address = results[0].formatted_address;
                    $('.longitude').val(lat);
                    $('.latitude').val(lng);
                    $('.address').html(address);
                }
            });
        });
    }
    google.maps.event.addDomListener(window, 'load', initialize);
});