//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap

$(document).ready ->
  $(".preview_link").click (e) ->
    e.preventDefault
    $("#preview_content").html  "Loading . . . "
    $(this).tab "show"
    request = jQuery.ajax(
      url: "/wiki/preview"
      type: "POST"
      data:
        content: "some **data**"
      dataType: "html"
    )
    request.done (html) ->
      $("#preview_content").html html
    request.fail (jqXHR, textStatus) ->
      $("#preview_content").html "Server Failed " + textStatus
    
    
    