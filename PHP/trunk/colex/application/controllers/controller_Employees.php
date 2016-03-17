<?php

class Controller_Employees extends Controller
{
	function __construct()
	{
		$this->model = new Model_Employees();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_Employees.php', 'view_template.php', $data);
	}
}