<h1>пользовательские функции</h1>
<p>
  <table>
    <!--caption></caption-->
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>наименование</th>
      <th>код</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%s</td><td>%d</td><td>%d</td></tr>', $row['id'], $row['name'], $row['code'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
