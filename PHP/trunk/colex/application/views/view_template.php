<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Colex</title>
    <!-- подключение Bootstrap -->
    <link type="text/css" rel="stylesheet" href="/css/bootstrap.min.css">
    
    <!-- подключение пользовательских стилей -->
    <link type="text/css" rel="stylesheet" href="/css/style.css">
    
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="/js/html5shiv.min.js"></script>
      <script src="/js/respond.min.js"></script>
    <![endif]-->
    <meta name="description" content="Тестовый проект автоматизации учёта для Colex">
    <meta name="author" content="Иванов Влад">
    <link rel="icon" href="/images/favicon.ico">
  </head>
  <body>
    <!-- навигационная панель страницы -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <!-- логитип и кнопка объединены для лучшего отображения на мобилах -->
        <div class="navbar-header">
          <!-- кнопка выпадающего меню для мелких устройств-->
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <!-- логотип -->
          <a class="navbar-brand" href="#">colex</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav navbar-left text-uppercase">
            <li><a href="/">главная <span class="sr-only">(current)</span></a></li>
            <li><a href="/news">новости</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">справочники <span class="caret"></span></a>
              <ul class="dropdown-menu text-capitalize-first" aria-labelledby="dropdownMenu3">
                <li class="dropdown-header text-uppercase">Функционал</li>
                <li><a href="/functions">пользовательские функции</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Персонал</li>
                <li><a href="/positions">должности</a></li>
                <li><a href="/employees">работники</a></li>
                <li><a href="/employeepositions">должности работников</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Доступ</li>
                <li><a href="/accessgroups">группы доступа</a></li>
                <li><a href="/functionaccess">доступ к функционалу</a></li>
                <li><a href="/positionaccess">доступ должностей</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Связи</li>
                <li><a href="/cosignatorytypes">типы субъектов</a></li>
                <li><a href="/cosignatories">субъекты</a></li>
                <li><a href="/dealershipagreements">дилерские соглашения</a></li>
                <li><a href="/warrantytypes">типы гарантий</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Продукция</li>
                <li><a href="/models">модели оборудования</a></li>
                <li><a href="/modelparttypes">типы частей моделей оборудования</a></li>
                <li><a href="/modelparts">части оборудования</a></li>
                <li><a href="/cosignments">партии изделий</a></li>
              </ul>
            </li>
            <li>
              <div class="form-group">
                <form class="navbar-form" role="search">
                  <input type="text" class="form-control text-capitalize" placeholder="поиск">
                  <button type="submit" class="btn btn-default text-capitalize">пуск</button>
                </form>            
              </div>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <!--li><a href="#">Войти</a></li-->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle avatar" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                <span><img class="img-circle img-avatar" alt="Profile Image" src="/images/islands-retina-50.jpg"></span>Влад Иванов <span class="caret"></span>
              </a>
              <ul class="dropdown-menu text-capitalize-first">
                <li><a href="#">настройка профиля</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="#">выйти</a></li>
              </ul>
            </li>
          </ul>          
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>
    <!-- тело страницы-->
    <div class="container-fluid">
      <?php include 'application/views/'.$view_content; ?>
    </div>
    <!-- футер страницы-->
    <footer class="footer">
      <div class="container-fluid">
        <p class="text-muted">Copyright, 2016 Иванов Влад, команда <a class="text-capitalize" href="#">colex</a>. Все права защищены.</p>
      </div>
    </footer>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="/js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/js/bootstrap.min.js"></script>
  </body>
</html>