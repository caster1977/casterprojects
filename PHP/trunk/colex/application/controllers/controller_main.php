<?php

class controller_main extends controller
{

	function action_index()
	{	
		$this->view->generate('view_main.php', 'view_template.php');
	}
}