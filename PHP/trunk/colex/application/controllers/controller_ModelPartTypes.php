<?php
class controller_modelparttypes extends controller
{
  function __construct()
  {
    $this->model = new model_modelparttypes();
    $this->view = new view();
  }

  function action_index()
  {
    $prev_action_result = null;
    if (isset($_POST['action']))
    {
      $action = strtolower($_POST['action']);
      if (in_array($action, array("add", "edit", "delete", "clear")))
      {
        $action = $_POST['action']."_data";
        $prev_action_result = $this->model->$action($_POST);
      }
    }
    $data = $this->model->sel_data();
    $this->view->generate('view_modelparttypes.php', 'view_template.php', $data, $prev_action_result);
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_modelparttypes_add.php', 'view_template.php', $data);
  }
  
  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_modelparttypes_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/modelparttypes/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_modelparttypes_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/modelparttypes/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_modelparttypes_clear.php', 'view_template.php', $data);
  }
}