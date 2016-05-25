<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li><a href="/cosignments">партии изделий</a></li>
  <li class="active">редактирование</li>
</ol>
<div class="row">
  <div class="col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row">
  <div class="col-xs-*">
    <form method="post" action="/cosignments">
      <?php foreach($data as $row):?>
      <div class="form-group-xs">
        <input type="hidden" name="id" value="<?php echo $row["id"];?>">
        <label for="number" class="text-capitalize-first">номер</label>
        <input type="text" class="form-control" id="number" name="number" maxlength="255" value="<?php echo htmlspecialchars($row["number"]);?>" placeholder="Введите номер" autofocus required>
        <script>if (!("autofocus" in document.createElement("input"))) document.getElementById("number").focus();</script>
      </div>
      <div class="form-group-xs">
        <label for="registrationdate" class="text-capitalize-first">дата регистрации</label>
        <input type="date" class="form-control" id="registrationdate" name="registrationdate" value="<?php echo htmlspecialchars($row["registrationdate"]);?>" required>
      </div>
      <div class="checkbox">
        <label class="text-capitalize-first"><input type="checkbox" name="active" <?php if ($row["active"] === 1) echo "checked";?>>aктивность</label>
      </div>
      <div class="form-group-xs">
        <div class="col-xs-*">
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
