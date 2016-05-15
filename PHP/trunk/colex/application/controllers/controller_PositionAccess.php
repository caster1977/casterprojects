<?php
class controller_positionaccess extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->allowed_actions = array('add', 'edit', 'delete', 'clear');
    $this->model = new model_positionaccess();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_positionaccess_add.php', 'view_template.php', $data);
  }
  
  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_positionaccess_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/positionaccess/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_positionaccess_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/positionaccess/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_positionaccess_clear.php', 'view_template.php', $data);
  }
}