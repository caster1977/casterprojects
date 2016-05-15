<?php
/*
класс-маршрутизатор для определения запрашиваемой страницы.
> цепляет классы контроллеров и моделей;
> создает экземпляры контролеров страниц и вызывает действия этих контроллеров.
*/
class route
{
	static function errorpage404()
	{
    $host = 'http://'.$_SERVER['HTTP_HOST'].'/';
    header('http/1.1 404 not found');
		header("status: 404 not found");
		header('location:'.$host.'404');
  }

	static function start()
	{
		// контроллер и действие по умолчанию
		$controller_name = 'main';
		$action_name = 'index';
		
		$routes = explode('/', $_SERVER['REQUEST_URI']);
    
		// получаем имя контроллера
		if (!empty($routes[1]))
		{	
			$controller_name = $routes[1];
		}
		
		// получаем имя экшена
		if (!empty($routes[2]))
		{
			$action_name = $routes[2];
		}

		// добавляем префиксы
		$model_name = 'model_'.$controller_name;
		$controller_name = 'controller_'.$controller_name;
		$action_name = 'action_'.$action_name;

		/*echo "model: $model_name <br>";
		echo "controller: $controller_name <br>";
		echo "action: $action_name <br>";*/

		// подцепляем файл с классом модели (файла модели может и не быть)
		$model_file = strtolower($model_name).'.php';
		$model_path = "application/models/".$model_file;
		if(file_exists($model_path))
		{
			include "application/models/".$model_file;
		}

		// подцепляем файл с классом контроллера
		$controller_file = strtolower($controller_name).'.php';
		$controller_path = "application/controllers/".$controller_file;
		if(file_exists($controller_path))
		{
			include "application/controllers/".$controller_file;
		}
		else
		{
			route::errorpage404(); // правильно было бы кинуть здесь исключение, но для упрощения сразу сделаем редирект на страницу 404
		}
		
		// создаем контроллер
		$controller = new $controller_name;
		$action = $action_name;
		
		if (method_exists($controller, $action))
		{			
			$controller->$action(); // вызываем действие контроллера
		}
		else
		{
			route::errorpage404(); // здесь также разумнее было бы кинуть исключение
		}
	}
}