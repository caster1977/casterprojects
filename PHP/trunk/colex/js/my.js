$(document).ready
(
  function()
  {
    var id_buttons = $('button:submit[name="id"]'); // получаем все кнопки действий, требуюих идентификатора
    id_buttons.addClass("disabled"); // делаем их недоступными
    
    $('.selectable tr').click // вещаем обработчик на событие клика выделяемой строке таблиц
    (
      function()
      {
        var lines = $('.selectable tr'); // получаем все строки таблицы
        lines.removeClass("active"); // убираем выделение со всех строк таблицы
        $(this).addClass("active"); // выделяем строку таблицы, по которой был выполнен щелчок
        var id = $(this).attr("id"); // получаем идентификатор выделенной строки
        if (id >= 0) //
        { // прописываем идентификатор записи в кнопки действий
          id_buttons.val(id);
          id_buttons.removeClass("disabled");
        }
        
        // дальше кусок "про запас"
        /*var buttons = $('.selectable tr td form button:submit');
        buttons.addClass("hidden");
        $('.active td form button:submit').removeClass("hidden");*/
        //alert('!');
      }
    );
  }
);
