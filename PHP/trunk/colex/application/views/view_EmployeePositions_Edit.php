<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li><a href="/employeepositions">должности работников</a></li>
  <li class="active">редактирование</li>
</ol>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <form method="post" action="/employeepositions">
      <?php foreach($data["employeepositions"] as $employeeposition):?>
      <div class="form-group-xs">
        <input type="hidden" name="id" value="<?php echo $employeeposition["id"];?>">
        <label for="employees" class="text-capitalize-first">работник</label>
        <select class="form-control" id="employees" name="employees" autofocus>
          <?php foreach($data["employees"] as $employee):?>
          <option value="<?php echo $employee["id"];?>"<?php if($employeeposition["employeeid"] === $employee["id"]) echo " selected";?>><?php echo $employee["fullname"];?></option>
          <?php endforeach;?>
        </select>
        <script>if (!("autofocus" in document.createElement("select"))) document.getElementById("employees").focus();</script>
      </div>
      <div class="form-group-xs">
        <label for="positions" class="text-capitalize-first">должность</label>
        <select class="form-control" id="positions" name="positions">
          <?php foreach($data["positions"] as $position):?>
          <option value="<?php echo $position["id"];?>"<?php if($employeeposition["positionid"] === $position["id"]) echo " selected";?>><?php echo $position["name"];?></option>
          <?php endforeach;?>
        </select>
      </div>
      <div class="form-group-xs">
        <label for="startdate" class="text-capitalize-first">дата вступления в должность</label>
        <input type="date" class="form-control" id="startdate" name="startdate" value="<?php echo $employeeposition["startdate"];?>">
      </div>
      <div class="form-group-xs">
        <label for="stopdate" class="text-capitalize-first">дата выхода из должности</label>
        <input type="date" class="form-control" id="stopdate" name="stopdate" value="<?php echo $employeeposition["stopdate"];?>">
      </div>
      <div class="checkbox">
        <label class="text-capitalize-first"><input type="checkbox" name="active" <?php if ($employeeposition["active"] === 1) echo "checked";?>>aктивность</label>
      </div>
      <div class="form-group-xs">
        <div class="col-sm-* col-xs-*">
          <div class="btn-toolbar" role="toolbar"  aria-label="Панель действий">
            <div class="btn-group" role="group">
              <button type="submit" class="btn btn-success btn-xs" name="action" value="edit" alt="сохранить">
                <span class="glyphicon glyphicon-ok-sign" alt="сохранить" aria-label="сохранить"></span>
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
      <?php endforeach;?>
    </form>
  </div>
</div>
