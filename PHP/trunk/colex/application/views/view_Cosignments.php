<h1>партии изделий</h1>
<p>
  <table>
    <!--caption></caption-->
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>номер</th>
      <th>дата регистрации</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%s</td><td>%s</td><td>%d</td></tr>', $row['id'], $row['number'], $row['registrationdate'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
