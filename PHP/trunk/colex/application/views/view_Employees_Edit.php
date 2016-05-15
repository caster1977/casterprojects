<ol class="breadcrumb">
  <li><a href="/">главная</a></li>
  <li><a href="/references">справочники</a></li>
  <li><a href="/employees">работники</a></li>
  <li class="active">редактирование</li>
</ol>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
  </div>
</div>
<div class="row-fluid">
  <div class="col-sm-* col-xs-*">
    <form method="post" action="/employees">
      <?php foreach($data as $row):?>      
      <div class="form-group-xs">
        <input type="hidden" name="id" value="<?php echo $row["id"];?>">
        <label for="lastname" class="text-capitalize-first">фамилия</label>
        <input type="text" class="form-control" id="lastname" name="lastname" maxlength="255" value="<?php echo $row["lastname"];?>" placeholder="Введите фамилию" autofocus>
        <script>if (!("autofocus" in document.createElement("input"))) document.getElementById("lastname").focus();</script>
      </div>
      <div class="form-group-xs">
        <label for="firstname" class="text-capitalize-first">имя</label>
        <input type="text" class="form-control" id="firstname" name="firstname" maxlength="255" value="<?php echo $row["firstname"];?>" placeholder="Введите имя">
      </div>
      <div class="form-group-xs">
        <label for="middlename" class="text-capitalize-first">отчество</label>
        <input type="text" class="form-control" id="middlename" name="middlename" maxlength="255" value="<?php echo $row["middlename"];?>" placeholder="Введите отчество">
      </div>
      <div class="form-group-xs">
        <label for="birthdate" class="text-capitalize-first">дата рождения</label>
        <input type="date" class="form-control" id="birthdate" name="birthdate" value="<?php echo $row["birthdate"];?>">
      </div>
      <div class="form-group-xs">
        <label class="control-label text-capitalize-first">пол</label>
        <div class="radio">
          <label><input type="radio" name="male" id="male1" value="1" <?php if ($row["male"] === 1) echo "checked";?>>мужской</label>
        </div>
        <div class="radio">
          <label><input type="radio" name="male" id="male0" value="0" <?php if ($row["male"] === 0) echo "checked";?>>женский</label>
        </div>
      </div>
      <div class="form-group-xs">
        <label for="login" class="text-capitalize-first">логин</label>
        <input type="text" class="form-control" id="login" name="login" maxlength="255" value="<?php echo $row["login"];?>" placeholder="Введите логин">
      </div>
      <div class="form-group-xs">
        <label for="password" class="text-capitalize-first">пароль</label>
        <input type="password" class="form-control" id="password" name="password" maxlength="255" placeholder="Введите новый пароль">
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
