<H1>Доступ к функционалу</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Функция</TH>
      <TH>Группа доступа</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%d</TD><TD>%d</TD><TD>%d</TD></TR>', $row['Id'], $row['FunctionId'], $row['AccessGroupId'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
