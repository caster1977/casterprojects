<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta name="description" content="" />
  <meta name="keywords" content="" />
  <title>Colex</title>
  <link href="http://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet" type="text/css" />
  <link href="http://fonts.googleapis.com/css?family=Kreon" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="/css/oldstyle.css" />
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
        <a href="/">colex</a>
      </div>
    </div>    
    <div id="page">
      <div id="sidebar">
        <!--div class="side-box">
          <h3>новости</h3>
          <p align="justify" class="quote" >
            <b>todo:</b> добавить функционал по отображению текущих новостей компании.
          </p>
        </div-->
        <div class="side-box">
          <h3><a href="/">главная</a></h3>
          <h3><a href="/news">новости</a></h3>
          <div id="references">
            <h3>справочники</h3>
          </div>
          <noindex>
            <ul class="list" id="references_list">
              <li><a href="/functions">пользовательские функции</a></li>
              <li><a href="/positions">должности</a></li>
              <li><a href="/employees">работники</a></li>
              <li><a href="/employeepositions">должности работников</a></li>
              <li><a href="/accessgroups">группы доступа</a></li>
              <li><a href="/functionaccess">доступ к функционалу</a></li>
              <li><a href="/positionaccess">доступ должностей</a></li>
              <li><a href="/cosignatorytypes">типы субъектов</a></li>
              <li><a href="/cosignatories">субъекты</a></li>
              <li><a href="/dealershipagreements">дилерские соглашения</a></li>
              <li><a href="/warrantytypes">типы гарантий</a></li>
              <li><a href="/models">модели оборудования</a></li>
              <li><a href="/modelparttypes">типы частей моделей оборудования</a></li>
              <li><a href="/modelparts">части оборудования</a></li>
              <li><a href="/cosignments">партии изделий</a></li>
            </ul>            
          </noindex>
          <div id="reports">
            <h3>отчёты</h3>
          </div>
          <noindex>
            <ul class="list" id="reports_list">
              <li><a href="/reports/_1">отчёт #1</a></li>
              <li><a href="/reports/_2">отчёт #2</a></li>
              <li><a href="/reports/_3">отчёт #3</a></li>
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
            <li>skypeid: caster1977</li>
            <li>email: caster1977@yandex.ru</li>
          </ul>
        </div>
        <div id="page-bottom-content">
          <h3>о компании</h3>
          <p><b>todo:</b> добавить функционал по отображению информации о компании.</p>
        </div>
        <br class="clearfix" />
      </div>
    </div>
    <div id="footer">
      &copy; 2016 <a href="/">colex</a>
    </div>
    <script>$('#references').toggle(function() {$('#references_list').slideUp();}, function() {$('#references_list').slideDown();});</script>
    <script>$('#reports').toggle(function() {$('#reports_list').slideUp();}, function() {$('#reports_list').slideDown();});</script>
  </body>
</html>