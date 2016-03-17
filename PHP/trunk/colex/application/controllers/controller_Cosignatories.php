<?php

class Controller_Cosignatories extends Controller
{
	function __construct()
	{
		$this->model = new Model_Cosignatories();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_Cosignatories.php', 'view_template.php', $data);
	}
}