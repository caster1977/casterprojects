<?php
class model_profile extends model
{
  public function sel_data($data = null)
  {
    require_once 'model_employees.php';
    $model_employees = new model_employees();

    require_once 'model_languages.php';
    $model_languages = new model_languages();

    $id = isset($data, $data['id']) ? $data['id'] : -1;
    $employeeid = isset($data, $data['employeeid']) ? $data['employeeid'] : -1;

    // получаем и возвращаем список профилей согласно указанного фильтра
    $statement = self::open("{call colex_sel_profiles (?, ?, ?)}", array($id, $employeeid, null));
    try
    {
      $data = array();

      while($row = sqlsrv_fetch_array($statement, SQLSRV_FETCH_ASSOC))
      {
        $data[] = $row;
      }
    }
    finally
    {
      self::close($statement);
    }

    $result = array();
    $result['profiles'] = $data;
    
    // получаем и возвращаем список активвных языков для заполнения комбика
    $result['languages'] = $model_languages->sel_data(array('active'=>1));

    // получаем и возвращаем список работников для выбранных профилей
    foreach($result['profiles'] as &$profile)
    {
      $data = $model_employees->sel_data(array('id'=>$profile['employeeid']));
      $profile['employee'] = (isset($data) and count($data) > 0) ? $data[0] : null;
      
      $data = $model_languages->sel_data(array('id'=>$profile['languageid']));
      $profile['language'] = (isset($data) and count($data) > 0) ? $data[0] : null;
    }

    return $result;
  }

  public function add_data($data = null)
  {
    /*extract($data);

    $id = -1;

    if (isset($languageid, $code, $string))
    {
      $result = self::open("{call colex_upd_profiles (?, ?, ?, ?, ?)}", array($id, $languageid, $code, $string, (isset($active) ? 1 : 0)));
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
    }*/
  }

  public function edit_data($data = null)
  {
    /*extract($data);

    if (isset($id, $languageid, $code, $string))
    {
      $result = self::open("{call colex_upd_profiles (?, ?, ?, ?, ?)}", array($id, $languageid, $code, $string, (isset($active) ? 1 : 0)));
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
    }*/
  }

  public function delete_data($data = null)
  {
    /*extract($data);

    if (isset($id))
    {
      $result = self::open("{call colex_del_profiles (?)}", array($id));
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
    }*/
  }

  public function clear_data($data = null)
  {
    /*$id = -1;
    $result = self::open("{call colex_del_profiles (?)}", array($id));
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
    }*/
  }
}