<?php

class Controller_Cosignments extends Controller
{
	function __construct()
	{
		$this->model = new Model_Cosignments();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_Cosignments.php', 'view_template.php', $data);
	}
}