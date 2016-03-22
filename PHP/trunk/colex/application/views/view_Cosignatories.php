<h1>субъекты</h1>
<p>
  <table>
    <!--caption></caption-->
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>тип</th>
      <th>наименование</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%d</td><td>%s</td><td>%d</td></tr>', $row['id'], $row['cosignatorytypeid'], $row['name'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
