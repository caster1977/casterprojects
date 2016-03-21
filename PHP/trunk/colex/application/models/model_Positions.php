<?php

class Model_Positions extends Model
{
  public function sel_data($data = null)
  {
    $id = -1;
    if (isset($data))
    {
      if (isset($data['Id']))
      {
        $id = $data['Id'];
      }
    }
    $result = self::Open("{CALL colex_sel_Positions (?, ?)}", array($id, NULL));
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
      self::Close($result);
    }
    return $data;
  }
  
  public function add_data($data = null)
  {
    //var_dump($data);

    extract($data);
    
    $id = -1;

    if (isset($Name))
    {
      // если переменная есть - значит флажок включен
      $active = isset($Active) ? 1 : 0;
      
      $result = self::Open("{CALL colex_upd_Positions (?, ?, ?)}", array($id, $Name, $active));
      try
      {
        if ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
        {
          return array($row['Result'], $row['Message']);
        }
        else
        {
          return array(0, self::GetLastErrors());
        }
      }
      finally
      {
        self::Close($result);
      }
    }    
  }
  
  public function edit_data($data = null)
  {
    //var_dump($data);

    extract($data);

    if (isset($Id) && isset($Name))
    {
      // если переменная есть - значит флажок включен
      $active = isset($Active) ? 1 : 0;
      
      $result = self::Open("{CALL colex_upd_Positions (?, ?, ?)}", array($Id, $Name, $active));
      try
      {
        if ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
        {
          return array($row['Result'], $row['Message']);
        }
        else
        {
          return array(0, self::GetLastErrors());
        }
      }
      finally
      {
        self::Close($result);
      }
    }    
  }

  public function delete_data($data = null)
  {
    //var_dump($data);

    extract($data);

    if (isset($Id))
    {
      $result = self::Open("{CALL colex_del_Positions (?)}", array($Id));
      try
      {
        //var_dump($result);
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        //var_dump($row);
        if ($row)
        {
          return array($row['Result'], $row['Message']);
        }
        else
        {
          return array(0, self::GetLastErrors());
        }
      }
      finally
      {
        self::Close($result);
      }
    }    
  }
  
  public function clear_data($data = null)
  {
    $id = -1;

    $result = self::Open("{CALL colex_del_Positions (?)}", array($id));
    try
    {
      $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
      if ($row)
      {
        return array($row['Result'], $row['Message']);
      }
      else
      {
        return array(0, self::GetLastErrors());
      }
    }
    finally
    {
      self::Close($result);
    }
}
}