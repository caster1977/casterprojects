<?php

class controller_profile extends controller
{
  function __construct()
  {
    parent::__construct();
    $this->model = new model_profile();
  }
}