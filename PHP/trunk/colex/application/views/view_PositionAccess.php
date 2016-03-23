<h1>доступ должностей</h1>
<p>
  <table>
    <caption><?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?></caption>
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>должность</th>
      <th>группа доступа</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%d</td><td>%d</td><td>%d</td></tr>', $row['id'], $row['positionid'], $row['accessgroupid'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
