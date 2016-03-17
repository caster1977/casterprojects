<?php

class Controller_DealershipAgreements extends Controller
{
	function __construct()
	{
		$this->model = new Model_DealershipAgreements();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_DealershipAgreements.php', 'view_template.php', $data);
	}
}