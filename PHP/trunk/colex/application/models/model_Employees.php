<?php
class model_employees extends model
{
  public function sel_data($data = null)
  {
    $id = isset($data, $data['id']) ? $data['id'] : -1;
    $result = self::open("{call colex_sel_employees (?, ?)}", array($id, null));
    try
    {
      $data = array();
      
      while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
      {
        $data[] = $row;
      }
    }
    finally
    {
      self::close($result);
    }
    return $data;
  }
  
  public function add_data($data = null)
  {
    extract($data);
    
    $id = -1;
    
    if (isset($lastname, $firstname, $middlename, $birthdate, $login, $password))
    {
      $result = self::open("{call colex_upd_employees (?, ?, ?, ?, ?, ?, ?, ?)}", 
        array($id, $lastname, $firstname, $middlename, date_format(date_create($birthdate), 'Ymd'), 
        $login, md5($password), (isset($active) ? 1 : 0)));
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

    if (isset($id, $lastname, $firstname, $middlename, $birthdate, $login, $password))
    {
      $result = self::open("{call colex_upd_employees (?, ?, ?, ?, ?, ?, ?, ?)}", 
        array($id, $lastname, $firstname, $middlename, date_format(date_create($birthdate), 'Ymd'),
        $login, md5($password), (isset($active) ? 1 : 0)));
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
      $result = self::open("{call colex_del_employees (?)}", array($id));
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
    $result = self::open("{call colex_del_employees (?)}", array($id));
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