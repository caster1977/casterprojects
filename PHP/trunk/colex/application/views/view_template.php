<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta name="description" content="" />
  <meta name="keywords" content="" />
  <title>Colex</title>
  <link href="http://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet" type="text/css" />
  <link href="http://fonts.googleapis.com/css?family=Kreon" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="/css/style.css" />
  <script src="/js/jquery-1.6.2.js" type="text/javascript"></script>
  <script type="text/javascript">
    // return a random integer between 0 and number
    function random(number)
    {
      return Math.floor(Math.random() * (number + 1));
    };

    // show random quote
    $(document).ready
    (
      function()
      { 
        var quotes = $('.quote');
        quotes.hide();      
        var qlen = quotes.length; //document.write( random(qlen-1) );
        $('.quote:eq(' + random(qlen-1) + ')').show(); //tag:eq(1)
      }
    );
  </script>
</head>
<body>
  <div id="wrapper">
    <div id="header">
      <div id="logo">
        <a href="/">Colex</a>
      </div>
    </div>    
    <div id="page">
      <div id="sidebar">
        <!--div class="side-box">
          <h3>Новости</h3>
          <p align="justify" class="quote" >
            <b>TODO:</b> Добавить функционал по отображению текущих новостей компании.
          </p>
        </div-->
        <div class="side-box">
          <h3><a href="/">Главная</a></h3>
          <h3><a href="/News">Новости</a></h3>
          <div id="references">
            <h3>Справочники</h3>
          </div>
          <noindex>
            <ul class="list" id="references_list">
              <li class="first"><a href="/Functions">Пользовательские функции</a></li>
              <li><a href="/Positions">Должности</a></li>
              <li><a href="/Employees">Работники</a></li>
              <li><a href="/EmployeePositions">Должности работников</a></li>
              <li><a href="/AccessGroups">Группы доступа</a></li>
              <li><a href="/FunctionAccess">Доступ к функционалу</a></li>
              <li><a href="/PositionAccess">Доступ должностей</a></li>
              <li><a href="/CosignatoryTypes">Типы субъектов</a></li>
              <li><a href="/Cosignatories">Субъекты</a></li>
              <li><a href="/DealershipAgreements">Дилерские соглашения</a></li>
              <li><a href="/WarrantyTypes">Типы гарантий</a></li>
              <li><a href="/Models">Модели оборудования</a></li>
              <li><a href="/ModelPartTypes">Типы частей моделей оборудования</a></li>
              <li><a href="/ModelParts">Части оборудования</a></li>
              <li class="last"><a href="/Cosignments">Партии изделий</a></li>
            </ul>            
          </noindex>
          <div id="reports">
            <h3>Отчёты</h3>
          </div>
          <noindex>
            <ul class="list" id="reports_list">
              <li class="first"><a href="/Reports/_1">Отчёт #1</a></li>
              <li><a href="/Reports/_2">Отчёт #2</a></li>
              <li class="last"><a href="/Reports/_3">Отчёт #3</a></li>
            </ul>            
          </noindex>
          <h3><a href="/Contacts">Контакты</a></h3>
        </div>
      </div>
      <div id="content">
        <div class="box">
          <?php include 'application/views/'.$view_content; ?>
        </div>
        <br class="clearfix" />
      </div>
      <div id="page-bottom">
        <div id="page-bottom-sidebar">
          <h3>Наши контакты</h3>
          <ul class="list">
            <li class="first">skypeid: caster1977</li>
            <li class="last">email: caster1977@yandex.ru</li>
          </ul>
        </div>
        <div id="page-bottom-content">
          <h3>О Компании</h3>
          <p><b>TODO:</b> Добавить функционал по отображению информации о компании.</p>
        </div>
        <br class="clearfix" />
      </div>
    </div>
    <div id="footer">
      &copy; 2016 <a href="/">Colex</a>
    </div>
    <script>$('#references').toggle(function() {$('#references_list').slideUp();}, function() {$('#references_list').slideDown();});</script>
    <script>$('#reports').toggle(function() {$('#reports_list').slideUp();}, function() {$('#reports_list').slideDown();});</script>
  </body>
</html>