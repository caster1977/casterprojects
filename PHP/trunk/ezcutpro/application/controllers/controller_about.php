<?php

class controller_about extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->model = new model_about();
  }
}