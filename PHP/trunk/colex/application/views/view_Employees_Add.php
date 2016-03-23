<h1>работники | добавление</h1>
<p>
  <form method="post" action="/employees">
    <table>
      <colgroup>
        <col>
        <col>
        <col>
        <col>
        <col>
        <col>
        <col class="activity">
      </colgroup>
      <thead>
        <tr>
          <th>фамилия</th>
          <th>имя</th>
          <th>отчество</th>
          <th>дата рождения</th>
          <th>логин</th>
          <th>пароль</th>
          <th class="activity">активность</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="text" name="lastname" maxlength="255" size="20"></td>
          <td><input type="text" name="firstname" maxlength="255" size="20"></td>
          <td><input type="text" name="middlename" maxlength="255" size="20"></td>
          <td><input type="date" name="birthdate" value="<?php echo date('Y-m-d');?>"></td>
          <td><input type="text" name="login" maxlength="255" size="20"></td>
          <td><input type="password" name="password" maxlength="255" size="20"></td>
          <td><input type="checkbox" name="active" class="activity" checked></td>
        </tr>
        <tr>
          <td colspan="7" align="left">
            <nobr>
              <button type="submit" class="action" name="action" value="add" alt="добавить"><img src="/images/tick_ok_yes.png"></button>
              <button type="submit" class="action" name="action" value="cancel" alt="отмена"><img src="/images/arrow_top_left.png"></button>
            </nobr>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</p>
