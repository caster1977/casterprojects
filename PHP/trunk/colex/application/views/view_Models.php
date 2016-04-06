<div class="page-header">
  <h5><a href="/">справочники</a><span class="level"></span>модели оборудования</h5>
</div>
<?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
<div class="table-responsive">
  <table class="table table-condensed table-hover table-bordered">
    <colgroup>
      <col class="actions"/>
      <col/>
      <col class="activity"/>
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
                <button type="submit" class="btn btn-success btn-xs" formaction="/models/add"><span class="glyphicon glyphicon-plus" alt="добавить" aria-label="добавить"></span></button>
              </div>
              <div class="btn-group" role="group">
                <button type="submit" class="btn btn-danger btn-xs" formaction="/models/clear"><span class="glyphicon glyphicon-trash" alt="удалить все" aria-label="удалить все"></span></button>
              </div>
            </div>
          </form>
        </th>
        <th class="text-left">наименование</th>
        <th class="text-center">прототип</th>
        <th class="text-left">описание</th>
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
                <button type="submit" class="btn btn-warning btn-xs" formaction="/models/edit" name="id" value="<?php echo $row["id"];?>">
                  <span class="glyphicon glyphicon-pencil" alt="редактировать" aria-label="редактировать"></span>
                </button>
              </div>
              <div class="btn-group" role="group">
                <button type="submit" class="btn btn-danger btn-xs" formaction="/models/delete" name="id" value="<?php echo $row["id"];?>">
                  <span class="glyphicon glyphicon-trash" alt="удалить" aria-label="удалить"></span>
                </button>
              </div>
            </div>
          </form>
        </td>
        <td><?php echo $row["name"];?></td>
        <td class="text-center activity">
          <span class="glyphicon glyphicon-<?php echo ($row["prototype"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
        </td>
        <td><?php echo $row["description"];?></td>
        <td class="text-center activity">
          <span class="glyphicon glyphicon-<?php echo ($row["active"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
        </td>
      </tr>
    <?php endforeach;?>
    </tbody>
  </table>
</div>