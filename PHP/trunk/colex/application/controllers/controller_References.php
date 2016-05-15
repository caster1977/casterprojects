<?php

class controller_references extends controller
{

	function action_index()
	{	
		$this->view->generate('view_references.php', 'view_template.php');
	}
}