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
  uCommon;

type
  THackControl=class(TControl);

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
    ApplicationEvents1: TApplicationEvents;
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
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure Action_SendExecute(Sender: TObject);
    procedure Action_CancelExecute(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure chkbxScrollLogToBottomClick(Sender: TObject);
  strict private
    FDataBufferSize: cardinal;
    FFirstRun: boolean;
    FServerHandle: THandle;
    FConnectedToServer: boolean;
    FCanceling: boolean;

    /// <summary>
    /// Объект для хранения настроек программы
    /// </summary>
    FConfiguration: TConfigurationClass;

    procedure PreFooter(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
    procedure Refresh_ConnectionState;
    procedure ProcessErrors(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
    procedure ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);

    procedure Do_LoadConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_ApplyConfiguration;
    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Configuration;

    function Do_RegisterWindowMessages: boolean;
    procedure SetDataBufferSize(const Value: cardinal);
    procedure SetConfiguration(const Value: TConfigurationClass);
    procedure Log(const aMessage: string; aMessageType: TLogMessagesType);
    procedure Do_UpdateColumnWidth;
  protected
    property DataBufferSize: cardinal read FDataBufferSize write SetDataBufferSize stored False;
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
  Winapi.CommCtrl,
  System.IniFiles,
  uAboutForm,
  uConfigurationForm,
  System.IOUtils;

resourcestring
  TEXT_MAINFORM_CAPTION='Shared Memory Client';
  TEXT_ABOUTFORM_CAPTION='About "Shared Memory Client"...';

const
  ICON_BUSY=0;
  ICON_READY=1;

  ICON_ERROR=0;
  ICON_WARNING=1;
  ICON_INFO=2;
  ICON_DEBUG=3;

var
  WM_SERVER, WM_CLIENT: cardinal;

var
  Recipients: DWORD=BSM_APPLICATIONS;

procedure TMainForm.ProcessErrors(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    begin
      LogError(aErrorMessage);
      ShowErrorBox(aHandle, aErrorMessage);
    end;
  pbMain.Position:=pbMain.Min;
end;

procedure TMainForm.Do_About(const aButtonVisible: boolean);
var
  AboutForm: TAboutForm;
  iBusy: integer;
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
  iBusy: integer;
begin
  ConfigurationForm:=TConfigurationForm.Create(Self);
  with ConfigurationForm do
    try
      ShowModal;
    finally
      Free;
    end;
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
      LogInfo('Чтение настроек программы из файла прошло успешно.');
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
    Result:=True;
  except
    on E: Exception do
      ShowErrorBox(Handle, E.Message);
  end;
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

  PreFooter(Handle, bError, sErrorMessage);
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

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Do_SaveConfiguration; // запись конфигурации
  if FConnectedToServer then // если соединение с сервером установлено, отправляем серверу уведомление о завершении работы клиента
    PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SHUTDOWN, 0);
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

begin
  FFirstRun:=True; // режим начала запуска программы включен
  FConnectedToServer:=False; // изначально клиент не подлючен
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

procedure TMainForm.miStatusBarClick(Sender: TObject);
begin
  StatusBar1.Visible:=miStatusbar.Checked;
  Configuration.ShowStatusbar:=StatusBar1.Visible;
  LogInfo('Панель статуса '+CommonFunctions.GetConditionalString(StatusBar1.Visible, 'в', 'от')+'ключена.');
end;

procedure TMainForm.PreFooter(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TMainForm.Refresh_ConnectionState;
begin
  if FConnectedToServer then
    ilMainFormStateIcons.GetIcon(ICON_READY, imConnectionState.Picture.Icon)
  else
    ilMainFormStateIcons.GetIcon(ICON_BUSY, imConnectionState.Picture.Icon);
  LogDebug('Соединение '+CommonFunctions.GetConditionalString(FConnectedToServer, 'в', 'от')+'ключено.');
  Application.ProcessMessages;
end;

procedure TMainForm.ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);
begin
  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(TEXT_MAINFORM_CAPTION+' - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
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

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.Action_SendExecute(Sender: TObject);
begin
  btnSend_btnCancel.Action:=Action_Cancel;
  Action_Send.Visible:=False;
  Action_Send.Enabled:=False;
  Action_Cancel.Visible:=True;
  Action_Cancel.Enabled:=True;
  if FConnectedToServer then
    PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_WANNA_SEND_FILE, 0); // отправляем сигнал серверу о желании начать передачу файла
end;

procedure TMainForm.Action_CancelExecute(Sender: TObject);
begin
  btnSend_btnCancel.Action:=Action_Send;
  Action_Cancel.Visible:=False;
  Action_Cancel.Enabled:=False;
  Action_Send.Visible:=True;
  Action_Send.Enabled:=True;
  if FConnectedToServer then
    PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_WANNA_CANCEL_SENDING, 0); // отправляем сигнал серверу об отмене передачи файла
end;

procedure TMainForm.SetConfiguration(const Value: TConfigurationClass);
begin
  FConfiguration := Value;
end;

procedure TMainForm.SetDataBufferSize(const Value: cardinal);
begin
  { TODO : добавить проверку на развер буфера в байтах (имя файла должно помещаться, как минимум) }
  if FDataBufferSize<>Value then
    FDataBufferSize:=Value;
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  Handled:=False;
  if Msg.message=WM_SERVER then
    if Msg.wParam=WPARAM_SERVER_SHUTDOWN then // сервер сообщает клиенту о своём отключении
      begin
        LogWarning('Клиент получил уведомление о завершении работы сервера.');
        LogInfo('Соединение с сервером прервано.');
        FConnectedToServer:=False; // убираем флаш соединения
        FServerHandle:=0; // обнуляем хэндл сервера
        LogDebug('Handle окна серверного приложения обнулён.');
//        FreeAndNil(FSharedMem); // удаляем объект доступа к общей памяти
        { TODO : дописать }
        Refresh_ConnectionState;
        Handled:=True;
      end
    else
      if FConnectedToServer then
        case Msg.wParam of
          WPARAM_SERVER_SENDS_SHAREDMEM_SIZE: // сервер прислал размер буфера общей памяти
            begin
              DataBufferSize:=Msg.lParam; // устанавливаем размер буфера общей памяти
              { TODO : дописать }
              Handled:=True;
            end;
          WPARAM_SERVER_WANNA_FILENAME: // сервер хочет имя файла
            begin
              { TODO : дописать }
              Handled:=True;
            end;
          WPARAM_SERVER_WANNA_CHUNKS_QUANTITY: // сервер хочет количество блоков в файле
            begin
              { TODO : дописать }
              Handled:=True;
            end;
          WPARAM_SERVER_WANNA_DATA: // сервер хочет блок данных
            begin
              { TODO : дописать }
              Handled:=True;
            end;
          WPARAM_SERVER_WANNA_CRC32: // сервер хочет CRC32
            begin
              { TODO : дописать }
              Handled:=True;
            end;
        end
      else
        case Msg.wParam of
        WPARAM_SERVER_WANNA_HANDLE: // сервер хочет хэндл окна клиента
          if FServerHandle<>THandle(Msg.lParam) then
            begin
              FServerHandle:=Msg.lParam; // сохранение хэндла окна сервера
              // отправка хэндла окна клиента серверу
              PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_HANDLE, Handle);
              { TODO : дописать }
              Handled:=True;
            end;
        WPARAM_SERVER_ACCEPT_CLIENT: // сервер подтверждает соединение с данным клиентом
          begin
            LogDebug('Сервер прислал подтверждение попытки поключения.');
            FConnectedToServer:=True; // ставим флаш соединения
            LogInfo('Соединение с сервером установлено.');
            Refresh_ConnectionState;
            { TODO : дописать }
            Handled:=True;
          end;
        end;
end;

procedure TMainForm.chkbxScrollLogToBottomClick(Sender: TObject);
begin
  Configuration.ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
  LogInfo('Прокурутка к последнему сообщению протокола '+CommonFunctions.GetConditionalString(Configuration.ScrollLogToBottom, 'в', 'от')+'ключена.');
end;

end.
