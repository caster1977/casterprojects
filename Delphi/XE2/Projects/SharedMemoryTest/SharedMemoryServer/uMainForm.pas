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
  uCommon;

type
  THackControl=class(TControl);

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
    ApplicationEvents1: TApplicationEvents;
    ilLog: TImageList;
    Panel1: TPanel;
    chkbxScrollLogToBottom: TCheckBox;
    lvLog: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure ApplicationEvents1Hint(Sender: TObject);
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

    FFirstRun: boolean;
    FClientConnected: boolean;
    FClientHandle: THandle;
    FCanceling: boolean;

    procedure ProcessErrors(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
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
    procedure SetConfiguration(const Value: TConfigurationClass);
    procedure Do_TerminateConnectionThread;
    procedure Log(const aMessage: string; aMessageType: TLogMessagesType);
    procedure Do_UpdateColumnWidth;
  public
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
  uAboutForm,
  uConfigurationForm;

resourcestring
  TEXT_MAINFORM_CAPTION='Shared Memory Server';
  TEXT_ABOUTFORM_CAPTION='About "Shared Memory Server"...';

const
  ICON_BUSY=0;
  ICON_READY=1;

  ICON_ERROR=0;
  ICON_WARNING=1;
  ICON_INFO=2;
  ICON_DEBUG=3;

var
  WM_SERVER, WM_CLIENT: cardinal;

procedure TMainForm.ProcessErrors(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    begin
      LogError(aErrorMessage);
      ShowErrorBox(aHandle, aErrorMessage);
    end;
  pbMain.Position:=pbMain.Min;
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

procedure TMainForm.Do_TerminateConnectionThread;
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
begin
  // применение настроек к панели статуса
  miStatusbar.Checked:=Configuration.ShowStatusbar;
  StatusBar1.Visible:=Configuration.ShowStatusbar;
  // применение настроек к прокрутке сообщений протокола
  chkbxScrollLogToBottom.Checked:=chkbxScrollLogToBottom.Enabled and Configuration.ScrollLogToBottom;
  chkbxScrollLogToBottom.OnClick:=chkbxScrollLogToBottomClick;

  LogInfo('Применение настроек программы прошло успешно.');
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
begin
  Do_SaveConfiguration; // запись конфигурации
  if FClientConnected then // если соединение с клиентом установлено, отправляем клиенту уведомление о завершении работы сервера
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_SHUTDOWN, 0);
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
  FCanceling:=False; // режим отмены передачи выключен
  Caption:=TEXT_MAINFORM_CAPTION; // установка заголовка окна
  ilMainFormSmallImages.GetIcon(ICON_MAIN, Icon); // установка иконки окна
  FConfiguration:=TConfigurationClass.Create; // создание и инициализщация объекта конфигурации
  BindMainProgressBarToStatusBar; // привязка прогрессбара к позиции на строке статуса
  BindStateImageToStatusBar; // привязка иконки готовности к позиции на строке статуса
  Refresh_ConnectionState;
  Do_LoadConfiguration; // загрузка настроек из файла
  Do_ApplyConfiguration; // применение настроек к интерфейсу
  Configuration.SharedMemoryName:='{6579B61D-DA05-480A-A29B-B0998A354860}';
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Do_TerminateConnectionThread;
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

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  if Configuration.ShowStatusbar then
    StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

  procedure Do_WPARAM_CLIENT_SENDS_HANDLE(const Handle: THandle);
  begin
    LogInfo('Получен ответ клиента на широковещательное сообщение.');

    LogInfo('Соединение с клиентом установлено.');
    Do_TerminateConnectionThread; // останавливаем поток, рассылающий хэндл сервера
    FClientHandle:=Handle; // получаем хэндл клиента
    LogDebug('Получен Handle окна клиентского приложения: '+IntToStr(Handle)+'.');
    FClientConnected:=True; // устанавливаем флаш соединения
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_ACCEPT_CLIENT, 0); // отправляет клиенту подтверждение подключения
    LogDebug('Отправлено уведомление об успешном подключении.');
    Refresh_ConnectionState;
  end;

  procedure Do_WPARAM_CLIENT_SHUTDOWN;
  begin
    LogWarning('Получено уведомление о завершении работы клиента.');

    FClientConnected:=False; // убираем флаш соединения
    FClientHandle:=0; // обнуляем хэндл клиента
    LogDebug('Handle окна клиентского приложения обнулён.');
    FreeAndNil(FSharedMem); // удаляем объект доступа к общей памяти
    LogDebug('Объект доступа к общей памяти уничтоден.');
    if not Do_ConnectionThreadStart then // запускаем поток рассылки хэндла сервера
      Application.Terminate;
    Refresh_ConnectionState;
    LogInfo('Соединение с клиентом прервано.');
  end;

  procedure Do_WPARAM_CLIENT_WANNA_SEND_FILE;
  begin
    LogInfo('Получено уведомление о попытке передачи файла клиентом.');

    FCanceling:=False;
    FSharedMem:=TSharedMemClass.Create(Configuration.SharedMemoryName, Configuration.DataBlockSize);
    LogDebug('Создан объект доступа к общей памяти.');
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_SENDS_SHAREDMEM_SIZE, Configuration.DataBlockSize); // отправляем клиенту размер блока общей памяти для обмена данными
    LogDebug('Отправлен размер порции для передачи данных файла: '+IntToStr(Int64(Configuration.DataBlockSize))+'.');
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILENAME, 0); // требуем от клиента имя файла
    LogDebug('Отправлен запрос на имя передаваемого файла.');
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILESIZE, 0); // требуем от клиента размер файла
    LogDebug('Отправлен запрос на размер передаваемого файла.');
  end;

  procedure Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
  begin
    LogWarning('Получено уведомление об отмене передачи файла клиентом.');
    FCanceling:=True;
    FreeAndNil(FSharedMem); // удаляем текущий объект доступа к общей памяти
    LogDebug('Объект доступа к общей памяти уничтоден.');
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILESIZE(const dwSize: cardinal);
  begin
    LogInfo('Получен размер передаваемого клиентом файла в байтах.');
    LogDebug('Hазмер файла в байтах: '+IntToStr(Int64(dwSize))+'.');

    {
      // сохраняем количество блоков в файле
      CurrentFileProperties.DataBlocksQuantity:=dwDataBlocksQuantity;
      // требуем первый блок данных файла
      CurrentFileProperties.CurrentDataBlockNumber:=1;
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, CurrentFileProperties.CurrentDataBlockNumber); // требуем от клиента указанный блок файла
    }
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILENAME(const dwSize: cardinal);
  {
    var
    s: string;
  }
  begin
    LogInfo('Получено имя передаваемого клиентом файла.');

    LogDebug('Размер имени передаваемого клиентом файла в байтах: '+IntToStr(Int64(dwSize))+'.');
    (*
      // пролучаем строку имени файла
      SetLength(s, dwSize);
      CopyMemory(@s, PMapView, dwSize);
      CurrentFileProperties.FileName:=s;
      // создаём файл на диске в указанной в настройках программы папке
      AssignFile(FDataFile, Configuration.DestinationFolder+CurrentFileProperties.FileName);
      try
      Rewrite(FDataFile);
      // запрашиваем количество блоков в файле
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_BLOCKS_QUANTITY, 0); // требуем от клиента количество блоков в файле
      except
      on E: EInOutError do
      begin
      CloseFile(FDataFile);
      ShowErrorBox(Handle, TEXT_ERROR_CREATEFILE+TEXT_ERRORCODE+IntToStr(GetLastError) { +E.Message } );
      end;
      end;
    *)
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_DATA(const dwSize: cardinal);
  {
    var
    ab: Taob;
  }
  begin
    LogInfo('Получено уведомление о передаче клиентом порции данных файла.');

    LogDebug('Размер порции данных передаваемого клиентом файла в байтах: '+IntToStr(Int64(dwSize))+'.');
    {
      // сохраняем размер переданных данных в байтах
      CurrentFileProperties.CurrentDataBlockSize:=dwSize;
      // копируем данные блока в массив
      SetLength(ab, CurrentFileProperties.CurrentDataBlockSize);
      CopyMemory(@ab[0], PMapView, CurrentFileProperties.CurrentDataBlockSize);
      CurrentFileProperties.CurrentDataBlockData:=ab;
      // требуем CRC32 переданного блока данных
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_CRC32, CurrentFileProperties.CurrentDataBlockNumber); // требуем от клиента CRC32 указанного блока файла
    }
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_CRC32(const dwCRC32: cardinal);
  begin
    LogInfo('Получена контрольная сумма переданной клиентом порции данных файла.');

    LogDebug('Контрольная сумма переданной клиентом порции данных файла: '+IntToHex(dwCRC32, 8)+'.');
    (*
      // получаем CRC32 указаного блока данных файла
      // производим сверку CRC32
      // если проверка прошла успешно, записываем данные в файл
      try
      BlockWrite(FDataFile, CurrentFileProperties.CurrentDataBlockData, CurrentFileProperties.CurrentDataBlockSize);
      // требуем от клиента следующий блок данных
      CurrentFileProperties.CurrentDataBlockNumber:=CurrentFileProperties.CurrentDataBlockNumber+1;
      if not bCanceling then // прерываем цикл передачи файла
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, CurrentFileProperties.CurrentDataBlockNumber)
      else
      begin
      bCanceling:=False;
      CurrentFileProperties.FileName:='';
      CloseFile(FDataFile);
      { TODO : добавить удаление недописанного файла с диска }
      end;
      except
      on E: EInOutError do
      begin
      CloseFile(FDataFile);
      ShowErrorBox(Handle, TEXT_ERROR_CREATEFILE+TEXT_ERRORCODE+IntToStr(GetLastError) { +E.Message } );
      end;
      end;
    *)
    { TODO : дописать }
  end;

begin
  Handled:=False;
  if Msg.message=WM_CLIENT then
    begin
      if Msg.wParam=WPARAM_CLIENT_SHUTDOWN then // клиент сообщает о своём отключении от сервера
        Do_WPARAM_CLIENT_SHUTDOWN
      else
        if FClientConnected then
          case Msg.wParam of
            WPARAM_CLIENT_WANNA_SEND_FILE: // клиент хочет послать очередной файл
              Do_WPARAM_CLIENT_WANNA_SEND_FILE;
            WPARAM_CLIENT_SENDS_FILENAME: // клиент отправляет имя файла (LPARAM = размер имени файла в байтах)
              Do_WPARAM_CLIENT_SENDS_FILENAME(Msg.lParam);
            WPARAM_CLIENT_SENDS_FILESIZE: // клиент отправляет размер файла (LPARAM = размер файла в байтах)
              Do_WPARAM_CLIENT_SENDS_FILESIZE(Msg.lParam);
            WPARAM_CLIENT_SENDS_DATA: // клиент отправляет указанный блок данных (LPARAM = размер переданных данных в байтах)
              Do_WPARAM_CLIENT_SENDS_DATA(Msg.lParam);
            WPARAM_CLIENT_SENDS_CRC32: // клиент отправляет контрольную сумму указанного блока данных (LPARAM = СКС32)
              Do_WPARAM_CLIENT_SENDS_CRC32(Msg.lParam);
            WPARAM_CLIENT_WANNA_CANCEL_SENDING: // клиент хочет прекратить передачу файла
              Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
          end
        else
          if Msg.wParam=WPARAM_CLIENT_SENDS_HANDLE then // клиент отправляет свой handle (LPARAM = handle клиента)
            Do_WPARAM_CLIENT_SENDS_HANDLE(Msg.lParam);
      Handled:=True;
    end;
end;

procedure TMainForm.chkbxScrollLogToBottomClick(Sender: TObject);
begin
  Configuration.ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
  LogInfo('Прокурутка к последнему сообщению протокола '+CommonFunctions.GetConditionalString(Configuration.ScrollLogToBottom, 'в', 'от')+'ключена.');
end;

end.
