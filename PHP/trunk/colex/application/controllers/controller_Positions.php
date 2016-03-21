<?php
class Controller_Positions extends Controller
{
  function __construct()
  {
    $this->model = new Model_Positions();
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
      if (in_array($action, array("add", "edit", "delete", "clear")))
      {
        // получаем реузльтат выполнения действия в виде массива (bool, string)
        $action = $_POST['action']."_data";
        $prev_action_result = $this->model->$action($_POST);
      }
    }
    // и выводим список данных из модели
    $data = $this->model->sel_data();
    $this->view->generate('view_Positions.php', 'view_template.php', $data, $prev_action_result);
  }

  function action_Add()
  {
    var_dump($_POST);
    $data = $this->model->sel_data($_POST);
    $this->view->generate('view_Positions_Add.php', 'view_template.php', $data);
  }
  
  function action_Edit()
  {
    if (isset($_POST['Id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_Positions_Edit.php', 'view_template.php', $data);
    }
    else
    {
      header('Location:/Positions/');
    }
  }

  function action_Delete()
  {
    if (isset($_POST['Id']))
    {
      $data = $this->model->sel_data($_POST);
      $this->view->generate('view_Positions_Delete.php', 'view_template.php', $data);
    }
    else
    {
      header('Location:/Positions/');
    }
  }

  function action_Clear()
  {
    var_dump($_POST);
    $data = $this->model->sel_data();
    var_dump($data);
    $this->view->generate('view_Positions_Clear.php', 'view_template.php', $data);
  }
}