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
    this


  updatePosition: (position) ->
    # Set all the key/value pairs avail in position coords
    this.set( position.coords )
    this

})
