<?php

class controller_features extends controller
{

	function action_index()
	{	
		$this->view->generate('view_features.php', 'view_template.php');
	}
}