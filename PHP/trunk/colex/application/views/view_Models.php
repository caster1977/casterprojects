<h1>модели оборудования</h1>
<p>
  <table>
    <!--caption></caption-->
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>наименование</th>
      <th>прототип</th>
      <th>описание</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%s</td><td>%d</td><td>%s</td><td>%d</td></tr>', $row['id'], $row['name'], $row['prototype'], $row['description'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
