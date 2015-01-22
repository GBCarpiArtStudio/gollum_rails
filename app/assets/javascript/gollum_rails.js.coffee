//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap

$(document).ready ->
  $(".preview_link").click (e) ->
    e.preventDefault
    $(this).tab "show"
    alert "done"