<?php

class lang
{
  const languages = array("en-us", "ru-ru");  
  private $http_accept_languages;
  public $current;
  
	function __construct($default = "en-us")
	{
    // инициализируем переменнные
    $this->current = $default;
    $this->http_accept_languages = array();
    
    // если считан предпочитаемый язык из настроек профиля
    if (isset($_SESSION["lang"]))
    {
      if (in_array(strtolower($_SESSION["lang"]), self::languages))
      {
        $this->current = strtolower($_SESSION["lang"]);
      }
    }
    // если есть список предпочитаемых языков, заданный в браузере/на сервере
    // получаем список и находим наиболее предпочитаемый из реализованных языков,
    // предлагая его как значение по-умолчанию
    elseif (isset($_SERVER['HTTP_ACCEPT_LANGUAGE']))
    {
      $list = strtolower($_SERVER['HTTP_ACCEPT_LANGUAGE']);
      
      if (preg_match_all('/([a-z]{1,8}(?:-[a-z]{1,8})?)(?:;q=([0-9.]+))?/', $list, $list))
      {
        $this->http_accept_languages = array_combine($list[1], $list[2]);
        foreach ($this->http_accept_languages as $key => $value)
        {
          $this->http_accept_languages[$key] = $value ? $value : 1;
        }
        arsort($this->http_accept_languages, SORT_NUMERIC);
        
        foreach($this->http_accept_languages as $key => $value)
        {
          if (in_array(strtolower($key), self::languages))
          {
            $this->current = strtolower($key);
            break;
          }
        }
      }
    }
	}  
}