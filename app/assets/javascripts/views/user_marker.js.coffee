###
# View to represent user position
###
window.JeepIcon = L.Icon.extend({
    iconUrl: 'assets/map_icons/military/blue/jeep.png',
    shadowUrl: 'assets/marker-shadow.png',
    iconSize: new L.Point(32, 37),
    shadowSize: new L.Point(41, 41),
    iconAnchor: new L.Point(16, 36),
    popupAnchor: new L.Point(-3, -32)
});

window.GravatarIcon = L.Icon.extend({
    shadowUrl: null,
    iconSize: new L.Point(48, 48),
    iconAnchor: new L.Point(24, 24),
    popupAnchor: new L.Point(-3, -32)
});

window.UserMarkerView = Backbone.View.extend({
  tagName: "div"
  className: "user_marker"

  zIndexOffset: 10
  zoomToMarkerOnCreation: true

  initialize: () ->
    # When the latitude or longitude of the user changes, re-render the marker
    this.model.on("change:position", this.render, this)

  _getLatitude: () ->
    this.model.getLatitude()

  _getLongitude: () ->
    this.model.getLongitude()

  _createIcon: (url) ->
    new window.GravatarIcon(url)

  render: () ->
    userPosition = new L.LatLng(this._getLatitude(), this._getLongitude())

    if 'userMarker' of this
      this.userMarker.setLatLng userPosition
    else
      icon = this._createIcon(@model.getGravatarIconUrl({size: 48}))
      @userMarker = new L.Marker(userPosition, {icon: icon, @zIndexOffset});
      window.gameView.map.addLayer @userMarker
      # focus the map on this position
      if @zoomToMarkerOnCreation
        window.gameView.map.setView userPosition, 13

})
