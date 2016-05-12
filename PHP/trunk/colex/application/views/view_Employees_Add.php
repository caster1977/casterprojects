<div class="page-header">
  <h5>
    <a href="/">справочники</a>
    <span class="level"></span>
    <a href="/employees">работники</a>
    <span class="level"></span>
    добавление
  </h5>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <form method="post" action="/employees">
      <div class="form-group-xs">
        <label for="lastname" class="text-capitalize-first">фамилия</label>
        <input type="text" class="form-control" id="lastname" name="lastname" maxlength="255" placeholder="Введите фамилию" autofocus>
        <script>if (!("autofocus" in document.createElement("input"))) document.getElementById("lastname").focus();</script>
      </div>
      <div class="form-group-xs">
        <label for="firstname" class="text-capitalize-first">имя</label>
        <input type="text" class="form-control" id="firstname" name="firstname" maxlength="255" placeholder="Введите имя">
      </div>
      <div class="form-group-xs">
        <label for="middlename" class="text-capitalize-first">отчество</label>
        <input type="text" class="form-control" id="middlename" name="middlename" maxlength="255" placeholder="Введите отчество">
      </div>
      <div class="form-group-xs">
        <label for="birthdate" class="text-capitalize-first">дата рождения</label>
        <input type="date" class="form-control" id="birthdate" name="birthdate" value="<?php echo date('Y-m-d');?>">
      </div>
      <div class="form-group-xs">
        <label for="login" class="text-capitalize-first">логин</label>
        <input type="text" class="form-control" id="login" name="login" maxlength="255" placeholder="Введите логин">
      </div>
      <div class="form-group-xs">
        <label for="password" class="text-capitalize-first">пароль</label>
        <input type="password" class="form-control" id="password" name="password" maxlength="255" placeholder="Введите пароль">
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
