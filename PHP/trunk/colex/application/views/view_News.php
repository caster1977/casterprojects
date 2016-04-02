<div class="page-header">
  <h1 class="text-uppercase">новости</h1>
</div>
<?php foreach($data as $row):?>
  <table class="table">
    <tbody>
      <tr>
        <th>[<?php echo $row['changedate'];?>]: <?php echo $row['title'];?></th>
      </tr>
      <tr>
        <td><?php echo $row['body'];?></td>
      </tr>
      <!tr>
        <td>автор: пользователь <?php echo $row['employeeid'];?></td>
      </tr>
    </tbody>
  </table>
<?php endforeach;?>