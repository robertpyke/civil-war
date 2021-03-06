window.UserModel = Backbone.Model.extend({
  urlRoot: '/users'

  defaults: {
    position: {
      latitude: 0
      longitude: 0
      accuracy: 99999999
      heading: 0
      speed: 0
    }
    attack_power: 20
    attack_angle: 90
  }

  initialize: () ->
    this

  getLatitude: ->
    @get('position')['latitude']

  getLongitude: ->
    @get('position')['longitude']

  updatePosition: (position) ->
    # Set all the key/value pairs avail in position coords
    this.set( {
      position: position.coords
    })
    this

  # See: http://en.gravatar.com/site/implement/images/
  # for gravatar request API
  getGravatarIconUrl: (options = {}) ->
    _defaultSize = 80
    size = options['size'] || _defaultSize
    email = @get('email')
    hash = md5 @get('email')
    console.log("hash", email, hash)

    # d options inclue:
    #   404
    #   mm: mystery man
    #   identicon
    #   monsterid
    #   wavatar
    #   retro
    url = "http://www.gravatar.com/avatar/" + hash + "?s=" + size + "&d=wavatar"

  # Nest the position attributes correctly
  toJSON: ->
    attrs = _.clone(@attributes)
    attrs.position_attributes = _.clone @attributes.position
    delete attrs.position
    attrs
})
