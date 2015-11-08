# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#recip').tokenInput(
    '/v1/relationships.json',
    theme: 'facebook'
    hintText: 'hint text'
    crossDomain: false
    searchingText: 'searching txt'
  )

