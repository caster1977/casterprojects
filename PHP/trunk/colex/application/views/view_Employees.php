<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li class="active">работники</li>
</ol>
<?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
<div class="table-responsive">
  <table class="table table-condensed table-hover table-bordered">
    <colgroup>
      <col class="actions"/>
      <col/>
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
        <th class="text-center">
          <form class="form-inline" method="post">
            <div class="form-group-xs">
              <div class="btn-toolbar" role="toolbar"  aria-label="Панель действий">
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-success btn-xs" formaction="/employees/add"><span class="glyphicon glyphicon-plus" alt="добавить" aria-label="добавить"></span></button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" formaction="/employees/clear"><span class="glyphicon glyphicon-trash" alt="удалить все" aria-label="удалить все"></span></button>
                </div>
              </div>
            </div>
          </form>
        </th>
        <th class="text-left">фамилия</th>
        <th class="text-left">имя</th>
        <th class="text-left">отчество</th>
        <th class="text-center">дата рождения</th>
        <th class="text-center">пол</th>
        <th class="text-left">логин</th>
        <th class="text-center">последний вход в систему</th>
        <th class="text-center"><abbr title="активность">*</abbr></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach($data as $row):?>
      <tr>
        <td class="text-center">
          <form class="form-inline" method="post">
            <div class="form-group-xs">
              <div class="btn-toolbar" role="toolbar"  aria-label="Панель действий">
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-warning btn-xs" formaction="/employees/edit" name="id" value="<?php echo $row["id"];?>">
                    <span class="glyphicon glyphicon-pencil" alt="редактировать" aria-label="редактировать"></span>
                  </button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" formaction="/employees/delete" name="id" value="<?php echo $row["id"];?>">
                    <span class="glyphicon glyphicon-trash" alt="удалить" aria-label="удалить"></span>
                  </button>
                </div>
              </div>
            </div>
          </form>
        </td>
        <td><?php echo $row["lastname"];?></td>
        <td><?php echo $row["firstname"];?></td>
        <td><?php echo $row["middlename"];?></td>
        <td class="text-center"><?php echo $row["birthdate"];?></td>
        <td class="text-center"><?php echo $row["male"] ? "мужской" : "женский";?></td>
        <td><?php echo $row["login"];?></td>
        <td class="text-center"><?php echo $row["lastlogon"];?></td>
        <td class="text-center activity">
          <span class="glyphicon glyphicon-<?php echo ($row["active"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
        </td>
      </tr>
      <?php endforeach;?>
    </tbody>
  </table>
</div>