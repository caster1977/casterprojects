<h1>должности | удаление</h1>
<p>
  <form method="post" action="/positions">
    <table>
      <col class="identity">
      <col>
      <col class="activity">
      <thead>
        <tr>
          <th class="identity"><abbr title="идентификатор">id</abbr></th>
          <th>наименование</th>
          <th class="activity">aктивность</th>
        </tr>
      </thead>
      <tbody>
      <?php
        foreach($data as $row)
        {
          $checked = "";
          if ($row['active'] === 1)
            $checked = " checked";
          printf('
            <tr>
              <td>%d<input type="hidden" name="id" value="%s"></td>
              <td>%s</td>
              <td><input type="checkbox" class="activity" disabled %s></td>
            </tr>', $row['id'], $row['id'], $row['name'], $checked);
        }
      ?>
        <tr>
          <td colspan="3" align="left">
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
