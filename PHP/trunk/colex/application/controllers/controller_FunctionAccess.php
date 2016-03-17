<?php

class Controller_FunctionAccess extends Controller
{
	function __construct()
	{
		$this->model = new Model_FunctionAccess();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_FunctionAccess.php', 'view_template.php', $data);
	}
}