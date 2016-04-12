<div class="page-header">
  <h5>
    <a href="/">справочники</a>
    <span class="level"></span>
    <a href="/functions">пользовательские функции</a>
    <span class="level"></span>
    редактирование
  </h5>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <form method="post" action="/functions">
      <?php foreach($data as $row):?>      
        <div class="form-group-xs">
          <input type="hidden" name="id" value="<?php echo $row["id"];?>">
          <label for="name" class="text-capitalize-first">наименование</label>
          <input type="text" class="form-control" id="name" name="name" maxlength="255" value="<?php echo $row["name"];?>" placeholder="Введите наименование" autofocus>
          <script>if (!("autofocus" in document.createElement("input"))) document.getElementById("name").focus();</script>
        </div>
        <div class="form-group-xs">
          <label for="code" class="text-capitalize-first">код</label>
          <input type="text" class="form-control" id="code" name="code" maxlength="255" value="<?php echo $row["code"];?>" placeholder="Введите код">
        </div>
        <div class="checkbox">
          <label class="text-capitalize-first"><input type="checkbox" name="active" <?php if ($row["active"] === 1) echo "checked";?>>aктивность</label>
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
      <?php endforeach;?>
    </form>
  </div>
</div>
