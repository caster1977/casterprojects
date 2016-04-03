<div class="page-header">
  <h1 class="text-uppercase">новости</h1>
</div>
<div class="row-fluid">
<?php foreach($data as $row):?>
  <div class="col-xs-4">
    <h4><?php echo $row['title'];?></h4>
    <p><?php echo $row['body'];?></p>
    <p class="small">[<?php echo $row['changedate'];?>] <?php echo $row['employeeid'];?></p>
  </div>
<?php endforeach;?>
</div>