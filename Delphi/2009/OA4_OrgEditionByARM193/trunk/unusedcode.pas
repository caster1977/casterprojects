(*
procedure TMainForm.btnSaveClick(Sender: TObject);
var
  s, sMsrID, sOrgID: string;
  q, sRTF, sPlane, sa: AnsiString;
	RTFStream: TMemoryStream;
	pac: PAnsiChar;
  bError: boolean;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  i, j, iLastID, iOrgID, iMsrID, city_id, street_id, org_firm_code: integer;
  GroupId: integer;
  pwcGroupName: PWideChar;
  LvGroup: TLVGROUP;
  ListItem: TListItem;
  LvItemA: TLVITEMA;
  house_num, subhouse_num, flat_num: integer;
  house_sym, subhouse_sym, flat_sym: string;
  tp: TPoint;

  procedure DivideNumberAndSymbolParts(const Source: string; var Num: integer; var Sym: string);
  var
    i, j: integer;
    s: string;
  begin
    s:='';
    // ������� � ������� ������� ������-��������� ������� �������, � ������� ������ �������� �������� �� ����
    for j:=1 to Length(Source) do
      begin
        s:=s+Source[j];
        i:=StrToIntDef(s,-1);
        if i=-1 then
          Break; // ������� ����� ��� "���������" �� ������, ������� ��� ���������� ������������� � �����
      end;
    Num:=StrToIntDef(Copy(Source,0,j-1),0);
    Sym:=Copy(Source,j,Length(Source)-j+1);
  end;

begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  sRTF:='';
  sPlane:='';
  bError:=False;
  iOrgID:=-1;
  iMsrID:=-1;
  org_firm_code:=-1;
  ProgressBar1.Step:=1;

  // ��������� ID ������
  // ��������� / ���������� ID �����
  // ��������� / ���������� ID org_firm_code
  // ����������� ������� �� ���������� / �������������� �����������
  // ���������� ����������� � ���������� ID ����������� �����������
  // ���������� ������ � ������� ����
  // ���������� ������ �����������
  // ���� ����������� ���� � ������ - ���������� ������ �� ��, ���� ��� - ���������� ������ �� ������ ������ �����������

  if PageControl1.ActivePage=tsOrg then
    begin
      if bAddingOrgNow then
        begin
          LogThis('������������ ���������� ����� �����������.',lmtInfo);
          ProgressBar1.Max:=9;
        end
      else
        begin
          if lvOrg.Selected<>nil then // ���������� ID �����������
            begin
              iOrgID:=StrToIntDef(lvOrg.Selected.SubItems[2],-1); // ���������� �������� ID ���������� �����������
              if iOrgID>=0 then
                LogThis('������������ �������� ��������� � ������ ����������� � ID='+IntToStr(iOrgID)+'.',lmtInfo)
              else
                begin
                  s:='�������� ������ ��� ��������� ID ������������� �����������!';
                  LogThis(s,lmtError);
                  ProgressBar1.Position:=ProgressBar1.Min;
                  Screen.Cursor:=crDefault;
                  MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                  SetReady;
                  Exit;
                end;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
          ProgressBar1.Max:=9;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // ���������� ���������� ����� �������������� ����������� ��� ����������
      cmbbxOrgType.Text:=ValidateString(cmbbxOrgType.Text);
      edbxOrgName.Text:=ValidateString(edbxOrgName.Text);
      edbxOrgAddress.Text:=ValidateString(edbxOrgAddress.Text);
      cmbbxOrgTown.Text:=ValidateString(cmbbxOrgTown.Text);
      cmbbxOrgStreet.Text:=ValidateString(cmbbxOrgStreet.Text);
      edbxOrgHouse.Text:=ValidateString(edbxOrgHouse.Text);
      edbxOrgSubHouse.Text:=ValidateString(edbxOrgSubHouse.Text);
      edbxOrgFlat.Text:=ValidateString(edbxOrgFlat.Text);
      edbxOrgHowToReach.Text:=ValidateString(edbxOrgHowToReach.Text);
      cmbbxOrgWorkTime.Text:=ValidateString(cmbbxOrgWorkTime.Text);
      sPlane:=ValidateString(reOrgOtherInfo.Text);
      DivideNumberAndSymbolParts(Trim(edbxOrgHouse.Text), house_num, house_sym); // �������� �������� � ���������� �������� ����
      DivideNumberAndSymbolParts(Trim(edbxOrgSubHouse.Text), subhouse_num, subhouse_sym); // �������� �������� � ���������� �������� �������
      DivideNumberAndSymbolParts(Trim(edbxOrgFlat.Text), flat_num, flat_sym); // �������� �������� � ���������� �������� ��������
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // ��������� ID ������
      city_id:=2507;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // ��������� ID �����
      street_id:=-1;
      q:='SELECT street_id FROM minsk.street WHERE name=UCASE('+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+') ORDER BY street_id;';
      LogThis(q,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('������ �������� �������.',lmtInfo);
          ResultSet:=mysql_store_result(MySQLConnectionHandler);
          try
            if ResultSet<>nil then
              begin
                LogThis('�������������� ������� �������� �������.',lmtInfo);
                i:=mysql_num_rows(ResultSet);
                LogThis('���������� ����� ������� ����� '+IntToStr(i)+'.',lmtInfo);
                if (i>0) then
                  begin
                    LogThis('������� ��������� ������ �������.',lmtInfo);
                    ResultRow:=mysql_fetch_row(ResultSet);
                    if ResultRow<>nil then
                      begin
                        LogThis('���������� ������ - <'+ResultRow[0]+'>.',lmtInfo);
                        street_id:=StrToIntDef(ResultRow[0],-1) // ������� ID ����� (ID ������� ����������)
                      end
                    else
                      begin
                        s:='�������� ������ ��� �������� ������ ������ �������!';
                        bError:=True;
                      end;
                  end
                else
                  if i=0 then
                    street_id:=-1 // ����� ���� �� �������, ���������� ����� ������� �
                  else
                    begin
                      s:='�������� ������������ ���������� ����� �������������� ������� ('+IntToStr(i)+')!';
                      bError:=True;
                    end;
              end
            else
              begin
                s:='�� ������� �������� �������������� ������� �� ���������� SQL-�������!';
                bError:=True;
              end;
          finally
            if ResultSet<>nil then
              begin
                LogThis('������������ ��������, ������� ����������� �������...',lmtInfo);
                mysql_free_result(ResultSet);
              end;
          end;
        end
      else
        begin
          s:='�������� ������ ��� ���������� �������!';
          bError:=True;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;

      // ���������� ID �����
      if not bError then
        begin
          // ���� ������ ������ ����� ������� �������, ���� ����� ����������� � ������ ����, ���������� �������� ������� �������� �����
          if street_id<0 then
            begin
              q:='INSERT INTO minsk.street (street_id, name, oper, date) VALUES (NULL, UCASE('+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+'), 0, NOW())';
              LogThis(q,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('������ �������� �������.',lmtInfo);
                  iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // ���������� ID ����������� �����
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',lmtInfo);
                  if (i=1) then
                    begin
                      LogThis('���������� ����� ����� ����������� �������',lmtInfo);
                      street_id:=iLastID;
                    end
                  else
                    begin
                      s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='�������� ������ ��� ���������� �������!';
                  bError:=True;
                end;
            end;
        end;
      if not bError then
        begin
          if street_id<0 then
            begin
              s:='�� ������� �������� ������������� �����!';
              bError:=True;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;

      // ��������� / ���������� ID org_firm_code
      if not bError then
        begin
          if bAddingOrgNow then // ���������� ID org_firm_code
            begin
              q:='INSERT INTO minsk.firma (firm_code, name, main, city_id, street_id, house_num, house_sym, subhouse_num, subhouse_sym, flat_num, flat_sym, comment, ext_comment, work, oper, date) VALUES (NULL, "';
              if Trim(edbxOrgName.Text)<>'' then
                q:=q+NormalizeStringForQuery(edbxOrgName.Text, False, False);
              q:=q+' |';
              if Trim(cmbbxOrgType.Text)<>'' then
                q:=q+NormalizeStringForQuery(cmbbxOrgType.Text, False, False);
              q:=q+'", '+
              '"!R", '+
              IntToStr(city_id)+', '+
              IntToStr(street_id)+', '+
              IntToStr(house_num)+', '+
              NormalizeStringForQuery(house_sym, True, False)+', '+
              IntToStr(subhouse_num)+', '+
              NormalizeStringForQuery(subhouse_sym, True, False)+', '+
              IntToStr(flat_num)+', '+
              NormalizeStringForQuery(flat_sym, True, False)+', '+
              '"", '+
              NormalizeStringForQuery(edbxOrgAddress.Text, True, True)+', '+
              '"", 0, NOW());';
              LogThis(q,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('������ �������� �������.',lmtInfo);
                  iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // ���������� ID ����������� �����
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',lmtInfo);
                  if (i=1) then
                    begin
                      LogThis('���������� ����� ����� ����������� �������',lmtInfo);
                      org_firm_code:=iLastID;
                    end
                  else
                    begin
                      s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='�������� ������ ��� ���������� �������!';
                  bError:=True;
                end;
            end
          else // ��������� ID org_firm_code
            begin
              q:='SELECT org_firm_code FROM _org WHERE org_id='+IntToStr(iOrgID)+';';
              LogThis(q,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('������ �������� �������.',lmtInfo);
                  ResultSet:=mysql_store_result(MySQLConnectionHandler);
                  try
                    if ResultSet<>nil then
                      begin
                        LogThis('�������������� ������� �������� �������.',lmtInfo);
                        i:=mysql_num_rows(ResultSet);
                        LogThis('���������� ����� ������� ����� '+IntToStr(i)+'.',lmtInfo);
                        if (i=1) then
                          begin
                            LogThis('������� ��������� ������ �������.',lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                LogThis('���������� ������ - <'+ResultRow[0]+'>.',lmtInfo);
                                org_firm_code:=StrToIntDef(ResultRow[0],-1);
                              end
                            else
                              begin
                                s:='�������� ������ ��� �������� ������ ������ �������!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='�������� ������������ ���������� ����� �������������� ������� ('+IntToStr(i)+')!';
                            bError:=True;
                          end;
                      end
                    else
                      begin
                        s:='�� ������� �������� �������������� ������� �� ���������� SQL-�������!';
                        bError:=True;
                      end;
                  finally
                    if ResultSet<>nil then
                      begin
                        LogThis('������������ ��������, ������� ����������� �������...',lmtInfo);
                        mysql_free_result(ResultSet);
                      end;
                  end;
                end
              else
                begin
                  s:='�������� ������ ��� ���������� �������!';
                  bError:=True;
                end;
            end;
          if not bError then
            begin
              if org_firm_code<0 then // ���� ��������� ������ ��� ��������� ������� ������, ������������� ������
                begin
                  s:='������� ������������ ������������� ������ ������ � ������� minsk.firma!';
                  bError:=True;
                end;
            end;
          ProgressBar1.StepIt;
          Application.ProcessMessages;
          if bError then
            begin
              LogThis(s,lmtError);
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              SetReady;
            end;
        end;

      // ����������� ������� �� ���������� / �������������� �����������
      if not bError then
        begin
          if bAddingOrgNow then
            begin
              q:='INSERT INTO _org (org_id, org_erased, _org_type, _org_name, _org_address, org_firm_code, org_how_to_reach, org_work_time, org_other_info, org_other_info_rtf, org_created_at, org_created_by_user_id, org_modified_at, org_modified_by_user_id) VALUES '+
              '(NULL, "0", '+
              NormalizeStringForQuery(cmbbxOrgType.Text,True,True)+', '+
              NormalizeStringForQuery(edbxOrgName.Text,True,True)+', '+
              NormalizeStringForQuery(edbxOrgAddress.Text,True,True)+', '+
              IntToStr(org_firm_code)+', '+
              NormalizeStringForQuery(edbxOrgHowToReach.Text,True,True)+', '+
              NormalizeStringForQuery(cmbbxOrgWorkTime.Text,True,True)+', ';
              if Trim(sPlane)='' then // org_other_info, org_other_info_rtf
                q:=q+'NULL, NULL, '
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
                  q:=q+'"'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // �������������� ������ RTF � ������ � ESC-��������������������
                  RTFStream:=TMemoryStream.Create;
                  try
                    reOrgOtherInfo.Lines.SaveToStream(RTFStream);
                    RTFStream.Seek(0,soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
                    q:=q+'"'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'NOW(), '+CurrentUser.sID+', NOW(), '+CurrentUser.sID+');';
            end
          else
            begin
              q:='UPDATE _org SET '+
              '_org_type='+NormalizeStringForQuery(cmbbxOrgType.Text,True,True)+', '+
              '_org_name='+NormalizeStringForQuery(edbxOrgName.Text,True,True)+', '+
              '_org_address='+NormalizeStringForQuery(edbxOrgAddress.Text,True,True)+', '+
              'org_how_to_reach='+NormalizeStringForQuery(edbxOrgHowToReach.Text,True,True)+', '+
              'org_work_time='+NormalizeStringForQuery(cmbbxOrgWorkTime.Text,True,True)+', ';
              if Trim(sPlane)='' then // org_other_info, org_other_info_rtf
                begin
                  q:=q+'org_other_info=NULL, ';
                  q:=q+'org_other_info_rtf=NULL, ';
                end
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
                  q:=q+'org_other_info="'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // �������������� ������ RTF � ������ � ESC-��������������������
                  RTFStream:=TMemoryStream.Create;
                  try
                    reOrgOtherInfo.Lines.SaveToStream(RTFStream);
                    RTFStream.Seek(0,soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
                    q:=q+'org_other_info_rtf="'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'org_modified_at=NOW(), '+
              'org_modified_by_user_id='+CurrentUser.sID+' '+
              'WHERE org_id='+lvOrg.Selected.SubItems[2]+';';
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      LogThis(q,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('������ �������� �������.',lmtInfo);
          iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // ���������� ID ����������� ������
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',lmtInfo);
          if (i=1) then
            begin
              if bAddingOrgNow then
                begin
                  iOrgID:=iLastID; // ���������� ID ����������� ������
                  LogThis('���������� ������ � ����� ����������� ����������� �������',lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'INS'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end
              else
                begin
                  LogThis('�������������� ������ ����������� ����������� �������',lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'MOD'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end;
              Application.ProcessMessages;
              // ������ ���������� � ��
              LogThis('�������� ������ � ������� �������.',lmtInfo);
              LogThis(q,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('������ �������� �������.',lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',lmtInfo);
                  if (i=1) then
                    LogThis('������ � ������� ������� ������� �������',lmtInfo)
                  else
                    begin
                      s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='�������� ������ ��� ���������� �������!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
              bError:=True;
            end;
        end
      else
        begin
          s:='�������� ������ ��� ���������� �������!';
          bError:=True;
        end;
      if not bError then
        begin
          if iOrgID<0 then // ���� ��������� ������ ��� ��������� ������� ������, ������������� ������
            begin
              s:='������� ������������ ������������� ������ ������ � ������� �����������!';
              bError:=True;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;

      // ���������� ������ � ������� ����
      if not bError then
        begin
          if bAddingOrgNow then
            q:='UPDATE minsk.firma SET comment="'+IntToStr(iOrgID)+'", date=NOW() WHERE firm_code='+IntToStr(org_firm_code)+';'
          else
            begin
              q:='UPDATE minsk.firma SET name="';
              if Trim(edbxOrgName.Text)<>'' then
                q:=q+NormalizeStringForQuery(edbxOrgName.Text, False, False);
              q:=q+' |';
              if Trim(cmbbxOrgType.Text)<>'' then
                q:=q+NormalizeStringForQuery(cmbbxOrgType.Text, False, False);
              q:=q+'", '+
              'main="!R", '+
              'city_id='+IntToStr(city_id)+', '+
              'street_id='+IntToStr(street_id)+', '+
              'house_num='+IntToStr(house_num)+', '+
              'house_sym='+NormalizeStringForQuery(house_sym, True, False)+', '+
              'subhouse_num='+IntToStr(subhouse_num)+', '+
              'subhouse_sym='+NormalizeStringForQuery(subhouse_sym, True, False)+', '+
              'flat_num='+IntToStr(flat_num)+', '+
              'flat_sym='+NormalizeStringForQuery(flat_sym, True, False)+', '+
              'comment="'+IntToStr(iOrgID)+'", '+
              'ext_comment='+NormalizeStringForQuery(edbxOrgAddress.Text, True, True)+', '+
              'date=NOW() WHERE firm_code='+IntToStr(org_firm_code)+';';
            end;
        end;
      LogThis(q,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('������ �������� �������.',lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',lmtInfo);
          if (i=1) then
            LogThis('������������� ������ ������ ������� ��������������� �������',lmtInfo)
          else
            begin
              s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
              bError:=True;
            end;
        end
      else
        begin
          s:='�������� ������ ��� ���������� �������!';
          bError:=True;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;
      bAddingOrgNow:=False;

      btbtnSearchClick(nil); // ����� ������ ������������ ������� �� ������ ������������ ���������, ����� ����� �������� ��� ������ ������
      lvOrg.Items.BeginUpdate;
      for i:=0 to lvOrg.Items.Count-1 do
        if lvOrg.Items[i]<>nil then
          begin
            if lvOrg.Items[i].SubItems[2]=IntToStr(iOrgID) then
              begin
                lvOrg.ItemIndex:=i;
                lvOrg.ItemFocused:=lvOrg.Items.Item[i];
                tp:=lvOrg.ItemFocused.GetPosition;
                lvOrg.Scroll(tp.X,tp.Y-23);
                lvOrg.ItemFocused.MakeVisible(False);
                lvOrg.SetFocus;
              end;
          end;
      lvOrg.Items.EndUpdate;
    end;

  // ���������� ������ ��� ����������
  // ��������� ID ���������� �����������/�����������
  // ����������� ������� �� ���������� / �������������� �����������
  // ���������� ����������� � ���������� ID ������������ �����������
  // ���������� ������ � ������� ����
  // ���������� ������ �����������
  // ���������� �������� ���������� ����������� � ���������� �����������
  // ���� ����������� ����������� ���� � ������ - ���������� ������ �� ���� ���� ��� - ���������� ������ �� ������ ������ �����������


  if PageControl1.ActivePage=tsMsr then
    begin

      // ���������� ������ ��� ����������
      cmbbxMsrType.Text:=ValidateString(cmbbxMsrType.Text);
      edbxMsrName.Text:=ValidateString(edbxMsrName.Text);
      cmbbxMsrAuthor.Text:=ValidateString(cmbbxMsrAuthor.Text);
      cmbbxMsrProducer.Text:=ValidateString(cmbbxMsrProducer.Text);
      cmbbxMsrPerformer.Text:=ValidateString(cmbbxMsrPerformer.Text);
      cmbbxMsrOrganizer.Text:=ValidateString(cmbbxMsrOrganizer.Text);
      meMsrTicketPrice.Text:=ValidateString(meMsrTicketPrice.Text);
      sPlane:=ValidateString(reMsrOtherInfo.Text);
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // ��������� ID ���������� �����������/�����������
      if bAddingMsrNow then
        begin
          if lvOrg.Selected<>nil then // ���������� ID �����������
            begin
              iOrgID:=StrToIntDef(lvOrg.Selected.SubItems[2],-1); // ���������� �������� ID ���������� �����������
              if iOrgID>=0 then
                LogThis('������������ ���������� ������ ����������� ��� ����������� � ID='+IntToStr(iOrgID)+'.',lmtInfo)
              else
                begin
                  s:='�������� ������ ��� ��������� ID �����������-��������� ������������ �����������!';
                  bError:=True;
                end;
              ProgressBar1.Max:=5;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
        end
      else
        begin
          if lvOrg.Selected<>nil then // ���������� ID �����������
            begin
              iOrgID:=StrToIntDef(lvOrg.Selected.SubItems[2],-1); // ���������� �������� ID ���������� �����������
              if iOrgID>=0 then
                LogThis('������������ �������������� ����������� �������������� ����������� � ID='+IntToStr(iOrgID)+'.',lmtInfo)
              else
                begin
                  s:='�������� ������ ��� ��������� ID �����������-��������� �������������� �����������!';
                  bError:=True;
                end;
              ProgressBar1.Max:=5;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
          if lvMsr.Selected<>nil then // ���������� ID �������������� �����������
            begin
              iMsrID:=StrToIntDef(lvMsr.Selected.SubItems[2],-1); // ���������� �������� ID ����������� �����������
              if iMsrID>=0 then
                begin
                  LogThis('������������ �������� ��������� � ������ ����������� � ID='+IntToStr(iMsrID)+'.',lmtInfo);
                end
              else
                begin
                  s:='�������� ������ ��� ��������� ID �������������� �����������!';
                  bError:=True;
                end;
              ProgressBar1.Max:=2;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;

      // ����������� ������� �� ���������� / �������������� �����������
      if not bError then
        begin
          if bAddingMsrNow then
            begin
              q:='INSERT INTO _msr (msr_id, msr_erased, msr_start_datetime, msr_stop_datetime, _msr_duration, msr_organization_id, ';
              q:=q+'msr_is_premier, msr_is_tour, msr_for_children, msr_for_teenagers, msr_for_adults_only, ';
              q:=q+'msr_type, msr_name, msr_author, msr_producer, msr_performer, msr_organizer, msr_ticket_price, msr_other_info, msr_other_info_rtf, ';
              q:=q+'msr_created_at, msr_created_by_user_id, msr_modified_at, msr_modified_by_user_id) VALUES (';
              q:=q+'NULL, "0", '; // msr_id, msr_erased
              if chkbxMsrStart.Checked then // msr_start_datetime
                q:=q+'"'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStartDate.DateTime)+'", '
              else q:=q+'NULL, ';
              if chkbxMsrStop.Checked then // msr_stop_datetime
                q:=q+'"'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStopDate.DateTime)+'", '
              else q:=q+'NULL, ';
              q:=q+'NULL, '+IntToStr(iOrgID)+', '+ // _msr_duration, msr_organization_id
              '"'+IntToStr(integer(chkbxMsrIsPremier.Checked))+'", '+ // msr_is_premier
              '"'+IntToStr(integer(chkbxMsrIsTour.Checked))+'", '+ // msr_is_tour
              '"'+IntToStr(integer(chkbxMsrForChildren.Checked))+'", '+ // msr_for_children
              '"'+IntToStr(integer(chkbxMsrForTeenagers.Checked))+'", '+ // msr_for_teenagers
              '"'+IntToStr(integer(chkbxMsrForAdultsOnly.Checked))+'", '+ // msr_for_adults_only
              NormalizeStringForQuery(cmbbxMsrType.Text,True,True)+', '+ // msr_type
              NormalizeStringForQuery(edbxMsrName.Text,True,True)+', '+ // msr_name
              NormalizeStringForQuery(cmbbxMsrAuthor.Text,True,True)+', '+ // msr_author
              NormalizeStringForQuery(cmbbxMsrProducer.Text,True,True)+', '+ // msr_producer
              NormalizeStringForQuery(cmbbxMsrPerformer.Text,True,True)+', '+ // msr_performer
              NormalizeStringForQuery(cmbbxMsrOrganizer.Text,True,True)+', '+ // msr_organizer
              NormalizeStringForQuery(meMsrTicketPrice.Text,True,True)+', '; // msr_ticket_price
              if Trim(sPlane)='' then // msr_other_info, msr_other_info_rtf
                q:=q+'NULL, NULL, '
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
                  q:=q+'"'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // �������������� ������ RTF � ������ � ESC-��������������������
	                RTFStream:=TMemoryStream.Create;
	                try
		                reMsrOtherInfo.Lines.SaveToStream(RTFStream);
		                RTFStream.Seek(0,soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
                    q:=q+'"'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'NOW(), ' +CurrentUser.sID+', '+'NOW(), ' +CurrentUser.sID+');';
            end
          else
            begin
              q:='UPDATE _msr SET ';
              if chkbxMsrStart.Checked then
                q:=q+'msr_start_datetime="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStartDate.DateTime)+'", '
              else q:=q+'msr_start_datetime=NULL, ';
              if chkbxMsrStop.Checked then
                q:=q+'msr_stop_datetime="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStopDate.DateTime)+'", '
              else q:=q+'msr_stop_datetime=NULL, ';
              q:=q+'msr_is_premier="'+IntToStr(integer(chkbxMsrIsPremier.Checked))+'", '+
              'msr_is_tour="'+IntToStr(integer(chkbxMsrIsTour.Checked))+'", '+
              'msr_for_children="'+IntToStr(integer(chkbxMsrForChildren.Checked))+'", '+
              'msr_for_teenagers="'+IntToStr(integer(chkbxMsrForTeenagers.Checked))+'", '+
              'msr_for_adults_only="'+IntToStr(integer(chkbxMsrForAdultsOnly.Checked))+'", '+
              'msr_type='+NormalizeStringForQuery(cmbbxMsrType.Text,True,True)+', '+
              'msr_name='+NormalizeStringForQuery(edbxMsrName.Text,True,True)+', '+
              'msr_author='+NormalizeStringForQuery(cmbbxMsrAuthor.Text,True,True)+', '+
              'msr_producer='+NormalizeStringForQuery(cmbbxMsrProducer.Text,True,True)+', '+
              'msr_performer='+NormalizeStringForQuery(cmbbxMsrPerformer.Text,True,True)+', '+
              'msr_organizer='+NormalizeStringForQuery(cmbbxMsrOrganizer.Text,True,True)+', '+
              'msr_ticket_price='+NormalizeStringForQuery(meMsrTicketPrice.Text,True,True)+', ';
              if Trim(sPlane)='' then
                q:=q+'msr_other_info=NULL, msr_other_info_rtf=NULL, '
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
                  q:=q+'msr_other_info="'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // �������������� ������ RTF � ������ � ESC-��������������������
	                RTFStream:=TMemoryStream.Create;
	                try
		                reMsrOtherInfo.Lines.SaveToStream(RTFStream);
		                RTFStream.Seek(0,soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
                    q:=q+'msr_other_info_rtf="'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'msr_modified_at=NOW(), msr_modified_by_user_id='+CurrentUser.sID+' WHERE msr_id='+IntToStr(iMsrID)+';';
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      LogThis(q,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('������ �������� �������.',lmtInfo);
          iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // ���������� ID ����������� ������
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',lmtInfo);
          if (i=1) then
            begin
              if bAddingMsrNow then
                begin
                  iMsrID:=iLastID; // ���������� ID ����������� ������
                  LogThis('���������� ������ � ����� ����������� ����������� �������',lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'INS'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end
              else
                begin
                  LogThis('�������������� ������ ����������� ����������� �������',lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'MOD'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end;
              Application.ProcessMessages;
              // ������ ���������� � ��
              LogThis('�������� ������ � ������� �������.',lmtInfo);
              LogThis(q,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('������ �������� �������.',lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',lmtInfo);
                  if (i=1) then
                    LogThis('������ � ������� ������� ������� �������',lmtInfo)
                  else
                    begin
                      s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='�������� ������ ��� ���������� �������!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
              bError:=True;
            end;
        end
      else
        begin
          s:='�������� ������ ��� ���������� �������!';
          bError:=True;
        end;
      if not bError then
        begin
          if iMsrID<0 then // ���� ��������� ������ ��� ��������� ������� ������, ������������� ������
            begin
              s:='������� ������������ ������������� ������ ������ � ������� �����������!';
              bError:=True;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;
      bAddingMsrNow:=False;

      btbtnSearchClick(nil); // ����� ������ ������������ ������� �� ������ ������������ ���������, ����� ����� �������� ��� ������ ������

      lvOrg.Items.BeginUpdate;
      for i:=0 to lvOrg.Items.Count-1 do
        if lvOrg.Items[i]<>nil then
          begin
            if lvOrg.Items[i].SubItems[2]=IntToStr(iOrgID) then
              begin
                lvOrg.ItemIndex:=i;
                lvOrg.ItemFocused:=lvOrg.Items.Item[i];
                tp:=lvOrg.ItemFocused.GetPosition;
                lvOrg.Scroll(tp.X,tp.Y-23);
                lvOrg.ItemFocused.MakeVisible(False);
              end;
          end;
      lvOrg.Items.EndUpdate;
      lvMsr.Items.BeginUpdate;
      for i:=0 to lvMsr.Items.Count-1 do
        if lvMsr.Items[i]<>nil then
          begin
            if lvMsr.Items[i].SubItems[2]=IntToStr(iMsrID) then
              begin
                lvMsr.ItemIndex:=i;
                lvMsr.ItemFocused:=lvMsr.Items.Item[i];
                tp:=lvMsr.ItemFocused.GetPosition;
                lvMsr.Scroll(tp.X,tp.Y-23);
                lvMsr.ItemFocused.MakeVisible(False);
                lvMsr.SetFocus;
              end;
          end;
      lvMsr.Items.EndUpdate;
    end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  SetReady;
end;
*)

