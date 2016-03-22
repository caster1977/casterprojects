<h1>должности | удаление всех</h1>
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
          printf('<tr><td>%d</td><td>%s</td><td><input type="checkbox" class="activity" disabled%s></td></tr>', $row['id'], $row['name'], ($row['active'] === 1 ? " checked" : ""));
        }
      ?>
        <tr>
          <td colspan="3" align="left">
            <nobr>
              <button type="submit" class="action" name="action" value="clear" alt="удалить все"><img src="/images/tick_ok_yes.png"></button>
              <button type="submit" class="action" name="action" value="cancel" alt="отмена"><img src="/images/arrow_top_left.png"></button>
            </nobr>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</p>
