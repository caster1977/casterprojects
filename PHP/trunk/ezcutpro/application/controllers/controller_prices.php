<?php

class controller_prices extends controller
{

	function action_index()
	{	
		$this->view->generate('view_prices.php', 'view_template.php');
	}
}