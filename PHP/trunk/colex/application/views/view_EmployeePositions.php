<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li class="active">должности работников</li>
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
                  <button type="submit" class="btn btn-success btn-xs" formaction="/employeepositions/add"><span class="glyphicon glyphicon-plus" alt="добавить" aria-label="добавить"></span></button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" formaction="/employeepositions/clear"><span class="glyphicon glyphicon-trash" alt="удалить все" aria-label="удалить все"></span></button>
                </div>
              </div>
            </div>
          </form>
        </th>
        <th class="text-left">работник</th>
        <th class="text-left">должность</th>
        <th class="text-left">дата вступления в должность</th>
        <th class="text-left">дата выхода из должности</th>
        <th class="text-center"><abbr title="активность">*</abbr></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach($data["employeepositions"] as $row):?>
      <tr>
        <td class="text-center">
          <form class="form-inline" method="post">
            <div class="form-group-xs">
              <div class="btn-toolbar" role="toolbar"  aria-label="Панель действий">
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-warning btn-xs" formaction="/employeepositions/edit" name="id" value="<?php echo $row["id"];?>">
                    <span class="glyphicon glyphicon-pencil" alt="редактировать" aria-label="редактировать"></span>
                  </button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" formaction="/employeepositions/delete" name="id" value="<?php echo $row["id"];?>">
                    <span class="glyphicon glyphicon-trash" alt="удалить" aria-label="удалить"></span>
                  </button>
                </div>
              </div>
            </div>
          </form>
        </td>
        <td><?php echo $row["employee_fullname"];?></td>
        <td><?php echo $row["position_name"];?></td>
        <td><?php echo $row["startdate"];?></td>
        <td><?php echo $row["stopdate"];?></td>
        <td class="text-center activity">
          <span class="glyphicon glyphicon-<?php echo ($row["active"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
        </td>
      </tr>
      <?php endforeach;?>
    </tbody>
  </table>
</div>