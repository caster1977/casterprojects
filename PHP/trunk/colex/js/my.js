$(document).ready
(
  function()
  {
    $('.selectable tr').click
    (
      function()
      {
        // у всех строк таблицы убираем класс active
        var lines = $('.selectable tr');
        lines.removeClass("active");
        // добавляем класс active строке таблицы, по которой был выполнен щелчок
        $(this).addClass("active");
        var buttons = $('.selectable tr td form button:submit');
        buttons.addClass("hidden");
        $('.active td form button:submit').removeClass("hidden");        
        //alert('!');
      }
    );
  }
);
