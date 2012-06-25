# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# File globals
map = null
from_projection = null
to_projection = null
tank_marker_layer = null
user_geom = null
user_feature = null

# Set up the map
setup_map = () ->
  map               = new OpenLayers.Map "map"
  mapnik            = new OpenLayers.Layer.OSM
  from_projection   = new OpenLayers.Projection "EPSG:4326"   # Transform from WGS 1984
  to_projection     = new OpenLayers.Projection "EPSG:900913" # to Spherical Mercator Projection
  position          = new OpenLayers.LonLat(153,-27.5).transform(from_projection, to_projection)
  zoom              = 10
  tank_vector_layer = new OpenLayers.Layer.Vector("Tank Vectors")
  
  # Add the base layer
  map.addLayer(mapnik)
  # Add the vector tank layer
  map.addLayer(tank_vector_layer)
  # Set the map's center
  map.setCenter(position, zoom )

  user_geom   = new OpenLayers.Geometry.Point(0, 0)
#  user_geom   = new OpenLayers.Geometry.Point(position.lon, position.lat)
  user_feature = new OpenLayers.Feature.Vector user_geom 
  user_feature.move position
  tank_vector_layer.addFeatures [user_feature]


# Update the user's position
update_position = (position) ->
  user_position = new OpenLayers.LonLat(position.coords.longitude, position.coords.latitude)
  transformed_user_position = user_position.transform(from_projection, to_projection)
  user_feature.move transformed_user_position
  map.setCenter transformed_user_position
  console.log "Updated Position", position

# GO!
$(document).ready ->
  setup_map()

  # Check if client supports geolocation api
  if navigator.geolocation
    # Get the users current position
    navigator.geolocation.watchPosition(
      (position) ->
        # success  
        console.log "Got Position"
        update_position position
        #mapServiceProvider(position.coords.latitude,position.coords.longitude);
      (error) ->
        # failure
        console.error "Couldn't get position"
    {
      timeout: (5 * 1000),
      maximumAge: (1000 * 5),
      enableHighAccuracy: true
    })
  else # finish the error checking if the client is not compliant with the spec
    console.error "Client Doesn't Support Geolocation API"
