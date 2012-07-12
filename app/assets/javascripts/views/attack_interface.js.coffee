###
# View to represent the attack interface
###
window.AttackInterfaceView = Backbone.View.extend({
  tagName: "div"
  className: "attack_interface"

  initialize: () ->
    this._getAttackPowerSlider().data('view', this)
    this._getAttackPowerSlider().data('setup', false)

    this._getAttackAngleSlider().data('view', this)
    this._getAttackAngleSlider().data('setup', false)

    # when the attack_power or attack_angle on the model changes, re-render
    this.model.on("change:attack_power", this.renderAttackPowerDiv, this)
    this.model.on("change:attack_angle", this.renderAttackAngleDiv, this)

  events: {
    "change .attack_power_input": "_attackPowerInputChanged"
    "change .attack_angle_input": "_attackAngleInputChanged"
  }

  ###
  # Power
  ###
  # when attack_power input changes, update the attack_power on the model
  _attackPowerInputChanged: () ->
    this.model.set('attack_power', this._getAttackPowerInput().val())

  _getAttackPowerSlider: () ->
    this.$el.find('.attack_power_slider')

  _getAttackPowerInput: () ->
    this.$el.find('.attack_power_input')

  # Updates both the slider and the input box with the correct values
  renderAttackPowerDiv: () ->
    # update text input
    this._getAttackPowerInput().val( this.model.get('attack_power') )
    # update slider
    # -------------
    # be smart about it, create the slider on the first go,
    # then only update the position of the handle on the slider
    if this._getAttackPowerSlider().data('setup')
      this._getAttackPowerSlider().slider('option', 'value', this.model.get('attack_power'))
    else
      this._getAttackPowerSlider().slider(
        min: 1
        max: 100
        value: this.model.get('attack_power')
        slide: ( event, ui ) ->
          view = $(this).data('view')
          view.model.set('attack_power', ui.value)
      )
      $(this._getAttackPowerSlider()).draggable()
      this._getAttackPowerSlider().data('setup', true)

    this

  ###
  # Angle
  ###

  # when attack_angle input changes, update the attack_angle on the model
  _attackAngleInputChanged: () ->
    this.model.set('attack_angle', this._getAttackAngleInput().val())

  _getAttackAngleSlider: () ->
    this.$el.find('.attack_angle_slider')

  _getAttackAngleInput: () ->
    this.$el.find('.attack_angle_input')

  # Updates both the slider and the input box with the correct values
  renderAttackAngleDiv: () ->
    # update text input
    this._getAttackAngleInput().val( this.model.get('attack_angle') )
    # update slider
    # -------------
    # be smart about it, create the slider on the first go,
    # then only update the position of the handle on the slider
    if this._getAttackAngleSlider().data('setup')
      this._getAttackAngleSlider().slider('option', 'value', this.model.get('attack_angle'))
    else
      this._getAttackAngleSlider().slider(
        min: 1
        max: 360
        value: this.model.get('attack_angle')
        slide: ( event, ui ) ->
          view = $(this).data('view')
          view.model.set('attack_angle', ui.value)
      )
      $(this._getAttackAngleSlider()).draggable()
      this._getAttackAngleSlider().data('setup', true)

    this

  render: () ->
    this.renderAttackPowerDiv()
    this.renderAttackAngleDiv()

    this

})
