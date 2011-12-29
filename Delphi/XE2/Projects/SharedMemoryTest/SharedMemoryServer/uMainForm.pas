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
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.ImgList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.AppEvnts,
  uConfigurationClass,
  uRetranslatorThreadClass,
  uSharedMemClass,
  uChunkClass,
  uChunkedFileClass,
  uWatchThreadClass,
  uCommon;

type
  TMainForm=class(TForm)
    ilMainFormSmallImages: TImageList;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    miStatusBar: TMenuItem;
    ActionManager1: TActionManager;
    Action_Quit: TAction;
    Action_About: TAction;
    Action_Configuration: TAction;
    Action_OpenDestinationFolder: TAction;
    StatusBar1: TStatusBar;
    pbMain: TProgressBar;
    imConnectionState: TImage;
    ilMainFormStateIcons: TImageList;
    ilLog: TImageList;
    Panel1: TPanel;
    chkbxScrollLogToBottom: TCheckBox;
    lvLog: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkbxScrollLogToBottomClick(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure lvLogResize(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_OpenDestinationFolderExecute(Sender: TObject);
  strict private

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
    /// Объект для рассылки широковещательного сообщения клиентским прилодениям
    /// </summary>
    FConnectionThread: TRetranslatorThreadClass;

    /// <summary>
    /// Объект для
    /// </summary>
    FWatchThread: TWatchThreadClass;

    FFirstRun: boolean;
    FClientConnected: boolean;
    FClientHandle: THandle;
    FReceiving: boolean;
    FFileName: string;

    procedure Refresh_ConnectionState;
    procedure ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);

    procedure Do_LoadConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_ApplyConfiguration;
    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Configuration;
    procedure Do_OpenDestinationFolder;

    function Do_RegisterWindowMessages: boolean;
    function Do_ConnectionThreadStart: boolean;
    procedure Do_ConnectionThreadTerminate;
    function Do_WatchThreadStart: boolean;
    procedure Do_WatchThreadTerminate;
    procedure SetConfiguration(const Value: TConfigurationClass);
    procedure Log(const aMessage: string; aMessageType: TLogMessagesType);
    procedure Do_UpdateColumnWidth;
    procedure Do_PlaySound;
    procedure ApplicationOnHint(Sender: TObject);
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    procedure ProcessErrors(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
    procedure LogError(const aMessage: string);
    procedure LogWarning(const aMessage: string);
    procedure LogInfo(const aMessage: string);
    procedure LogDebug(const aMessage: string);
    property Configuration: TConfigurationClass read FConfiguration write SetConfiguration stored False;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.IniFiles,
  Winapi.CommCtrl,
  Winapi.ShellAPI,
  Winapi.MMSystem,
  uAboutForm,
  uCommonConfigurationClass,
  uConfigurationForm;

resourcestring
  TEXT_MAINFORM_CAPTION='Shared Memory Server';
  TEXT_ABOUTFORM_CAPTION='About "Shared Memory Server"...';

type
  THackControl=class(TControl);

var
  WM_SERVER, WM_CLIENT: cardinal;

procedure TMainForm.ProcessErrors(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    begin
      LogError(aErrorMessage);
      ShowErrorBox(aHandle, aErrorMessage);
      pbMain.Position:=pbMain.Min;
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

procedure TMainForm.Do_UpdateColumnWidth;
var
  h: THandle;
begin
  lvLog.Column[0].Width:=130;
  h:=lvLog.Handle;
  if (GetWindowLong(h, GWL_STYLE)and WS_VSCROLL)=WS_VSCROLL then
    lvLog.Column[1].Width:=lvLog.Width-(lvLog.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)-lvLog.Column[0].Width
  else
    lvLog.Column[1].Width:=lvLog.Width-(lvLog.BevelWidth*2)-2-lvLog.Column[0].Width;
  lvLog.FlatScrollBars:=False;
  lvLog.FlatScrollBars:=True;
end;

procedure TMainForm.Log(const aMessage: string; aMessageType: TLogMessagesType);
const
  ICON_ERROR=0;
  ICON_WARNING=1;
  ICON_INFO=2;
  ICON_DEBUG=3;
var
  i: integer;
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
      ListItem.Caption:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now);
      ListItem.SubItems.Add(aMessage);
      Do_UpdateColumnWidth;
      if Configuration.ScrollLogToBottom then
        SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
    end;
end;

procedure TMainForm.miStatusBarClick(Sender: TObject);
begin
  StatusBar1.Visible:=miStatusbar.Checked;
  Configuration.ShowStatusbar:=StatusBar1.Visible;
  LogInfo('Панель статуса '+CommonFunctions.GetConditionalString(StatusBar1.Visible, 'в', 'от')+'ключена.');
end;

procedure TMainForm.Refresh_ConnectionState;
const
  ICON_BUSY=0;
  ICON_READY=1;
begin
  if FClientConnected then
    ilMainFormStateIcons.GetIcon(ICON_READY, imConnectionState.Picture.Icon)
  else
    ilMainFormStateIcons.GetIcon(ICON_BUSY, imConnectionState.Picture.Icon);
  LogDebug('Индикатор соединения в'+CommonFunctions.GetConditionalString(FClientConnected, '', 'ы')+'ключен.');
  Application.ProcessMessages;
end;

procedure TMainForm.SetConfiguration(const Value: TConfigurationClass);
begin
  if FConfiguration<>Value then
    FConfiguration:=Value;
end;

procedure TMainForm.ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);
begin
  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(TEXT_MAINFORM_CAPTION+' - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;
end;

procedure TMainForm.Do_LoadConfiguration;
var
  bError: boolean;
  sErrorMessage: string;
begin
  if not FFirstRun then
    begin
      bError:=False;
      LogDebug('Производится попытка чтения настроек программы из файла...');
    end;
  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Load;
      LogInfo('Чтение настроек программы из файла конфигурации прошло успешно.');
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    if not FFirstRun then
      CommonFunctions.GenerateError('Произошла ошибка при попытке чтения настроек программы из файла!', sErrorMessage, bError);
    Application.HandleException(Self);
  end;
  if not FFirstRun then
    ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TMainForm.Do_OpenDestinationFolder;
var
  sErrorMessage: string;
  bError: boolean;
begin
  bError:=False;
  LogDebug('Производится попытка открытия папки приёма файлов...');
  if DirectoryExists(Configuration.DestinationFolder) then
    begin
      ShellExecute(Application.Handle, 'open', PWideChar(Configuration.DestinationFolder), nil, nil, SW_MAXIMIZE);
      LogInfo('Открыта папка приёма файлов.');
    end
  else
    CommonFunctions.GenerateError('Папка приёма файлов не существует! Проверьте правильность указанного в настройках пути ['+Configuration.DestinationFolder+']!', sErrorMessage, bError);
  ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TMainForm.Do_PlaySound;
begin
  if Configuration.PlaySoundOnComplete then
    PlaySound('WAVE_0', HInstance, SND_RESOURCE or SND_ASYNC);
end;

procedure TMainForm.Do_SaveConfiguration;
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Save;
      LogInfo('Запись настроек программы в файл прошла успешно.');
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    on E: EIniFileException do
      begin
        CommonFunctions.GenerateError(E.Message, sErrorMessage, bError);
        if MessageBox(Handle, PWideChar('Вы желаете повторить попытку записи настроек программы в файл?'), PWideChar(MainForm.Caption+' - Предупреждение'), MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON1)=IDOK then
          try
            Screen.Cursor:=crHourGlass;
            try
              Configuration.Save;
              LogInfo('Запись настроек программы в файл прошла успешно.');
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

procedure TMainForm.Do_ConnectionThreadTerminate;
var
  Thread: TRetranslatorThreadClass;
begin
  Thread:=FConnectionThread;
  FConnectionThread:=nil;
  if Assigned(Thread) then
    begin
      Thread.Terminate;
      LogDebug('Поток поиска клиентов остановлен.');
    end;
end;

function TMainForm.Do_WatchThreadStart: boolean;
begin
  Result:=False;
  if not Assigned(FWatchThread) then
    begin
      FWatchThread:=TWatchThreadClass.Create(FClientHandle, Handle, WM_CLIENT, WPARAM_CLIENT_LOST);
      try
        FWatchThread.Start;
        LogDebug('Поток наблюдения за наличием соединения с клиентом запущен.');
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
      LogDebug('Поток наблюдения за наличием соединения с клиентом остановлен.');
    end;
end;

procedure TMainForm.Do_About(const aButtonVisible: boolean);
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
  miStatusbar.Checked:=Configuration.ShowStatusbar;
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

  LogInfo('Применение настроек программы прошло успешно.');
end;

procedure TMainForm.Do_Configuration;
var
  ConfigurationForm: TConfigurationForm;
begin
  ConfigurationForm:=TConfigurationForm.Create(Self);
  with ConfigurationForm do
    try
      lblSharedMemSize.Enabled:=not FReceiving;
      edbxSharedMemSizeValue.Enabled:=not FReceiving;
      ShowModal;
    finally
      if ModalResult=mrOk then
        Do_ApplyConfiguration;
      Free;
    end;
end;

function TMainForm.Do_ConnectionThreadStart: boolean;
begin
  Result:=False;
  if not Assigned(FConnectionThread) then
    begin
      FConnectionThread:=TRetranslatorThreadClass.Create(WM_SERVER, WPARAM_SERVER_WANNA_HANDLE, Handle);
      try
        FConnectionThread.Start;
        LogDebug('Поток поиска клиентов запущен.');
        Result:=True;
      except
        on E: Exception do
          ShowErrorBox(Handle, E.Message);
      end;
    end;
end;

function TMainForm.Do_RegisterWindowMessages: boolean;
begin
  Result:=False;
  try
    WM_SERVER:=RegisterWindowMessage(PWideChar(TEXT_WM_SM_SERVER));
    if WM_SERVER=0 then
      raise Exception.Create(TEXT_REGISTERWINDOWMESSAGEERROR+TEXT_ERRORCODE+IntToStr(GetLastError));
    WM_CLIENT:=RegisterWindowMessage(PWideChar(TEXT_WM_SM_CLIENT));
    if WM_CLIENT=0 then
      raise Exception.Create(TEXT_REGISTERWINDOWMESSAGEERROR+TEXT_ERRORCODE+IntToStr(GetLastError));
    LogDebug('Регистрация оконных сообщений выполнена успешно.');
    Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  FormPosition: TFormPosition;
begin

  CanClose:=False;

  if Configuration.ShowConfirmationOnQuit then
    CanClose:=MessageBox(Handle, PWideChar('Вы действительно хотите завершить работу программы?'), PWideChar(TEXT_MAINFORM_CAPTION+' - Подтверждение выхода'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK
  else
    CanClose:=True;
  Application.ProcessMessages;

  if CanClose then
    begin
      LogInfo('Завершение работы приложения было подтверждено.');
      // применение текущих настроек главного окна к конфигурации
      FormPosition.Left:=Left;
      FormPosition.Top:=Top;
      FormPosition.Width:=Width;
      FormPosition.Height:=Height;
      FormPosition.Centered:=False;
      FormPosition.Maximized:=WindowState=wsMaximized;
      Configuration.MainFormPosition:=FormPosition;

      Do_SaveConfiguration; // запись конфигурации
      if FClientConnected then // если соединение с клиентом установлено, отправляем клиенту уведомление о завершении работы сервера
        PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_SHUTDOWN, 0);
    end
  else
    LogInfo('Завершение работы приложения было отменено пользователем.');
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FReceiving:=False; // режим передачи данных выключен
  Do_ConnectionThreadTerminate;
  FreeAndNil(FChunk);
  FreeAndNil(FChunkedFile);
  FreeAndNil(FSharedMem);
  FreeAndNil(FConfiguration);
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
      if not Do_ConnectionThreadStart then
        Application.Terminate;
    end;
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
begin
  Do_About(True);
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
begin
  Do_Configuration;
end;

procedure TMainForm.Action_OpenDestinationFolderExecute(Sender: TObject);
begin
  Do_OpenDestinationFolder;
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

procedure TMainForm.WndProc(var Message: TMessage);

  procedure Do_Disconnect;
  begin
    pbMain.Visible:=False;
    Do_WatchThreadTerminate;
    FClientConnected:=False; // убираем флаш соединения
    FClientHandle:=0; // обнуляем хэндл клиента
    LogDebug('Handle окна клиентского приложения обнулён.');
    FreeAndNil(FChunkedFile); // удаляем объект доступа к порционному файлу
    LogDebug('Объект доступа к порционному файлу уничтоден.');
    FreeAndNil(FSharedMem); // удаляем объект доступа к общей памяти
    LogDebug('Объект доступа к общей памяти уничтоден.');
    if not Do_ConnectionThreadStart then // запускаем поток рассылки хэндла сервера
      Application.Terminate;
    Refresh_ConnectionState;
    LogInfo('Соединение с клиентом прервано.');
  end;

  procedure Do_WPARAM_CLIENT_SHUTDOWN;
  begin
    LogWarning('Получено уведомление о завершении работы клиента.');
    Do_Disconnect;
  end;

  procedure Do_WPARAM_CLIENT_LOST;
  begin
    LogError('Произошла непредвиденная потеря соединения с сервером!');
    Do_Disconnect;
  end;

  procedure Do_WPARAM_CLIENT_SENDS_HANDLE(const Handle: THandle);
  begin
    LogInfo('Получен ответ клиента на широковещательное сообщение.');

    LogInfo('Соединение с клиентом установлено.');
    Do_ConnectionThreadTerminate; // останавливаем поток, рассылающий хэндл сервера
    FClientHandle:=Handle; // получаем хэндл клиента
    LogDebug('Получен Handle окна клиентского приложения: '+IntToStr(Handle)+'.');
    FClientConnected:=True; // устанавливаем флаш соединения
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_ACCEPT_CLIENT, 0); // отправляет клиенту подтверждение подключения
    LogDebug('Отправлено уведомление об успешном подключении.');
    if not Do_WatchThreadStart then
      Application.Terminate;
    Refresh_ConnectionState;
  end;

  procedure Do_WPARAM_CLIENT_WANNA_SEND_FILE;
  begin
    LogInfo('Получено уведомление о попытке передачи файла клиентом.');

    FReceiving:=True;
    FSharedMem:=TSharedMemClass.Create(Configuration.SharedMemoryName, Configuration.SharedMemSize);

    LogDebug('Создан объект доступа к общей памяти.');
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_SENDS_SHAREDMEM_SIZE, Configuration.SharedMemSize); // отправляем клиенту размер блока общей памяти для обмена данными
    LogDebug('Отправлен размер порции для передачи данных файла: '+IntToStr(Int64(Configuration.SharedMemSize))+'.');
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILENAME, 0); // требуем от клиента имя файла
    LogDebug('Отправлен запрос на имя передаваемого файла.');
  end;

  procedure Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
  begin
    LogWarning('Получено уведомление об отмене передачи файла клиентом.');
    FReceiving:=False;
    pbMain.Visible:=False;
    FreeAndNil(FChunkedFile); // удаляем объект доступа к порционному файлу
    LogDebug('Объект доступа к порционному файлу уничтоден.');
    FreeAndNil(FSharedMem); // удаляем текущий объект доступа к общей памяти
    LogDebug('Объект доступа к общей памяти уничтоден.');
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILENAME(const dwSize: cardinal);
  begin
    LogDebug('Получено уведомление о передаче клиентом имени файла.');

    LogDebug('Размер имени передаваемого клиентом файла в байтах: '+IntToStr(Int64(dwSize))+'.');
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug('Создан объект порции данных.');
      end;
    try
      FSharedMem.Mapped:=True;
      FSharedMem.Read(dwSize, FChunk);
      FSharedMem.Mapped:=False;
      FFilename:=StringOf(FChunk.Data);
    finally
      FreeAndNil(FChunk);
      LogDebug('Объект порции данных уничтожен.');
    end;
    LogInfo('Получено имя передаваемого клиентом файла: ['+FFileName+']');

    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILESIZE, 0); // требуем от клиента размер файла
    LogDebug('Отправлен запрос на размер передаваемого файла.');
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILESIZE(const dwSize: cardinal);
  var
    aSize: Int64;
    s: string;
  begin
    LogDebug('Получен размер строки передаваемого клиентом размера файла в байтах: ['+IntToStr(Int64(dwSize))+'].');

    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug('Создан объект порции данных.');
      end;
    try
      FSharedMem.Mapped:=True;
      FSharedMem.Read(dwSize, FChunk);
      FSharedMem.Mapped:=False;
      s:=StringOf(FChunk.Data);
      LogDebug('Строка размера файла в байтах: '+s+'.');
      aSize:=StrToInt64Def(s, -1);
    finally
      FreeAndNil(FChunk);
      LogDebug('Объект порции данных уничтожен.');
    end;
    LogInfo('Размер файла в байтах: '+IntToStr(aSize)+'.');

    if not Assigned(FChunkedFile) then
      begin
        FChunkedFile:=TChunkedFileClass.Create(Configuration.DestinationFolder+FFilename, Configuration.SharedMemSize, aSize);
        pbMain.Max:=FChunkedFile.Count;
        pbMain.Position:=pbMain.Min;
        pbMain.Visible:=True;
        LogDebug('Создан объект доступа к порционному файлу.');
        LogInfo('Начат приём данных файла.');
        PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, FChunkedFile.Index); // требуем от клиента указанный блок файла
        LogDebug('Отправлен запрос на получение очередной порции данных.');
      end
    else
      raise Exception.Create('Объект порционного файла уже был ранее создан!');
  end;

  procedure Do_WPARAM_CLIENT_SENDS_DATA(const dwSize: cardinal);
  begin
    LogDebug('Получено уведомление о передаче клиентом порции данных файла.');

    LogDebug('Размер порции данных передаваемого клиентом файла в байтах: '+IntToStr(Int64(dwSize))+'.');
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug('Создан объект порции данных.');
      end;
    FSharedMem.Mapped:=True;
    FSharedMem.Read(dwSize, FChunk);
    FSharedMem.Mapped:=False;

    // данные остались в объекте порции данных
    // теперь требуем CRC32 блока
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_CRC32, FChunkedFile.Index); // требуем от клиента CRC32 указанной порции данных файла
    LogDebug('Отправлен запрос на получение контрольной суммы очередной порции данных.');
  end;

  procedure Do_WPARAM_CLIENT_SENDS_CRC32(const dwCRC32: cardinal);
  begin
    LogDebug('Получена контрольная сумма переданной клиентом порции данных файла.');

    LogDebug('Контрольная сумма переданной клиентом порции данных файла: '+IntToHex(dwCRC32, 8)+'.');
    // проводим сверку полученной контрольной суммы и контрольной суммы ранее полученной порции данных файла
    if FChunk.CRC32=dwCRC32 then
      begin
        LogDebug('Контрольная сумма порции данных совпала.');
        // контрольная сумма совпала, можно записывать данные в файл
        FChunkedFile.Write(FChunk);
        // проверка, была ли получена последняя порция данных файла
        FChunkedFile.Index:=FChunkedFile.Index+1;
        if FChunkedFile.Index<FChunkedFile.Count then
          begin
            pbMain.StepBy(1);
            // нужно запросить следующую порцию данных
            PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, FChunkedFile.Index); // требуем от клиента указанный блок файла
            LogDebug('Отправлен запрос на получение очередной порции данных.');
          end
        else
          begin
            // последняя порция данных, можно уведомить клиент об успешной передаче данных и закрыть файл
            try
              try
                LogInfo('Окончен приём данных файла.');
                FChunkedFile.Complete:=True;

                PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_TRANSFER_COMPLETE, 0); // уведомляем клиент об успешном окончании передачи файла
                LogDebug('Отправлено уведомление об успешной передаче файла.');

                LogInfo('Файл успешно принят.');
              except
                on E: Exception do
                  begin
                    FReceiving:=False;

                    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_TRANSFER_ERROR, 0); // уведомляем клиент об ошибке при передаче файла
                    LogDebug('Отправлено уведомление об ошибке при передаче файла.');

                    LogError(E.Message);
                    LogWarning('Файл не был принят!');
                  end;
              end;
            finally
              pbMain.Visible:=False;
              Application.ProcessMessages;

              FreeAndNil(FChunkedFile); // удаляем объект доступа к порционному файлу
              LogDebug('Объект доступа к порционному файлу уничтоден.');

              FreeAndNil(FSharedMem); // удаляем текущий объект доступа к общей памяти
              LogDebug('Объект доступа к общей памяти уничтоден.');

              if Configuration.PlaySoundOnComplete then
                Do_PlaySound;
            end;
          end;
      end
    else
      begin
        // контрольная сумма не совпала, требуется повторно получить порцию данных файла
        LogError('Контрольная сумма порции данных номер '+IntToStr(FChunkedFile.Index)+' не совпала!');
        LogInfo('Проводим повторное получение порции данных номер '+IntToStr(FChunkedFile.Index)+'.');
        PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, FChunkedFile.Index); // требуем от клиента указанный блок файла
        LogDebug('Отправлен запрос на повторное получение порции данных.');
      end;
  end;

begin
  inherited;
  if message.Msg=WM_CLIENT then
    begin
      if message.WParam=WPARAM_CLIENT_SHUTDOWN then // клиент сообщает о своём отключении от сервера
        Do_WPARAM_CLIENT_SHUTDOWN
      else
        if FClientConnected then
          case message.WParam of
            WPARAM_CLIENT_WANNA_SEND_FILE: // клиент хочет послать очередной файл
              Do_WPARAM_CLIENT_WANNA_SEND_FILE;
            WPARAM_CLIENT_SENDS_FILENAME: // клиент отправляет имя файла (LPARAM = размер имени файла в байтах)
              Do_WPARAM_CLIENT_SENDS_FILENAME(message.LParam);
            WPARAM_CLIENT_SENDS_FILESIZE: // клиент отправляет размер файла (LPARAM = размер символьного представления размера файла в байтах)
              Do_WPARAM_CLIENT_SENDS_FILESIZE(message.LParam);
            WPARAM_CLIENT_SENDS_DATA: // клиент отправляет указанный блок данных (LPARAM = размер переданных данных в байтах)
              Do_WPARAM_CLIENT_SENDS_DATA(message.LParam);
            WPARAM_CLIENT_SENDS_CRC32: // клиент отправляет контрольную сумму указанного блока данных (LPARAM = СКС32)
              Do_WPARAM_CLIENT_SENDS_CRC32(message.LParam);
            WPARAM_CLIENT_WANNA_CANCEL_SENDING: // клиент хочет прекратить передачу файла
              Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
            WPARAM_CLIENT_LOST: // поток-сторож сообщает о том, что окно клиента неожиданно пропало
              Do_WPARAM_CLIENT_LOST;
          end
        else
          if message.WParam=WPARAM_CLIENT_SENDS_HANDLE then // клиент отправляет свой handle (LPARAM = handle клиента)
            Do_WPARAM_CLIENT_SENDS_HANDLE(message.LParam);
    end;
end;

procedure TMainForm.chkbxScrollLogToBottomClick(Sender: TObject);
begin
  Configuration.ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
  LogInfo('Прокурутка к последнему сообщению протокола '+CommonFunctions.GetConditionalString(Configuration.ScrollLogToBottom, 'в', 'от')+'ключена.');
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  ICON_MAIN=3;
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

begin
  FFirstRun:=True; // режим начала запуска программы включен
  FClientConnected:=False; // изначально клиент не подлючен
  FReceiving:=False; // режим передачи данных выключен
  Caption:=TEXT_MAINFORM_CAPTION; // установка заголовка окна
  ilMainFormSmallImages.GetIcon(ICON_MAIN, Icon); // установка иконки окна
  FConfiguration:=TConfigurationClass.Create; // создание и инициализщация объекта конфигурации
  BindMainProgressBarToStatusBar;
  BindStateImageToStatusBar;
  Refresh_ConnectionState;
  Application.OnHint:=ApplicationOnHint;
  Do_LoadConfiguration; // загрузка настроек из файла
  Do_ApplyConfiguration; // применение настроек к интерфейсу
  Configuration.SharedMemoryName:='{6579B61D-DA05-480A-A29B-B0998A354860}';
end;

end.
