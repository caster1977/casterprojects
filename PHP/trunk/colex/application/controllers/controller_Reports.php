<?php

class controller_reports extends controller
{

	function action_index()
	{	
		$this->view->generate('view_reports.php', 'view_template.php');
	}
}