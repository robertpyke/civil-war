###
# View to represent user position
###
window.JeepIcon = L.Icon.extend({
    iconUrl: 'assets/map_icons/military/blue/jeep.png',
    shadowUrl: 'assets/marker-shadow.png',
    iconSize: new L.Point(32, 37),
    shadowSize: new L.Point(32, 37),
    iconAnchor: new L.Point(16, 37),
    popupAnchor: new L.Point(-3, -6)
});

window.UserMarkerView = Backbone.View.extend({
  tagName: "div"
  className: "user_marker"

  zIndexOffset: 10


  initialize: () ->
    # When the latitude or longitude of the user changes, re-render the marker
    this.model.on("change:position", this.render, this)

  _getLatitude: () ->
    this.model.getLatitude()

  _getLongitude: () ->
    this.model.getLongitude()

  _createIcon: () ->
    new JeepIcon()

  render: () ->
    userPosition = new L.LatLng(this._getLatitude(), this._getLongitude())

    if 'userMarker' of this
      this.userMarker.setLatLng userPosition
    else
      icon = this._createIcon()
      @userMarker = new L.Marker(userPosition, {icon: icon, @zIndexOffset});
      window.gameView.map.addLayer @userMarker
      # focus the map on this position
      window.gameView.map.setView userPosition, 13

})
