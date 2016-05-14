<?php
class model_stringresources extends model
{
  public function sel_data($data = null)
  {
    $id = isset($data, $data['id']) ? $data['id'] : -1;
    $languageid = isset($data, $data['languageid']) ? $data['languageid'] : -1;
    $code = isset($data, $data['code']) ? $data['code'] : -1;    
    $result = self::open("{call colex_sel_stringresources (?, ?, ?, ?)}", array($id, $languageid, $code, null));
    try
    {
      $stringresources = array();
      
      while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
      {
        $stringresources[] = $row;
      }
    }
    finally
    {
      self::close($result);
    }

    $result = self::open("{call colex_sel_languages (?, ?)}", array(-1, 1));
    try
    {
      $languages = array();
      
      while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
      {
        $languages[] = $row;
      }
    }
    finally
    {
      self::close($result);
    }

    $data = array();
    $data["stringresources"] = $stringresources;
    $data["languages"] = $languages;
    
    return $data;
  }
  
  public function add_data($data = null)
  {
    extract($data);
    
    $id = -1;

    if (isset($languageid, $code, $string))
    {
      $result = self::open("{call colex_upd_stringresources (?, ?, ?, ?, ?)}", array($id, $languageid, $code, $string, (isset($active) ? 1 : 0)));
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

    if (isset($id, $languageid, $code, $string))
    {
      $result = self::open("{call colex_upd_stringresources (?, ?, ?, ?, ?)}", array($id, $languageid, $code, $string, (isset($active) ? 1 : 0)));
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
      $result = self::open("{call colex_del_stringresources (?)}", array($id));
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
    $result = self::open("{call colex_del_stringresources (?)}", array($id));
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