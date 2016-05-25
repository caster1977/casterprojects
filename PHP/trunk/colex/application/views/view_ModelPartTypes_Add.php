<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li><a href="/modelparttypes">типы частей оборудования</a></li>
  <li class="active">добавление</li>
</ol>
<div class="row">
  <div class="col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row">
  <div class="col-xs-*">
    <form method="post" action="/modelparttypes">
      <div class="form-group-xs">
        <label for="name" class="text-capitalize-first">наименование</label>
        <input type="text" class="form-control" id="name" name="name" maxlength="255" placeholder="Введите наименование" autofocus required>
        <script>if (!("autofocus" in document.createElement("input"))) document.getElementById("name").focus();</script>
      </div>
      <div class="checkbox">
        <label class="text-capitalize-first"><input type="checkbox" name="active" checked>aктивность</label>
      </div>
      <div class="form-group-xs">
        <div class="col-xs-*">
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
