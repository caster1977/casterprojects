<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    
     <!-- Custom styles for this template -->
    <link href="/css/sticky-footer-navbar.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="/js/html5shiv.min.js"></script>
      <script src="/js/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">colex</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav text-uppercase">
            <li class="_active"><a href="#">главная <span class="sr-only">(current)</span></a></li>
            <li><a href="#">новости</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">справочники <span class="caret"></span></a>
              <ul class="dropdown-menu text-capitalize-first" aria-labelledby="dropdownMenu3">
                <li class="dropdown-header text-uppercase">Функционал</li>
                <li><a href="#">пользовательские функции</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Персонал</li>
                <li><a href="#">должности</a></li>
                <li><a href="#">работники</a></li>
                <li><a href="#">должности работников</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Доступ</li>
                <li><a href="#">группы доступа</a></li>
                <li><a href="#">доступ к функционалу</a></li>
                <li><a href="#">доступ должностей</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Связи</li>
                <li><a href="#">типы субъектов</a></li>
                <li><a href="#">субъекты</a></li>
                <li><a href="#">дилерские соглашения</a></li>
                <li><a href="#">типы гарантий</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header text-uppercase">Продукция</li>
                <li><a href="#">модели оборудования</a></li>
                <li><a href="#">типы частей моделей оборудования</a></li>
                <li><a href="#">части оборудования</a></li>
                <li><a href="#">партии изделий</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li>
              <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                  <input type="text" class="form-control text-capitalize" placeholder="поиск">
                </div>
                <button type="submit" class="btn btn-default text-capitalize">пуск</button>
              </form>            
            </li>
            <!--li><a href="#">Войти</a></li-->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                <span><img class="img-circle img-avatar" alt="Profile Image" src="/images/islands-retina-50.jpg"></span> Влад Иванов <span class="caret"></span>
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
    <footer class="footer">
      <div class="container">
        <p class="text-muted">Copyright, 2016 Иванов Влад, команда <a class="text-capitalize" href="#">colex</a>. Все права защищены.</p>
      </div>
    </footer>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="/js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/js/bootstrap.min.js"></script>
  </body>
</html>