unit Main;

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
  ComCtrls,
  Menus,
  ActnList,
  XPStyleActnCtrls,
  ActnMan,
  ExtCtrls,
  IniFiles,
  mysql,
  ImgList,
  Grids;

type
  TMainForm= class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    StatusBar2: TStatusBar;
    StatusBar1: TStatusBar;
    ActionManager1: TActionManager;
    Action_Login: TAction;
    Action_Logoff: TAction;
    Action_About: TAction;
    Action_Quit: TAction;
    Action_Logbook: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Timer1: TTimer;
    Timer2: TTimer;
    Panel1: TPanel;
    ImageList1: TImageList;
    StringGrid1: TStringGrid;
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Action_LogoffExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure StatusBar2DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_LoginExecute(Sender: TObject);
  public
    sHost: string;
    iChannelID: integer;
    bViewOnly: boolean;
    iViewChannelID: integer;
    bUserLogged: boolean;
    MySQLConnectionHandler: PMYSQL;
    procedure DoConnect;
    procedure RefreshList;
  end;

function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): string;
procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  About,
  Login,
  Logoff,
  InvalidePassword,
  AddingCar,
  ConfirmDelete;

function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): string;
var
  z: PAnsiChar;
begin
  NormalizeStringForQuery:='';
  if ((ReturnNull)and(Trim(Source)='')) then
    NormalizeStringForQuery:='NULL'
  else
    begin
      z:=GetMemory(Length(PAnsiChar(AnsiString(Source)))*2+1);
      try
        mysql_escape_string(z, PAnsiChar(AnsiString(Source)), Length(PAnsiChar(AnsiString(Source))));
        if AddCommas then
          NormalizeStringForQuery:='"'+string(StrPas(z))+'"'
        else
          NormalizeStringForQuery:=string(StrPas(z));
      finally
        if z<>nil then
          FreeMemory(z);
      end;
    end;
end;

procedure TMainForm.Action_LoginExecute(Sender: TObject);
var
  mr: TModalResult;
  sLastLogin, sLastPassword: string;
  q: string;
  i: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  if bUserLogged then
    Action_Logoff.Execute;
  if (bUserLogged) then
    Exit;
  with TLoginForm.Create(Self) do
    try
      ShowModal;
    finally
      mr:=ModalResult;
      sLastLogin:=Trim(edbxLogin.Text);
      sLastPassword:=Trim(edbxPassword.Text);
      Free;
    end;
  if mr=mrOk then
    begin
      q:='SELECT ID_User, UserName, Comment FROM Users WHERE ID_User>0 AND UserName LIKE "'+NormalizeStringForQuery(sLastLogin, False, False)+'" AND Password=MD5("'+NormalizeStringForQuery(sLastPassword, False, False)+'") AND Active=1;';
      i:=mysql_real_query(MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          // s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MySQLConnectionHandler);
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
                      StatusBar2.Panels[3].Text:=string(ResultRow[1])+' ('+string(ResultRow[2])+')';
                      Action_Logoff.Enabled:=True;
                      bUserLogged:=True;
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
      if not bUserLogged then
        // вывод окна в случае ошибки
        with TInvalidePasswordForm.Create(Self) do
          try
            ShowModal;
          finally
            Free;
          end;
    end;
end;

procedure TMainForm.Action_LogoffExecute(Sender: TObject);
var
  mr: TModalResult;
  sLastLogin, sLastPassword: string;
begin
  with TLogoffForm.Create(Self) do
    try
      Label1.Caption:='Завершить работу диспетчера '+StatusBar2.Panels[3].Text+'?';
      ShowModal;
    finally
      mr:=ModalResult;
      Free;
    end;
  if mr=mrOk then
    begin
      sLastLogin:='';
      sLastPassword:='';
      StatusBar2.Panels[3].Text:='';
      Action_Logoff.Enabled:=False;
      bUserLogged:=False;
    end;
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
begin
  with TAboutForm.Create(Self) do
    try
      Image2.Visible:=True;
      Timer1.Enabled:=False;
      AlphaBlend:=False;
      Timer2.Enabled:=False;
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if bUserLogged then
    Action_Logoff.Execute;
  if bUserLogged then
    CanClose:=False
  else
    begin
      if MySQLConnectionHandler<>nil then
        begin
          mysql_close(MySQLConnectionHandler);
          MySQLConnectionHandler:=nil;
        end;
      CanClose:=True;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
  q: string;
begin
  bUserLogged:=False;
  with TAboutForm.Create(Self) do
    try
      Image2.Visible:=False;
      Timer1.Enabled:=True;
      AlphaBlend:=False;
      Timer2.Enabled:=True;
      ShowModal;
    finally
      Free;
    end;
  with StringGrid1 do
    begin
      Cells[0, 0]:='Район';
      Cells[1, 0]:='Кол-во';
      Cells[2, 0]:='Очередь';
    end;
  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'TaxiQueue.ini');
  with IniFile do
    try
      sHost:=ReadString('mysql', 'host', 'localhost');
      iChannelID:=ReadInteger('General', 'ChannelID', -1);
      bViewOnly:=ReadBool('General', 'ViewOnly', False);
      iViewChannelID:=ReadInteger('General', 'ViewChannelID', -1);
      StatusBar2.Panels[2].Text:='Канал '+IntToStr(iChannelID);
      if iViewChannelID>-1 then
        begin
          StringGrid1.ColWidths[3]:=264;
          StringGrid1.ColWidths[2]:=StringGrid1.Width-(StringGrid1.ColWidths[0]+StringGrid1.ColWidths[1]+StringGrid1.ColWidths[3]+(StringGrid1.BevelWidth*4+4));
          StringGrid1.Cells[3, 0]:='Очередь канала '+IntToStr(iViewChannelID);
        end
      else
        StringGrid1.ColWidths[2]:=StringGrid1.Width-(StringGrid1.ColWidths[0]+StringGrid1.ColWidths[1]+(StringGrid1.BevelWidth*4+3));
    finally
      Free;
    end;
  DoConnect;
  //
  q:='SET names cp1251;';
  mysql_real_query(MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
  RefreshList;
  Action_Logoff.Enabled:=False;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if iViewChannelID>-1 then
    begin
      StringGrid1.ColWidths[2]:=StringGrid1.Width-(StringGrid1.ColWidths[0]+StringGrid1.ColWidths[1]+StringGrid1.ColWidths[3]+(StringGrid1.BevelWidth*4+4));
    end
  else
    StringGrid1.ColWidths[2]:=StringGrid1.Width-(StringGrid1.ColWidths[0]+StringGrid1.ColWidths[1]+(StringGrid1.BevelWidth*4+3));
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Timer2.Enabled:=True;
end;

procedure TMainForm.StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
  if (StringGrid1.Cells[5, StringGrid1.Selection.Top]='20')or(StringGrid1.Cells[6, StringGrid1.Selection.Top]='20') then
    begin
      StatusBar1.Canvas.Font.Style:=StatusBar2.Canvas.Font.Style+[fsBold];
      StatusBar1.Canvas.FillRect(Rect);
      StatusBar1.Canvas.TextOut(Rect.Left+2, Rect.Top, StatusBar.Panels[0].Text);
    end
  else
    begin
      StatusBar1.Canvas.Font.Style:=StatusBar2.Canvas.Font.Style-[fsBold];
      StatusBar1.Canvas.FillRect(Rect);
      StatusBar1.Canvas.TextOut(Rect.Left+2, Rect.Top, StatusBar.Panels[0].Text);
    end;
end;

procedure TMainForm.StatusBar2DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel.index=2 then
    begin
      StatusBar2.Canvas.Font.Style:=StatusBar2.Canvas.Font.Style+[fsBold];
      StatusBar2.Canvas.FillRect(Rect);
      StatusBar2.Canvas.TextOut(Rect.Left+2, Rect.Top, StatusBar.Panels[2].Text);
    end
  else
    begin
      StatusBar2.Canvas.Font.Style:=StatusBar2.Canvas.Font.Style-[fsBold];
      StatusBar2.Canvas.FillRect(Rect);
      StatusBar2.Canvas.TextOut(Rect.Left+2, Rect.Top, StatusBar.Panels[2].Text);
    end;
end;

procedure TMainForm.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  lRow, lCol: Longint;
  slA: TStringList;
  i: integer;
begin
  lRow:=ARow;
  lCol:=ACol;
  with Sender as TStringGrid, Canvas do
    begin
      if (gdSelected in State) then
        Brush.Color:=clHighlight
      else
        if (gdFixed in State) then
          Brush.Color:=FixedColor
        else
          Brush.Color:=Color;
      FillRect(Rect);
      SetBkMode(Handle, TRANSPARENT);
      if ((ACol=3)and(StringGrid1.Cells[5, ARow]='20'))or((ACol=2)and(StringGrid1.Cells[6, ARow]='20')) then
        Font.Style:=[fsBold]
      else
        Font.Style:=[];
      if (ACol=1)and(ARow>0) then
        begin
          SetTextAlign(Handle, TA_RIGHT);
          TextOut(Rect.Right-2, Rect.Top+2, Cells[lCol, lRow]);
        end
      else
        begin
          if (ACol in [2, 3])and(ARow>0) then
            begin
              // деление строки на части по симфолу табуляции #09 и последовательная их отрисовка на расстоянии
              slA:=TStringList.Create;
              try
                slA.Duplicates:=dupIgnore;
                CutStringByLimiterToStringList(Cells[lCol, lRow], slA, #09);
                SetTextAlign(Handle, TA_RIGHT);
                for i:=0 to slA.Count-1 do
                  TextOut(Rect.Left+36*i, Rect.Top+2, slA[i]);
              finally
                slA.Free;
              end;
            end
          else
            begin
              SetTextAlign(Handle, TA_LEFT);
              TextOut(Rect.Left+2, Rect.Top+2, Cells[lCol, lRow]);
            end;
        end;
    end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  Hour, Min, Sec, MSec: word;
  Year, Month, Day, WeekDay: word;
  dtNow: TDateTime;
  s: string;
begin
  dtNow:=Now;
  DecodeDate(dtNow, Year, Month, Day);
  DecodeTime(dtNow, Hour, Min, Sec, MSec);
  WeekDay:=DayOfWeek(dtNow);
  if Day<10 then
    s:='0'+IntToStr(Day)+'-'
  else
    s:=IntToStr(Day)+'-';
  case Month of
    1:
      s:=s+'янв';
    2:
      s:=s+'фев';
    3:
      s:=s+'мар';
    4:
      s:=s+'апр';
    5:
      s:=s+'мая';
    6:
      s:=s+'июн';
    7:
      s:=s+'июл';
    8:
      s:=s+'авг';
    9:
      s:=s+'сен';
    10:
      s:=s+'окт';
    11:
      s:=s+'ноя';
    12:
      s:=s+'дек';
  end;
  s:=s+'-'+Copy(IntToStr(Year), 3, 2)+', ';
  case WeekDay of
    1:
      s:=s+'воскресенье';
    2:
      s:=s+'понедельник';
    3:
      s:=s+'вторник';
    4:
      s:=s+'среда';
    5:
      s:=s+'четверг';
    6:
      s:=s+'пятница';
    7:
      s:=s+'суббота';
  end;
  StatusBar2.Panels[0].Text:=s;
  StatusBar2.Panels[1].Text:=TimeToStr(EncodeTime(Hour, Min, Sec, MSec));
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled:=False;
  Action_Login.Execute;
end;

procedure TMainForm.DoConnect;
var
  s: string;
  i: integer;
  pm: PMYSQL;
begin
  Screen.Cursor:=crHourGlass;
  MySQLConnectionHandler:=mysql_init(nil);
  Screen.Cursor:=crDefault;
  if MySQLConnectionHandler<>nil then
    begin
      s:='Инициализация объекта соединения MySQL прошла успешно.';
      Screen.Cursor:=crHourGlass;
      pm:=mysql_real_connect(MySQLConnectionHandler, PAnsiChar(AnsiString(sHost)), PAnsiChar(AnsiString('TLabel')), PAnsiChar(AnsiString('TButton')), PAnsiChar(AnsiString('nabat')), MYSQL_PORT, nil, 1);
      Screen.Cursor:=crDefault;
      if pm=MySQLConnectionHandler then
        begin
          s:='Подключение к серверу MySQL выполнено успешно.';
        end
      else
        begin
          i:=mysql_errno(MySQLConnectionHandler);
          // s:=mysql_error(MySQLConnectionHandler);
          if i=2003 then
            s:='Возникла ошибка при попытке подключения к серверу MySQL, так как сервер MySQL не запущен!'
          else
            s:='Возникла ошибка при попытке подключения к серверу MySQL!';
        end;
    end
  else
    s:='Возникла ошибка при инициализации объекта соединения MySQL!';
end;

procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  s:=Source;
  if Destination=nil then
    Destination:=TStringList.Create
  else
    Destination.Clear;
  Destination.Sorted:=False;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter, s);
      if i=0 then
        begin
          Destination.Add(s);
          Exit;
        end
      else
        begin
          s1:=Copy(s, 0, i-1);
          Destination.Add(s1);
          s1:=Copy(s, i+1, Length(s));
          s:=s1;
        end;
    end;
end;

procedure TMainForm.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if not bViewOnly then
    if CharInSet(Key, ['0'..'9']) then
      begin
        with TAddingCarForm.Create(Self) do
          try
            Left:=MainForm.Left+MainForm.Width-Width;
            Top:=MainForm.Top+((MainForm.Height-Height)div 2);
            Edit1.Text:=Key;
            ShowModal;
          finally
            if ModalResult=mrOk then
              RefreshList;
            Free;
          end;
      end;
end;

procedure TMainForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  StatusBar1.Panels[0].Text:=StringReplace(StringGrid1.Cells[2, ARow], #09, '    ', [rfReplaceAll]);
end;

procedure TMainForm.RefreshList;
var
  s, s1, q: string;
  i, j, k: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  bError:=False;
  if not bError then
    begin
      q:='SELECT Regions.ID_Region, RegionName, IF(ISNULL(q.Cnt), 0, q.Cnt) FROM Regions '+'LEFT JOIN (SELECT ID_Region, COUNT(Queue.ID_Car) AS Cnt FROM Queue LEFT JOIN Cars '+'USING (ID_Car) WHERE Cars.ChannelID='+IntTostr(iChannelID)
        +' GROUP BY ID_Region) AS q on q.ID_Region=Regions.ID_Region '+'WHERE Active=1 ORDER BY RegionName;';
      i:=mysql_real_query(MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              s:='Результирующая выборка получена успешно.';
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  s:='Количество строк выборки равно '+IntToStr(i)+'.';
                  StringGrid1.RowCount:=2;
                  StringGrid1.RowCount:=StringGrid1.RowCount+i-1;
                  for j:=0 to i-1 do
                    begin
                      s:='Получение очередной строки выборки ('+IntToStr(j)+').';
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          s:='Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.';
                          StringGrid1.Cells[0, j+1]:=string(ResultRow[1]);
                          StringGrid1.Cells[1, j+1]:=string(ResultRow[2]);
                          StringGrid1.Cells[2, j+1]:='';
                          StringGrid1.Cells[3, j+1]:='';
                          StringGrid1.Cells[4, j+1]:=string(ResultRow[0]);
                          StringGrid1.Cells[5, j+1]:='';
                          StringGrid1.Cells[6, j+1]:='';
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                    end;
                end
              else
                begin
                  s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
    end;

  if not bError then
    begin
      q:='SELECT q.ID_Region, q.CallerID, q.State, BodyKind FROM (SELECT CallerID, State, '+'ID_Region, Time FROM Queue LEFT JOIN Cars USING (ID_Car) WHERE Cars.ChannelID='+IntToStr(iChannelID)
        +') AS q, '+'Cars WHERE Cars.CallerID=q.CallerID AND Cars.ChannelID='+IntToStr(iChannelID)+' AND '+'Cars.Active=1 ORDER BY q.State, q.Time;';
      i:=mysql_real_query(MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              s:='Результирующая выборка получена успешно.';
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  s:='Количество строк выборки равно '+IntToStr(i)+'.';
                  for j:=0 to i-1 do
                    begin
                      s:='Получение очередной строки выборки ('+IntToStr(j)+').';
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          s:='Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.';
                          for k:=1 to StringGrid1.RowCount-1 do
                            begin
                              if StringGrid1.Cells[4, k]=string(ResultRow[0]) then
                                begin
                                  s1:=string(ResultRow[1]);
                                  if string(ResultRow[3])='1' then
                                    s1:=s1+'у';
                                  if string(ResultRow[3])='2' then
                                    s1:=s1+'м';
                                  StringGrid1.Cells[2, k]:=StringGrid1.Cells[2, k]+#09+s1;
                                  StringGrid1.Cells[6, k]:=string(ResultRow[2]);
                                end;
                            end;
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                    end;
                end
              else
                begin
                  s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
    end;

  if not bError then
    begin
      q:='SELECT q.ID_Region, q.CallerID, q.State, BodyKind FROM (SELECT CallerID, State, '+'ID_Region, Time FROM Queue LEFT JOIN Cars USING (ID_Car) WHERE Cars.ChannelID='+IntToStr(iViewChannelID)
        +') AS q, '+'Cars WHERE Cars.CallerID=q.CallerID AND Cars.ChannelID='+IntToStr(iViewChannelID)+' AND '+'Cars.Active=1 ORDER BY q.State, q.Time;';
      i:=mysql_real_query(MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          s:='Запрос выполнен успешно.';
          ResultSet:=mysql_store_result(MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              s:='Результирующая выборка получена успешно.';
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  s:='Количество строк выборки равно '+IntToStr(i)+'.';
                  for j:=0 to i-1 do
                    begin
                      s:='Получение очередной строки выборки ('+IntToStr(j)+').';
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          s:='Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.';
                          for k:=1 to StringGrid1.RowCount-1 do
                            begin
                              if StringGrid1.Cells[4, k]=string(ResultRow[0]) then
                                begin
                                  s1:=string(ResultRow[1]);
                                  if string(ResultRow[3])='1' then
                                    s1:=s1+'у';
                                  if string(ResultRow[3])='2' then
                                    s1:=s1+'м';
                                  StringGrid1.Cells[3, k]:=StringGrid1.Cells[3, k]+#09+s1;
                                  StringGrid1.Cells[5, k]:=string(ResultRow[2]);
                                end;
                            end;
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                    end;
                end
              else
                begin
                  s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
    end;
  if bError then
    StatusBar1.Panels[0].Text:=''
  else
    StatusBar1.Panels[0].Text:=StringReplace(StringGrid1.Cells[2, StringGrid1.Row], #09, '    ', [rfReplaceAll]);
end;

end.

// запрос на изменение кодовой таблицы
// SET names cp1251;
// запрос на получение ланных для первых трёх столбцов списка
// SELECT Regions.ID_Region, RegionName, IF(ISNULL(q.Cnt), 0, q.Cnt) FROM Regions LEFT JOIN (SELECT ID_Region, COUNT(Queue.ID_Car) AS Cnt FROM Queue LEFT JOIN Cars USING (ID_Car) WHERE Cars.ChannelID=1 GROUP BY ID_Region) AS q on q.ID_Region=Regions.ID_Region WHERE Active=1 ORDER BY RegionName;
// запрос на получение ланных для четвёртого столбца списка
// SELECT q.ID_Region, q.CallerID, q.State, BodyKind FROM (SELECT CallerID, State, ID_Region, Time FROM Queue LEFT JOIN Cars USING (ID_Car) WHERE Cars.ChannelID=2) AS q, Cars WHERE Cars.CallerID=q.CallerID AND Cars.ChannelID=2 AND Cars.Active=1 ORDER BY q.State, q.Time;
// SELECT ID_User, UserName, Comment FROM Users WHERE ID_User > 0 AND UserName LIKE "ира" AND Password=MD5("") AND Active=1;
