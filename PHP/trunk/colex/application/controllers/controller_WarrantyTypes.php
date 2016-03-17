<?php

class Controller_WarrantyTypes extends Controller
{
	function __construct()
	{
		$this->model = new Model_WarrantyTypes();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_WarrantyTypes.php', 'view_template.php', $data);
	}
}