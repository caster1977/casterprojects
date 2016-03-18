<?php

	/*
		Модель обычно включает методы выборки данных, это могут быть:
			> методы нативных библиотек pgsql или mysql;
			> методы библиотек, реализующих абстракицю данных. Например, методы библиотеки PEAR MDB2;
			> методы ORM;
			> методы для работы с NoSQL;
			> и др.
	*/
  
abstract class Model
{
  const ServerName = '.'; //'CASTER-HOME\SQLEXPRESS';
  const ConnectionOptions = array("Database"=>"Colex", "LoginTimeout"=>60, "UID"=>"caster1977", "PWD"=>"=OKY<osc1977", "CharacterSet" => "UTF-8");

  protected $Connection;

	abstract public function get_data();

	function __construct()
	{
    /* parent::__construct();*/
    self::Connect();
	}
  
  function __destruct()
  {
    self::Disconnect();
    /*try
    {
    }
    finally
    {
      parent::__destruct();
    }*/
  }

  protected function Connect()
  {
    $this->Connection = sqlsrv_connect(self::ServerName, self::ConnectionOptions);
    if ($this->Connection === false)
    {
      echo "Ошибка подключения к серверу MSSQL:<BR>";
      die(self::GetLastErrors());
    }
  }
    
  protected function Disconnect()
  {
    if (isset($this->Connection))
    {
      if (sqlsrv_close($this->Connection) === false)
      {
        echo "Ошибка отключения от сервера MSSQL:<BR>";
        die(self::GetLastErrors());
      }
    }
  }
  
  protected function GetLastErrors()
  {
    $result = "";
    foreach (sqlsrv_errors() as $error)
    {
      $result = sprintf("<BR>SQLSTATE: %s<BR>Code: %s<BR>Message: %s", $error['SQLSTATE'], $error['code'], $error['message'], $result);
    }
    return $result;
  }
  
  protected function Open($SQL, $Params)
  {
    $result = sqlsrv_query($this->Connection, $SQL, $Params);
    if ($result === false)
    {
      echo "Не удалось получить результат выполнения запроса:<BR>";
      die(self::GetLastErrors());
    }
    return $result;
  }
  
  protected function Close($Statement)
  {
    if (isset($Statement))
    {
      if (sqlsrv_free_stmt($Statement) === false)
      {
        echo "Не удалось освободить результат выполнения запроса:<BR>";
        die(self::GetLastErrors());
      }
    }
  }
}