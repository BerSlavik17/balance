$(document).ready(function() {
  var items_container = $('table#items').children('tbody');
  var consolidates    = $('table#consolidates').find('tr');

  var months  = $('a.month');
  var years   = $('a.year');
  
  var cashes        = $('a.cash');
  var edit_cash     = $('form#edit-cash');
  var cash_name     = $('input#cash_name');
  var cash_sum      = $('input#cash_sum');
  var cash_deleted  = $('input#cash_deleted');

  var new_cash      = $('a#new_cash');
  var new_cash_form = $('#new_cash_form'); 
  var new_cash_name = $('input#new_cash_name');
  var new_cash_sum  = $('input#new_cash_sum');

  var balance = $('#balance');
  var at_end  = $('#at_end');

  var new_item_form     = $('form#new_item');
  var item_date         = $('#item_date');
  var item_summa        = $('#item_summa');
  var item_category_id  = $('#item_category_id');
  var item_description  = $('#item_description');
  var item_submit       = $('#item_submit');
  var cancel            = $('#cancel');
  var cancel_button     = $('#cancel_button');
  var hidden_method     = $('#hidden_method');
  var delete_button     = $('#delete_button');

  var errors      = $('#errors');
  var ajax_loader = $('#ajax-loader');

  var items = $('a.item');

  // Глобальные AJAX-события
  $(document).ajaxStart(function() { ajax_loader.show() });
  $(document).ajaxStop(function() { ajax_loader.hide() }); 

  // Инициализация поля с календариком
  $.datepicker.setDefaults($.datepicker.regional[ 'ru' ]);
  $.datepicker.setDefaults({  
    buttonImageOnly: true,
    buttonImage: '/images/calendar.gif',
    showOn: 'both'
  });
  $('input#item_date').datepicker(); 

  // Инициализация окна с ошибками валидации
  errors.dialog({
    autoOpen: false,
    modal: true,
    title: 'Ошибки:'
  });

  // Инициализация окна для редактирования остатка
  edit_cash.dialog({
    autoOpen: false,
    modal: true,
    title: 'Редактирование остатка',
    width: '300px',
    open: function() {
      cash_sum.focus();
      cash_deleted.attr('checked', false);
    }
  })

  // Инициализация окна для нового остатка
  new_cash_form.dialog({
    autoOpen: false,
    modal: true,
    title: 'Новый остаток',
    width: '300px',
    open: function() {
      new_cash_sum.val('');
      new_cash_name.val('');
      $('#new_cash_submit').attr('disabled', false);
      $('#errors_for_new_cash').text('');
    }
  })

  function parse_url(url) {
    var default_url = '/';

    if(url && url.length > 0) {
      var arrs = url.split('#');

      if(arrs[1]) {
        return arrs[1];
      } else {
        return default_url;
      }
    } else {
      return default_url;
    }
  };

  // алиас
  function parseUrl(url) {
    return parse_url(url);
  }

  // функция преобразования item в html
  function item2html(item, klass) {
    var html = '';
    html += '<tr class="' + klass + '" id="item_' + item.id + '">';
      html += '<td class="date">' + item.date + '</td>';
      html += '<td class="sum"><a href="/items/' + item.id +'/edit" class="item">' + item.sum + '</a></td>';
      html += '<td class="category">' + item.category_name + '</td>';
      html += '<td>' + item.description + '</td>';
    html += '</tr>';

    return html;
  }

  function parse_items(items) {
    var html = '';
    
    var klass = 'even';
    $.each(items, function(index, item) {
      html += item2html(item, klass);
      klass = (klass == 'odd' ? 'even' : 'odd');
    })

    if(html.length > 0) {
      items_container.html(html).parent().show();
    } else {
      items_container.html(function() {
        return '<tr><td colspan="4" class="notice">ничего не найдено</td></tr>'    
      })
    }
  }

  // обновить список Item за указанный отчетный период
  function make_request() {
    var self = $(this);
    var self_class = self.attr('class');

    if(/month/.test(self_class)) {
      months.removeClass('current');
    } else if(/year/.test(self_class)) {
      years.removeClass('current');
    }
    self.addClass('current');

    var url = parse_url(self.attr('href'));

    $.getJSON(url, parse_items);
    getConsolidates(url);  
  }

  // получить сводный отчет за месяц
  function getConsolidates(url) {
    if(url == undefined) { url = '/' };

    $.getJSON(
      '/items/consolidates' + url, 
      function(items) {
        consolidates.html(function() {
          return $.map(items, function(item) {
            var html = '';
            var klass = item.income ? 'income' : 'expense';
            html += '<td class="' + klass + '">';
              html += '<div class="category">';
                html += '<div class="name">' + item.category_name + '</div>';
                html += '<div class="sum"><a href="#">' + item.sum + '</a></div>';
              html += '</div>';
            html += '</td>';
            
            return html;
          }).join('');
        });
      }
    );
  }

  // функция для получения баланса
  function getBalance () {
    $.getJSON(
      '/balance', 
      function(json) {
        balance.html(json.balance);
      }
    );
  };

  // функция для получения остатка на конец
  function getAtEnd () {
    $.getJSON(
      '/cashes/at_end',
      function(json) {
        at_end.html(json.at_end);
      }
    );
  };

  // Вешаем события на нажатие на ссылку с месяцем или годом
  $(months).click(make_request);
  $(years).click(make_request);

  // Показываем форму для редактирования остатка при нажатии на ссылку с остатком
  cashes.click(function() {
    var self = $(this);

    $.getJSON(
      self.attr('href'),  
      function(cash) {
        cash_sum.val(cash.sum);
        cash_name.val(cash.name);
        edit_cash.attr('action', '/cashes/' + cash.id).dialog('open');
      }
    );

    return false;    
  })

  // Показываем форму для создания остатка при нажатии на ссылку #new_cash
  new_cash.click(function() {
    new_cash_form.dialog('open');

    return false;
  })

  // Показываем форму для редактирования item при нажатии на ее сумму
  $('a.item').live('click', function() {
    var self = $(this);

    $.getJSON(
      self.attr('href'),
      function(item) {
        item_date.val(item.date);
        item_summa.val(item.summa).focus();
        item_category_id.val(item.category_id);
        item_description.val(item.description);
        item_submit.val('обновить');

        new_item_form.attr('action', '/items/' + item.id);
        hidden_method.val('put');
        cancel.show();
        delete_button.show().find('#item_deleted').attr('checked', false);
      }
    );
    
    return false;    
  })

  // Обрабатываем нажатие на ссылку "отметить"
  // в форме редактирования Item
  cancel_button.click(function() {
    item_submit.val('сохранить');
    new_item_form.attr('action', '/items');
    hidden_method.val('post');
    
    item_date.val('');
    item_summa.val('');
    item_category_id.val(0);
    item_description.val('');

    cancel.hide();
    delete_button.hide().find('#item_delete').attr('checked', false);

    return false;    
  })

  // Обновляем остаток
  edit_cash.ajaxForm({
    dataType: 'json',
    success: function(cash) {
      if(cash.deleted == true) {
        $('a#cash-' + cash.id).parents('tr').remove();
      } else {
        $('a#cash-' + cash.id).text(cash.sum);
      }
      
      getBalance();
      getAtEnd();
      
      edit_cash.dialog('close');
    } 
  })

  // Создание новой записи
  new_item_form.ajaxForm({
    dataType: 'json',
    beforeSubmit: function() {
      item_submit.attr('disabled', true);
    },
    success: function(item) {
      var klass = items_container.children(':first-child').attr('class');
      klass = (klass == 'odd' ? 'even' : 'odd');

      if(hidden_method.val() == 'post') {
        items_container.prepend(function() { return item2html(item, klass) })
      } else if(hidden_method.val() == 'put') {
        if(item.deleted == true) {
          $('tr#item_' + item.id).remove();
        } else {
          $('tr#item_' + item.id).html(function() {
            var html = '';
            
            html += '<td class="date">' + item.date + '</td>';
            html += '<td class="sum"><a href="/items/' + item.id +'/edit" class="item">' + item.summa + '</a></td>';
            html += '<td class="category">' + item.category_name + '</td>';
            html += '<td>' + item.description + '</td>';

            return html;  
          })
        }

        item_submit.val('сохранить');
        new_item_form.attr('action', '/items');
        hidden_method.val('post');
        cancel.hide();
        delete_button.hide().find('#item_delete').attr('checked', false);
      }

      item_date.val('');
      item_summa.val('');
      item_category_id.val(0);
      item_description.val('');

      getConsolidates();
      getAtEnd();
      getBalance();
    },
    complete: function() {
      item_submit.attr('disabled', false);
    },
    error: function(xhr) {
      var failures = $.parseJSON(xhr.responseText);
      var html = '';
      $.each(failures, function(field, message) {
        html += '<ul>';
          html += '<li><strong>' + field + '</strong>:&nbsp;' + message +'</li>';
        html += '</ul>';
      })

      errors.html(html).dialog('open');
    }
  })

  // список items на дату по-умолчанию
  $.getJSON('/items', parse_items);

  // сводный отчет за месяц
  getConsolidates();

  // посчитать баланс
  getBalance();

  // посчитать остаток на конец
  getAtEnd();
})
