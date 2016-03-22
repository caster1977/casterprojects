<h1>партии изделий | редактирование</h1>
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
              <td><input type="text" name="number" maxlength="255" size="100" value="%s"></td>
              <td><input type="text" name="registrationdate" maxlength="10" size="10" value="%s"></td>
              <td><input type="checkbox" name="active" class="activity" %s></td>
            </tr>', $row['id'], $row['id'], $row['number'], $row['registrationdate'], (($row['active'] === 1) ? " checked" : ""));
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
