<?php
class controller_news extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->allowed_actions = array('add', 'edit', 'delete', 'clear');
    $this->model = new model_news();
  }

  function action_add()
  {
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_news_add.php', 'view_template.php', $data);
  }
  
  function action_edit()
  {
    if (isset($_POST["id"]))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate(model::get_caption(), 'view_news_edit.php', 'view_template.php', $data);
    }
    else
    {
      header("location:/news/");
    }
  }

  function action_delete()
  {
    if (isset($_POST['id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_news_delete.php', 'view_template.php', $data);
    }
    else
    {
      header('location:/news/');
    }
  }

  function action_clear()
  {
    $data = $this->model->sel_data();
    $this->view->generate('view_news_clear.php', 'view_template.php', $data);
  }
}