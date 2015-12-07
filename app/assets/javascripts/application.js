// = require jquery
// = require jquery_ujs
// = require bootstrap/util
// = require bootstrap/modal
// = require bootstrap-datepicker/core
// = require bootstrap-datepicker/locales/bootstrap-datepicker.ua
//
// = require_self

$(function() {
  // Глобальные AJAX-события
  // $(document).ajaxStart(function() { $('#ajax-loader').show() });
  // $(document).ajaxStop(function() { $('#ajax-loader').hide() });

  // Инициализация поля с календариком
  // $.datepicker.setDefaults($.datepicker.regional['ru']);

  $('.bootstrap-datepicker').datepicker({ format: 'dd.mm.yyyy', autoclose: true, language: 'ua' });
})
