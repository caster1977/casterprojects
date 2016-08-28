<?php

class controller_profile extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->allowed_actions = array('edit', 'delete', 'logon', 'logoff');
    $this->model = new model_profile();
  }

  function action_index()
  {
    if (isset($_SESSION, $_SESSION['user_id']))
    {
      if (isset($_POST['action']))
      {
        $action = strtolower($_POST['action']);
        if (in_array($action, $this->allowed_actions))
        {
          $action = $_POST['action']."_data";
          $_SESSION[__CLASS__."_action_result"] = $this->model->$action($_POST);
        }
        header('location:'.$_SERVER['REQUEST_URI']);
      }
      else
      {
        $a = explode('/', $_SERVER['REQUEST_URI']);
        if (!empty($a[1]))
        {
          $data = $this->model->sel_data(array('employeeid'=>$_SESSION['user_id']));
          $this->view->generate('view_'.$a[1].'.php', 'view_template.php',
            $data, isset($_SESSION[__CLASS__."_action_result"]) ? $_SESSION[__CLASS__."_action_result"]: NULL);
        }
        if (isset($_SESSION[__CLASS__."_action_result"]))
        {
          unset($_SESSION[__CLASS__."_action_result"]);
        }
      }
    }
    else
    {
      header('location:/profile/logon/');
    }
  }

  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_profile_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/profile/');
    }
  }

  function action_logon()
  {
    if (isset($_POST, $_POST['login'], $_POST['password']))
    {
      require_once 'application/models/model_employees.php';
      $model_employees = new model_employees();
      $data = $model_employees->sel_data(array('login'=>$_POST['login'], 'passwordmd5'=>md5($_POST['password'])));
      if (count($data) === 1)
      {
        $_SESSION['logged'] = 1;
        $_SESSION['user_id'] = $data[0]['id'];
        $_SESSION['user_name'] = $data[0]['lastname'].' '.$data[0]['firstname'];
        if ($_SESSION['user_id'] === 1)
        {
          $_SESSION['avatar'] = '/images/islands-retina-50.jpg';
        }
        if ($_SESSION['user_id'] === 2)
        {
          $_SESSION['avatar'] = '/images/ilya.jpg';
        }
        header('location:/news/');
      }
      else
      {
        $this->view->generate('view_profile_logon.php', 'view_template.php');
      }
    }
    else
    {
      $this->view->generate('view_profile_logon.php', 'view_template.php');
    }
  }

  function action_logoff()
  {
    if (isset($_POST, $_POST['confirm'], $_SESSION, $_SESSION['logged']))
    {
      session_destroy();
      header('Location:/');
    }
    else
    {
      $this->view->generate('view_profile_logoff.php', 'view_template.php');
    }
  }
}


// /* проверка логина пользователя */
// $user_login = "";/* по-умолчанию берём пустой логин */
// if(isset($_POST['user_login'])) : /* если логин сохранён в переменной формы */
  // if(trim($_POST['user_login'] != "")): /* если логин в переменной формы не пустой */
    // $user_login = trim($_POST['user_login']);/* берём логин из переменной формы */
    // $_SESSION['user_login'] = $user_login; /* созраняем логин в переменных сессии */
  // endif;
// elseif(isset($_SESSION['user_login'])): /* иначе, если логин сохранён в переменных сессии */
  // if($_SESSION['user_login'] != ""): /* если логин в переменных сессии не пустой */
    // $user_login = $_SESSION['user_login'];/* берём логин из переменных сессии */
  // else: /* иначе */
    // unset($_SESSION['user_login']);/* удаляем логин из переменных сессии */
  // endif;
// endif;

// if($user_login != ""): /* если логин не пустой */
  // /* проверка пароля пользователя */
  // $user_password = "";/* по-умолчанию берём пустой пароль */
  // if(isset($_POST['user_password'])): /* если пароль сохранён в переменной формы */
    // $user_password = trim($_POST['user_password']);/* берём пароль из переменной формы */
    // $_SESSION['user_password'] = $user_password; /* сохраняем пароль в переменных сессии */
  // elseif(isset($_SESSION['user_password'])): /* иначе, если пароль сохранён в переменных сессии */
    // $user_password = $_SESSION['user_password'];/* берём пароль из переменных сессии */
  // endif;
// else:
  // unset($_SESSION['user_password']);/* удаляем пароль из переменных сессии */
// endif;
