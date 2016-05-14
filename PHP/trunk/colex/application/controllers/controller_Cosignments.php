<?php
class controller_cosignments extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->model = new model_cosignments();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_cosignments_add.php', 'view_template.php', $data);
  }

  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_cosignments_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/cosignments/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_cosignments_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/cosignments/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_cosignments_clear.php', 'view_template.php', $data);
  }
}