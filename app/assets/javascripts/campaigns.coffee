# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.update_campaign input').bind 'blur', ->
    $('.update_campaign').submit()

  $('.update_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'PUT'
        dataType: 'json',
        data: $(".update_campaign").serialize()
        success: (data, text, jqXHR) ->
          Materialize.toast('Campanha atualizada', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na atualização da Campanha', 4000, 'red')
    return false

  $('.remove_campaign').click (e) ->
    $('#remove_campaign_modal').modal('open')
    return false

  $('.remove_campaign_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          $(location).attr('href','/campaigns');
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na remoção da Campanha', 4000, 'red')
    return false

  $('.raffle_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          Materialize.toast('Tudo certo, em breve os participantes receberão um email!', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast(jqXHR.responseText, 4000, 'red')
    return false
