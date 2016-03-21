<?php
class Controller_Cosignments extends Controller
{
  function __construct()
  {
    $this->model = new Model_Cosignments();
    $this->view = new View();
  }

  function action_index()
  {
    // проверяем на необходимость выполнить выбранное пользователем действие
    $prev_action_result = null;
    if (isset($_POST['action']))
    {
      // если действие является допустимым, передаём его на обработку модели
      $action = strtolower($_POST['action']);
      if (in_array($action, array("add", "edit", "delete")))
      {
        // получаем реузльтат выполнения действия в виде массива (bool, string)
        $action = $_POST['action']."_data";
        $prev_action_result = $this->model->$action($_POST);
      }
    }
    // и выводим список данных из модели
    $data = $this->model->sel_data(-1);
    $this->view->generate('view_Cosignments.php', 'view_template.php', $data, $prev_action_result);
  }

  function action_Add()
  {
    $this->view->generate('view_Cosignments_Add.php', 'view_template.php');
  }
  
  function action_Edit()
  {
    if (isset($_POST['Id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_Cosignments_Edit.php', 'view_template.php', $data);
    }
    else
    {
      header('Location:/Cosignments/');
    }
  }

  function action_Delete()
  {
    if (isset($_POST['Id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_Cosignments_Delete.php', 'view_template.php', $data);
    }
    else
    {
      header('Location:/Cosignments/');
    }
  }
}