<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li><a href="/dealershipagreements">дилерские соглашения</a></li>
  <li class="active">редактирование</li>
</ol>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <form method="post" action="/dealershipagreements">
      <?php foreach($data as $row):?>
      <div class="form-group-xs">
        <input type="hidden" name="id" value="<?php echo $row["id"];?>">
        <label for="name" class="text-capitalize-first">наименование</label>
        <input type="text" class="form-control" id="name" name="name" maxlength="255" value="<?php echo htmlspecialchars($row["name"]);?>" placeholder="Введите наименование" autofocus>
        <script>if (!("autofocus" in document.createElement("input"))) document.getElementById("name").focus();</script>
      </div>
      <div class="form-group-xs">
        <label for="details" class="text-capitalize-first">условия</label>
        <textarea class="form-control" name="details" id="details" rows="20" cols="60" placeholder="Введите условия"><?php echo htmlspecialchars($row["details"]);?></textarea>
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
      </div>
      <?php endforeach;?>
    </form>
  </div>
</div>
