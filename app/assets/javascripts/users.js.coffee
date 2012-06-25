# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.get_user = () ->
  {
    email: $('#user_details').data('email'),
    url: $('#user_details').data('url'),
    id: $('#user_details').data('id'),
  }

