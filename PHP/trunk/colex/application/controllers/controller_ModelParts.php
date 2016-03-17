<?php

class Controller_ModelParts extends Controller
{
	function __construct()
	{
		$this->model = new Model_ModelParts();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_ModelParts.php', 'view_template.php', $data);
	}
}