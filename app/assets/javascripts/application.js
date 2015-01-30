//= require jquery
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery-ui/datepicker
//= require jquery-ui/datepicker-uk
//= require jquery-ui/position
//= require jquery-ui/widget
//= require jquery-ui/button
//= require jquery-ui/dialog
//= require_self

$(function() {
  // Глобальные AJAX-события
  $(document).ajaxStart(function() { $('#ajax-loader').show() });
  $(document).ajaxStop(function() { $('#ajax-loader').hide() }); 

  // Инициализация поля с календариком
  $.datepicker.setDefaults($.datepicker.regional['ru']);

  $('input.date').datepicker();
})
