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
        return sprintf(
            '<div class="alert alert-%s" role="alert">'.
            '<span class="glyphicon glyphicon-%s" aria-hidden="true"></span>'.
            '<span class="sr-only">%s:</span> %s</div>',
            ($result[0] >= 0 ? "success" : "danger"), 
            ($result[0] >= 0 ? "ok" : "exclamation-sign"),
            ($result[0] >= 0 ? "Успех" : "Ошибка"),
            $result[1]);
      }
    }
  }
}
