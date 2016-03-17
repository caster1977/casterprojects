<?php

class Controller_EmployeePositions extends Controller
{
	function __construct()
	{
		$this->model = new Model_EmployeePositions();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_EmployeePositions.php', 'view_template.php', $data);
	}
}