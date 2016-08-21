<?php

abstract class controller
{
	public $model;
	protected $view;
  protected $allowed_actions;
	
	function __construct()
	{
		$this->view = new view();
    $this->allowed_actions = array();
	}
	
  function action_index()
  {
    if (isset($_POST['action']))
    {
      $action = strtolower($_POST['action']);
      if (in_array($action, $this->allowed_actions))
      {
        $action = $_POST['action'].'_data';
        $_SESSION[__CLASS__."_action_result"] = $this->model->$action($_POST);
      }
      header('location:'.$_SERVER['REQUEST_URI']);
    }
    else
    {
      $a = explode('/', $_SERVER['REQUEST_URI']);
      if (!empty($a[1]))
      {	
        $data = $this->model->sel_data();
        $this->view->generate('view_'.$a[1].'.php', 'view_template.php',
          $data, isset($_SESSION[__CLASS__."_action_result"]) ? $_SESSION[__CLASS__."_action_result"]: NULL);
      }
      if (isset($_SESSION[__CLASS__."_action_result"]))
      {
        unset($_SESSION[__CLASS__."_action_result"]);
      }
    }
  }
}