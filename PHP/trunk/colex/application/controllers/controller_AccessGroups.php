<?php

class Controller_AccessGroups extends Controller
{
	function __construct()
	{
		$this->model = new Model_AccessGroups();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_AccessGroups.php', 'view_template.php', $data);
	}
}