<div class="container top-bar-single">
  <ol class="breadcrumb">
    <li><a href="/">главная</a></li>
    <li class="active">новости</li>
  </ol>
</div>
<div class="container-fluid">
  <div class="row">
    <?php foreach($data as $row):?>
    <div class="col-md-4 col-sm-6 col-xs-12">
      <h4><?php echo $row['title'];?></h4>
      <p><?php echo $row['body'];?></p>
      <p class="small">[<?php echo $row['changedate'];?>] <?php echo $row['employeeid'];?></p>
    </div>
    <?php endforeach;?>
  </div>
</div>