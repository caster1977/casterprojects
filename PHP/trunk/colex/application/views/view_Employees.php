<h1>работники</h1>
<p>
  <table>
    <caption>
      <?php
        if (isset($prev_action_result))
        {
          echo self::showresult($prev_action_result);
        }
      ?>
    </caption>
    <colgroup>
      <col class="identity">
      <col>
      <col>
      <col>
      <col>
      <col>
      <col>
      <col class="activity">
      <col class="actions">
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
        <th class="actions">
          <nobr>
            <form method="post" action="">
              <button class="action" type="submit" formaction="/employees/add" alt="добавить"><img src="/images/add.png"></button>
              <button class="action" type="submit" formaction="/employees/clear" alt="удалить все"><img src="/images/close_cancel_deny_denied.png"></button>
            </form>
          </nobr>
        </th>
      </tr>
    </thead>
    <tbody>
    <?php
      foreach($data as $row)
      {
        printf(
'     <tr>
        <td>%d</td>
        <td>%s</td>
        <td>%s</td>
        <td>%s</td>
        <td>%s</td>
        <td>%s</td>
        <td>%s</td>
        <td><input class="activity" type="checkbox" disabled%s></td>
        <td>
          <nobr>
            <form method="post" action="">
              <button class="action" type="submit" formaction="/employees/edit" alt="редактировать" name="id" value="%d"><img src="/images/write_edit_pen.png"></button>
              <button class="action" type="submit" formaction="/employees/delete" alt="удалить" name="id" value="%d"><img src="/images/close_cancel_deny_denied.png"></button>
            </form>
          </nobr>
        </td>
      </tr>',
        $row['id'], $row['lastname'], $row['firstname'], $row['middlename'], $row['birthdate'], $row['login'], $row['lastlogon'],
        (($row['active'] === 1) ? " checked" : ""), $row['id'], $row['id']);
      }      
    ?>
    </tbody>
  </table>
</p>