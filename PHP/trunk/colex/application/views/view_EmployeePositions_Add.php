<ol class="breadcrumb">
  <li><a href="/">справочники</a></li>
  <li><a href="/employeepositions">должности работников</a></li>
  <li class="active">добавление</li>
</ol>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <form method="post" action="/employeepositions">
      <div class="form-group-xs">
        <label for="employees" class="text-capitalize-first">работник</label>
        <select class="form-control" id="employees" name="employees" autofocus>
          <?php foreach($data["employees"] as $row):?>
          <option value="<?php echo $row["id"];?>"><?php echo $row["fullname"];?></option>
          <?php endforeach;?>
        </select>
        <script>if (!("autofocus" in document.createElement("select"))) document.getElementById("employees").focus();</script>
      </div>
      <div class="form-group-xs">
        <label for="positions" class="text-capitalize-first">должность</label>
        <select class="form-control" id="positions" name="positions">
          <?php foreach($data["positions"] as $row):?>
          <option value="<?php echo $row["id"];?>"><?php echo $row["name"];?></option>
          <?php endforeach;?>
        </select>
      </div>
      <div class="form-group-xs">
        <label for="startdate" class="text-capitalize-first">дата вступления в должность</label>
        <input type="date" class="form-control" id="startdate" name="startdate" value="<?php echo date('Y-m-d');?>">
      </div>
      <div class="form-group-xs">
        <label for="stopdate" class="text-capitalize-first">дата выхода из должности</label>
        <input type="date" class="form-control" id="stopdate" name="stopdate">
      </div>
      <div class="checkbox">
        <label class="text-capitalize-first"><input type="checkbox" name="active" checked>aктивность</label>
      </div>      
      <div class="form-group-xs">
        <div class="col-sm-* col-xs-*">
          <div class="btn-toolbar" role="toolbar"  aria-label="Панель действий">
            <div class="btn-group" role="group">
              <button type="submit" class="btn btn-success btn-xs" name="action" value="add" alt="добавить">
                <span class="glyphicon glyphicon-ok-sign" alt="добавить" aria-label="добавить"></span>
              </button>
            </div>
            <div class="btn-group" role="group">
              <button type="submit" class="btn btn-danger btn-xs" name="action" value="cancel" alt="отмена">
                <span class="glyphicon glyphicon-remove-sign" alt="отмена" aria-label="отмена"></span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
