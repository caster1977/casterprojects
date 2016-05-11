<?php
class model_employeepositions extends model
{
  public function sel_data($data = null)
  {
    $id = isset($data, $data['id']) ? $data['id'] : -1;
    $result = self::open("{call colex_sel_employeepositions (?, ?)}", array($id, null));
    try
    {
      $employeepositions = array();
      
      while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
      {
        $employeepositions[] = $row;
      }
    }
    finally
    {
      self::close($result);
    }

    $result = self::open("{call colex_sel_employees (?, ?)}", array(-1, 1));
    try
    {
      $employees = array();
      
      while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
      {
        $employees[] = $row;
      }
    }
    finally
    {
      self::close($result);
    }

    $result = self::open("{call colex_sel_positions (?, ?)}", array(-1, 1));
    try
    {
      $positions = array();
      
      while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
      {
        $positions[] = $row;
      }
    }
    finally
    {
      self::close($result);
    }
    
    $data = array();
    $data["employeepositions"] = $employeepositions;
    $data["employees"] = $employees;
    $data["positions"] = $positions;
    
    return $data;
  }
  
  public function add_data($data = null)
  {
    extract($data);
    
    $id = -1;

    if (isset($name))
    {
      $result = self::open("{call colex_upd_employeepositions (?, ?, ?)}", array($id, $name, (isset($active) ? 1 : 0)));
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
      $result = self::open("{call colex_upd_employeepositions (?, ?, ?)}", array($id, $name, (isset($active) ? 1 : 0)));
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
      $result = self::open("{call colex_del_employeepositions (?)}", array($id));
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
    $result = self::open("{call colex_del_employeepositions (?)}", array($id));
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