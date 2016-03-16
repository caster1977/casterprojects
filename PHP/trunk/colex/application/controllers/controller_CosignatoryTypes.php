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
		$this->view->generate('CosignatoryTypes_view.php', 'template_view.php', $data);
	}
}