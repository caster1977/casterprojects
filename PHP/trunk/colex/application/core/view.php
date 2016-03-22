<?php
class view
{
	function generate($view_content, $view_template, $data = null, $prev_action_result = null)
	{
		include 'application/views/'.$view_template;
	}
  
  protected function showresult($result)
  {
    if (isset($result))
    {
      if (count($result) === 2)
      {
        return sprintf("<span class='%s'>%s</span>", ($result[0] >= 0 ? "success" : "failure"), $result[1]);
      }
    }
  }
}