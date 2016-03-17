<h1>Новости</h1>
<?php
  foreach($data as $row):
?>
  <TABLE id="news">
    <TBODY>
      <TR>
        <TH>[<?php echo $row['ChangeDate'];?>]: <?php echo $row['Title'];?></TH>
      </TR>
      <TR>
        <TD><?php echo $row['Body'];?></TD>
      </TR>
      <!--TR>
        <TD>Автор: пользователь <?php echo $row['EmployeeId'];?></TD>
      </TR-->
    </TBODY>
  </TABLE>
  <BR>
<?php
  endforeach;
?>