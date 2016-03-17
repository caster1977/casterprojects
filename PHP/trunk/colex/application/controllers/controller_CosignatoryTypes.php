<?php

class Controller_CosignatoryTypes extends Controller
{
	function __construct()
	{
		$this->model = new Model_CosignatoryTypes();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_CosignatoryTypes.php', 'view_template.php', $data);
	}
}