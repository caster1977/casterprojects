<h1>партии изделий | удаление</h1>
<p>
  <form method="post" action="/cosignments">
    <table>
      <col class="identity">
      <col>
      <col>
      <col class="activity">
      <thead>
        <tr>
          <th class="identity"><abbr title="идентификатор">id</abbr></th>
          <th>номер</th>
          <th>дата регистрации</th>
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
              <td>%s</td>
              <td>%s</td>
              <td><input type="checkbox" class="activity" disabled%s></td>
            </tr>', $row['id'], $row['id'], $row['number'], $row['registrationdate'], ($row['active'] === 1 ? " checked" : ""));
        }
      ?>
        <tr>
          <td colspan="4" align="left">
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
