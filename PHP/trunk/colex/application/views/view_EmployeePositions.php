<h1>должности работников</h1>
<p>
  <table>
    <!--caption></caption-->
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>работник</th>
      <th>должность</th>
      <th>дата вступления в должность</th>
      <th>дата выхода из должности</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%d</td><td>%d</td><td>%s</td><td>%s</td><td>%d</td></tr>',
	  $row['id'], $row['employeeid'], $row['positionid'], $row['startdate'], $row['stopdate'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
