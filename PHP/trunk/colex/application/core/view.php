<?php

class View
{
	
	//public $view_template; // здесь можно указать общий вид по умолчанию.
	
	/*
	$content_file - виды отображающие контент страниц;
	$template_file - общий для всех страниц шаблон;
	$data - массив, содержащий элементы контента страницы. Обычно заполняется в модели.
	*/
	function generate($view_content, $view_template, $data = null, $prev_action_result = null)
	{
		
		/*
		if(is_array($data)) {
			
			// преобразуем элементы массива в переменные
			extract($data);
		}
		*/
		
		/*
		динамически подключаем общий шаблон (вид),
		внутри которого будет встраиваться вид
		для отображения контента конкретной страницы.
		*/
		include 'application/views/'.$view_template;
	}
  
  protected function ShowResult($result)
  {
    if (isset($result))
    {
      if (count($result) === 2)
      {
        return sprintf("<SPAN class='%s'>%s</SPAN>", $result[0] > 0 ? "success" : "failure", $result[1]);
      }
    }
  }
}