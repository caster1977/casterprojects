<?php

class Controller_PositionAccess extends Controller
{
	function __construct()
	{
		$this->model = new Model_PositionAccess();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_PositionAccess.php', 'view_template.php', $data);
	}
}