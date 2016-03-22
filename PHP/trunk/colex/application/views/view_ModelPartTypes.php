<h1>тип части оборудования</h1>
<p>
  <table>
    <!--caption></caption-->
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>наименование</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%s</td><td>%d</td></tr>', $row['id'], $row['name'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
