<?php
	/*
		модель обычно включает методы выборки данных, это могут быть:
			> методы нативных библиотек pgsql или mysql;
			> методы библиотек, реализующих абстракицю данных. например, методы библиотеки pear mdb2;
			> методы orm;
			> методы для работы с nosql;
			> и др.
	*/
  
abstract class model
{
  const servername = '.';
  const connectionoptions = array(
    "database" => "colex",
    "logintimeout" => 60,
    //"uid" => "colex",
    //"pwd" => "1/2_5a",
    "characterset" => "utf-8",
    "multipleactiveresultsets" => 1
    );

  protected $connection;
	
  abstract public function sel_data($data = null);
  abstract public function add_data($data = null);
  abstract public function edit_data($data = null);
  abstract public function delete_data($data = null);
  abstract public function clear_data($data = null);

	function __construct()
	{
    /* parent::__construct();*/
    self::connect();
	}
  
  function __destruct()
  {
    self::disconnect();
    /*try
    {
    }
    finally
    {
      parent::__destruct();
    }*/
  }

  protected function connect()
  {
    $this->connection = sqlsrv_connect(self::servername, self::connectionoptions);
    if ($this->connection === false)
    {
      echo "Ошибка подключения к серверу mssql:<br>";
      die(self::getlasterrors());
    }
  }
    
  protected function disconnect()
  {
    if (isset($this->connection))
    {
      if (sqlsrv_close($this->connection) === false)
      {
        echo "Ошибка отключения от сервера mssql:<br>";
        die(self::getlasterrors());
      }
    }
  }
  
  protected function getlasterrors()
  {
    $result = "";
    foreach (sqlsrv_errors() as $error)
    {
      $result = sprintf("<br>SqlState: %s<br>Code: %s<br>Message: %s", $error['SqlState'], $error['Code'], $error['Message'], $result);
    }
    return $result;
  }
  
  protected function open($sql, $params)
  {
    $result = sqlsrv_query($this->connection, $sql, $params);
    if ($result === false)
    {
      echo "Не удалось получить результат выполнения запроса:<br>";
      die(self::getlasterrors());
    }
    return $result;
  }
  
  protected function close($statement)
  {
    if (isset($statement))
    {
      if (sqlsrv_free_stmt($statement) === false)
      {
        echo "Не удалось освободить результат выполнения запроса:<br>";
        die(self::getlasterrors());
      }
    }
  }
}