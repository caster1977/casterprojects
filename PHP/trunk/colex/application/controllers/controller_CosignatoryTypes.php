<?php
class controller_cosignatorytypes extends controller
{
  function __construct()
  {
    $this->model = new model_cosignatorytypes();
    $this->view = new view();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_cosignatorytypes_add.php', 'view_template.php', $data);
  }
  
  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_cosignatorytypes_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/cosignatorytypes/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_cosignatorytypes_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/cosignatorytypes/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_cosignatorytypes_clear.php', 'view_template.php', $data);
  }
}