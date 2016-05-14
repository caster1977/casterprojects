<?php
class controller_modelparts extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->model = new model_modelparts();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_modelparts_add.php', 'view_template.php', $data);
  }
  
  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_modelparts_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/modelparts/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_modelparts_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/modelparts/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_modelparts_clear.php', 'view_template.php', $data);
  }
}