<?php
class controller_dealershipagreements extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->model = new model_dealershipagreements();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_dealershipagreements_add.php', 'view_template.php', $data);
  }

  function action_edit()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_dealershipagreements_edit.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/dealershipagreements/');
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_dealershipagreements_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/dealershipagreements/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_dealershipagreements_clear.php', 'view_template.php', $data);
  }
}