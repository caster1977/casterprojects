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
  ToolWin,
  ActnCtrls,
  ImgList,
  CommCtrl,
  mysql,
  IniFiles,
  AppEvnts,
  Grids;

type
  THackControl= class(TControl);
    TMainForm= class(TForm)MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    StatusBar1: TStatusBar;
    ActionManager1: TActionManager;
    Action_Logon: TAction;
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
    F1: TMenuItem;
    Action_ConnectToKeeper: TAction;
    N10: TMenuItem;
    Action_CorrectOrder: TAction;
    Action11: TAction;
    Action_CancelOrder: TAction;
    Action14: TAction;
    Action13: TAction;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N18: TMenuItem;
    Image1: TImage;
    N14: TMenuItem;
    N16: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    StringGrid1: TStringGrid;
    procedure Action11Execute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Action_LogbookExecute(Sender: TObject);
    procedure Action_CancelOrderExecute(Sender: TObject);
    procedure Action_CorrectOrderExecute(Sender: TObject);
    procedure Action_LogoffExecute(Sender: TObject);
    procedure Action_ConnectToKeeperExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_LogonExecute(Sender: TObject);
  private
    { Private declarations }
    sRecordDir, sHost, sOrderHost: string;
    iActiveChannels, iSmartChannels, iCompID, iChannelID, iOrderServerPort, iOrderClientPort: integer;
    bKeeperDebug, bUseQueue: boolean;
    bUserLogged: boolean;
  public
    { Public declarations }
    MySQLConnectionHandler: PMYSQL;
    procedure DoConnect;
  end;

function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): string;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  About,
  Login,
  Logoff,
  InvalidePassword,
  KeeperNotLaunched,
  KeeperConnected,
  Order,
  OrderList,
  AddOrder,
  BannedAutosList;

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

procedure TMainForm.Action_LogonExecute(Sender: TObject);
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
                      StatusBar1.Panels[3].Text:=ResultRow[1]+' ('+string(ResultRow[2])+')';
                      Action_Logoff.Enabled:=True;
                      Action_CorrectOrder.Enabled:=True;
                      Action_CancelOrder.Enabled:=True;
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
        end
      else
        begin
          // s:='Возникла ошибка при выполнении запроса!';
        end;
      if not bUserLogged then
        begin
          // вывод окна в случае ошибки
          with TInvalidePasswordForm.Create(Self) do
            try
              ShowModal;
            finally
              Free;
            end
        end
      else
        begin
          Action_ConnectToKeeper.Execute;
        end;
    end;
end;

procedure TMainForm.Action_CorrectOrderExecute(Sender: TObject);
begin
  with TOrderForm.Create(Self) do
    try
      Caption:='Выберите заказ для редактирования';
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.Action_CancelOrderExecute(Sender: TObject);
begin
  with TOrderForm.Create(Self) do
    try
      Caption:='Выберите заказ для отмены';
      ShowModal;
    finally
      Free;
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

procedure TMainForm.Action_ConnectToKeeperExecute(Sender: TObject);
var
  bKeeperLaunched: boolean;
  mr: TModalResult;
begin
  bKeeperLaunched:=True;
  mr:=mrNone;
  //
  // hOA4LogClient:=FindWindow('TMainForm','OA4 Log Client'); // получение хэндла окна лог-клиента
  // если программа была найдена
  if bKeeperLaunched then
    begin
      with TKeeperConnectedForm.Create(Self) do
        try
          ShowModal;
        finally
          Free;
        end;
    end
  else
    begin
      // если программа не была найдена
      while not((bKeeperLaunched)or(mr=mrAbort)) do
        begin
          Application.ProcessMessages;
          with TKeeperNotLaunchedForm.Create(Self) do
            try
              ShowModal;
            finally
              mr:=ModalResult;
              // если была нажата кнопка повтора - проверить наличие загруженной программы
              Free;
            end;
        end;
    end;
end;

procedure TMainForm.Action_LogbookExecute(Sender: TObject);
begin
  with TOrderListForm.Create(Self) do
    try
      Width:=Screen.WorkAreaWidth;
      Height:=Screen.WorkAreaHeight;
      Top:=Screen.WorkAreaTop;
      Left:=Screen.WorkAreaLeft;
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.Action_LogoffExecute(Sender: TObject);
var
  mr: TModalResult;
  sLastLogin, sLastPassword: string;
begin
  with TLogoffForm.Create(Self) do
    try
      Label1.Caption:='Завершить работу диспетчера '+StatusBar1.Panels[3].Text+'?';
      ShowModal;
    finally
      mr:=ModalResult;
      Free;
    end;
  if mr=mrOk then
    begin
      sLastLogin:='';
      sLastPassword:='';
      StatusBar1.Panels[3].Text:='';
      Action_Logoff.Enabled:=False;
      Action_CorrectOrder.Enabled:=False;
      Action_CancelOrder.Enabled:=False;
      bUserLogged:=False;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  PanelRect: TRect;
  IniFile: TIniFile;
  q: string;
begin
  bUserLogged:=False;
  with TAboutForm.Create(Self) do
    try
      Image2.Visible:=False;
      Timer1.Enabled:=True;
      AlphaBlendValue:=0;
      Timer2.Enabled:=True;
      ShowModal;
    finally
      Free;
    end;
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, 2, Integer(@PanelRect));
  Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right-PanelRect.Left+1, PanelRect.Bottom-PanelRect.Top+1);
  with StringGrid1 do
    begin
      Cells[0, 0]:='Принят';
      Cells[1, 0]:='№ п/п';
      Cells[2, 0]:='Телефон';
      Cells[3, 0]:='Улица';
      Cells[4, 0]:='Дом/корпус';
      Cells[5, 0]:='Квартира (подъезд)';
      Cells[6, 0]:='Позывной';
      Cells[7, 0]:='Срок';
      Cells[8, 0]:='Прибытие';
    end;
  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'Taxi.ini');
  with IniFile do
    try
      iActiveChannels:=ReadInteger('Keeper', 'ActiveChannels', 1);
      iSmartChannels:=ReadInteger('Keeper', 'SmartChannels', -1);
      sRecordDir:=ReadString('Keeper', 'RecordDir', '');
      bKeeperDebug:=ReadBool('Keeper', 'KeeperDebug', False);
      sHost:=ReadString('mysql', 'host', 'localhost');
      iCompID:=ReadInteger('General', 'CompID', -1);
      iChannelID:=ReadInteger('General', 'ChannelID', -1);
      sOrderHost:=ReadString('General', 'OrderHost', 'localhost');
      iOrderServerPort:=ReadInteger('General', 'OrderServerPort', 2049);
      iOrderClientPort:=ReadInteger('General', 'OrderClientPort', 2050);
      bUseQueue:=ReadBool('General', 'UseQueue', False);
    finally
      Free;
    end;
  DoConnect;
  q:='SET names cp1251;';
  mysql_real_query(MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
  Action_Logoff.Enabled:=False;
  Action_CorrectOrder.Enabled:=False;
  Action_CancelOrder.Enabled:=False;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  StringGrid1.ColWidths[3]:=StringGrid1.Width-(StringGrid1.ColWidths[0]+StringGrid1.ColWidths[1]+StringGrid1.ColWidths[2]+StringGrid1.ColWidths[4]+StringGrid1.ColWidths[5]+StringGrid1.ColWidths[6]+StringGrid1.ColWidths[7]+StringGrid1.ColWidths[8]+
      (StringGrid1.BevelWidth*4+9));
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Timer2.Enabled:=True;
end;

procedure TMainForm.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if bUserLogged then
    if CharInSet(Key, ['0'..'9']) then
      begin
        with TAddOrderForm.Create(Self) do
          try
            Left:=Screen.WorkAreaLeft;
            Top:=Screen.WorkAreaTop+(Screen.WorkAreaHeight-Height);
            MaskEdit1.Text:=Key;
            ShowModal;
          finally
            Free;
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
  StatusBar1.Panels[0].Text:=s;
  StatusBar1.Panels[1].Text:=TimeToStr(EncodeTime(Hour, Min, Sec, MSec));
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled:=False;
  Action_Logon.Execute;
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

procedure TMainForm.Action11Execute(Sender: TObject);
begin
  // запреты работы
  with TBannedAutosForm.Create(Self) do
    try
      Width:=783;
      Height:=364;
      ShowModal;
    finally
      Free;
    end;
end;

end.

// запрос на логирование пользователя
// set names cp1251
// delete from Orders where ((Time + interval 30 minute) < now() and State = 2) or ((Time + interval 120 minute) < now() and State = 1) or ((Time + interval 1 day) < now())
// select ID_Order, date_format(Time, "%H:%i:%S"), StreetName, Build, Block, Flat, Entrance, CallerID, Phone, OrderN, Orders.ID_Street, Orders.ID_Car, Customer, State, RecordFile, Orders.ID_User, UserName, Orders.ID_Comp, Comps.Color, ChannelID, Term, date_format(date_add(Time, interval Term minute), "%H:%i:%S"), PhoneCode from Orders left join Cars on Orders.ID_Car=Cars.ID_Car left join Streets on Orders.ID_Street=Streets.ID_Street left join Users on Orders.ID_User=Users.ID_User left join Comps on Orders.ID_Comp=Comps.ID_Comp order by Time desc
// select ID_Comp, Color from Comps order by ID_Comp
// select ID_User from Users where ID_User > 0 and UserName like "ира" and Password=MD5("") and Active=1
// select UserName, Comment from Users where ID_User=9


// 080707 15:47:29	      1 Query       select id_street, streetname from streets where Active=1
// 080707 15:47:30	      1 Query       select CallerID, date_format(Time, "%d.%m.%y %H:%i:%S"), StreetName, Build, Block, Number, ChannelID from Orders left join Cars on Orders.ID_Car=Cars.ID_Car left join Streets on Orders.ID_Street=Streets.ID_Street where State=1 order by Time
