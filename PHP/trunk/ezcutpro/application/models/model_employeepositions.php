<?php
class model_employeepositions extends model
{
  public function sel_data($data = null)
  {
    $id = isset($data, $data['id']) ? $data['id'] : -1;
    $result = self::open("{call sel_employeepositions (?, ?)}", array($id, null));
    try
    {
      $employeepositions = array();
      
      while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
      {
        $employeepositions[$row['id']] = $row;
      }
    }
    finally
    {
      self::close($result);
    }

    $data = array();
    $data["employeepositions"] = $employeepositions;

    require_once 'model_employees.php';
    $model_employees = new model_employees();
    $data["employees"] = $model_employees->sel_data(array("active" => 1));

    require_once 'model_positions.php';
    $model_positions = new model_positions();
    $data["positions"] = $model_positions->sel_data(array("active" => 1));
    
    return $data;
  }
  
  public function add_data($data = null)
  {
    extract($data);
    
    $id = -1;

    if (isset($name))
    {
      $result = self::open("{call upd_employeepositions (?, ?, ?)}", array($id, $name, (isset($active) ? 1 : 0)));
      try
      {
        if ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
        {
          return array($row['result'], $row['message']);
        }
        else
        {
          return array(0, self::getlasterrors());
        }
      }
      finally
      {
        self::close($result);
      }
    }    
  }
  
  public function edit_data($data = null)
  {
    extract($data);

    if (isset($id, $name))
    {
      $result = self::open("{call upd_employeepositions (?, ?, ?)}", array($id, $name, (isset($active) ? 1 : 0)));
      try
      {
        if ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
        {
          return array($row['result'], $row['message']);
        }
        else
        {
          return array(0, self::getlasterrors());
        }
      }
      finally
      {
        self::close($result);
      }
    }    
  }

  public function delete_data($data = null)
  {
    extract($data);

    if (isset($id))
    {
      $result = self::open("{call del_employeepositions (?)}", array($id));
      try
      {
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        if ($row)
        {
          return array($row['result'], $row['message']);
        }
        else
        {
          return array(0, self::getlasterrors());
        }
      }
      finally
      {
        self::close($result);
      }
    }    
  }
  
  public function clear_data($data = null)
  {
    $id = -1;    
    $result = self::open("{call del_employeepositions (?)}", array($id));
    try
    {
      $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
      if ($row)
      {
        return array($row['result'], $row['message']);
      }
      else
      {
        return array(0, self::getlasterrors());
      }
    }
    finally
    {
      self::close($result);
    }
  }
}