<?php
class controller_warrantytypes extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->model = new model_warrantytypes();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_warrantytypes_add.php', 'view_template.php', $data);
  }

  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_warrantytypes_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/warrantytypes/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_warrantytypes_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/warrantytypes/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_warrantytypes_clear.php', 'view_template.php', $data);
  }
}