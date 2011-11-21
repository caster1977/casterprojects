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
  uRetranslatorThreadClass;

resourcestring
  TEXT_MAINFORM_CAPTION='Shared Memory Server';
  TEXT_ABOUTFORM_CAPTION='About "Shared Memory Server"...';

type
  Taob=array of Byte;

  THackControl=class(TControl);

  TFileProperties=class
  strict private
    FFileName: string;
    FDataBlocksQuantity: cardinal;
    FFileStream: TFileStream;
    FCurrentDataBlockNumber: cardinal;
    FCurrentDataBlockSize: cardinal;
    FCurrentDataBlockData: Taob;
    procedure SetCurrentDataBlockData(const Value: Taob);
    procedure SetCurrentDataBlockNumber(const Value: cardinal);
    procedure SetCurrentDataBlockSize(const Value: cardinal);
    procedure SetFDataBlocksQuantity(const Value: cardinal);
    procedure SetFileName(const Value: string);
    procedure SetFileStream(const Value: TFileStream);
  protected
    property FileName: string read FFileName write SetFileName stored False;
    property DataBlocksQuantity: cardinal read FDataBlocksQuantity write SetFDataBlocksQuantity stored False;
    property FileStream: TFileStream read FFileStream write SetFileStream stored False;
    property CurrentDataBlockNumber: cardinal read FCurrentDataBlockNumber write SetCurrentDataBlockNumber stored False;
    property CurrentDataBlockSize: cardinal read FCurrentDataBlockSize write SetCurrentDataBlockSize stored False;
    property CurrentDataBlockData: Taob read FCurrentDataBlockData write SetCurrentDataBlockData stored False;
  public
    constructor Create(const sFileName: string='');
    destructor Destroy; override;
  end;

  TMainForm=class(TForm)
    MainMenu1: TMainMenu;
    ActionManager1: TActionManager;
    ImageList1: TImageList;
    Action_Quit: TAction;
    Action_About: TAction;
    Action_Configuration: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    pbMain: TProgressBar;
    imState: TImage;
    ilMainFormStateIcons: TImageList;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
  strict private
    FConfiguration: TConfiguration;
    FFileProperties: TFileProperties;
    bFirstRun: boolean;
    iBusyCounter: integer;
    bAboutWindowExist: boolean;

    WM_SERVER, WM_CLIENT: cardinal;
    ConnectionThread: TRetranslatorThread;
    bClientConnected: boolean;
    hClientHandle: THandle;
    hSharedMemory: THandle;
    PMapView: pointer;
    bCanceling: boolean;

    FDataFile: file of byte;
    procedure ProcedureHeader;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure ProcedureFooter;
    procedure PreShowModal(var aOldBusyState: integer);
    procedure PostShowModal(var aOldBusyState: integer);
    procedure Refresh_BusyState;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);

    procedure Do_LoadConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Configuration;

    function Do_RegisterWindowMessages: boolean;
    function Do_ConnectionThreadStart: boolean;
    function Do_CreateSharedFile: boolean;
    function Do_CloseSharedFile: boolean;
    function Do_MapSharedFile: boolean;
    function Do_UnMapSharedFile: boolean;
    procedure SetConfiguration(const Value: TConfiguration);
    procedure SetFileProperties(const Value: TFileProperties);
    procedure Do_TerminateConnectionThread;
  protected
    property Configuration: TConfiguration read FConfiguration write SetConfiguration stored False;
    property CurrentFileProperties: TFileProperties read FFileProperties write SetFileProperties stored False;
  public
    procedure Inc_BusyState;
    procedure Dec_BusyState;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.IniFiles,
  Winapi.CommCtrl,
  uCommon,
  uAboutForm,
  uConfigurationForm;

{ TFileProperties }

constructor TFileProperties.Create(const sFileName: string='');
begin
  inherited Create;
  FFileName:=Trim(sFileName);
  FDataBlocksQuantity:=0;
  FFileStream:=nil;
  FCurrentDataBlockNumber:=0;
  FCurrentDataBlockSize:=0;
  FCurrentDataBlockData:=nil;
end;

destructor TFileProperties.Destroy;
begin
  FreeAndNil(FFileStream);
  if Assigned(FCurrentDataBlockData) then
    SetLength(FCurrentDataBlockData, 0);
  FreeAndNil(FCurrentDataBlockData);
  inherited;
end;

procedure TFileProperties.SetCurrentDataBlockData(const Value: Taob);
begin
  if FCurrentDataBlockData<>Value then

    FCurrentDataBlockData:=Value;
end;

procedure TFileProperties.SetCurrentDataBlockNumber(const Value: cardinal);
begin
  if FCurrentDataBlockNumber<>Value then
    FCurrentDataBlockNumber:=Value;
end;

procedure TFileProperties.SetCurrentDataBlockSize(const Value: cardinal);
begin
  if FCurrentDataBlockSize<>Value then
    FCurrentDataBlockSize:=Value;
end;

procedure TFileProperties.SetFDataBlocksQuantity(const Value: cardinal);
begin
  if FDataBlocksQuantity<>Value then
    FDataBlocksQuantity:=Value;
end;

procedure TFileProperties.SetFileName(const Value: string);
begin
  if FFileName<>Value then
    FFileName:=Value;
end;

procedure TFileProperties.SetFileStream(const Value: TFileStream);
begin
  if FFileStream<>Value then
    FFileStream:=Value;
end;

procedure TMainForm.ProcedureHeader;
begin
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TMainForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TMainForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(var aOldBusyState: integer);
begin
  with MainForm do
    begin
      aOldBusyState:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState; // обновление состояния индикатора
    end;
end;

procedure TMainForm.PostShowModal(var aOldBusyState: integer);
begin
  with MainForm do
    begin
      iBusyCounter:=aOldBusyState; // возвращение старого значения счётчика
      Refresh_BusyState; // обновление состояния индикатора
    end;
end;

procedure TMainForm.Inc_BusyState;
begin
  with MainForm do
    begin
      iBusyCounter:=iBusyCounter+1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState;
    end;
end;

procedure TMainForm.Dec_BusyState;
begin
  with MainForm do
    begin
      iBusyCounter:=iBusyCounter-1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState;
    end;
end;

procedure TMainForm.Refresh_BusyState;
begin
  with MainForm do
    begin
      if iBusyCounter>0 then
        ilMainFormStateIcons.GetIcon(ICON_BUSY, imState.Picture.Icon)
      else
        ilMainFormStateIcons.GetIcon(ICON_READY, imState.Picture.Icon);
      StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=TCommonFunctions.GetConditionalString(iBusyCounter>0, 'Пожалуйста, подождите...', 'Готово');
    end;
  Application.ProcessMessages;
end;

procedure TMainForm.SetConfiguration(const Value: TConfiguration);
begin
  if FConfiguration<>Value then
    FConfiguration:=Value;
end;

procedure TMainForm.SetFileProperties(const Value: TFileProperties);
begin
  if FFileProperties<>Value then
    FFileProperties:=Value;
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);
var
  iOldBusyCounter: integer;
begin
  iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState; // обновление состояния индикатора

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(TEXT_MAINFORM_CAPTION+' - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
  Refresh_BusyState; // обновление состояния индикатора
  Application.ProcessMessages;
end;

procedure TMainForm.Do_LoadConfiguration;
var
  bError: boolean;
  sErrorMessage: string;
begin
  if not bFirstRun then
    begin
      ProcedureHeader;
      bError:=False;
    end;
  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Load;
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    if not bFirstRun then
      TCommonFunctions.GenerateError('Произошла ошибка при попытке чтения настроек программы из файла!', sErrorMessage, bError);
    Application.HandleException(Self);
  end;
  if not bFirstRun then
    begin
      PreFooter(Handle, bError, sErrorMessage);
      ProcedureFooter;
    end;
end;

procedure TMainForm.Do_SaveConfiguration;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader;
  bError:=False;

  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Save;
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    on E: EIniFileException do
      begin
        TCommonFunctions.GenerateError(E.Message, sErrorMessage, bError);
        if MessageBox(Handle, PWideChar('Вы желаете повторить попытку записи настроек программы в файл?'), PWideChar(MainForm.Caption+' - Предупреждение'), MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON1)=IDOK then
          try
            Screen.Cursor:=crHourGlass;
            try
              Configuration.Save;
            except
              on E: EIniFileException do
                TCommonFunctions.GenerateError(E.Message, sErrorMessage, bError);
            end;
          finally
            Screen.Cursor:=crDefault;
          end;
      end;
    else
      Application.HandleException(Self);
  end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TMainForm.Do_TerminateConnectionThread;
begin
  if Assigned(ConnectionThread) then
    ConnectionThread.Terminate;
end;

procedure TMainForm.Do_About(const aButtonVisible: boolean);
var
  AboutForm: TAboutForm;
  iBusy: integer;
begin
  ProcedureHeader;
  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', PWideChar(TEXT_ABOUTFORM_CAPTION)))
  else
    begin
      AboutForm:=TAboutForm.Create(Self);
      with AboutForm do
        try
          bAboutWindowExist:=True;
          Caption:=TEXT_ABOUTFORM_CAPTION;
          lblTitle.Caption:=TEXT_MAINFORM_CAPTION;
          Action_Close.Visible:=aButtonVisible;
          PreShowModal(iBusy);
          ShowModal;
        finally
          PostShowModal(iBusy);
          Free;
          bAboutWindowExist:=False;
        end;
    end;
  ProcedureFooter;
end;

procedure TMainForm.Do_Configuration;
var
  ConfigurationForm: TConfigurationForm;
  iBusy: integer;
begin
  ProcedureHeader;
  ConfigurationForm:=TConfigurationForm.Create(Self);
  with ConfigurationForm do
    try
      PreShowModal(iBusy);
      ShowModal;
    finally
      PostShowModal(iBusy);
      Free;
    end;
  ProcedureFooter;
end;

function TMainForm.Do_ConnectionThreadStart: boolean;
begin
  ProcedureHeader;
  Result:=False;
  // запуск потока, рассылающего широковещательное сообщение клиентам
  if not Assigned(ConnectionThread) then
    begin
      ConnectionThread:=TRetranslatorThread.Create(WM_SERVER, WPARAM_SERVER_WANNA_HANDLE, Handle);
      try
        ConnectionThread.Start;
        Result:=True;
      except
        on E: Exception do
          ShowErrorBox(Handle, E.Message);
      end;
    end;
  ProcedureFooter;
end;

function TMainForm.Do_RegisterWindowMessages: boolean;
begin
  ProcedureHeader;
  Result:=False;
  try
    WM_SERVER:=RegisterWindowMessage(PWideChar(TEXT_WM_SM_SERVER));
    if WM_SERVER=0 then
      raise Exception.Create(TEXT_REGISTERWINDOWMESSAGEERROR+TEXT_ERRORCODE+IntToStr(GetLastError));
    WM_CLIENT:=RegisterWindowMessage(PWideChar(TEXT_WM_SM_CLIENT));
    if WM_CLIENT=0 then
      raise Exception.Create(TEXT_REGISTERWINDOWMESSAGEERROR+TEXT_ERRORCODE+IntToStr(GetLastError));
    Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
  ProcedureFooter;
end;

function TMainForm.Do_CreateSharedFile: boolean;
begin
  ProcedureHeader;
  Result:=False;
  // hSharedMemory:=CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, Configuration.DataBlockSize, PWideChar(Configuration.SharedMemoryName));
  hSharedMemory:=CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, Configuration.DataBlockSize, PWideChar(WideString('{B72BE7F9-4D0A-412F-A4FE-D6C47C35E9C9}')));
  try
    if hSharedMemory=NULL then
      raise Exception.Create(TEXT_ERROR_CREATEFILEMAPPING+TEXT_ERRORCODE+IntToStr(GetLastError))
    else
      if GetLastError=ERROR_ALREADY_EXISTS then
        raise Exception.Create(TEXT_ERROR_CREATEFILEMAPPING_ALREADYEXISTS+TEXT_ERRORCODE+IntToStr(GetLastError))
      else
        Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
  ProcedureFooter;
end;

function TMainForm.Do_CloseSharedFile: boolean;
begin
  ProcedureHeader;
  Result:=False;
  try
    if not CloseHandle(hSharedMemory) then
      raise Exception.Create(TEXT_ERROR_CLOSE_FILEMAPPING_HANDLE+TEXT_ERRORCODE+IntToStr(GetLastError))
    else
      Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
  ProcedureFooter;
end;

function TMainForm.Do_MapSharedFile: boolean;
begin
  ProcedureHeader;
  Result:=False;
  try
    PMapView:=MapViewOfFile(hSharedMemory, FILE_MAP_WRITE, 0, 0, 0);
    if not Assigned(PMapView) then
      raise Exception.Create(TEXT_ERROR_MAPVIEWOFFILE+TEXT_ERRORCODE+IntToStr(GetLastError))
    else
      Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
  ProcedureFooter;
end;

function TMainForm.Do_UnMapSharedFile: boolean;
begin
  ProcedureHeader;
  Result:=False;
  try
    if UnmapViewOfFile(PMapView) then
      raise Exception.Create(TEXT_ERROR_UNMAPVIEWOFFILE+TEXT_ERRORCODE+IntToStr(GetLastError))
    else
      Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
  ProcedureFooter;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ProcedureHeader;
  Do_SaveConfiguration; // запись конфигурации
  ProcedureFooter;
end;

procedure TMainForm.FormCreate(Sender: TObject);
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
    THackControl(imState).SetParent(StatusBar1);
    SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
    imState.SetBounds(PanelRect.Left+2, PanelRect.Top+1, PanelRect.Right-PanelRect.Left-4, PanelRect.Bottom-PanelRect.Top-4);
  end;

begin
  bFirstRun:=True;
  bClientConnected:=False;
  bCanceling:=False;
  Caption:=TEXT_MAINFORM_CAPTION;
  // создание и инициализщация объекта конфигурации
  FConfiguration:=TConfiguration.Create;
  // обновление переменной текущего открытого файла
  FFileProperties:=TFileProperties.Create;
  // привязка прогрессбара к позиции на строке статуса
  BindMainProgressBarToStatusBar;
  // привязка иконки готовности к позиции на строке статуса
  BindStateImageToStatusBar;
  // загрузка настроек из файла
  Do_LoadConfiguration;

  if not Do_CreateSharedFile then
    Application.Terminate;
  { TODO : дописать }
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
{$I-}
  CloseFile(FDataFile);
{$I+}
  Do_TerminateConnectionThread;
  Do_CloseSharedFile;
  FreeAndNil(FFileProperties);
  FreeAndNil(FConfiguration);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ProcedureHeader;

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
      // Do_About(False); // отображение окна "О программе"

      // регистрация оконных сообщений
      if not Do_RegisterWindowMessages then
        Application.Terminate;

      if not Do_ConnectionThreadStart then
        Application.Terminate;

      { TODO : дописать }
    end;
  Refresh_BusyState;

  ProcedureFooter;
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
begin
  ProcedureHeader;
  Do_About(True);
  ProcedureFooter;
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
begin
  ProcedureHeader;
  Do_Configuration;
  ProcedureFooter;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  ProcedureHeader;
  Close;
  ProcedureFooter;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

  procedure Do_WPARAM_CLIENT_SENDS_HANDLE(const Handle: THandle);
  begin
    Do_TerminateConnectionThread; // останов потока, рассылающего хэндл сервера
    hClientHandle:=Handle; // получаем хэндл клиента
    bClientConnected:=True; // устанавливаем флаш соединения
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SHUTDOWN;
  begin
    bClientConnected:=False; // убираем флаш соединения
    if not Do_ConnectionThreadStart then // запуск потока рассылки хэндла сервера
      Application.Terminate;
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_WANNA_SEND_FILE;
  begin
    bCanceling:=False;
    PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_SENDS_BUFFER_SIZE, Configuration.DataBlockSize); // отправляем клиенту размер блока общей памяти для обмена данными
    PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILENAME, 0); // требуем от клиента имя файла
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
  begin
    bCanceling:=True;
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY(const dwDataBlocksQuantity: cardinal);
  begin
    // сохраняем количество блоков в файле
    CurrentFileProperties.DataBlocksQuantity:=dwDataBlocksQuantity;
    // требуем первый блок данных файла
    CurrentFileProperties.CurrentDataBlockNumber:=1;
    PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, CurrentFileProperties.CurrentDataBlockNumber); // требуем от клиента указанный блок файла
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILENAME(const dwSize: cardinal);
  var
    s: string;
  begin
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
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_DATA(const dwSize: cardinal);
  var
    ab: Taob;
  begin
    // сохраняем размер переданных данных в байтах
    CurrentFileProperties.CurrentDataBlockSize:=dwSize;
    // копируем данные блока в массив
    SetLength(ab, CurrentFileProperties.CurrentDataBlockSize);
    CopyMemory(@ab[0], PMapView, CurrentFileProperties.CurrentDataBlockSize);
    CurrentFileProperties.CurrentDataBlockData:=ab;
    // требуем CRC32 переданного блока данных
    PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_CRC32, CurrentFileProperties.CurrentDataBlockNumber); // требуем от клиента CRC32 указанного блока файла
    { TODO : дописать }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_CRC32(const dwSize: cardinal);
  begin
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
    { TODO : дописать }
  end;

begin
  Handled:=False;
  if Msg.message=WM_CLIENT then
    begin
      if Msg.wParam=WPARAM_CLIENT_SHUTDOWN then // клиент сообщает о своём отключении от сервера
        Do_WPARAM_CLIENT_SHUTDOWN
      else
        if bClientConnected then
          case Msg.wParam of
            WPARAM_CLIENT_WANNA_SEND_FILE: // клиент хочет послать очередной файл
              Do_WPARAM_CLIENT_WANNA_SEND_FILE;
            WPARAM_CLIENT_WANNA_CANCEL_SENDING: // клиент хочет прекратить передачу файла
              Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
            WPARAM_CLIENT_SENDS_FILENAME: // клиент отправляет имя файла (LPARAM = размер имени файла в байтах)
              Do_WPARAM_CLIENT_SENDS_FILENAME(Msg.lParam);
            WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY: // клиент отправляет количество блоков в файле (LPARAM = количество блоков в файле)
              Do_WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY(Msg.lParam);
            WPARAM_CLIENT_SENDS_DATA: // клиент отправляет указанный блок данных (LPARAM = размер переданных данных в байтах)
              Do_WPARAM_CLIENT_SENDS_DATA(Msg.lParam);
            WPARAM_CLIENT_SENDS_CRC32: // клиент отправляет контрольную сумму указанного блока данных (LPARAM = размер строки СКС32 в байтах)
              Do_WPARAM_CLIENT_SENDS_CRC32(Msg.lParam);
          end
        else
          if Msg.wParam=WPARAM_CLIENT_SENDS_HANDLE then // клиент отправляет свой handle (LPARAM = handle клиента)
            Do_WPARAM_CLIENT_SENDS_HANDLE(Msg.lParam);
      Handled:=True;
    end;
end;

{
  // var
  // lpData: Pointer;
  // lLineSize, ltemp: Integer;
  // lpBuffer: array of Byte;
  // FileName: WideString;

  // var
  // ffile: THandle;
  // ffileMapObj: THandle;
  // lpBaseAdd: PChar;
  // str: string;

  // ffile := CreateFile('C:\ffile.txt', GENERIC_ALL, FILE_SHARE_WRITE, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
  ffile:=CreateFile('ffile.txt', GENERIC_ALL, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (ffile=INVALID_HANDLE_VALUE) then
  ShowMessage('C:\pzdc!');
  Edit1.Text:=IntToStr(ffile);
  Edit2.Text:=IntToStr(DWORD(-1)); // посмотрел код ошибки

  ffileMapObj:=CreateFileMapping(ffile, // Ссылка на файл
  nil, // указатель на запись типа TSecurityAttributes
  PAGE_READWRITE, // способ совместного использования создаваемого объекта
  0, // старший разряд 64-битного значения размера выделяемого объема памяти для совместного доступа
  1, // размер файла подкачки
  'MySharedValue' // имя объекта файлового отображения
  );

  if (ffileMapObj<>0) then
  ShowMessage('Операция создания Swap-файла удалась');

  lpBaseAdd:=MapViewOfFile(ffileMapObj, FILE_MAP_WRITE, 0, 0, 0);

  if (lpBaseAdd=nil) then
  ShowMessage('Не могу подключить FileMapping!');
  SetLength(Str, 12);
  CopyMemory(Pointer(Str), lbBaseAdd, 12);
  Memo1.Lines.Add(str); // по идее тут я в мемо должен получить кусок своего текстового файла, но этого не происходит
}
end.
