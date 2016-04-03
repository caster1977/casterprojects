<div class="page-header">
  <h1 class="text-uppercase">должности</h1>
</div>
<?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
<div class="table-responsive">
  <table class="table table-condensed table-hover table-bordered">
    <colgroup>
      <col/>
      <col class="activity"/>
      <col/>
    </colgroup>
    <thead>
      <tr>
        <th class="text-capitalize text-left">наименование</th>
        <th class="text-capitalize text-center">активность</th>
        <th class="text-capitalize text-center">
          <form method="post">
            <div class="btn-group" role="group" aria-label="Панель действий">
              <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-plus" aria-label="добавить"></span></button>
              <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-trash" aria-label="удалить все"></button>
            </div>
          
            <button class="action" type="submit" formaction="/positions/add" alt="добавить"><img src="/images/add.png"></button>
            <button class="action" type="submit" formaction="/positions/clear" alt="удалить все"><img src="/images/close_cancel_deny_denied.png"></button>
          </form>
        </th>
      </tr>
    </thead>
    <tbody>
      <?php foreach($data as $row):?>      
      <tr>
        <td><?php echo $row["name"];?></td>
        <td class="text-center activity">
          <span class="glyphicon glyphicon-<?php echo ($row["active"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
        </td>
        <td>
          <form method="post">
            <button class="action" type="submit" formaction="/positions/edit" alt="редактировать" name="id" value="<?php echo $row["id"];?>"><img src="/images/write_edit_pen.png"></button>
            <button class="action" type="submit" formaction="/positions/delete" alt="удалить" name="id" value="<?php echo $row["id"];?>"><img src="/images/close_cancel_deny_denied.png"></button>
          </form>
        </td>
      </tr>
    <?php endforeach;?>
    </tbody>
  </table>
</div>