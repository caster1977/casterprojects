<h1>работники</h1>
<p>
  <table>
    <!--caption></caption-->
    <tbody>
    <tr>
      <th>идентификатор</th>
      <th>фамилия</th>
      <th>имя</th>
      <th>отчество</th>
      <th>дата рождения</th>
      <th>логин</th>
      <!--th>hash пароля</th-->
      <th>последний вход в систему</th>
      <th>активность</th>
    </tr>
    <?php
      foreach($data as $row)
      {
        printf('<tr><td>%d</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%d</td></tr>', 
	  $row['id'], $row['lastname'], $row['firstname'], $row['middlename'], $row['birthdate'], $row['login'], $row['lastlogon'], $row['active']);
      }      
    ?>
    </tbody>
  </table>
</p>
