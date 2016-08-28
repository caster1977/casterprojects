<?php
  $_SESSION['logged'] = 1;
  $_SESSION['user_id'] = 1;
  $_SESSION['user_name'] = 'caster';
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ez Cut Pro</title>
    <link type="text/css" rel="stylesheet" href="/css/bootstrap.css">
    <link type="text/css" rel="stylesheet" href="/css/style.css">
    <!--[if lt IE 9]>
      <script src="/js/html5shiv.min.js"></script>
      <script src="/js/respond.min.js"></script>
    <![endif]-->
    <meta name="description" content="Ez Cut Pro Online business card">
    <meta name="author" content="Ivanov Vladislav">
    <link rel="icon" href="/images/favicon.ico">
  </head>
  <body>
    <header class="navbar navbar-default navbar-fixed-top" role="banner">
      <div class="container-fluid">
  	    <div class="row">
          <div class="address-banner text-center col-xs-*">
            <abbr title="Monday-Saturday 8am-8pm (EST)">Phones:</abbr> 
            +19733424395 +12018736744, 
            <span class="text-nowrap">E-Mail:</span> 
            <a href="mailto:sales@ezcutpro.com">sales@ezcutpro.com</a>
          </div>
        </div>        
      </div>
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            </span>
          </button>
          <a class="navbar-brand text-uppercase" href="/">Ez Cut Pro<span> &#174</span></a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-left navbar-nav text-uppercase">
            <?php if (isset($_SESSION, $_SESSION['logged'], $_SESSION['user_id'], $_SESSION['user_name']) and $_SESSION['logged'] === 1):?>
            <li><a href="/features">features</a></li>
            <li><a href="/prices">prices</a></li>
            <li><a href="/blog">blog</a></li>
            <?php endif;?>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">explore <span class="caret"></span></a>
              <ul class="dropdown-menu text-capitalize-first" aria-labelledby="dropdownMenu3" role="menu">
                <li class="dropdown-header text-uppercase">company</li>
                <?php if (isset($_SESSION, $_SESSION['logged'], $_SESSION['user_id'], $_SESSION['user_name']) and $_SESSION['logged'] === 1):?>
                <li><a href="/about">about us</a></li>
                <?php endif;?>
                <li><a href="/contact">contact us</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <?php if (isset($_SESSION, $_SESSION['logged'], $_SESSION['user_id'], $_SESSION['user_name']) and $_SESSION['logged'] === 1):?>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle avatar" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                <?php if (isset($_SESSION, $_SESSION['avatar'])):?>
                <span>
                  <img class="img-circle img-avatar" alt="Avatar image" src="<?php echo $_SESSION['avatar'];?>">
                </span>
                <?php endif;?>
                <?php echo $_SESSION['user_name'];?>
                &nbsp;<span class="caret"></span>
              </a>
              <ul class="dropdown-menu text-capitalize-first" role="menu">
                <li><a  href="/profile">Profile</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="/profile/logoff">Logoff</a></li>
              </ul>
            </li>
            <?php else :?>
            <li class="text-uppercase"><a href="/profile/logon">Logon</a></li>
            <?php endif;?>
          </ul>
        </div>
      </div>
    </header>
    <main>
    <?php include 'application/views/'.$view_content; ?>
    </main>
    <footer>
      <div class="container-fluid">
  	    <div class="row">
          <div class="col-xs-*">
            <p>&#169 2016 Ez Cut Pro LLC</p>
          </div>
        </div>
      </div>
    </footer>
    <script src="/js/jquery-1.12.4.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/my.js"></script>
  </body>
</html>