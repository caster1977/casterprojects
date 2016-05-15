<?php

class controller_profile extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->allowed_actions = array('edit', 'delete');
    $this->model = new model_profile();
  }
  
  function action_index()
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
        $data = $this->model->sel_data(array('employeeid'=>1));
        $this->view->generate('view_'.$a[1].'.php', 'view_template.php',
          $data, isset($_SESSION[__CLASS__."_action_result"]) ? $_SESSION[__CLASS__."_action_result"]: NULL);
      }
      if (isset($_SESSION[__CLASS__."_action_result"]))
      {
        unset($_SESSION[__CLASS__."_action_result"]);
      }
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
}