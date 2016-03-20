<h1>Должности | Удаление</h1>
<p>
  <form name="edit" method="post" action="/positions">
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
            <button type="submit" name="action" value="delete" width="100">Удалить</button>
            &nbsp;
            <button type="submit" name="action" value="cancel" width="100">Отмена</button>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</p>
