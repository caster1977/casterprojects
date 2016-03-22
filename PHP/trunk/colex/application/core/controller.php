<?php

abstract class controller
{
	public $model;
	public $view;
	
	function __construct()
	{
		$this->view = new view();
	}
	
	abstract function action_index();
}