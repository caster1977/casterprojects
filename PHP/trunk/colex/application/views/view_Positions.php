<H1>Должности</h1>
<P>
  <TABLE>
    <CAPTION>
      <?php
        if (isset($prev_action_result))
        {
          echo self::ShowResult($prev_action_result);
        }
      ?>
    </CAPTION>
    <COL class="identity">
    <COL>
    <COL class="activity">
    <COL class="actions">
    <THEAD>
      <TR>
        <TH class="identity"><ABBR title="Идентификатор">ID</></TH>
        <TH>Наименование</TH>
        <TH class="activity"><ABBR title="Активность">*</></TH>
        <TH class="actions"><ABBR title="Доступные действия">**</ABBR></TH>
      </TR>
    </THEAD>
    <TBODY>
    <?php
      foreach($data as $row)
      {
        $checked = "";
        if ($row['Active'] === 1)
        {
          $checked = " CHECKED";
        };
        printf('
          <TR>
            <TD>%d</TD>
            <TD>%s</TD>
            <TD><INPUT class="activity" TYPE="checkbox" DISABLED%s></TD>
            <TD>
              <NOBR>
                <FORM METHOD="POST" ACTION="">
                  <BUTTON CLASS="action" TYPE="SUBMIT" FORMACTION="/Positions/Edit" ALT="Редактировать" Name="Id" VALUE="%d"><IMG SRC="/images/b_edit.png"></BUTTON>
                  <BUTTON CLASS="action" TYPE="SUBMIT" FORMACTION="/Positions/Delete" ALT="Удалить" Name="Id" VALUE="%d"><IMG SRC="/images/b_drop.png"></BUTTON>
                </FORM>
              </NOBR>
            </TD>
          </TR>', $row['Id'], $row['Name'], $checked, $row['Id'], $row['Id']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>