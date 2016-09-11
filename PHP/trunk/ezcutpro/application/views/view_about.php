<div class="container top-bar-single">
  <ol class="breadcrumb">
    <li><a href="/">main</a></li>
    <li class="active">about</li>
  </ol>
</div>
<div class="container">
  <h1 class="text-center">Our Team</h1>
  <div class="row">
    <?php foreach($data['employeepositions'] as $row):?>
    <div class="about col-xs-6 col-sm-4 col-md-3 text-center">
      <img class="img-circle img-about" alt="Avatar image" src="<?php echo $data['employees'][$row['employeeid']]['avatar'];?>">
      <h3><?php echo $data['positions'][$row['positionid']]['name'];?></h3>
      <h5>
        <span class="first-name"><?php echo $data['employees'][$row['employeeid']]['firstname'];?></span>
        <span class="last-name"><?php echo $data['employees'][$row['employeeid']]['lastname'];?></span>
      </h5>
    </div>
    <?php endforeach;?>
  </div>
</div>