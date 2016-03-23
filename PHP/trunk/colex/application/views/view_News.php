<h1>новости</h1>
<?php foreach($data as $row):?>
  <table id="news">
    <tbody>
      <tr>
        <th>[<?php echo $row['changedate'];?>]: <?php echo $row['title'];?></th>
      </tr>
      <tr>
        <td><?php echo $row['body'];?></td>
      </tr>
      <!--tr>
        <td>автор: пользователь <?php echo $row['employeeid'];?></td>
      </tr-->
    </tbody>
  </table>
  <br />
<?php endforeach;?>