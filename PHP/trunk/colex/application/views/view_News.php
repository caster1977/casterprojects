<div class="page-header">
  <h5>новости</h5>
</div>
<div class="row-fluid">
<?php foreach($data as $row):?>
  <div class="col-sm-4 col-xs-6">
    <h4><?php echo $row['title'];?></h4>
    <p><?php echo $row['body'];?></p>
    <p class="small">[<?php echo $row['changedate'];?>] <?php echo $row['employeeid'];?></p>
  </div>
<?php endforeach;?>
</div>