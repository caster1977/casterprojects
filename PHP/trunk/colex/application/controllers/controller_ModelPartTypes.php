<?php

class Controller_ModelPartTypes extends Controller
{
	function __construct()
	{
		$this->model = new Model_ModelPartTypes();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_ModelPartTypes.php', 'view_template.php', $data);
	}
}