<div class="page-header">
  <h5>
    <a href="/">справочники</a>
    <span class="level"></span>
    <a href="/employeepositions">должности работников</a>
    <span class="level"></span>
    удаление
  </h5>
</div>
<div class="table-responsive">
  <form class="form-inline" method="post" action="/employeepositions">
    <table class="table table-condensed table-hover table-bordered">
      <colgroup>
        <col/>
        <col/>
        <col/>
        <col/>
        <col class="activity"/>
      </colgroup>
      <thead>
        <tr>
          <th class="text-left">работник</th>
          <th class="text-left">должность</th>
          <th class="text-left">дата вступления в должность</th>
          <th class="text-left">дата выхода из должности</th>
          <th class="text-center"><abbr title="активность">*</abbr></th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="5" class="text-left">
            <div class="form-group-xs">
              <div class="btn-toolbar" role="toolbar"  aria-label="Панель действий">
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-success btn-xs" name="action" value="delete" alt="удалить">
                    <span class="glyphicon glyphicon-ok-sign" alt="удалить" aria-label="удалить"></span>
                  </button>
                </div>
                <div class="btn-group" role="group">
                  <button type="submit" class="btn btn-danger btn-xs" name="action" value="cancel" alt="отмена">
                    <span class="glyphicon glyphicon-remove-sign" alt="отмена" aria-label="отмена"></span>
                  </button>
                </div>
              </div>
            </div>
          </td>
        </tr>
      </tfoot>
      <tbody>
        <?php foreach($data["employeepositions"] as $row):?>      
        <tr>
          <td>
            <input type="hidden" name="id" value="<?php echo $row["id"];?>">
            <?php echo $row["employee_fullname"];?>
          </td>
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
  </form>        
</div>