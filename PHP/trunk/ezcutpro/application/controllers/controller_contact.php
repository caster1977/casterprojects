<?php

class controller_contact extends controller
{

	function action_index()
	{	
		$this->view->generate('view_contact.php', 'view_template.php');
	}
}