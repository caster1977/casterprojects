<?php
class model_about extends model
{
  public function sel_data($data = null)
  {
    require_once 'model_employeepositions.php';
    $model_employeepositions = new model_employeepositions();
    $data = $model_employeepositions->sel_data(array("active" => 1));
    return $data;
  }

  public function add_data($data = null)
  {
  }

  public function edit_data($data = null)
  {
  }

  public function delete_data($data = null)
  {
  }

  public function clear_data($data = null)
  {
  }
}