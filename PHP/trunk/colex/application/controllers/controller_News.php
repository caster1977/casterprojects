<?php

class Controller_News extends Controller
{
	function __construct()
	{
		$this->model = new Model_News();
		$this->view = new View();
	}
	
	function action_index()
	{
		$data = $this->model->get_data();		
		$this->view->generate('view_News.php', 'view_template.php', $data);
	}
}