unit uMainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.Menus,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.AppEvnts,
  Vcl.ExtCtrls,
  uConfigurationClass,
  uSharedMemClass,
  uChunkClass,
  uChunkedFileClass,
  uWatchThreadClass,
  uCommon,
  SharedMemoryCOMLibrary_TLB;

type
  TMainForm=class(TForm)
    ilMainFormSmallImages: TImageList;
    ActionManager1: TActionManager;
    Action_Quit: TAction;
    Action_About: TAction;
    Action_Configuration: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Action_SekectFile: TAction;
    Action_Send: TAction;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Action_Cancel: TAction;
    N10: TMenuItem;
    pbMain: TProgressBar;
    StatusBar1: TStatusBar;
    imConnectionState: TImage;
    ilMainFormStateIcons: TImageList;
    N11: TMenuItem;
    miStatusBar: TMenuItem;
    Panel1: TPanel;
    pnlButtons: TPanel;
    btnSelectFile: TButton;
    btnSend_btnCancel: TButton;
    ebSelectFile: TEdit;
    chkbxScrollLogToBottom: TCheckBox;
    lvLog: TListView;
    ilLog: TImageList;
    procedure FormShow(Sender: TObject);
    procedure Action_SendExecute(Sender: TObject);
    procedure Action_CancelExecute(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure chkbxScrollLogToBottomClick(Sender: TObject);
    procedure Action_SekectFileExecute(Sender: TObject);
    procedure lvLogResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private

    /// <summary>
    /// Интерфейс для доступа к COM-объекту, раздающему имя общей памяти
    /// </summary>
    FSharedMemoryCOMInterface: ISharedMemoryCOMInterface;

    /// <summary>
    /// Объект для доступа к общей памяти
    /// </summary>
    FSharedMem: TSharedMemClass;

    /// <summary>
    /// Объект для манипуляций с фрагментом данных
    /// </summary>
    FChunk: TChunkClass;

    /// <summary>
    /// Объект для манипуляций с "порционным" файлом данных
    /// </summary>
    FChunkedFile: TChunkedFileClass;

    /// <summary>
    /// Объект для хранения настроек программы
    /// </summary>
    FConfiguration: TConfigurationClass;

    /// <summary>
    /// Объект нити для опроса состояния соединения
    /// </summary>
    FWatchThread: TWatchThreadClass;

    /// <summary>
    /// Флаг состояния отправки данных
    /// </summary>
    FSending: Boolean;

    /// <summary>
    /// Флаг состояния первичного запуска прилодения
    /// </summary>
    FFirstRun: Boolean;

    /// <summary>
    /// Флаг состояния соединения с сервером
    /// </summary>
    FConnectedToServer: Boolean;

    /// <summary>
    /// Handle окна серверного приложения
    /// </summary>
    FServerHandle: THandle;

    /// <summary>
    /// Имя файла для передачи
    /// </summary>
    FFilename: string;

    procedure ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);
    procedure SetConfiguration(const Value: TConfigurationClass);
    procedure Log(const aMessage: string; aMessageType: TLogMessagesType);
    procedure ApplicationOnHint(Sender: TObject);

    procedure Do_RefreshConnectionState;
    procedure Do_LoadConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_ApplyConfiguration;
    procedure Do_About(const aButtonVisible: Boolean);
    procedure Do_Configuration;
    procedure Do_WatchThreadTerminate;
    procedure Do_UpdateColumnWidth;
    procedure Do_UpdateAcrions;
    procedure Do_PlaySound;
    function Do_RegisterWindowMessages: Boolean;
    function Do_WatchThreadStart: Boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    procedure LogError(const aMessage: string);
    procedure LogWarning(const aMessage: string);
    procedure LogInfo(const aMessage: string);
    procedure LogDebug(const aMessage: string);
    procedure ProcessErrors(const aHandle: THandle; const aError: Boolean; const aErrorMessage: string);
    property Configuration: TConfigurationClass read FConfiguration write SetConfiguration stored False;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Winapi.CommCtrl,
  System.IniFiles,
  Winapi.MMSystem,
  uAboutForm,
  uConfigurationForm,
  uCommonConfigurationClass,
  System.IOUtils;

type
  THackControl=class(TControl);

resourcestring
  TEXT_MAINFORM_CAPTION='Shared Memory Client';
  TEXT_ABOUTFORM_CAPTION='About "Shared Memory Client"...';
  TEXT_DATA_READED_TO_CHUNK='Считаны данные из порционного файла.';

var
  WM_SERVER, WM_CLIENT: cardinal;
  Recipients: DWORD=BSM_APPLICATIONS;

procedure TMainForm.ProcessErrors(const aHandle: THandle; const aError: Boolean; const aErrorMessage: string);
begin
  if aError then
    begin
      LogError(aErrorMessage);
      ShowErrorBox(aHandle, aErrorMessage);
      pbMain.Position:=pbMain.Min;
    end;
end;

procedure TMainForm.Do_About(const aButtonVisible: Boolean);
var
  AboutForm: TAboutForm;
begin
  AboutForm:=TAboutForm.Create(Self);
  with AboutForm do
    try
      Caption:=TEXT_ABOUTFORM_CAPTION;
      lblTitle.Caption:=TEXT_MAINFORM_CAPTION;
      Action_Close.Visible:=aButtonVisible;
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.Do_ApplyConfiguration;
var
  FormPosition: TFormPosition;
begin
  // применение настроек к прокрутке сообщений протокола
  chkbxScrollLogToBottom.Checked:=chkbxScrollLogToBottom.Enabled and Configuration.ScrollLogToBottom;
  chkbxScrollLogToBottom.OnClick:=chkbxScrollLogToBottomClick;
  // применение настроек к панели статуса
  miStatusBar.Checked:=Configuration.ShowStatusbar;
  StatusBar1.Visible:=Configuration.ShowStatusbar;

  // установка позиции и размеров главного окна в соответсвии с параметрами конфигурации
  WindowState:=wsNormal;
  Position:=poDesigned;
  Left:=Configuration.MainFormPosition.Left;
  Top:=Configuration.MainFormPosition.Top;
  Width:=Configuration.MainFormPosition.Width;
  Height:=Configuration.MainFormPosition.Height;
  if Configuration.MainFormPosition.Maximized then
    WindowState:=wsMaximized
  else
    if Configuration.MainFormPosition.Centered then
      begin
        Position:=poScreenCenter;
        FormPosition.Centered:=False;
        FormPosition.Maximized:=Configuration.MainFormPosition.Maximized;
        FormPosition.Left:=Configuration.MainFormPosition.Left;
        FormPosition.Top:=Configuration.MainFormPosition.Top;
        FormPosition.Width:=Configuration.MainFormPosition.Width;
        FormPosition.Height:=Configuration.MainFormPosition.Height;
        Configuration.MainFormPosition:=FormPosition;
      end;

  LogInfo(TEXT_CONFIGURATION_SUCCESSFULLY_APPLIED);
end;

procedure TMainForm.Do_Configuration;
var
  ConfigurationForm: TConfigurationForm;
begin
  ConfigurationForm:=TConfigurationForm.Create(Self);
  with ConfigurationForm do
    try
      ShowModal;
    finally
      if ModalResult=mrOk then
        Do_ApplyConfiguration;
      Free;
    end;
end;

procedure TMainForm.Do_LoadConfiguration;
var
  bError: Boolean;
  sErrorMessage: string;
begin
  if not FFirstRun then
    begin
      bError:=False;
      LogDebug(TEXT_CONFIGURATION_TRYING_TO_READ);
    end;
  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Load;
      LogInfo(TEXT_CONFIGURATION_SUCCESSFULLY_READED);
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    if not FFirstRun then
      CommonFunctions.GenerateError(TEXT_CONFIGURATION_READ_ERROR, sErrorMessage, bError);
    Application.HandleException(Self);
  end;
  if not FFirstRun then
    ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TMainForm.Do_PlaySound;
begin
  if Configuration.PlaySoundOnComplete then
    PlaySound('WAVE_0', HInstance, SND_RESOURCE or SND_ASYNC);
end;

function TMainForm.Do_RegisterWindowMessages: Boolean;
begin
  Result:=False;
  try
    WM_SERVER:=RegisterWindowMessage(PWideChar(TEXT_WM_SM_SERVER));
    if WM_SERVER=0 then
      raise Exception.Create(TEXT_REGISTERWINDOWMESSAGEERROR+TEXT_ERRORCODE+IntToStr(GetLastError));
    WM_CLIENT:=RegisterWindowMessage(PWideChar(TEXT_WM_SM_CLIENT));
    if WM_CLIENT=0 then
      raise Exception.Create(TEXT_REGISTERWINDOWMESSAGEERROR+TEXT_ERRORCODE+IntToStr(GetLastError));
    LogDebug(TEXT_MESSAGE_REGISTRATION_COMPLETED_SUCCESSFULLY);
    Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
end;

procedure TMainForm.Do_SaveConfiguration;
var
  bError: Boolean;
  sErrorMessage: string;
begin
  bError:=False;

  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Save;
      LogInfo(TEXT_CONFIGURATION_SUCCESSFULLY_WRITTEN);
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    on E: EIniFileException do
      begin
        CommonFunctions.GenerateError(E.Message, sErrorMessage, bError);
        if MessageBox(Handle, PWideChar(TEXT_DO_YOU_WANNA_RETRY_CONFIGURATION_SAVING), PWideChar(Format(TEXT_WARNING, [MainForm.Caption])), MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON1)=IDOK then
          try
            Screen.Cursor:=crHourGlass;
            try
              Configuration.Save;
              LogInfo(TEXT_CONFIGURATION_SUCCESSFULLY_WRITTEN);
            except
              on E: EIniFileException do
                CommonFunctions.GenerateError(E.Message, sErrorMessage, bError);
            end;
          finally
            Screen.Cursor:=crDefault;
          end;
      end;
    else
      Application.HandleException(Self);
  end;

  ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  FormPosition: TFormPosition;
begin
  CanClose:=False;

  if Configuration.ShowConfirmationOnQuit then
    CanClose:=MessageBox(Handle, PWideChar(TEXT_ARE_YOU_SURE_YOU_WANNA_QUIT), PWideChar(Format(TEXT_QIUT_CONFIRMATION, [TEXT_MAINFORM_CAPTION])), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK
  else
    CanClose:=True;
  Application.ProcessMessages;

  if CanClose then
    begin
      LogInfo(TEXT_QIUT_CONFIRMED);
      // применение текущих настроек главного окна к конфигурации
      FormPosition.Left:=Left;
      FormPosition.Top:=Top;
      FormPosition.Width:=Width;
      FormPosition.Height:=Height;
      FormPosition.Centered:=False;
      FormPosition.Maximized:=WindowState=wsMaximized;
      Configuration.MainFormPosition:=FormPosition;

      Do_SaveConfiguration; // запись конфигурации
      if FConnectedToServer then // если соединение с сервером установлено, отправляем серверу уведомление о завершении работы клиента
        PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SHUTDOWN, 0);
    end
  else
    LogInfo(TEXT_QIUT_ABORTED_BY_USER);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if FFirstRun then
    begin
      FFirstRun:=False;
      if Configuration.ShowSplashAtStart then
        Do_About(False);
      if not Do_RegisterWindowMessages then
        Application.Terminate;
    end;
  Do_UpdateAcrions;
end;

procedure TMainForm.Log(const aMessage: string; aMessageType: TLogMessagesType);
const
  ICON_ERROR=0;
  ICON_WARNING=1;
  ICON_INFO=2;
  ICON_DEBUG=3;
var
  i: Integer;
  ListItem: TListItem;
begin
  i:=-1;
  if (((lmtError in Configuration.KeepLogTypes)and(aMessageType=lmtError))or((lmtWarning in Configuration.KeepLogTypes)and(aMessageType=lmtWarning))or((lmtInfo in Configuration.KeepLogTypes)and(aMessageType=lmtInfo))or
    ((lmtDebug in Configuration.KeepLogTypes)and(aMessageType=lmtDebug))) then
    begin
      case aMessageType of
        lmtError:
          i:=ICON_ERROR;
        lmtWarning:
          i:=ICON_WARNING;
        lmtInfo:
          i:=ICON_INFO;
        lmtDebug:
          i:=ICON_DEBUG;
      end;
      ListItem:=lvLog.Items.Add;
      ListItem.ImageIndex:=i;
      ListItem.Caption:=FormatDateTime(TEXT_DATETIME_FORMAT, Now);
      ListItem.SubItems.Add(aMessage);
      Do_UpdateColumnWidth;
      if Configuration.ScrollLogToBottom then
        SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
    end;
end;

procedure TMainForm.LogDebug(const aMessage: string);
begin
  if lmtDebug in Configuration.KeepLogTypes then
    Log(aMessage, lmtDebug);
end;

procedure TMainForm.LogError(const aMessage: string);
begin
  if lmtError in Configuration.KeepLogTypes then
    Log(aMessage, lmtError);
end;

procedure TMainForm.LogInfo(const aMessage: string);
begin
  if lmtInfo in Configuration.KeepLogTypes then
    Log(aMessage, lmtInfo);
end;

procedure TMainForm.LogWarning(const aMessage: string);
begin
  if lmtWarning in Configuration.KeepLogTypes then
    Log(aMessage, lmtWarning);
end;

procedure TMainForm.lvLogResize(Sender: TObject);
begin
  Do_UpdateColumnWidth;
end;

procedure TMainForm.Do_UpdateAcrions;
begin
  Action_SekectFile.Enabled:=not FSending;
  Action_Send.Enabled:=FConnectedToServer and FileExists(FFilename);
  Action_Send.Visible:=btnSend_btnCancel.Action=Action_Send;
  LogDebug(Format(TEXT_ACTION_SWITCHED, [Action_Send.Caption, CommonFunctions.GetConditionalString(Action_Send.Enabled, TEXT_ACTION_ON, TEXT_ACTION_OFF)]));

  Action_Cancel.Enabled:=Action_Send.Enabled;
  Action_Cancel.Visible:=btnSend_btnCancel.Action=Action_Cancel;
  LogDebug(Format(TEXT_ACTION_SWITCHED, [Action_Cancel.Caption, CommonFunctions.GetConditionalString(Action_Cancel.Enabled, TEXT_ACTION_ON, TEXT_ACTION_OFF)]));
  Application.ProcessMessages;
end;

procedure TMainForm.Do_UpdateColumnWidth;
var
  H: THandle;
begin
  lvLog.Column[0].Width:=130;
  H:=lvLog.Handle;
  if (GetWindowLong(H, GWL_STYLE)and WS_VSCROLL)=WS_VSCROLL then
    lvLog.Column[1].Width:=lvLog.Width-(lvLog.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)-lvLog.Column[0].Width
  else
    lvLog.Column[1].Width:=lvLog.Width-(lvLog.BevelWidth*2)-2-lvLog.Column[0].Width;
  lvLog.FlatScrollBars:=False;
  lvLog.FlatScrollBars:=True;
end;

procedure TMainForm.miStatusBarClick(Sender: TObject);
begin
  StatusBar1.Visible:=miStatusBar.Checked;
  Configuration.ShowStatusbar:=StatusBar1.Visible;
  LogInfo(Format(TEXT_STATUSBAR_SWITCHED, [CommonFunctions.GetConditionalString(StatusBar1.Visible, TEXT_STATUSBAR_ON, TEXT_STATUSBAR_OFF)]));
end;

procedure TMainForm.Do_RefreshConnectionState;
const
  ICON_BUSY=0;
  ICON_READY=1;
begin
  if FConnectedToServer then
    ilMainFormStateIcons.GetIcon(ICON_READY, imConnectionState.Picture.Icon)
  else
    ilMainFormStateIcons.GetIcon(ICON_BUSY, imConnectionState.Picture.Icon);
  LogDebug(Format(TEXT_CONNECTION_SWITCHED, [CommonFunctions.GetConditionalString(FConnectedToServer, TEXT_CONNECTION_ON, TEXT_CONNECTION_OFF)]));
  Application.ProcessMessages;
end;

procedure TMainForm.ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);
begin
  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(Format(TEXT_ERROR, [TEXT_MAINFORM_CAPTION])), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
begin
  Do_About(True);
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
begin
  Do_Configuration;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ApplicationOnHint(Sender: TObject);
begin
  if Configuration.ShowStatusbar then
    StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.Action_SendExecute(Sender: TObject);
resourcestring
  TEXT_SENDING_STARTED_BY_USER='Пользователь запустил процедуру отправки файла на сервер.';
  TEXT_NOTIFICATION_ABOUT_START_SENDING_FILE_POSTED='Отправлено уведомление о попытке передачи файла на сервер.';
begin
  LogInfo(TEXT_SENDING_STARTED_BY_USER);
  FSending:=True;
  Action_Send.Enabled:=False;
  Action_Cancel.Enabled:=False;
  btnSend_btnCancel.Action:=Action_Cancel;
  Do_UpdateAcrions;
  if FConnectedToServer then
    begin
      PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_WANNA_SEND_FILE, 0);
      LogInfo(TEXT_NOTIFICATION_ABOUT_START_SENDING_FILE_POSTED);
    end;
end;

procedure TMainForm.Action_CancelExecute(Sender: TObject);
resourcestring
  TEXT_SENDING_ABORTED_BY_USER='Отправка файла на сервер отменена пользователем.';
  TEXT_NOTIFICATION_ABOUT_CANCEL_SENDING_FILE_POSTED='Отправлено уведомление об отмене передачи файла на сервер.';
begin
  LogWarning(TEXT_SENDING_ABORTED_BY_USER);
  pbMain.Visible:=False;
  FSending:=False;
  Action_Send.Enabled:=False;
  Action_Cancel.Enabled:=False;
  btnSend_btnCancel.Action:=Action_Send;
  Do_UpdateAcrions;
  FreeAndNil(FChunkedFile); // удаляем объект доступа к порционному файлу
  LogDebug(TEXT_CHUNKEDFILE_OBJECT_DESTROYED);
  if FConnectedToServer then
    begin
      PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_WANNA_CANCEL_SENDING, 0); // отправляем сигнал серверу об отмене передачи файла
      LogInfo(TEXT_NOTIFICATION_ABOUT_CANCEL_SENDING_FILE_POSTED);
    end;
end;

procedure TMainForm.SetConfiguration(const Value: TConfigurationClass);
begin
  FConfiguration:=Value;
end;

procedure TMainForm.chkbxScrollLogToBottomClick(Sender: TObject);
begin
  Configuration.ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
  LogInfo(Format(TEXT_SCROLLLOG_SWITCHED, [CommonFunctions.GetConditionalString(Configuration.ScrollLogToBottom, TEXT_SCROLLLOG_ON, TEXT_SCROLLLOG_OFF)]));
end;

function TMainForm.Do_WatchThreadStart: Boolean;
begin
  Result:=False;
  if not Assigned(FWatchThread) then
    begin
      FWatchThread:=TWatchThreadClass.Create(FServerHandle, Handle, WM_SERVER, WPARAM_SERVER_LOST);
      try
        FWatchThread.Start;
        LogDebug(TEXT_WATCH_THREAD_STARTED);
        Result:=True;
      except
        on E: Exception do
          ShowErrorBox(Handle, E.Message);
      end;
    end;
end;

procedure TMainForm.Do_WatchThreadTerminate;
var
  Thread: TWatchThreadClass;
begin
  Thread:=FWatchThread;
  FWatchThread:=nil;
  if Assigned(Thread) then
    begin
      Thread.Terminate;
      LogDebug(TEXT_WATCH_THREAD_STOPPED);
    end;
end;

procedure TMainForm.WndProc(var Message: TMessage);
resourcestring
  TEXT_TRANSFER_COMPLETE='Окончена передача данных файла.';

  procedure Do_Disconnect;
  resourcestring
    TEXT_SENDING_CANCELED='Отпрака файла на сервер отменена.';
    TEXT_SERVER_HANDLE_CLEARED='Handle окна серверного приложения обнулён.';
    TEXT_DISCONNECTED_FROM_SERVER='Соединение с сервером прервано.';
  begin
    pbMain.Visible:=False;
    if FSending then
      LogWarning(TEXT_SENDING_CANCELED);
    FSending:=False;
    Do_WatchThreadTerminate;
    FConnectedToServer:=False; // убираем флаш соединения
    FServerHandle:=0; // обнуляем хэндл сервера
    LogDebug(TEXT_SERVER_HANDLE_CLEARED);
    FreeAndNil(FChunkedFile); // удаляем объект доступа к порционному файлу
    LogDebug(TEXT_CHUNKEDFILE_OBJECT_DESTROYED);
    FreeAndNil(FSharedMem); // удаляем объект доступа к общей памяти
    LogDebug(TEXT_SHARED_MEMORY_OBJECT_DESTROYED);
    Do_RefreshConnectionState;
    btnSend_btnCancel.Action:=Action_Send;
    Do_UpdateAcrions;
    LogInfo(TEXT_DISCONNECTED_FROM_SERVER);
  end;

  procedure Do_WPARAM_SERVER_LOST;
  resourcestring
    TEXT_SERVER_LOST='Произошла непредвиденная потеря соединения с сервером!';
  begin
    LogError(TEXT_SERVER_LOST);
    Do_Disconnect;
  end;

  procedure Do_WPARAM_SERVER_SHUTDOWN;
  resourcestring
    TEXT_SERVER_SHUTDOWN='Получено уведомление о завершении работы сервера.';
  begin
    LogWarning(TEXT_SERVER_SHUTDOWN);
    Do_Disconnect;
  end;

  procedure Do_WPARAM_SERVER_WANNA_HANDLE(const dwHandle: THandle);
  resourcestring
    TEXT_RECEIVED_SERVERS_HANDLE='Получен идентификатор доступного сервера.';
    TEXT_SERVERS_HANDLE='Handle окна доступного сервера: %s.';
    TEXT_POSTED_CONNECTION_QUERY='Отправлен запрос на подключение к серверу.';
    TEXT_POSTED_CLIENTS_HANDLE='Отправлеен Handle клиента: %s.';
  begin
    if FServerHandle<>dwHandle then
      begin
        LogInfo(TEXT_RECEIVED_SERVERS_HANDLE);
        LogDebug(Format(TEXT_RECEIVED_SERVERS_HANDLE, [IntToStr(dwHandle)]));
        FServerHandle:=dwHandle; // сохранение хэндла окна сервера
        PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_HANDLE, Handle);
        // отправка хэндла окна клиента серверу
        LogInfo(TEXT_POSTED_CONNECTION_QUERY);
        LogDebug(Format(TEXT_POSTED_CLIENTS_HANDLE, [IntToStr(Handle)]));
      end;
  end;

  procedure Do_WPARAM_SERVER_ACCEPT_CLIENT;
  resourcestring
    TEXT_RECEIVED_SUCCESSFUL_CONNECTION_NOTIFICATION='Получено подтверждение об успешном подключении к серверу.';
    TEXT_CONNECTION_WITH_SERVER_ESTABLISHED='Соединение с сервером установлено.';
  begin
    LogInfo(TEXT_RECEIVED_SUCCESSFUL_CONNECTION_NOTIFICATION);
    FConnectedToServer:=True; // ставим флаш соединения
    if not Do_WatchThreadStart then
      Application.Terminate;
    Do_RefreshConnectionState;
    Do_UpdateAcrions;
    LogInfo(TEXT_CONNECTION_WITH_SERVER_ESTABLISHED);
  end;

  procedure Do_WPARAM_SERVER_SENDS_SHAREDMEM_SIZE(const dwSize: cardinal);
  resourcestring
    TEXT_SERVER_SENDS_SHAREDMEM_SIZE='Получен размер буфера общей памяти в байтах: %s.';
  begin
    LogInfo(Format(TEXT_SERVER_SENDS_SHAREDMEM_SIZE, [IntToStr(Int64(dwSize))]));
    Configuration.SharedMemSize:=dwSize;
    FSharedMem:=TSharedMemClass.Create(Configuration.SharedMemoryName, Configuration.SharedMemSize);
    LogDebug(TEXT_SHARED_MEMORY_OBJECT_CREATED);
  end;

  procedure Do_WPARAM_SERVER_WANNA_FILENAME;
  resourcestring
    TEXT_RECEIVED_FILENAME_QUERY='Получен запрос имени файла.';
    TEXT_POSTED_FILENAME='Отправлено имя передаваемого файла: [%s].';
  var
    a: TArray<byte>;
  begin
    LogInfo(TEXT_RECEIVED_FILENAME_QUERY);
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug(TEXT_CHUNK_OBJECT_CREATED);
      end;
    try
      a:=BytesOf(ExtractFileName(FFilename));
      FChunk.Size:=Length(a);
      FChunk.Data:=Copy(a, 0, FChunk.Size);
      FSharedMem.Mapped:=True;
      FSharedMem.Write(FChunk);
      FSharedMem.Mapped:=False;
      PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_FILENAME, FChunk.Size);
      // отправка хэндла окна клиента серверу (LPARAM = размер имени файла в байтах)
      LogInfo(Format(TEXT_POSTED_FILENAME,[ExtractFileName(FFilename)]));
    finally
      FreeAndNil(FChunk);
      LogDebug(TEXT_CHUNK_OBJECT_DESTROYED);
    end;
  end;

  procedure Do_WPARAM_SERVER_WANNA_FILESIZE;
  resourcestring
    TEXT_RECEIVED_FILESIZE_QUERY='Получен запрос размера файла в байтах.';
    TEXT_POSTED_FILESIZE='Отправлен размер передаваемого файла в байтах: %s.';
    TEXT_ERROR_READING_FILE='Не удалось открыть для чтения указанный файл! Файл уже открыт другой программой либо недостаточно прав доступа.';
    TEXT_SENDING_STARTED='Начата передача данных файла.';
  var
    a: TArray<byte>;
  begin
    LogInfo(TEXT_RECEIVED_FILESIZE_QUERY);
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug(TEXT_CHUNK_OBJECT_CREATED);
      end;
    try
      if not Assigned(FChunkedFile) then
        begin
          try
            FChunkedFile:=TChunkedFileClass.Create(FFilename, Configuration.SharedMemSize);
            LogDebug(TEXT_CHUNKEDFILE_OBJECT_CREATED);
            pbMain.Max:=FChunkedFile.Count;
            pbMain.Position:=pbMain.Min;
            pbMain.Visible:=True;
            // так как размер файла может превышать 4 гигабайта, размер требуется передавать в виде текстовой строки
            a:=BytesOf(IntToStr(FChunkedFile.Size));
            FChunk.Size:=Length(a);
            FChunk.Data:=Copy(a, 0, FChunk.Size);
            FSharedMem.Mapped:=True;
            FSharedMem.Write(FChunk);
            FSharedMem.Mapped:=False;
            PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_FILESIZE, FChunk.Size);
            LogInfo(Format(TEXT_POSTED_FILESIZE, [IntToStr(FChunkedFile.Size)]));
          except
            on EInOutError do
              LogError(TEXT_ERROR_READING_FILE);
            on E: Exception do
              LogError(E.Message);
          end;
        end
      else
        raise Exception.Create(TEXT_CHUNKEDFILE_OBJECT_CREATION_ERROR);
    finally
      FreeAndNil(FChunk);
      LogDebug(TEXT_CHUNK_OBJECT_DESTROYED);
    end;
    LogInfo(TEXT_SENDING_STARTED);
  end;

  procedure Do_WPARAM_SERVER_WANNA_DATA(const dwBlockNumber: cardinal);
  resourcestring
    TEXT_RECEIVED_SERVER_WANNA_DATA_QUERY='Получен запрос на передачу порции данных файла.';
    TEXT_DATA_WRITTEN_TO_SHARED_MEMORY='Данные записаны в общую память.';
    TEXT_CHUNK_SENDED='Отправлена порция данных передаваемого файла.';
  begin
    LogDebug(TEXT_RECEIVED_SERVER_WANNA_DATA_QUERY);
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug(TEXT_CHUNK_OBJECT_CREATED);
      end;
    try
      FChunkedFile.Read(dwBlockNumber, FChunk);
      LogDebug(TEXT_DATA_READED_TO_CHUNK);
      FSharedMem.Mapped:=True;
      FSharedMem.Write(FChunk);
      FSharedMem.Mapped:=False;
      LogDebug(TEXT_DATA_WRITTEN_TO_SHARED_MEMORY);
      PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_DATA, FChunk.Size);
      LogDebug(TEXT_CHUNK_SENDED);
    finally
      FreeAndNil(FChunk);
    end;
  end;

  procedure Do_WPARAM_SERVER_WANNA_CRC32(const dwBlockNumber: cardinal);
  resourcestring
    TEXT_RECEIVED_CRC32_QUERY='Получен запрос на передачу контрольной суммы порции данных файла.';
    TEXT_SENDED_CRC32_OF_CHUNK='Отправлена контрольная сумма порции данных передаваемого файла.';
  begin
    LogDebug(TEXT_RECEIVED_CRC32_QUERY);
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug(TEXT_CHUNK_OBJECT_CREATED);
      end;
    try
      FChunkedFile.Read(dwBlockNumber, FChunk);
      LogDebug(TEXT_DATA_READED_TO_CHUNK);
      PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_CRC32, FChunk.CRC32);
      LogDebug(TEXT_SENDED_CRC32_OF_CHUNK);
      pbMain.StepBy(1);
    finally
      FreeAndNil(FChunk);
    end;
  end;

  procedure Do_WPARAM_SERVER_TRANSFER_COMPLETE;
  resourcestring
    TEXT_RECEIVED_SUCCESSFUL_TRANSFER_CONFIRMATION='Получено подтверждение об успешной передаче файла.';
    TEXT_TRANSFER_COMPLETE_SUCCESSFUL='Передача файла успешно завершена.';
  begin
    LogInfo(TEXT_RECEIVED_SUCCESSFUL_TRANSFER_CONFIRMATION);
    FSending:=False;
    pbMain.Visible:=False;
    FreeAndNil(FChunkedFile); // удаляем объект доступа к порционному файлу
    LogDebug(TEXT_CHUNKEDFILE_OBJECT_DESTROYED);
    FreeAndNil(FSharedMem); // удаляем объект доступа к общей памяти
    LogDebug(TEXT_SHARED_MEMORY_OBJECT_DESTROYED);
    btnSend_btnCancel.Action:=Action_Send;
    Do_UpdateAcrions;
    LogInfo(TEXT_TRANSFER_COMPLETE);
    LogInfo(TEXT_TRANSFER_COMPLETE_SUCCESSFUL);
    if Configuration.PlaySoundOnComplete then
      Do_PlaySound;
  end;

  procedure Do_WPARAM_SERVER_TRANSFER_ERROR;
  resourcestring
    TEXT_RECEIVED_ERROR_TRANSFER_CONFIRMATION='Получено уведомление об ошибке при передаче файла!';
    TEXT_TRANSFER_COMPLETE_ERROR='Передача файла закончилась неудачей!';
  begin
    LogError(TEXT_RECEIVED_ERROR_TRANSFER_CONFIRMATION);
    FSending:=False;
    pbMain.Visible:=False;
    FreeAndNil(FChunkedFile); // удаляем объект доступа к порционному файлу
    LogDebug(TEXT_CHUNKEDFILE_OBJECT_DESTROYED);
    FreeAndNil(FSharedMem); // удаляем объект доступа к общей памяти
    LogDebug(TEXT_SHARED_MEMORY_OBJECT_DESTROYED);
    btnSend_btnCancel.Action:=Action_Send;
    Do_UpdateAcrions;
    LogInfo(TEXT_TRANSFER_COMPLETE);
    LogWarning(TEXT_TRANSFER_COMPLETE_ERROR);
    if Configuration.PlaySoundOnComplete then
      Do_PlaySound;
  end;

begin
  inherited;
  if message.Msg=WM_SERVER then
    begin
      if message.WParam=WPARAM_SERVER_SHUTDOWN then
        // сервер сообщает клиенту о своём отключении
        Do_WPARAM_SERVER_SHUTDOWN
      else
        if FConnectedToServer then
          case message.WParam of
            WPARAM_SERVER_SENDS_SHAREDMEM_SIZE:
              // сервер прислал размер буфера общей памяти
              Do_WPARAM_SERVER_SENDS_SHAREDMEM_SIZE(message.LParam);
            WPARAM_SERVER_WANNA_FILENAME: // сервер хочет имя файла
              Do_WPARAM_SERVER_WANNA_FILENAME;
            WPARAM_SERVER_WANNA_FILESIZE: // сервер хочет количество блоков в файле
              Do_WPARAM_SERVER_WANNA_FILESIZE;
            WPARAM_SERVER_WANNA_DATA: // сервер хочет блок данных
              if FSending then
                Do_WPARAM_SERVER_WANNA_DATA(message.LParam);
            WPARAM_SERVER_WANNA_CRC32: // сервер хочет CRC32
              if FSending then
                Do_WPARAM_SERVER_WANNA_CRC32(message.LParam);
            WPARAM_SERVER_TRANSFER_COMPLETE:
              // сервер сообщает что получил файл полностью
              Do_WPARAM_SERVER_TRANSFER_COMPLETE;
            WPARAM_SERVER_TRANSFER_ERROR:
              // сервер сообщает что получил файл с ошибками
              Do_WPARAM_SERVER_TRANSFER_ERROR;
            WPARAM_SERVER_LOST:
              // поток-сторож сообщает о том, что окно сервера неожиданно пропало
              Do_WPARAM_SERVER_LOST;
          end
        else
          case message.WParam of
            WPARAM_SERVER_WANNA_HANDLE:
              // сервер прислал свой хендл и хочет получить хэндл окна клиента
              Do_WPARAM_SERVER_WANNA_HANDLE(message.LParam);
            WPARAM_SERVER_ACCEPT_CLIENT:
              // сервер подтверждает соединение с данным клиентом
              Do_WPARAM_SERVER_ACCEPT_CLIENT;
          end;
    end;
end;

procedure TMainForm.Action_SekectFileExecute(Sender: TObject);
resourcestring
  TEXT_ALL_FILES='Все файлы';
  TEXT_SELECT_FILE_QUERY='Выберите файл для передачи на сервер...';
  TEXT_FILE_NOT_SELECTED='Не выбран файл для передачи на сервер!';
  TEXT_FILE_SELECTED_SUCCESSFULLY='Файл для передачи на сервер выбран успешно: [%s].';
  TEXT_FILENAME_TO_SEND='Имя файла для передачи на сервер: [%s].';
  TEXT_SELECTED_FILE_NOT_EXISTS='Выбранный файл не существует!';
var
  sErrorMessage: string;
  bError: Boolean;
begin
  bError:=False;
  with TOpenDialog.Create(Self) do
    try
      Filter:=TEXT_ALL_FILES+' (*.*)|*.*';
      Title:=TEXT_SELECT_FILE_QUERY;
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          ShowErrorBox(Handle, TEXT_FILE_NOT_SELECTED)
        else
          begin
            if FileExists(FileName) then
              begin
                FFilename:=FileName;
                ebSelectFile.Text:=FFilename;
                LogInfo(Format(TEXT_FILE_SELECTED_SUCCESSFULLY, [FFilename]));
                LogDebug(Format(TEXT_FILENAME_TO_SEND, [FFilename]));
              end
            else
              CommonFunctions.GenerateError(TEXT_SELECTED_FILE_NOT_EXISTS, sErrorMessage, bError);
          end;
    finally
      Free;
      Do_UpdateAcrions;
    end;
  ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  ICON_MAIN=6;
var
  PanelRect: TRect;

  procedure BindMainProgressBarToStatusBar;
  begin
    THackControl(pbMain).SetParent(StatusBar1);
    SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
    pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right-PanelRect.Left, PanelRect.Bottom-PanelRect.Top-1);
  end;

  procedure BindStateImageToStatusBar;
  begin
    THackControl(imConnectionState).SetParent(StatusBar1);
    SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
    imConnectionState.SetBounds(PanelRect.Left+2, PanelRect.Top+1, PanelRect.Right-PanelRect.Left-4, PanelRect.Bottom-PanelRect.Top-4);
  end;

var
  s: WideString;
begin
  FFirstRun:=True; // режим начала запуска программы включен
  FConnectedToServer:=False; // изначально клиент не подлючен
  FServerHandle:=0; // хэндл сервера обнулён
  FSending:=False;
  FFilename:='';
  Caption:=TEXT_MAINFORM_CAPTION; // установка заголовка окна
  ilMainFormSmallImages.GetIcon(ICON_MAIN, Icon); // установка иконки окна
  FConfiguration:=TConfigurationClass.Create;
  BindMainProgressBarToStatusBar;
  BindStateImageToStatusBar;
  Do_RefreshConnectionState;
  Application.OnHint:=ApplicationOnHint;
  Do_LoadConfiguration; // загрузка настроек из файла
  Do_ApplyConfiguration; // применение настроек к интерфейсу
  try
    FSharedMemoryCOMInterface:=nil;
    FSharedMemoryCOMInterface:=CoSharedMemoryCOMCoClass.Create;
    FSharedMemoryCOMInterface.GetSharedMemoryName(s);
    Configuration.SharedMemoryName:=s;
    LogInfo(Format(TEXT_SHARED_MEMORY_NAME_GETTING_SUCCESSFULLY, [Configuration.SharedMemoryName]));
  except
    Configuration.SharedMemoryName:=TEXT_DEFAULT_SHARED_MEMORY_NAME;
    LogError(TEXT_SHARED_MEMORY_NAME_GETTING_ERROR);
    LogWarning(Format(TEXT_SHARED_MEMORY_NAME_USED_DEFAULT, [Configuration.SharedMemoryName]));
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FSharedMemoryCOMInterface:=nil;
  Do_WatchThreadTerminate;
  FreeAndNil(FChunk);
  FreeAndNil(FChunkedFile);
  FreeAndNil(FSharedMem);
  FreeAndNil(FConfiguration);
end;

end.
