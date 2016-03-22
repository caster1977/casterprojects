<?php
class controller_admin extends controller
{
	
	function action_index()
	{
		session_start();
		
		/*
		для простоты, в нашем случае, проверяется равенство сессионной переменной admin прописанному
		в коде значению — паролю. такое решение не правильно с точки зрения безопасности.
		пароль должен храниться в базе данных в захешированном виде, но пока оставим как есть.
		*/
		if ( $_SESSION['admin'] == "12345" )
		{
			$this->view->generate('view_admin.php', 'view_template.php');
		}
		else
		{
			session_destroy();
			route::errorpage404();
		}

	}
	
	// действие для разлогинивания администратора
	function action_logout()
	{
		session_start();
		session_destroy();
		header('location:/');
	}
}