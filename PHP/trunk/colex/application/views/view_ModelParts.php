<ol class="breadcrumb">
  <li><a href="/">справочники</a></li>
  <li class="active">части оборудования</li>
</ol>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="table-responsive">
  <table class="table table-condensed table-hover table-bordered">
    <colgroup>
      <col class="actions"/>
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
                  <button type="submit" class="btn btn-success btn-xs" formaction="/modelparts/add"><span class="glyphicon glyphicon-plus" alt="добавить" aria-label="добавить"></span></button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" formaction="/modelparts/clear"><span class="glyphicon glyphicon-trash" alt="удалить все" aria-label="удалить все"></span></button>
                </div>
              </div>
            </div>
          </form>
        </th>
        <th class="text-left">модель</th>
        <th class="text-left">тип части оборудования</th>
        <th class="text-left">наименование</th>
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
                  <button type="submit" class="btn btn-warning btn-xs" formaction="/modelparts/edit" name="id" value="<?php echo $row["id"];?>">
                    <span class="glyphicon glyphicon-pencil" alt="редактировать" aria-label="редактировать"></span>
                  </button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" formaction="/modelparts/delete" name="id" value="<?php echo $row["id"];?>">
                    <span class="glyphicon glyphicon-trash" alt="удалить" aria-label="удалить"></span>
                  </button>
                </div>
              </div>
            </div>
          </form>
        </td>
        <td><?php echo $row["model_name"];?></td>
        <td><?php echo $row["modelparttype_name"];?></td>
        <td><?php echo $row["name"];?></td>
        <td class="text-center activity">
          <span class="glyphicon glyphicon-<?php echo ($row["active"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
        </td>
      </tr>
      <?php endforeach;?>
    </tbody>
  </table>
</div>