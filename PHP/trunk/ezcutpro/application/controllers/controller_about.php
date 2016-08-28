<?php

class controller_about extends controller
{

	function action_index()
	{	
		$this->view->generate('view_about.php', 'view_template.php');
	}
}