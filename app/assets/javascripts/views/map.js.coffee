# MapView Definition
window.MapView = Backbone.View.extend({
  tagName: "div"
  className: "map"

  setupMap: () ->
    map               = new L.Map this.id
    cloudmade         = new L.TileLayer 'http://{s}.tile.cloudmade.com/66c4371c1b2941e8a77e68b72074c150/997/256/{z}/{x}/{y}.png', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18
    }
    london = new L.LatLng 51.505, -0.09 # geographical point (longitude and latitude)
    map.setView(london, 13).addLayer(cloudmade)

    this.map = map

})
