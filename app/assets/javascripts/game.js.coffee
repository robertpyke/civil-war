# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# File globals

# Code to watch the user position
# NOTE: Leaflet has methods to do this as well
_setupPositionWatcher = () ->
  # Check if client supports geolocation api
  if navigator.geolocation
    # Get the users current position
    navigator.geolocation.watchPosition(
      (position) ->
        console.log "Got Position"
        window.user.updatePosition position
      (error) ->
        # failure
        console.error "Couldn't get position"
    {
      timeout: (5 * 1000),
      maximumAge: (1000 * 5),
      enableHighAccuracy: true
    })
    true
  else # finish the error checking if the client is not compliant with the spec
    console.error "Client Doesn't Support Geolocation API"
    false

$ ->
  # If we are looking at the map page...
  if document.getElementById 'map'
    # Create a view for the overall game (incl. assocaited game map)
    window.gameView = new window.MapView({
      id: 'map'
    })
    gameView.setupMap()

    # Create a model to represent the user
    window.user = new window.UserModel({
      # TODO
      # ----
      #
      # Set the user info based on the data in the user div.
      # Set up a global containing these vars,
      # then set them on the user model.
    })

    # Associate the userMarker with the user model
    window.userMarkerView = new window.UserMarkerView({
      model: window.user
    })

    # Associate the userMarker with the user model
    window.attackInterfaceView = new window.AttackInterfaceView({
      model: window.user
      id: 'attack_interface'
      el: document.getElementById('attack_interface')
    })
    window.attackInterfaceView.render()

    # Associate the AttackPowerLine with the user model
    window.attackPowerLineView= new window.AttackPowerLineView({
      model: window.user
    })

    _setupPositionWatcher()
