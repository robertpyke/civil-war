window.EnemyJeepIcon = L.Icon.extend({
    iconUrl: 'assets/map_icons/military/red/jeep.png',
    iconSize: new L.Point(32, 37),
    shadowSize: new L.Point(32, 37),
    iconAnchor: new L.Point(16, 37),
    popupAnchor: new L.Point(-3, -6)
});

window.EnemyUserMarkerView = window.UserMarkerView.extend({
  _createIcon: () ->
    new EnemyJeepIcon()
})
