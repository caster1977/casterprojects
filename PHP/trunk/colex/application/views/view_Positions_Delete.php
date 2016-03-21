<h1>Должности | Удаление</h1>
<p>
  <form method="post" action="/positions">
    <table>
      <col class="identity">
      <col>
      <col class="activity">
      <thead>
        <tr>
          <th class="identity"><abbr title="Идентификатор">Id</></th>
          <th>Наименование</th>
          <th class="activity"><abbr title="Aктивность">*</></th>
        </tr>
      </thead>
      <tbody>
      <?php
        foreach($data as $row)
        {
          $checked = "";
          if ($row['Active'] === 1)
            $checked = " checked";
          printf('
            <tr>
              <td>%d<input type="hidden" name="Id" value="%s"></td>
              <td>%s</td>
              <td><input type="checkbox" class="activity" disabled %s></td>
            </tr>', $row['Id'], $row['Id'], $row['Name'], $checked);
        }
      ?>
        <tr>
          <td colspan="3" align="left">
            <nobr>
              <button type="submit" class="action" name="action" value="delete" ALT="Удалить"><IMG SRC="/images/tick_ok_yes.png"></button>
              <button type="submit" class="action" name="action" value="cancel" ALT="Отмена"><IMG SRC="/images/arrow_top_left.png"></button>
            </nobr>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</p>
