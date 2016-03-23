<h1>работники | редактирование</h1>
<p>
  <form method="post" action="/employees">
    <table>
      <colgroup>
        <col class="identity">
        <col>
        <col>
        <col>
        <col>
        <col>
        <col>
        <col class="activity">
      </colgroup>
      <thead>
        <tr>
          <th class="identity"><abbr title="идентификатор">id</abbr></th>
          <th>фамилия</th>
          <th>имя</th>
          <th>отчество</th>
          <th>дата рождения</th>
          <th>логин</th>
          <th>пароль</th>
          <th class="activity">активность</th>
        </tr>
      </thead>
      <tbody>
      <?php
        foreach($data as $row)
        {
          printf('
        <tr>
          <td>%d<input type="hidden" name="id" value="%d"></td>
          <td><input type="text" name="lastname" maxlength="255" size="20" value="%s"></td>
          <td><input type="text" name="firstname" maxlength="255" size="20" value="%s"></td>
          <td><input type="text" name="middlename" maxlength="255" size="20" value="%s"></td>
          <td><input type="date" name="birthdate" value="%s"></td>
          <td><input type="text" name="login" maxlength="255" size="20" value="%s"></td>
          <td><input type="password" name="password" maxlength="255" size="20"></td>
          <td><input type="checkbox" name="active" class="activity"%s></td>
        </tr>', 
          $row['id'], $row['id'], $row['lastname'], $row['firstname'], $row['middlename'], $row['birthdate'], $row['login'],
          (($row['active'] === 1) ? " checked" : ""));
        }
      ?>
        <tr>
          <td colspan="8" align="left">
            <nobr>
              <button type="submit" class="action" name="action" value="edit" alt="сохранить"><img src="/images/tick_ok_yes.png"></button>
              <button type="submit" class="action" name="action" value="cancel" alt="отмена"><img src="/images/arrow_top_left.png"></button>
            </nobr>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</p>
