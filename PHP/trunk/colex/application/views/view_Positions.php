<h1>должности</h1>
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
    <col class="identity">
    <col>
    <col class="activity">
    <col class="actions">
    <thead>
      <tr>
        <th class="identity"><abbr title="идентификатор">id</abbr></th>
        <th>наименование</th>
        <th class="activity">активность</th>
        <th class="actions">
          <nobr>
            <form method="post" action="">
              <button class="action" type="submit" formaction="/positions/add" alt="добавить"><img src="/images/add.png"></button>
              <button class="action" type="submit" formaction="/positions/clear" alt="удалить все"><img src="/images/close_cancel_deny_denied.png"></button>
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
        <td><input class="activity" type="checkbox" disabled%s></td>
        <td>
          <nobr>
            <form method="post" action="">
              <button class="action" type="submit" formaction="/positions/edit" alt="редактировать" name="id" value="%d"><img src="/images/write_edit_pen.png"></button>
              <button class="action" type="submit" formaction="/positions/delete" alt="удалить" name="id" value="%d"><img src="/images/close_cancel_deny_denied.png"></button>
            </form>
          </nobr>
        </td>
      </tr>', $row['id'], $row['name'], (($row['active'] === 1) ? " checked" : ""), $row['id'], $row['id']);
      }      
    ?>
    </tbody>
  </table>
</p>