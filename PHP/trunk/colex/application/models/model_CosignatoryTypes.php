<?php

class Model_CosignatoryTypes extends Model
{
  public function get_data()
  {
    $result = self::Open("{CALL colex_sel_CosignatoryTypes (?, ?)}", array(-1, 1));
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

}