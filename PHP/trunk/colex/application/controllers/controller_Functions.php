<?php
class controller_functions extends controller
{
  function __construct()
  {
    $this->model = new model_functions();
    $this->view = new view();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_functions_add.php', 'view_template.php', $data);
  }
  
  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_functions_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/functions/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_functions_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/functions/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_functions_clear.php', 'view_template.php', $data);
  }
}