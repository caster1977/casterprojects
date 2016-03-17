<?php

class Controller_Models extends Controller
{
	function __construct()
	{
		$this->model = new Model_Models();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_Models.php', 'view_template.php', $data);
	}
}