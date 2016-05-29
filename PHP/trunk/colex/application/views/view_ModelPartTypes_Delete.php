<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li><a href="/modelparttypes">типы частей оборудования</a></li>
  <li class="active">удаление</li>
</ol>
<div class="table-responsive">
  <form class="form-inline" method="post" action="/modelparttypes">
    <table class="table table-condensed table-hover table-bordered">
      <colgroup>
        <col/>
        <col class="activity"/>
      </colgroup>
      <thead>
        <tr>
          <th class="text-left">наименование</th>
          <th class="text-center"><abbr title="активность">*</abbr></th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2" class="text-left">
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
        <?php foreach($data as $row):?>
        <tr>
          <td>
            <input type="hidden" name="id" value="<?php echo $row["id"];?>">
            <?php echo $row["name"];?>
          </td>
          <td class="text-center activity">
            <span class="glyphicon glyphicon-<?php echo ($row["active"] === 1) ? "ok" : "remove";?>" aria-hidden="true"></span>
          </td>
        </tr>
        <?php endforeach;?>
      </tbody>
    </table>
  </form>
</div>