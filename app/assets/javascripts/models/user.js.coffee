window.UserModel = Backbone.Model.extend({
  defaults: {
    latitude: 0
    longitude: 0
    accuracy: 99999999
    heading: 0
    speed: 0

    attack_power: 20
    attack_angle: 90
  }

  initialize: () ->
    console.log "creating a user model"
    this


  updatePosition: (position) ->
    latitude  = position.coords.latitude
    longitude = position.coords.longitude
    accuracy  = position.coords.accuracy
    heading   = position.coords.heading
    speed     = position.coords.speed

    # Set all the key/value pairs avail in position coords
    this.set( position.coords )
    this

})
