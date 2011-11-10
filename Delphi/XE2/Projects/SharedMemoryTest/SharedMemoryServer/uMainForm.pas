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
  uConfigurationClass;

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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  strict private
    bFirstRun: boolean;
    iBusyCounter: integer;
    bAboutWindowExist: boolean;
    USER_WM_READDATA, USER_WM_WRITEDATA, USER_WM_DONE: cardinal;

    procedure ProcedureHeader;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure ProcedureFooter;
    procedure PreShowModal(var aOldBusyState: integer);
    procedure PostShowModal(var aOldBusyState: integer);
    procedure Inc_BusyState;
    procedure Dec_BusyState;
    procedure Refresh_BusyState;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);

    procedure Do_LoadConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Configuration;

    function Do_RegisterWindowMessages: boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    Configuration: TConfiguration;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.IniFiles,
  Winapi.CommCtrl,
  uCommon,
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
// var
// AboutForm: TAboutForm;
// iBusy: integer;
begin
  // ProcedureHeader;
  // if bAboutWindowExist then
  // SetForegroundWindow(FindWindow('TAboutForm', TEXT_ABOUTFORM_CAPTION))
  // else
  // begin
  // AboutForm:=TAboutForm.Create(Self);
  // with AboutForm do
  // try
  // bAboutWindowExist:=True;
  // Caption:=TEXT_ABOUTFORM_CAPTION;
  // Action_Close.Visible:=aButtonVisible;
  // PreShowModal(iBusy);
  // ShowModal;
  // finally
  // PostShowModal(iBusy);
  // Free;
  // bAboutWindowExist:=False;
  // end;
  // end;
  // ProcedureFooter;
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
resourcestring
  RegisterWindowErrorMessage='Не удалось выполнить операцию регистрации оконного сообщения! Код ошибки: ';
begin
  ProcedureHeader;
  try
    USER_WM_READDATA:=RegisterWindowMessage(PWideChar(TEXT_READDATA));
    if USER_WM_READDATA=0 then
      raise Exception.Create(RegisterWindowErrorMessage+IntToStr(GetLastError));
    USER_WM_WRITEDATA:=RegisterWindowMessage(PWideChar(TEXT_WRITEDATA));
    if USER_WM_WRITEDATA=0 then
      raise Exception.Create(RegisterWindowErrorMessage+IntToStr(GetLastError));
    USER_WM_DONE:=RegisterWindowMessage(PWideChar(TEXT_DONE));
    if USER_WM_DONE=0 then
      raise Exception.Create(RegisterWindowErrorMessage+IntToStr(GetLastError));
  except
    on E: Exception do
      MessageBox(Handle, PWideChar(E.Message), PWideChar(Caption+' - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  end;
  ProcedureFooter;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ProcedureHeader;

  // запись конфигурации
  Do_SaveConfiguration;

  ProcedureFooter;
end;

procedure TMainForm.FormCreate(Sender: TObject);
// var
// ffile: THandle;
// ffileMapObj: THandle;
// lpBaseAdd: PChar;
// str: string;
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
  Caption:=TEXT_MAINFORM_CAPTION;
  // создание и инициализщация объекта конфигурации
  Configuration:=TConfiguration.Create;
  // привязка прогрессбара к позиции на строке статуса
  BindMainProgressBarToStatusBar;
  // привязка иконки готовности к позиции на строке статуса
  BindStateImageToStatusBar;
  // загрузка настроек из файла
  Do_LoadConfiguration;

  { TODO : дописать }

  // // ffile := CreateFile('C:\ffile.txt', GENERIC_ALL, FILE_SHARE_WRITE, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
  // ffile:=CreateFile('ffile.txt', GENERIC_ALL, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  // if (ffile=INVALID_HANDLE_VALUE) then
  // ShowMessage('C:\pzdc!');
  // Edit1.Text:=IntToStr(ffile);
  // Edit2.Text:=IntToStr(DWORD(-1)); // посмотрел код ошибки
  // ffileMapObj:=CreateFileMapping(ffile, // Ссылка на файл
  // nil, // указатель на запись типа TSecurityAttributes
  // PAGE_READWRITE, // способ совместного использования создаваемого объекта
  // 0, // старший разряд 64-битного значения размера выделяемого объема памяти для совместного доступа
  // 1, // размер файла подкачки
  // 'MySharedValue' // имя объекта файлового отображения
  // );
  // if (ffileMapObj<>0) then
  // ShowMessage('Операция создания Swap-файла удалась');
  // lpBaseAdd:=MapViewOfFile(ffileMapObj, FILE_MAP_WRITE, 0, 0, 0);
  // if (lpBaseAdd=nil) then
  // ShowMessage('Не могу подключить FileMapping!');
  // SetLength(Str, 12);
  // CopyMemory(Pointer(Str), lbBaseAdd, 12);
  // Memo1.Lines.Add(str); // по идее тут я в мемо должен получить кусок своего текстового файла
  // этого не происходит
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Configuration.Free;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ProcedureHeader;

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
      if Do_RegisterWindowMessages then
        { TODO : дописать }
          ;
    end;
  Refresh_BusyState;

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

procedure TMainForm.WndProc(var Message: TMessage);
var
  lpData: Pointer;
  lLineSize, ltemp: Integer;
  lpBuffer: array of Byte;
begin
  inherited;
  if message.Msg=USER_WM_READDATA then;
  if message.Msg=USER_WM_WRITEDATA then;
  if message.Msg=USER_WM_DONE then;
  { TODO : дописать }

  try
    if message.Msg=FtWM_CLIENT_WRITE then
      begin
        isListened:=True;
        LogFile.Add(llTRACE, TEXT_WM_SERVER_READ);
        lpData:=MapViewOfFile(FhSharedMemory, FILE_MAP_READ, 0, 0, BlockSize);
        if lpData=nil then
          begin
            Exit;
            RaiseLastOSError;
          end;
        lLineSize:=message.WParam;
        LogFile.Add(llTRACE, TEXT_WRITE_SIZE_OF_INPUT+IntToStr(lLineSize));
        SetLength(lpBuffer, lLineSize);
        LogFile.Add(llTRACE, TEXT_READ_DATA_SHARED_MEMORY);
        CopyMemory(@lpBuffer[0], Pointer(Integer(lpData)+4), lLineSize);
        LogFile.Add(llTRACE, TEXT_SERVER_READ_BEG);
        BlockWrite(FFile, lpBuffer, lLineSize, ltemp);
        LogFile.Add(llTRACE, TEXT_SERVER_READ_END);
        UnmapViewOfFile(lpData);
        LogFile.Add(llTRACE, TEXT_SLEEP+FloatToStr(TransferFileTimeInterval/1000)+TEXT_SECOND);
        Sleep(TransferFileTimeInterval);
        LogFile.Add(llTRACE, TEXT_WM_SERVER_POST);
        PostMessage(HWND_BROADCAST, FtWM_SERVER_READ, 0, 0);
      end;
    if message.Msg=FtWM_EOF then
      begin
        CloseFile(FFile);
        LogFile.Add(llINFO, TEXT_FILE_TRANSFERAD);
      end;
  except
    on e: Exception do
      begin
        LogFile.Add(llERROR, TEXT_ERROR_PREFIX+e.Message);
      end;
  end;
end;

end.
