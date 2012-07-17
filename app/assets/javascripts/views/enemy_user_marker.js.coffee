window.EnemyJeepIcon = L.Icon.extend({
    iconUrl: 'assets/map_icons/military/red/jeep.png',
    shadowUrl: 'assets/marker-shadow.png',
    iconSize: new L.Point(32, 37),
    shadowSize: new L.Point(41, 41),
    iconAnchor: new L.Point(16, 36),
    popupAnchor: new L.Point(-3, -32)
});

window.EnemyUserMarkerView = window.UserMarkerView.extend({
  zIndexOffset: -10
  zoomToMarkerOnCreation: false
})
