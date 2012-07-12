###
# View to represent the attack interface
###
window.AttackInterfaceView = Backbone.View.extend({
  tagName: "div"
  className: "attack_interface"

  initialize: () ->
    this._getPowerSlider().data('view', this)

  events: {
    "change .power_input": "_powerInputChanged"
  }

  _updatePowerOnModel: () ->
    this.model.set('power', this._getPowerInput().val())

  _powerInputChanged: () ->
    this.render()
    this._updatePowerOnModel()

  _getPowerSlider: () ->
    this.$el.find('.power_slider')

  _getPowerInput: () ->
    this.$el.find('.power_input')

  render: () ->
    this._getPowerSlider().slider(
      min: 1
      max: 100
      value: this._getPowerInput().val()
      slide: ( event, ui ) ->
        view = $(this).data('view')
        view._getPowerInput().val( ui.value )
        # Fire the change event on the power input
        view._getPowerInput().change()
    )

})
