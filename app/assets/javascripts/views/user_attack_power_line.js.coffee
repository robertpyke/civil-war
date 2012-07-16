###
# View to represent the attack interface
###
window.AttackPowerLineView = Backbone.View.extend({
  tagName: "div"
  className: "attack_power_line"

  initialize: () ->

    # when the attack_power or attack_angle on the model changes, re-render
    this.model.on("change:attack_power change:attack_angle change:position", this.render, this)

  render: () ->
    powerDivFactor = 1000

    latitude  = this.model.getLatitude()
    longitude = this.model.getLongitude()

    userPosition = new L.LatLng(latitude, longitude)

    angleRadians              = this.model.get('attack_angle') * (Math.PI/180)
    powerInDecDegrees         = this.model.get('attack_power') / powerDivFactor
    powerCircleRadiusInMeters = this.model.get('attack_power') * 10

    distX = powerInDecDegrees * Math.cos(angleRadians)
    distY = powerInDecDegrees * Math.sin(angleRadians)

    p1 = userPosition
    p2 = new L.LatLng (latitude + distX), (longitude + distY)

    linePoints = [p1, p2]

    if 'powerLine' of this
      this.powerLine.setLatLngs(linePoints)
    else
      this.powerLine = new L.Polyline linePoints
      window.gameView.map.addLayer this.powerLine

    if 'powerCircle' of this
      this.powerCircle.setLatLng(p2)
      this.powerCircle.setRadius(powerCircleRadiusInMeters)
    else
      this.powerCircle = new L.Circle(p2)
      this.powerCircle.setRadius(powerCircleRadiusInMeters)
      window.gameView.map.addLayer this.powerCircle

    this

})
