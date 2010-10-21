$(document).ready(function() {
  // Глобальные AJAX-события
  $(document).ajaxStart(function() { $('#ajax-loader').show() });
  $(document).ajaxStop(function() { $('#ajax-loader').hide() }); 

  // Инициализация поля с календариком
  $.datepicker.setDefaults($.datepicker.regional[ 'ru' ]);
  $.datepicker.setDefaults({  
    buttonImageOnly: true,
    buttonImage: '/images/calendar.gif',
    showOn: 'both'
  });
  $('input#item_date').datepicker(); 

  // расскрасим таблицу Items
  $('#items').children('tr:odd').addClass('odd');
      
})

