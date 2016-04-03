<div class="page-header">
  <h1 class="text-uppercase">пользовательские функции</h1>
</div>
<div>
<table class="table table-striped table-bordered table-hover table-condensed">
  <caption><?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?></caption>
  <tbody>
  <tr>
    <th class="text-center">идентификатор</th>
    <th class="text-center">наименование</th>
    <th class="text-center">код</th>
    <th class="text-center">активность</th>
  </tr>
  <?php
    foreach($data as $row)
    {
      printf('<tr><td>%d</td><td>%s</td><td>%d</td><td>%d</td></tr>', $row['id'], $row['name'], $row['code'], $row['active']);
    }      
  ?>
  </tbody>
</table>
</div>