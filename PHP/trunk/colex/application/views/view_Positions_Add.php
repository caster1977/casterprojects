<h1>Должности | Добавление</h1>
<p>
  <form method="post" action="/positions">
    <table>
      <col>
      <col class="activity">
      <thead>
        <tr>
          <th>Наименование</th>
          <th class="activity"><abbr title="Aктивность">*</></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="text" name="Name" maxlength="255" size="100"></td>
          <td><input type="checkbox" name="Active" class="activity" checked></td>
        </tr>
        <tr>
          <td colspan="2" align="left">
            <nobr>
              <button type="submit" class="action" name="action" value="add" ALT="Добавить"><IMG SRC="/images/tick_ok_yes.png"></button>
              <button type="submit" class="action" name="action" value="cancel" ALT="Отмена"><IMG SRC="/images/arrow_top_left.png"></button>
            </nobr>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</p>
