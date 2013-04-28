//= require jquery
//= require jquery-ui
//= require jquery.ui.datepicker-ru
//= require rails
//= require_self

$(function() {
  // Глобальные AJAX-события
  $(document).ajaxStart(function() { $('#ajax-loader').show() });
  $(document).ajaxStop(function() { $('#ajax-loader').hide() }); 

  // Инициализация поля с календариком
  $.datepicker.setDefaults($.datepicker.regional['ru']);

  $('.date').datepicker();
})
