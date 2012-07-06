# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# File globals
map = null
userMarker = null
powerLine = null
power = 0.02

# Set up the map
setup_map = () ->
  map               = new L.Map "map"
  cloudmade         = new L.TileLayer 'http://{s}.tile.cloudmade.com/66c4371c1b2941e8a77e68b72074c150/997/256/{z}/{x}/{y}.png', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18
  }
  london = new L.LatLng 51.505, -0.09 # geographical point (longitude and latitude)
  map.setView(london, 13).addLayer(cloudmade)

updatePowerLine = (latitude, longitude) ->
  userPosition = new L.LatLng latitude, longitude # geographical point (longitude and latitude)

  angle = 30 * (Math.PI/180)
  
  distX = power * Math.cos(angle)
  distY = power * Math.sin(angle)

  console.log(distX);
  console.log(distY);

  p1 = userPosition
  p2 = new L.LatLng (latitude + distY), (longitude + distX)

  linePoints = [p1, p2]

  if powerLine == null
    powerLine = new L.Polyline linePoints
    map.addLayer powerLine

# Update the user's position
updatePosition = (position) ->
  latitude  = position.coords.latitude
  longitude = position.coords.longitude
  accuracy  = position.coords.accuracy
  heading   = position.coords.heading
  speed     = position.coords.speed

  # Where is the user?
  userPosition = new L.LatLng latitude, longitude # geographical point (longitude and latitude)

  if userMarker == null
    userMarker = new L.Marker userPosition
    map.addLayer userMarker
    map.setView userPosition, 13
  else
    userMarker.setLatLng userPosition

  # Update the power line, as the user has moved
  updatePowerLine(latitude, longitude)
    
  console.log "Updated Position on Map", position

  ajax_data = {
    user: {
      position_attributes: {
        latitude: latitude,
        longitude: longitude,
      }
    }
  }

  $.ajax({
    type: 'PUT',
    url: window.get_user().url,
    data: ajax_data,
    success: (data, textStatus, jqXHR) ->
      console.log "Updated Position in DB",
    dataType: 'json'
  })
  console.log("Started Ajax");

# GO!
$(document).ready ->
  console.log window.get_user()
  setup_map()

  # Check if client supports geolocation api
  if navigator.geolocation
    # Get the users current position
    navigator.geolocation.watchPosition(
      (position) ->
        # success  
        console.log "Got Position"
        updatePosition position
      (error) ->
        # failure
        console.error "Couldn't get position"
    {
      timeout: (5 * 1000),
      maximumAge: (1000 * 5),
      enableHighAccuracy: true
    })
  else # finish the error checking if the client is not compliant with the spec
    console.error "Client Doesn't Support Geolocation API"
