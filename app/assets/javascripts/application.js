//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
//= require_tree .

$(document).on('turbolinks:load', function(){
    $('.modal').modal();
  });