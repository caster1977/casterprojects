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
  uConfigurationClass,
  Vcl.AppEvnts,
  uRetranslatorThreadClass;

resourcestring
  TEXT_MAINFORM_CAPTION='Shared Memory Server';
  TEXT_ABOUTFORM_CAPTION='About "Shared Memory Server"...';

type
  THackControl=class(TControl);

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
    FDataFile: file of byte;
    bFirstRun: boolean;
    iBusyCounter: integer;
    bAboutWindowExist: boolean;
    WM_SERVER, WM_CLIENT: cardinal;
    ConnectionThread: TRetranslatorThread;
    bClientFounded: boolean;
    hClientHandle: THandle;
    hSharedMemory: THandle;
    PMapView: pointer;
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
    function Do_CreateSharedFile: boolean;
    function Do_CloseSharedFile: boolean;
    function Do_MapSharedFile: boolean;
    function Do_UnMapSharedFile: boolean;
  public
    Configuration: TConfiguration;
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
//  hSharedMemory:=CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, Configuration.DataBlockSize, PWideChar(Configuration.SharedMemoryName));
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
  bClientFounded:=False;
  Caption:=TEXT_MAINFORM_CAPTION;
  // создание и инициализщация объекта конфигурации
  Configuration:=TConfiguration.Create;
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
  Do_CloseSharedFile;
  Configuration.Free;
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

      // запуск потока, рассылающего широковещательное сообщение клиентам
      ConnectionThread:=TRetranslatorThread.Create(WM_SERVER, WPARAM_SERVER_SENDS_HANDLE, Handle);
      try
        ConnectionThread.Start;
      except
        on E: Exception do
          ShowErrorBox(Handle, E.Message);
      end;

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
// var
// lpData: Pointer;
// lLineSize, ltemp: Integer;
// lpBuffer: array of Byte;
// FileName: WideString;
begin
  Handled:=False;
  if Msg.message=WM_CLIENT then
    case Msg.wParam of
      WPARAM_CLIENT_SENDS_HANDLE: // сигнал серверу о том, что в LPARAM находится handle клиента
        begin
          // если клиент был найден и не был найден ранее
          if not bClientFounded then
            begin
              bClientFounded:=True;
              // останов поиска
              if ConnectionThread<>nil then
                ConnectionThread.Terminate;
              // получаем хэндл клиента
              hClientHandle:=Msg.lParam;
              // отправляем сигнал о том, что сервер готов к получению файла и указываем размер блока общей мапяти для передачи данных
              PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_READY, Configuration.DataBlockSize);
              { TODO : дописать }
            end;
          Handled:=True;
        end;
      WPARAM_CLIENT_SENDS_FILENAME: // сигнал серверу о том, что клиент записал имя файла в блок памяти и что в LPARAM находится длина имени файла в символах
        begin
          // если клиент был найден
          if not bClientFounded then
            begin
              // получаем имя передаваемого файла
              // создаём файл на диске
              { TODO : дописать }
            end;
          Handled:=True;
        end;
      WPARAM_CLIENT_SENDS_DATA: // сигнал серверу о том, что клиент начинает записывать данные в блок памяти и в LPARAM находится номер передаваемой части
        begin
          // ждём, пока клиент записывает чанк в общую память
          { TODO : возможно, стоит добавить вывод номера части, которую записываеит клиент? }
          { TODO : дописать }
          Handled:=True;
        end;
      WPARAM_CLIENT_SENDS_SIZE: // сигнал серверу о том, что клиент окончил записывать данные затребованного чанка в блок памяти и данные готовы для чтения и в LPARAM находится размер записанного в память блока данных в байтах
        begin
          { TODO : дописать }
          Handled:=True;
        end;
      WPARAM_CLIENT_SENDS_CRC32: // сигнал серверу о том, что в LPARAM находится контрольная сумма записанной части
        begin
          { TODO : дописать }
          Handled:=True;
        end;
      WPARAM_CLIENT_SENDS_EOF: // сигнал серверу о том, что был достигнут конец файла и можно "закрыть" файл
        begin
          CloseFile(FDataFile);
          { TODO : дописать }
          Handled:=True;
        end;
    end;
end;

{
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
