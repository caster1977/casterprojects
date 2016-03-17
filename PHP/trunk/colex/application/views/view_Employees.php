<H1>Работники</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Фамилия</TH>
      <TH>Имя</TH>
      <TH>Отчество</TH>
      <TH>Дата рождения</TH>
      <TH>Логин</TH>
      <!--TH>HASH пароля</TH-->
      <TH>Последний вход в систему</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD><TD>%d</TD></TR>', 
	  $row['Id'], $row['LastName'], $row['FirstName'], $row['MiddleName'], $row['BirthDate'], $row['Login'], $row['LastLogon'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
