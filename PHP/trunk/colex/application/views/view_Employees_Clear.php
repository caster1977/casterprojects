<ol class="breadcrumb">
  <li><a href="/">справочники</a></li>
  <li><a href="/employees">работники</a></li>
  <li class="active">удаление всех</li>
</ol>
<div class="table-responsive">
  <table class="table table-condensed table-hover table-bordered">
    <colgroup>
      <col/>
      <col/>
      <col/>
      <col/>
      <col/>
      <col/>
      <col class="activity"/>
    </colgroup>
    <thead>
      <tr>
        <th class="text-left">фамилия</th>
        <th class="text-left">имя</th>
        <th class="text-left">отчество</th>
        <th class="text-left">дата рождения</th>
        <th class="text-left">логин</th>
        <th class="text-left">последний вход в систему</th>
        <th class="text-center"><abbr title="активность">*</abbr></th>
      </tr>
    </thead>
    <tfoot>
      <tr>
        <td colspan="7" class="text-left">
          <form class="form-inline" method="post" action="/employees">
            <div class="form-group-xs">
              <div class="btn-toolbar" role="toolbar"  aria-label="Панель действий">
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-success btn-xs" name="action" value="clear" alt="удалить все">
                    <span class="glyphicon glyphicon-ok-sign" alt="удалить все" aria-label="удалить все"></span>
                  </button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" name="action" value="cancel" alt="отмена">
                    <span class="glyphicon glyphicon-remove-sign" alt="отмена" aria-label="отмена"></span>
                  </button>
                </div>
              </div>
            </div>
          </form>
        </td>
      </tr>
    </tfoot>
    <tbody>
      <?php foreach($data as $row):?>
      <tr>
        <td><?php echo $row["lastname"];?></td>
        <td><?php echo $row["firstname"];?></td>
        <td><?php echo $row["middlename"];?></td>
        <td><?php echo $row["birthdate"];?></td>
        <td><?php echo $row["login"];?></td>
        <td><?php echo $row["lastlogon"];?></td>
        <td class="text-center activity">
          <span class="glyphicon glyphicon-<?php echo ($row["active"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
        </td>
      </tr>
      <?php endforeach;?>
    </tbody>
  </table>
</div>