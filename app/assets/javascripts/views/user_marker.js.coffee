###
# View to represent user position
###
window.ArmyIcon = L.Icon.extend({
    iconUrl: 'assets/map_icons/military/jeep.png',
    iconSize: new L.Point(32, 37),
    shadowSize: new L.Point(32, 37),
    iconAnchor: new L.Point(16, 37),
    popupAnchor: new L.Point(-3, -6)
});

window.UserMarkerView = Backbone.View.extend({
  tagName: "div"
  className: "user_marker"

  initialize: () ->
    this.model.on("change:latitude change:longitude", this.render, this)

  _getLatitude: () ->
    this.model.get('latitude')
  
  _getLongitude: () ->
    this.model.get('longitude')

  render: () ->
    userPosition = new L.LatLng(this._getLatitude(), this._getLongitude())

    if 'userMarker' of this
      this.userMarker.setLatLng userPosition
      # focus the map on this position
      window.gameView.map.setView userPosition, 13
    else
      armyIcon = new ArmyIcon()
      this.userMarker = new L.Marker(userPosition, {icon: armyIcon});
      window.gameView.map.addLayer this.userMarker

})