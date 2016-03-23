<h1>работники | удаление</h1>
<p>
  <form method="post" action="/employees">
    <table>
      <colgroup>
        <col class="identity" />
        <col />
        <col />
        <col />
        <col />
        <col />
        <col />
        <col class="activity" />
      </colgroup>
      <thead>
        <tr>
          <th class="identity"><abbr title="идентификатор">id</abbr></th>
          <th>фамилия</th>
          <th>имя</th>
          <th>отчество</th>
          <th>дата рождения</th>
          <th>логин</th>
          <th>последний вход в систему</th>
          <th class="activity">активность</th>
        </tr>
      </thead>
      <tbody>
      <?php
        foreach($data as $row)
        {
          printf('
        <tr>
          <td>%d<input type="hidden" name="id" value="%s"></td>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
          <td><input type="checkbox" class="activity" disabled%s></td>
        </tr>',
            $row['id'], $row['id'], $row['lastname'], $row['firstname'], $row['middlename'], $row['birthdate'], $row['login'], $row['lastlogon'], 
            ($row['active'] === 1 ? " checked" : ""));
        }
      ?>
        <tr>
          <td colspan="8" align="left">
            <nobr>
              <button type="submit" class="action" name="action" value="delete" alt="удалить"><img src="/images/tick_ok_yes.png"></button>
              <button type="submit" class="action" name="action" value="cancel" alt="отмена"><img src="/images/arrow_top_left.png"></button>
            </nobr>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</p>
