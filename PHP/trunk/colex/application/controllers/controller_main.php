<?php

class Controller_Main extends Controller
{

	function action_index()
	{	
		$this->view->generate('view_main.php', 'view_template.php');
	}
}