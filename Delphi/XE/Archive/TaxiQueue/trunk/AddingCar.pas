unit AddingCar;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  mysql,
  Main;

type
  TAddingCarForm= class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    RichEdit1: TRichEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    sRayon: string;
    iPos, iCallNumber: integer;
  end;

var
  AddingCarForm: TAddingCarForm;

implementation

uses
  Grids,
  ConfirmDelete;
{$R *.dfm}

procedure TAddingCarForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TAddingCarForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TAddingCarForm.Button3Click(Sender: TObject);
var
  q: string;
  i: integer;
  mr: TModalResult;
  ResultSet: PMYSQL_RES;
  // bError: boolean;
begin
  if (iCallNumber>-1)and(iPos>0) then
    begin
      with TConfirmDeleteForm.Create(Self) do
        try
          Label1.Caption:='Удалить позывной '+IntToStr(iCallNumber)+' из очереди '+IntToStr(iPos)+' района '+sRayon+'?';
          ShowModal;
        finally
          mr:=ModalResult;
          Free;
        end;
      if mr=mrOk then
        begin
          q:='select @ID_Car:=Queue.ID_Car, @ID_Region:=ID_Region, @State:=State from Queue left join Cars using (ID_Car) where CallerID='+IntToStr(iCallNumber)+' and ChannelID='+IntToStr(MainForm.iChannelID)+';';
          i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
          if i=0 then
            begin
              // s:='Запрос выполнен успешно.';
              ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
              if ResultSet<>nil then
                // пустышка
              else
                begin
                  // s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                  // bError:=True;
                end;
              if ResultSet<>nil then
                begin
                  // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
                  mysql_free_result(ResultSet);
                end;
            end
          else
            begin
              // s:='Возникла ошибка при выполнении запроса!';
              // bError:=True;
            end;
          q:='delete from Queue using Queue, Cars where Queue.ID_Car=Cars.ID_Car and CallerID='+IntToStr(iCallNumber)+' and ChannelID='+IntToStr(MainForm.iChannelID)+';';
          i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
          // в оригинальной программе изначально есть ошибка при помещении данных в лог !!!!!!
          q:='insert into QueueLog (ID_Region, ID_Car, State, ID_User, Operation, DelKind, Host) values (@ID_Region, @ID_Car, @State, 0, 1, 1, substring(user(), 7));';
          i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
        end;
    end;
  ModalResult:=mrOk;
end;

procedure TAddingCarForm.Edit1Change(Sender: TObject);
var
  s, q: string;
  i, j, k, l, iSelStart, iSelLenght: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError, bArrest: boolean;
  slA: TStringList;
begin
  // тут необходимо вставить обработку запроса на выборку данных из БД
  // и заполнение контрола RichEdit
  RichEdit1.Clear;
  Button1.Enabled:=False;
  Button2.Enabled:=False;
  Button3.Enabled:=False;
  iCallNumber:=StrToIntDef(Trim(Edit1.Text), -1);
  if iCallNumber>-1 then
    begin
      q:='select Model, Color, Number, Driver, Comment, ID_Car, BodyKind, CallerPhone, NumberTAXI from Cars where CallerID='+IntToStr(iCallNumber)+' and Active=1 and ChannelID='+IntToStr(MainForm.iChannelID)+';';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          // s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            // пустышка
          else
            begin
              // s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
          if ResultSet<>nil then
            begin
              // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
              mysql_free_result(ResultSet);
            end;
        end
      else
        begin
          // s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      q:='update CarsArest set TimeCreate=TimeCreate, TimeAbort=(TimeCreate + interval Duration hour), Active=0 where Active=1 and Duration > 0 and (TimeCreate + interval Duration hour) <= now()';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      q:='insert into CarsArest (ID_Car, ID_Date, ID_UserCreate, Duration, ID_ArestKind, TimeCreate) select LicenseDates.ID_Car, LicenseDates.ID_LicenseDate, '+
        '1, 0, 500, (LicenseDates.Date + interval 1 day) from LicenseDates where LicenseDates.Active=1 and LicenseDates.ID_CarArest is null and (LicenseDates.Date - interval 14 day) < now();';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      q:='update LicenseDates, CarsArest set LicenseDates.ID_CarArest=CarsArest.ID_CarArest, LicenseDates.TimeCreate = LicenseDates.TimeCreate, '+
        'CarsArest.TimeCreate = CarsArest.TimeCreate, CarsArest.TimeAbort = CarsArest.TimeAbort, CarsArest.ID_TwinCarArest = CarsArest.ID_CarArest '+
        'where ID_ArestKind=500 and LicenseDates.ID_CarArest is null and CarsArest.ID_Date=LicenseDates.ID_LicenseDate;';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      q:='insert into CarsArest (ID_Car, ID_Date, ID_UserCreate, Duration, ID_ArestKind, TimeCreate) select PaymentDates.ID_Car, '+
        'PaymentDates.ID_PaymentDate, 1, 0, 501, (PaymentDates.Date + interval 1 day) from PaymentDates where PaymentDates.Active=1 '+'and PaymentDates.ID_CarArest is null and (PaymentDates.Date - interval 2 day) < now();';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      q:='update PaymentDates, CarsArest set PaymentDates.ID_CarArest=CarsArest.ID_CarArest, '+'PaymentDates.TimeCreate = PaymentDates.TimeCreate, CarsArest.TimeCreate = CarsArest.TimeCreate, '+
        'CarsArest.TimeAbort = CarsArest.TimeAbort, CarsArest.ID_TwinCarArest = CarsArest.ID_CarArest '+'where ID_ArestKind=501 and PaymentDates.ID_CarArest is null and CarsArest.ID_Date=PaymentDates.ID_PaymentDate;';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      q:='delete from Orders using Orders left join CarsArest on Orders.ID_Car=CarsArest.ID_Car where '+'Orders.State=1 and CarsArest.Active=1 and CarsArest.TimeCreate <= now();';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));

      q:='select @ID_Region:=Queue.ID_Region, RegionName from Queue left join Regions on '+'Queue.ID_Region = Regions.ID_Region left join Cars on Queue.ID_Car = Cars.ID_Car '+'where CallerID='+IntToStr(iCallNumber)+' and ChannelID='+IntToStr
        (MainForm.iChannelID)+';';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          // s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              // s:='Результирующая выборка получена успешно.';
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  // s:='Количество строк выборки равно '+IntToStr(i)+'.';
                  for j:=0 to i-1 do
                    begin
                      // s:='Получение очередной строки выборки ('+IntToStr(j)+').';
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          // s:='Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.';
                          iSelStart:=Length(RichEdit1.Text);
                          iSelLenght:=Length('Район: ');
                          sRayon:=string(ResultRow[1]);
                          RichEdit1.Lines.Add('Район: '+#09+string(ResultRow[1]));
                          RichEdit1.SelStart:=iSelStart;
                          RichEdit1.SelLength:=iSelLenght;
                          RichEdit1.SelAttributes.Color:=clPurple;
                          iSelStart:=Length(RichEdit1.Text)-Length(string(ResultRow[1]))-2;
                          iSelLenght:=Length(ResultRow[1]);
                          RichEdit1.SelStart:=iSelStart;
                          RichEdit1.SelLength:=iSelLenght;
                          RichEdit1.SelAttributes.Style:=[fsBold];
                          RichEdit1.SelLength:=0;
                          // позиция
                          // определение позиции номера в списке
                          for k:=1 to MainForm.StringGrid1.RowCount-1 do
                            begin
                              if (MainForm.StringGrid1.Cells[0, k]=string(ResultRow[1])) then
                                begin
                                  slA:=TStringList.Create;
                                  try
                                    slA.Duplicates:=dupAccept;
                                    CutStringByLimiterToStringList(MainForm.StringGrid1.Cells[2, k], slA, #09);
                                    for l:=0 to slA.Count-1 do
                                      begin
                                        if ((IntToStr(iCallNumber)=slA[l])or(IntToStr(iCallNumber)+'м'=slA[l])or(IntToStr(iCallNumber)+'у'=slA[l])) then
                                          begin
                                            iSelStart:=Length(RichEdit1.Text);
                                            iSelLenght:=Length('Позиция:');
                                            RichEdit1.Lines.Add('Позиция:'+#09+IntToStr(l));
                                            iPos:=l;
                                            RichEdit1.SelStart:=iSelStart;
                                            RichEdit1.SelLength:=iSelLenght;
                                            RichEdit1.SelAttributes.Color:=clPurple;
                                            iSelStart:=Length(RichEdit1.Text)-Length(IntToStr(l))-2;
                                            iSelLenght:=Length(IntToStr(l));
                                            RichEdit1.SelStart:=iSelStart;
                                            RichEdit1.SelLength:=iSelLenght;
                                            RichEdit1.SelAttributes.Style:=[fsBold];
                                            RichEdit1.SelLength:=0;
                                            Button3.Enabled:=True;
                                          end;
                                      end;
                                  finally
                                    slA.Free;
                                  end;
                                end;
                            end;
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                    end
                end
              else
                begin
                  // s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                  bError:=True;
                end;
            end
          else
            begin
              // s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
          if ResultSet<>nil then
            begin
              // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
              mysql_free_result(ResultSet);
            end;
        end
      else
        begin
          // s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;

      if Length(RichEdit1.Text)>0 then
        RichEdit1.Lines.Add('');

      q:='SELECT Duration, DATE_FORMAT(CarsArest.TimeCreate + INTERVAL Duration HOUR, "%d.%m.%y %H:%i"), '+'ArestKindName FROM CarsArest LEFT JOIN ArestKinds ON CarsArest.ID_ArestKind = ArestKinds.ID_ArestKind '+
        'LEFT JOIN Cars ON CarsArest.ID_Car = Cars.ID_Car WHERE CarsArest.Active=1 AND '+'CallerID='+IntToStr(iCallNumber)+' AND ChannelID='+IntToStr(MainForm.iChannelID)+' AND CarsArest.TimeCreate <= NOW() ORDER BY CarsArest.TimeCreate;';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          // s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              // s:='Результирующая выборка получена успешно.';
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  // s:='Количество строк выборки равно '+IntToStr(i)+'.';
                  bArrest:=True;
                  for j:=0 to i-1 do
                    begin
                      // s:='Получение очередной строки выборки ('+IntToStr(j)+').';
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          // s:='Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.';
                          iSelStart:=Length(RichEdit1.Text);
                          RichEdit1.Lines.Add('Запрещён с '+string(ResultRow[1]));
                          iSelLenght:=Length('Запрещён с '+string(ResultRow[1]));
                          RichEdit1.SelStart:=iSelStart;
                          RichEdit1.SelLength:=iSelLenght;
                          RichEdit1.SelAttributes.Style:=[fsBold];
                          RichEdit1.SelAttributes.Color:=clBlue;
                          RichEdit1.SelLength:=0;

                          iSelStart:=Length(RichEdit1.Text);
                          RichEdit1.Lines.Add(string(ResultRow[2]));
                          iSelLenght:=Length(string(ResultRow[2]));
                          RichEdit1.SelStart:=iSelStart;
                          RichEdit1.SelLength:=iSelLenght;
                          RichEdit1.SelAttributes.Color:=clRed;
                          RichEdit1.SelLength:=0;
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                    end
                end
              else
                begin
                  // s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                  bArrest:=False;
                  bError:=True;
                end;
            end
          else
            begin
              // s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
          if ResultSet<>nil then
            begin
              // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
              mysql_free_result(ResultSet);
            end;
        end
      else
        begin
          // s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;

      if not bArrest then
        begin
          q:='select date_format(Date, "%d.%m.%y") from LicenseDates left join Cars '+'on LicenseDates.ID_Car = Cars.ID_Car left join CarsArest on LicenseDates.ID_CarArest = '+'CarsArest.ID_CarArest where LicenseDates.Active=1 and '+'ChannelID='+
            IntToStr(MainForm.iChannelID)+' and CallerID='+IntToStr(iCallNumber)+' and '+'CarsArest.TimeCreate > now();';
          i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
          if i=0 then
            begin
              // s:='Запрос выполнен успешно.';
              ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
              if ResultSet<>nil then
                begin
                  // s:='Результирующая выборка получена успешно.';
                  i:=mysql_num_rows(ResultSet);
                  if i>0 then
                    begin
                      // s:='Количество строк выборки равно '+IntToStr(i)+'.';
                      for j:=0 to i-1 do
                        begin
                          // s:='Получение очередной строки выборки ('+IntToStr(j)+').';
                          ResultRow:=mysql_fetch_row(ResultSet);
                          if ResultRow<>nil then
                            begin
                              // s:='Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.';
                              iSelStart:=Length(RichEdit1.Text);
                              RichEdit1.Lines.Add('Лицензия до '+ResultRow[0]);
                              iSelLenght:=Length('Лицензия до '+ResultRow[0]);
                              RichEdit1.SelStart:=iSelStart;
                              RichEdit1.SelLength:=iSelLenght;
                              RichEdit1.SelAttributes.Style:=[fsBold];
                              RichEdit1.SelAttributes.Color:=clGreen;
                              RichEdit1.SelLength:=0;
                              Button1.Enabled:=True;
                              Button2.Enabled:=True;
                              Button3.Enabled:=True;
                            end
                          else
                            begin
                              s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                              bError:=True;
                            end;
                        end
                    end
                  else
                    begin
                      // s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                      bArrest:=False;
                      bError:=True;
                    end;
                end
              else
                begin
                  // s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                  bError:=True;
                end;
              if ResultSet<>nil then
                begin
                  // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
                  mysql_free_result(ResultSet);
                end;
            end
          else
            begin
              // s:='Возникла ошибка при выполнении запроса!';
              bError:=True;
            end;
        end;

      q:='SELECT CallerPhone, Model, Color, Number, Driver, Comment, ID_Car, BodyKind, NumberTAXI FROM Cars WHERE CallerID='+IntToStr(iCallNumber)+' AND Active=1 AND ChannelID='+IntToStr(MainForm.iChannelID)+';';
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          // s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              // s:='Результирующая выборка получена успешно.';
              i:=mysql_num_rows(ResultSet);
              if i=1 then
                begin
                  // s:='Количество строк выборки равно '+IntToStr(i)+'.';
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      RichEdit1.Lines.Add('Тел.:'+#09+ResultRow[0]);
                      iSelStart:=Length(RichEdit1.Text+'Авт.:'+#09);
                      if ResultRow[2]>'' then
                        begin
                          RichEdit1.Lines.Add('Авт.:'+#09+string(ResultRow[1])+' ('+string(ResultRow[2])+')');
                          iSelLenght:=Length(string(ResultRow[1])+' ('+string(ResultRow[2])+')');
                        end
                      else
                        begin
                          RichEdit1.Lines.Add('Авт.:'+#09+string(ResultRow[1]));
                          iSelLenght:=Length(string(ResultRow[1]));
                        end;
                      RichEdit1.SelStart:=iSelStart;
                      RichEdit1.SelLength:=iSelLenght;
                      RichEdit1.SelAttributes.Style:=[fsBold];
                      RichEdit1.SelLength:=0;

                      if string(ResultRow[7])='1' then
                        begin
                          iSelStart:=Length(RichEdit1.Text+#09);
                          RichEdit1.Lines.Add(#09+'универсал');
                          iSelLenght:=Length(RichEdit1.Text)-iSelStart;
                        end;
                      if string(ResultRow[7])='2' then
                        begin
                          iSelStart:=Length(RichEdit1.Text+#09);
                          RichEdit1.Lines.Add(#09+'минивэн');
                          iSelLenght:=Length(RichEdit1.Text)-iSelStart;
                        end;
                      if iSelLenght>0 then
                        begin
                          RichEdit1.SelStart:=iSelStart;
                          RichEdit1.SelLength:=iSelLenght;
                          RichEdit1.SelAttributes.Style:=[fsBold];
                          RichEdit1.SelLength:=0;
                        end;

                      RichEdit1.Lines.Add('Номер:'+#09+string(ResultRow[3]));
                      RichEdit1.Lines.Add('Вод.:'+#09+string(ResultRow[4]));
                    end
                  else
                    begin
                      // s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                    end;
                end
              else
                begin
                  // s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                end;
            end
          else
            begin
              // s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
            end;
          if ResultSet<>nil then
            begin
              // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
              mysql_free_result(ResultSet);
            end;
        end
      else
        begin
          // s:='Возникла ошибка при выполнении запроса!';
        end;
    end;
end;

procedure TAddingCarForm.FormCreate(Sender: TObject);
begin
  iPos:=-1;
  iCallNumber:=-1;
  sRayon:='';
end;

procedure TAddingCarForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_SUBTRACT then
    Button3.Click;
  if Key=VK_ADD then
    Button2.Click;
  if Key=VK_RETURN then
    Button1.Click;
end;

procedure TAddingCarForm.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
  Edit1.SelStart:=Length(Edit1.Text);
end;

end.

// запросы на вывод данных в окне "Постановка/списание автомобиля"
// select Model, Color, Number, Driver, Comment, ID_Car, BodyKind, CallerPhone, NumberTAXI from Cars where CallerID=222 and Active=1 and ChannelID=1

// update CarsArest set TimeCreate=TimeCreate, TimeAbort=(TimeCreate + interval Duration hour), Active=0 where Active=1 and Duration > 0 and (TimeCreate + interval Duration hour) <= now()
// insert into CarsArest (ID_Car, ID_Date, ID_UserCreate, Duration, ID_ArestKind, TimeCreate) select LicenseDates.ID_Car, LicenseDates.ID_LicenseDate, 1, 0, 500, (LicenseDates.Date + interval 1 day) from LicenseDates where LicenseDates.Active=1 and LicenseDates.ID_CarArest is null and (LicenseDates.Date - interval 14 day) < now()
// update LicenseDates, CarsArest set LicenseDates.ID_CarArest=CarsArest.ID_CarArest, LicenseDates.TimeCreate = LicenseDates.TimeCreate, CarsArest.TimeCreate = CarsArest.TimeCreate, CarsArest.TimeAbort = CarsArest.TimeAbort, CarsArest.ID_TwinCarArest = CarsArest.ID_CarArest where ID_ArestKind=500 and LicenseDates.ID_CarArest is null and CarsArest.ID_Date=LicenseDates.ID_LicenseDate
// insert into CarsArest (ID_Car, ID_Date, ID_UserCreate, Duration, ID_ArestKind, TimeCreate) select PaymentDates.ID_Car, PaymentDates.ID_PaymentDate, 1, 0, 501, (PaymentDates.Date + interval 1 day) from PaymentDates where PaymentDates.Active=1 and PaymentDates.ID_CarArest is null and (PaymentDates.Date - interval 2 day) < now()
// update PaymentDates, CarsArest set PaymentDates.ID_CarArest=CarsArest.ID_CarArest, PaymentDates.TimeCreate = PaymentDates.TimeCreate, CarsArest.TimeCreate = CarsArest.TimeCreate, CarsArest.TimeAbort = CarsArest.TimeAbort, CarsArest.ID_TwinCarArest = CarsArest.ID_CarArest where ID_ArestKind=501 and PaymentDates.ID_CarArest is null and CarsArest.ID_Date=PaymentDates.ID_PaymentDate
// delete from Orders using Orders left join CarsArest on Orders.ID_Car=CarsArest.ID_Car where Orders.State=1 and CarsArest.Active=1 and CarsArest.TimeCreate <= now()
// select Duration, date_format(CarsArest.TimeCreate + interval Duration hour, "%d.%m.%y %H:%i"), ArestKindName from CarsArest left join ArestKinds on CarsArest.ID_ArestKind = ArestKinds.ID_ArestKind left join Cars on CarsArest.ID_Car = Cars.ID_Car where CarsArest.Active=1 and CallerID=222 and ChannelID=1 and CarsArest.TimeCreate <= now() order by CarsArest.TimeCreate
// select @ID_Region:=Queue.ID_Region, RegionName from Queue left join Regions on Queue.ID_Region = Regions.ID_Region left join Cars on Queue.ID_Car = Cars.ID_Car where CallerID=222 and ChannelID=1
// select date_format(Date, "%d.%m.%y") from LicenseDates left join Cars on LicenseDates.ID_Car = Cars.ID_Car left join CarsArest on LicenseDates.ID_CarArest = CarsArest.ID_CarArest where LicenseDates.Active=1 and ChannelID=1 and CallerID=222 and CarsArest.TimeCreate > now()
// select ViewDriver from Vars
