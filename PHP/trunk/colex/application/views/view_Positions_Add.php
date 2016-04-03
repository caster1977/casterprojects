<div class="page-header">
  <h1 class="text-uppercase">должности | добавление</h1>
</div>
<?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
<div class="table-responsive">
  <form method="post" action="/positions">
	<table class="table table-condensed table-hover table-bordered">
      <col>
      <col class="activity">
      <thead>
        <tr>
          <th>наименование</th>
          <th class="activity">активность</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="text" name="name" maxlength="255" size="100"></td>
          <td><input type="checkbox" name="active" class="activity" checked></td>
        </tr>
        <tr>
          <td colspan="2" align="left">
            <nobr>
              <button type="submit" class="action" name="action" value="add" alt="добавить"><img src="/images/tick_ok_yes.png"></button>
              <button type="submit" class="action" name="action" value="cancel" alt="отмена"><img src="/images/arrow_top_left.png"></button>
            </nobr>
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</div>