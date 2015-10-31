# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#editable_div').keydown (e) ->
    keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145]

    if($.inArray(e.keyCode, keys) == -1)
      if(checkMaxLength(@innerHTML, 15))
        e.preventDefault()
        e.stopPropagation()

  checkMaxLength = (text, max) ->
     text.length >= max
  $('#input-tweet').on 'input', (e) ->
    symbolsCount = $('#input-tweet').val().length
    $('#input-tweet-number-of-symbols').html(symbolsCount)
    $('#pro1').attr('aria-valuenow', symbolsCount)
    $('#pro1').css('width', symbolsCount + '%')