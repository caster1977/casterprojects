<?php
class model_cosignatorytypes extends model
{
  public function sel_data($data = null)
  {
    $id = (isset($data)) && (isset($data['id'])) ? $data['id'] : -1;
    $result = self::open("{call colex_sel_cosignatorytypes (?, ?)}", array($id, null));
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

    if (isset($name))
    {
      $active = isset($active) ? 1 : 0;
      
      $result = self::open("{call colex_upd_cosignatorytypes (?, ?, ?)}", array($id, $name, $active));
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

    if (isset($id) && isset($name))
    {
      $result = self::open("{call colex_upd_cosignatorytypes (?, ?, ?)}", array($id, $name, (isset($active) ? 1 : 0)));
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
      $result = self::open("{call colex_del_cosignatorytypes (?)}", array($id));
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
    $result = self::open("{call colex_del_cosignatorytypes (?)}", array($id));
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