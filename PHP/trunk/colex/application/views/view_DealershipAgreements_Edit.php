<h1>дилерские соглашения | редактирование</h1>
<p>
  <form method="post" action="/dealershipagreements">
    <table>
      <col class="identity">
      <col>
      <col>
      <col class="activity">
      <thead>
        <tr>
          <th class="identity"><abbr title="идентификатор">id</abbr></th>
          <th>наименование</th>
          <th>условия</th>
          <th class="activity">aктивность</th>
        </tr>
      </thead>
      <tbody>
      <?php
        foreach($data as $row)
        {
          printf('
            <tr>
              <td>%d<input type="hidden" name="id" value="%s"></td>
              <td><input type="text" name="name" maxlength="255" size="100" value="%s"></td>
              <td><textarea name="details" rows="20" cols="60">%s</textarea></td>
              <td><input type="checkbox" name="active" class="activity" %s></td>
            </tr>', $row['id'], $row['id'], $row['name'], $row['details'], (($row['active'] === 1) ? " checked" : ""));
        }
      ?>
        <tr>
          <td colspan="4" align="left">
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
