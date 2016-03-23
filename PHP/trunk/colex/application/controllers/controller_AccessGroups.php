<?php
class controller_accessgroups extends controller
{
  function __construct()
  {
    $this->model = new model_accessgroups();
    $this->view = new view();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_accessgroups_add.php', 'view_template.php', $data);
  }
  
  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_accessgroups_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/accessgroups/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_accessgroups_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/accessgroups/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_accessgroups_clear.php', 'view_template.php', $data);
  }
}