<div class="container top-bar-single">
  <ol class="breadcrumb">
    <li><a href="/">main</a></li>
    <li class="active">logon</li>
  </ol>
</div>
<div class="container-fluid">
  <div class="row">
    <div class="col-xs-*">
    <?php echo (isset($prev_action_result)) ? self::showresult($prev_action_result): "";?>
    </div>
  </div>
  <div class="row">
    <form class="form-signin" role="form" action="/profile/logon" method="post">
      <p class="lead form-signin-heading">Authorization</p>
      <input type="text" name="login" class="form-control" placeholder="Login" required autofocus>
      <input type="password" name="password" class="form-control" placeholder="Password" required>
      <label class="checkbox hidden">
        <input type="checkbox" name="remember" value="1"> remember me
      </label>
      <button class="btn btn-sm btn-primary btn-block" type="submit">Enter</button>
    </form>
  </div>
</div>