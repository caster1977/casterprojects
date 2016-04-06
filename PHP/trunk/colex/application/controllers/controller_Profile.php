<?php

class controller_profile extends controller
{

	function action_index()
	{	
		$this->view->generate('view_profile.php', 'view_template.php');
	}
}