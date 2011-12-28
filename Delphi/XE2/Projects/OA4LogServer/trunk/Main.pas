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
  getFVI,
  ComCtrls,
  ExtCtrls,
  ImgList,
  mysql,
  CommCtrl,
  ActnList,
  XPStyleActnCtrls,
  ActnMan,
  AppEvnts,
  Menus,
  ToolWin,
  ActnCtrls;

const
  STATUSBAR_ITEMS_COUNT_PANEL_NUMBER: integer=0;
  STATUSBAR_STATE_PANEL_NUMBER: integer=1;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=2;
  STATUSBAR_HINT_PANEL_NUMBER: integer=3;

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL); // типы сообщений передаваемых в лог
  tTTI=(TTI_NONE, TTI_INFO, TTI_WARNING, TTI_ERROR);
  THackControl=class(TControl);

  TConfigurationRec=record
    sLocalHost: string;
    bMySQLConnected: boolean;
    sMySQLHost: AnsiString;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: AnsiString;
    sMySQLUser: AnsiString;
    sMySQLPassword: AnsiString;
    sCustomHelpFile: string;
    bNoToolBar: boolean;
    bNoStatusBar: boolean;
    bFullScreen: boolean;
    bUseLog: boolean;
  end;

  TMainForm=class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    gsFileVersionInfo1: TgsFileVersionInfo;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_About: TAction;
    Action_Quit: TAction;
    Action_Restore: TAction;
    ImageList1: TImageList;
    ImageList2: TImageList;
    PopupMenu1: TPopupMenu;
    ActionRestore1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    O1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    MainMenu1: TMainMenu;
    N5: TMenuItem;
    N7: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    O2: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ListView1: TListView;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private
    SessionLogEventCount: cardinal;
    Configuration: TConfigurationRec;
    MySQLConnectionHandler: PMYSQL;
    procedure Save_ConfigIni;
    procedure Load_ConfigIni;
    procedure SetReady(aLogGroupGUID: string);
    procedure SetBusy(aLogGroupGUID: string);
    procedure LogThis(a, sGroupGIUD: string; MessageType: TLogMessagesType);
    procedure Restore_MainForm;
  public
    bAboutWindowExist: boolean;
    bStartingNormalShutdown: boolean;
    procedure Do_Connect;
    procedure Do_Disconnect;
  end;

function GetLocalIP: string;
procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): string;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  About,
  IniFiles,
  WinSock;

procedure TMainForm.Restore_MainForm;
var
  fwi: FLASHWINFO;
begin
  if bAboutWindowExist then
    begin
      with fwi do
        begin
          cbSize:=sizeof(FLASHWINFO);
          hwnd:=Application.Handle;
          dwFlags:=FLASHW_TRAY or FLASHW_TIMERNOFG;
          uCount:=0;
          dwTimeout:=0;
        end;
      FlashWindowEx(fwi);
    end
  else
    begin
      TrayIcon1.Visible:=False;
      MainForm.Visible:=True;
      SetForegroundWindow(MainForm.Handle);
      Application.Restore;
    end;
end;

procedure TMainForm.Do_Connect;
var
  sMessage: string;
  i: integer;
  pm: PMYSQL;
  bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{84F4C7D6-E67F-4085-956C-92DA5913EE97}';
  LogThis('[Процедура подключения программы к MySQL-серверу]', LogGroupGUID, lmtInfo);
  LogThis('Начало процедуры...', LogGroupGUID, lmtInfo);
  SetBusy(LogGroupGUID);
  Application.ProcessMessages;

  bError:=False;
  MySQLConnectionHandler:=mysql_init(nil);
  if MySQLConnectionHandler<>nil then
    begin
      LogThis('Инициализация объекта соединения MySQL прошла успешно.', LogGroupGUID, lmtInfo);
      pm:=mysql_real_connect(MySQLConnectionHandler, PAnsiChar(Configuration.sMySQLHost), PAnsiChar(Configuration.sMySQLUser), PAnsiChar(Configuration.sMySQLPassword), PAnsiChar(Configuration.sMySQLDatabase), Configuration.iMySQLPort, nil, 1);
      if pm=MySQLConnectionHandler then
        begin
          LogThis('Подключение к серверу MySQL выполнено успешно.', LogGroupGUID, lmtInfo);
          Configuration.bMySQLConnected:=True;
        end
      else
        begin
          bError:=True;
          i:=mysql_errno(MySQLConnectionHandler);
          if i=2003 then
            sMessage:='Возникла ошибка при попытке подключения к серверу MySQL, так как сервер MySQL не запущен!'
          else
            sMessage:='Возникла ошибка при попытке подключения к серверу MySQL!';
        end;
    end
  else
    begin
      bError:=True;
      sMessage:='Возникла ошибка при инициализации объекта соединения MySQL!';
    end;

  Application.ProcessMessages;
  if bError then
    begin
      LogThis(sMessage, LogGroupGUID, lmtError);
      // Application.ProcessMessages;
      // MessageBox(Handle,PChar(sMessage),PChar('OA4LogClient - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else
    LogThis('Процедура выполнена без ошибок.', LogGroupGUID, lmtInfo);

  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.', LogGroupGUID, lmtInfo);
end;

function GetLocalIP: string;
const
  WSVer=$101;
var
  wsaData: TWSAData;
  P: PHostEnt;
  Buf: array [0..127] of Char;
begin
  Result:='';
  if WSAStartup(WSVer, wsaData)=0 then
    begin
      if GetHostName(@Buf, 128)=0 then
        begin
          P:=GetHostByName(@Buf);
          if P<>nil then
            Result:=string(iNet_ntoa(PInAddr(p^.h_addr_list^)^));
        end;
      WSACleanup;
    end;
end;

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

procedure TMainForm.Action_AboutExecute(Sender: TObject);
begin
  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "OA4 Log Server"...'))
  else
    begin
      bAboutWindowExist:=True;
      with TAboutForm.Create(Self) do
        try
          Button1.Visible:=True;
          Timer1.Enabled:=False;
          AlphaBlendValue:=222;
          Timer2.Enabled:=False;
          Label2.Caption:=Format('Версия %d.%d Release %d Build %d', [gsFileVersionInfo1.ModuleVersion.Major, gsFileVersionInfo1.ModuleVersion.Minor, gsFileVersionInfo1.ModuleVersion.Release, gsFileVersionInfo1.ModuleVersion.Build]);
          Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
          ShowModal;
        finally
          Free;
          bAboutWindowExist:=False;
        end;
    end;
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
begin
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    MessageBox(MainForm.Handle, PChar('Извините, справочный файл к данной программе не найден.'), PChar(MainForm.Caption+' - '+'Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
begin
  Restore_MainForm;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
begin
  MainForm.Visible:=False;
  TrayIcon1.Visible:=True;
end;

procedure TMainForm.Do_Disconnect;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{DC769909-7C42-4E22-90C8-E12E66BEE417}';
  LogThis('[Процедура отключения программы от MySQL-сервера]', LogGroupGUID, lmtInfo);
  LogThis('Начало процедуры...', LogGroupGUID, lmtInfo);
  SetBusy(LogGroupGUID);
  Application.ProcessMessages;

  if MySQLConnectionHandler<>nil then
    begin
      LogThis('"Экземпляр подключения к MySQL-серверу не пуст. Производится отключение.', LogGroupGUID, lmtInfo);
      mysql_close(MySQLConnectionHandler);
      MySQLConnectionHandler:=nil;
    end
  else
    LogThis('"Экземпляр подключения к MySQL-серверу пуст. Отключение не требуется.', LogGroupGUID, lmtInfo);
  Configuration.bMySQLConnected:=False;

  LogThis('Процедура выполнена без ошибок.', LogGroupGUID, lmtInfo);

  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.', LogGroupGUID, lmtInfo);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{98820E3D-0168-459B-8902-19391BEFBDDE}';
  LogThis('[Процедура завершения работы приложения]', LogGroupGUID, lmtInfo);
  LogThis('Начало процедуры...', LogGroupGUID, lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  CanClose:=False;
  Screen.Cursor:=crDefault;
  CanClose:=MessageBox(Handle, PChar('Вы действительно хотите завершить работу программы?'), PChar('OA4 - Подтверждение выхода'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  Screen.Cursor:=crHourGlass;
  if CanClose then
    begin
      LogThis('Завершение работы приложения было подтверждено.', LogGroupGUID, lmtInfo);
      // if ListBox1.Items.Count>0 then // записываем результаты работы в файл
      // ListBox1.Items.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4LogClient_UnsendedMessages.dat'); // если остались непереданные сообщения - записать их в файл
      Do_Disconnect;
      Save_ConfigIni;
      LogThis('Производится завершение работы приложения...', LogGroupGUID, lmtInfo);
    end
  else
    LogThis('Завершение работы приложения было отменено пользователем.', LogGroupGUID, lmtInfo);

  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.', LogGroupGUID, lmtInfo);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: string;
  PanelRect: TRect;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{86F46A43-AD16-4321-996B-735308A24499}';
  SessionLogEventCount:=0; // инициализация счётчика лога
  Configuration.bMySQLConnected:=False;
  THackControl(ProgressBar1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  ProgressBar1.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right-PanelRect.Left, PanelRect.Bottom-PanelRect.Top);
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
  Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right-PanelRect.Left+1, PanelRect.Bottom-PanelRect.Top+1);
  gsFileVersionInfo1.Filename:=Application.ExeName;
  if not(FileExists(ExpandFileName(Application.HelpFile))) then
    begin
      Action_Help.Enabled:=False;
      Action_Help.Visible:=False;
    end;
  s:=ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4LogServer.log';
  if FileExists(s) then
    begin
      // ListView1.Items.LoadFromFile(s);
      // DeleteFile(s);
    end;

  MainForm.Width:=Screen.WorkAreaWidth;
  MainForm.Height:=Screen.WorkAreaHeight;
  MainForm.Top:=Screen.WorkAreaTop;
  MainForm.Left:=Screen.WorkAreaLeft;

  MainForm.Visible:=False;
  TrayIcon1.Visible:=True;
  Load_ConfigIni;
  Do_Connect;
end;

procedure TMainForm.Load_ConfigIni;
var
  IniFile: TIniFile;
begin
  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4LogServer.ini');
  with IniFile do
    try
      Configuration.sLocalHost:=GetLocalIP;
      Configuration.sMySQLHost:=AnsiString(ReadString('Сервер и база данных', 'sMySQLHost', ''));
      Configuration.iMySQLPort:=ReadInteger('Сервер и база данных', 'iMySQLPort', MYSQL_PORT);
      Configuration.iMySQLTimeout:=ReadInteger('Сервер и база данных', 'iMySQLTimeout', 30);
      Configuration.bMySQLCompress:=ReadBool('Сервер и база данных', 'bMySQLCompress', True);
      Configuration.sMySQLDatabase:=AnsiString(ReadString('Сервер и база данных', 'sMySQLDatabase', ''));
      Configuration.sMySQLUser:=AnsiString(ReadString('Сервер и база данных', 'sMySQLUser', ''));
      Configuration.sMySQLPassword:=AnsiString(ReadString('Сервер и база данных', 'sMySQLPassword', ''));
      Configuration.bNoToolBar:=ReadBool('Интерфейс', 'bNoToolBar', False);
      Configuration.bNoStatusBar:=ReadBool('Интерфейс', 'bNoStatusBar', False);
      Configuration.bFullScreen:=ReadBool('Интерфейс', 'bFullScreen', False);
      Configuration.bUseLog:=ReadBool('Интерфейс', 'bUseLog', False);
      Configuration.sCustomHelpFile:=ReadString('Прочее', 'sCustomHelpFile', '');
    finally
      Free;
    end;
end;

procedure TMainForm.Save_ConfigIni;
var
  IniFile: TIniFile;
begin
  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4LogServer.ini');
  with IniFile do
    try
      WriteString('Сервер и база данных', 'sMySQLHost', string(Configuration.sMySQLHost));
      WriteString('Сервер и база данных', 'sMySQLHost', string(Configuration.sMySQLHost));
      WriteInteger('Сервер и база данных', 'iMySQLPort', Configuration.iMySQLPort);
      WriteInteger('Сервер и база данных', 'iMySQLTimeout', Configuration.iMySQLTimeout);
      WriteBool('Сервер и база данных', 'bMySQLCompress', Configuration.bMySQLCompress);
      WriteString('Сервер и база данных', 'sMySQLDatabase', string(Configuration.sMySQLDatabase));
      WriteString('Сервер и база данных', 'sMySQLUser', string(Configuration.sMySQLUser));
      WriteString('Сервер и база данных', 'sMySQLPassword', string(Configuration.sMySQLPassword));
      WriteBool('Интерфейс', 'bNoToolBar', Configuration.bNoToolBar);
      WriteBool('Интерфейс', 'bNoStatusBar', Configuration.bNoStatusBar);
      WriteBool('Интерфейс', 'bFullScreen', Configuration.bFullScreen);
      WriteBool('Интерфейс', 'bUseLog', Configuration.bUseLog);
      WriteString('Прочее', 'sCustomHelpFile', Configuration.sCustomHelpFile);
      if FileExists(Configuration.sCustomHelpFile) then
        Application.HelpFile:=Configuration.sCustomHelpFile;
    finally
      Free;
    end;
end;

procedure TMainForm.LogThis(a, sGroupGIUD: string; MessageType: TLogMessagesType);
var
  s, m: string;
begin
  if not Configuration.bUseLog then
    Exit;
  SessionLogEventCount:=SessionLogEventCount+1;
  case MessageType of
    lmtError:
      s:='ERROR  ';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO   ';
    lmtSQL:
      s:='SQL    ';
  end;
  m:=s+#09+ // тип сообщения
    StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss', Now), ' ', #09, [rfReplaceAll])+#09+ // дата и время сообщения
    sGroupGIUD+#09+StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])+#09+ // порядковый номер сообщения
    #09+ // текущий залогированный пользователь
    a; // текст сообщения
  // Memo2.Lines.Add(m);
end;

procedure TMainForm.SetBusy(aLogGroupGUID: string);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:=aLogGroupGUID;
  LogThis('Установлен режим "Занято".', LogGroupGUID, lmtInfo);
  ImageList2.GetIcon(3, Image1.Picture.Icon);
  Application.ProcessMessages;
end;

procedure TMainForm.SetReady(aLogGroupGUID: string);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:=aLogGroupGUID;
  LogThis('Установлен режим "Готово".', LogGroupGUID, lmtInfo);
  ImageList2.GetIcon(4, Image1.Picture.Icon);
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
begin
  if MainForm.Visible then
    SetForegroundWindow(MainForm.Handle);
end;

procedure TMainForm.TrayIcon1DblClick(Sender: TObject);
begin
  Restore_MainForm;
end;

end.
