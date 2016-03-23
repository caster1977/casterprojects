<h1>работники</h1>
<p>
  <table>
    <caption><?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?></caption>
    <colgroup>
      <col class="identity" />
      <col />
      <col />
      <col />
      <col />
      <col />
      <col />
      <col class="activity" />
      <col class="actions" />
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
            <form method="post">
              <button class="action" type="submit" formaction="/employees/add" alt="добавить"><img src="/images/add.png"></button>
              <button class="action" type="submit" formaction="/employees/clear" alt="удалить все"><img src="/images/close_cancel_deny_denied.png"></button>
            </form>
          </nobr>
        </th>
      </tr>
    </thead>
    <tbody>
<?php foreach($data as $row):?>
      <tr>
        <td><?php echo $row["id"];?></td>
        <td><?php echo $row["lastname"];?></td>
        <td><?php echo $row["firstname"];?></td>
        <td><?php echo $row["middlename"];?></td>
        <td><?php echo $row["birthdate"];?></td>
        <td><?php echo $row["login"];?></td>
        <td><?php echo $row["lastlogon"];?></td>
        <td><input class="activity" type="checkbox" disabled <?php ($row["active"] === 1) ? "checked" : "";?>/></td>
        <td>
          <nobr>
            <form method="post">
              <button class="action" type="submit" formaction="/employees/edit" alt="редактировать" name="id" value="<?php echo $row["id"];?>"><img src="/images/write_edit_pen.png"></button>
              <button class="action" type="submit" formaction="/employees/delete" alt="удалить" name="id" value="<?php echo $row["id"];?>"><img src="/images/close_cancel_deny_denied.png"></button>
            </form>
          </nobr>
        </td>
      </tr>
<?php endforeach;?>
    </tbody>
  </table>
</p>