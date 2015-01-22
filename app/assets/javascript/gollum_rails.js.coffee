//= require jquery
//= require jquery_ujs
//= require jquery-ui


$("#myTab a").click (e) ->
  e.preventDefault()
  $(this).tab "show"
  return

jQuery('a[data-toggle="tab"]').on 'shown.bs.tab' ,  (e) ->
  pageTarget = $(e.target).attr('href');
  jQuery.ajax(url: "/orders/" + gon.order_id + "/button_list.html").done (html) ->
    $(".preview_tab").append html
