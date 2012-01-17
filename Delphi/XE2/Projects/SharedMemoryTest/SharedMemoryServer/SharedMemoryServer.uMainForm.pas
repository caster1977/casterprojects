unit SharedMemoryServer.uMainForm;

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
  System.Win.ComObj,
  Winapi.ActiveX,
  SharedMemoryServer.uConfigurationClass,
  SharedMemoryCommon.uRetranslatorThreadClass,
  SharedMemoryCommon.uSharedMemClass,
  SharedMemoryCommon.uChunkClass,
  SharedMemoryCommon.uChunkedFileClass,
  SharedMemoryCommon.uWatchThreadClass,
  SharedMemoryCommon.uCommon,
  SharedMemoryCommon.SharedMemoryCOMLibrary_TLB;

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
    /// ��������� ��� ������� � COM-�������, ���������� ��� ����� ������
    /// </summary>
    FSharedMemoryCOMInterface: ISharedMemoryCOMInterface;

    /// <summary>
    /// ������ ��� ������� � ����� ������
    /// </summary>
    FSharedMem: TSharedMemClass;

    /// <summary>
    /// ������ ��� ����������� � ���������� ������
    /// </summary>
    FChunk: TChunkClass;

    /// <summary>
    /// ������ ��� ����������� � "����������" ������ ������
    /// </summary>
    FChunkedFile: TChunkedFileClass;

    /// <summary>
    /// ������ ��� �������� �������� ���������
    /// </summary>
    FConfiguration: TConfigurationClass;

    /// <summary>
    /// ������ ���� ��� �������� ������������������ ��������� ���������� �����������
    /// </summary>
    FConnectionThread: TRetranslatorThreadClass;

    /// <summary>
    /// ������ ���� ��� ������ ��������� ����������
    /// </summary>
    FWatchThread: TWatchThreadClass;

    /// <summary>
    /// ���� ��������� ��������� ������
    /// </summary>
    FReceiving: boolean;

    /// <summary>
    /// ���� ��������� ���������� ������� ����������
    /// </summary>
    FFirstRun: boolean;

    /// <summary>
    /// ���� ��������� ���������� � ��������
    /// </summary>
    FClientConnected: boolean;

    /// <summary>
    /// Handle ���� ����������� ����������
    /// </summary>
    FClientHandle: THandle;

    /// <summary>
    /// ��� ����� ��� ���������
    /// </summary>
    FFileName: string;

    procedure ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);
    procedure ApplicationOnHint(Sender: TObject);
    procedure SetConfiguration(const Value: TConfigurationClass);
    procedure Log(const aMessage: string; aMessageType: TLogMessagesType);

    procedure Do_RefreshConnectionState;
    procedure Do_LoadConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_ApplyConfiguration;
    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Configuration;
    procedure Do_OpenDestinationFolder;
    procedure Do_ConnectionThreadTerminate;
    procedure Do_WatchThreadTerminate;
    procedure Do_UpdateColumnWidth;
    procedure Do_PlaySound;
    function Do_RegisterWindowMessages: boolean;
    function Do_ConnectionThreadStart: boolean;
    function Do_WatchThreadStart: boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    procedure LogError(const aMessage: string);
    procedure LogWarning(const aMessage: string);
    procedure LogInfo(const aMessage: string);
    procedure LogDebug(const aMessage: string);
    procedure ProcessErrors(const aHandle: THandle; const aError: boolean; const aErrorMessage: string);
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
  SharedMemoryServer.uAboutForm,
  SharedMemoryCommon.uCommonConfigurationClass,
  SharedMemoryServer.uConfigurationForm;

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
      ListItem.Caption:=FormatDateTime(TEXT_DATETIME_FORMAT, Now);
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
  LogInfo(Format(TEXT_STATUSBAR_SWITCHED, [CommonFunctions.GetConditionalString(StatusBar1.Visible, TEXT_STATUSBAR_ON, TEXT_STATUSBAR_OFF)]));
end;

procedure TMainForm.Do_RefreshConnectionState;
const
  ICON_BUSY=0;
  ICON_READY=1;
begin
  if FClientConnected then
    ilMainFormStateIcons.GetIcon(ICON_READY, imConnectionState.Picture.Icon)
  else
    ilMainFormStateIcons.GetIcon(ICON_BUSY, imConnectionState.Picture.Icon);
  LogDebug(Format(TEXT_CONNECTION_SWITCHED, [CommonFunctions.GetConditionalString(FClientConnected, TEXT_CONNECTION_ON, TEXT_CONNECTION_OFF)]));
  Application.ProcessMessages;
end;

procedure TMainForm.SetConfiguration(const Value: TConfigurationClass);
begin
  if FConfiguration<>Value then
    FConfiguration:=Value;
end;

procedure TMainForm.ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);
begin
  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(Format(TEXT_ERROR, [TEXT_MAINFORM_CAPTION])), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
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

procedure TMainForm.Do_OpenDestinationFolder;
resourcestring
  TEXT_TRYING_TO_OPEN_DESTINATION_FOLDER='������������ ������� �������� ����� ����� ������...';
  TEXT_DESTINATION_FOLDER_OPENED='������� ����� ����� ������.';
  TEXT_DESTINATION_FOLDER_NOT_EXISTS='����� ����� ������ �� ����������! ��������� ������������ ���������� � ���������� ���� [%s]!';
var
  sErrorMessage: string;
  bError: boolean;
begin
  bError:=False;
  LogDebug(TEXT_TRYING_TO_OPEN_DESTINATION_FOLDER);
  if DirectoryExists(Configuration.DestinationFolder) then
    begin
      ShellExecute(Application.Handle, 'open', PWideChar(Configuration.DestinationFolder), nil, nil, SW_MAXIMIZE);
      LogInfo(TEXT_DESTINATION_FOLDER_OPENED);
    end
  else
    CommonFunctions.GenerateError(Format(TEXT_DESTINATION_FOLDER_NOT_EXISTS, [Configuration.DestinationFolder]), sErrorMessage, bError);
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

procedure TMainForm.Do_ConnectionThreadTerminate;
resourcestring
  TEXT_CONNECTION_THREAD_STOPPED='����� ������ �������� ����������.';
var
  Thread: TRetranslatorThreadClass;
begin
  Thread:=FConnectionThread;
  FConnectionThread:=nil;
  if Assigned(Thread) then
    begin
      Thread.Terminate;
      LogDebug(TEXT_CONNECTION_THREAD_STOPPED);
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
  // ���������� �������� � ��������� ��������� ���������
  chkbxScrollLogToBottom.Checked:=chkbxScrollLogToBottom.Enabled and Configuration.ScrollLogToBottom;
  chkbxScrollLogToBottom.OnClick:=chkbxScrollLogToBottomClick;
  // ���������� �������� � ������ �������
  miStatusbar.Checked:=Configuration.ShowStatusbar;
  StatusBar1.Visible:=Configuration.ShowStatusbar;

  // ��������� ������� � �������� �������� ���� � ����������� � ����������� ������������
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
resourcestring
  TEXT_CONNECTION_THREAD_STARTED='����� ������ �������� �������.';
begin
  Result:=False;
  if not Assigned(FConnectionThread) then
    begin
      FConnectionThread:=TRetranslatorThreadClass.Create(WM_SERVER, WPARAM_SERVER_WANNA_HANDLE, Handle);
      try
        FConnectionThread.Start;
        LogDebug(TEXT_CONNECTION_THREAD_STARTED);
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
    LogDebug(TEXT_MESSAGE_REGISTRATION_COMPLETED_SUCCESSFULLY);
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
    CanClose:=MessageBox(Handle, PWideChar(TEXT_ARE_YOU_SURE_YOU_WANNA_QUIT), PWideChar(Format(TEXT_QIUT_CONFIRMATION, [TEXT_MAINFORM_CAPTION])), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK
  else
    CanClose:=True;
  Application.ProcessMessages;

  if CanClose then
    begin
      LogInfo(TEXT_QIUT_CONFIRMED);
      // ���������� ������� �������� �������� ���� � ������������
      FormPosition.Left:=Left;
      FormPosition.Top:=Top;
      FormPosition.Width:=Width;
      FormPosition.Height:=Height;
      FormPosition.Centered:=False;
      FormPosition.Maximized:=WindowState=wsMaximized;
      Configuration.MainFormPosition:=FormPosition;

      Do_SaveConfiguration; // ������ ������������
      if FClientConnected then // ���� ���������� � �������� �����������, ���������� ������� ����������� � ���������� ������ �������
        PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_SHUTDOWN, 0);
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
  resourcestring
    TEXT_DISCONNECTED_FROM_CLIENT='���������� � �������� ��������.';
    TEXT_CLIENT_HANDLE_CLEARED='Handle ���� ����������� ���������� ������.';
  begin
    pbMain.Visible:=False;
    Do_WatchThreadTerminate;
    FClientConnected:=False; // ������� ���� ����������
    FClientHandle:=0; // �������� ����� �������
    LogDebug(TEXT_CLIENT_HANDLE_CLEARED);
    FreeAndNil(FChunkedFile); // ������� ������ ������� � ����������� �����
    LogDebug(TEXT_CHUNKEDFILE_OBJECT_DESTROYED);
    FreeAndNil(FSharedMem); // ������� ������ ������� � ����� ������
    LogDebug(TEXT_SHARED_MEMORY_OBJECT_DESTROYED);
    if not Do_ConnectionThreadStart then // ��������� ����� �������� ������ �������
      Application.Terminate;
    Do_RefreshConnectionState;
    LogInfo(TEXT_DISCONNECTED_FROM_CLIENT);
  end;

  procedure Do_WPARAM_CLIENT_SHUTDOWN;
  resourcestring
    TEXT_CLIENT_SHUTDOWN='�������� ����������� � ���������� ������ �������.';
  begin
    LogWarning(TEXT_CLIENT_SHUTDOWN);
    Do_Disconnect;
  end;

  procedure Do_WPARAM_CLIENT_LOST;
  resourcestring
    TEXT_CLIENT_LOST='��������� �������������� ������ ���������� � ��������!';
  begin
    LogError(TEXT_CLIENT_LOST);
    Do_Disconnect;
  end;

  procedure Do_WPARAM_CLIENT_SENDS_HANDLE(const Handle: THandle);
  resourcestring
    TEXT_CLIENT_SENDS_ANSWER_ON_BROADCAST='������� ����� ������� �� ����������������� ���������.';
    TEXT_CONNECTION_WITH_CLIENT_ESTABLISHED='���������� � �������� �����������.';
    TEXT_RECEIVED_CLIENTS_HANDLE='������� Handle ���� ����������� ����������: %s.';
    TEXT_POSTED_SUCCESSFUL_CONNECTION_NOTIFICATION='���������� ����������� �� �������� �����������.';
  begin
    LogInfo(TEXT_CLIENT_SENDS_ANSWER_ON_BROADCAST);

    LogInfo(TEXT_CONNECTION_WITH_CLIENT_ESTABLISHED);
    Do_ConnectionThreadTerminate; // ������������� �����, ����������� ����� �������
    FClientHandle:=Handle; // �������� ����� �������
    LogDebug(Format(TEXT_RECEIVED_CLIENTS_HANDLE, [IntToStr(Handle)]));
    FClientConnected:=True; // ������������� ���� ����������
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_ACCEPT_CLIENT, 0); // ���������� ������� ������������� �����������
    LogDebug(TEXT_POSTED_SUCCESSFUL_CONNECTION_NOTIFICATION);
    if not Do_WatchThreadStart then
      Application.Terminate;
    Do_RefreshConnectionState;
  end;

  procedure Do_WPARAM_CLIENT_WANNA_SEND_FILE;
  resourcestring
    TEXT_RECEIVED_CLIENT_WANNA_SEND_FILE_NOTIFICATION='�������� ����������� � ������� �������� ����� ��������.';
    TEXT_SENDED_CHUNK_SIZE='��������� ������ ������ ��� �������� ������ �����: %s.';
    TEXT_SENDED_FILENAME_QUERY='��������� ������ �� ��� ������������� �����.';
  begin
    LogInfo(TEXT_RECEIVED_CLIENT_WANNA_SEND_FILE_NOTIFICATION);

    FReceiving:=True;
    FSharedMem:=TSharedMemClass.Create(Configuration.SharedMemoryName, Configuration.SharedMemSize);

    LogDebug(TEXT_SHARED_MEMORY_OBJECT_CREATED);
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_SENDS_SHAREDMEM_SIZE, Configuration.SharedMemSize); // ���������� ������� ������ ����� ����� ������ ��� ������ �������
    LogDebug(Format(TEXT_SENDED_CHUNK_SIZE, [IntToStr(Int64(Configuration.SharedMemSize))]));
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILENAME, 0); // ������� �� ������� ��� �����
    LogDebug(TEXT_SENDED_FILENAME_QUERY);
  end;

  procedure Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
  resourcestring
    TEXT_CLIENT_WANNA_CANCEL_SENDING='�������� ����������� �� ������ �������� ����� ��������.';
  begin
    LogWarning(TEXT_CLIENT_WANNA_CANCEL_SENDING);
    FReceiving:=False;
    pbMain.Visible:=False;
    FreeAndNil(FChunkedFile); // ������� ������ ������� � ����������� �����
    LogDebug(TEXT_CHUNKEDFILE_OBJECT_DESTROYED);
    FreeAndNil(FSharedMem); // ������� ������� ������ ������� � ����� ������
    LogDebug(TEXT_SHARED_MEMORY_OBJECT_DESTROYED);
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILENAME(const dwSize: cardinal);
  resourcestring
    TEXT_RECEIVED_CLIENT_SENDS_FILENAME_NOTIFICATION='�������� ����������� � �������� �������� ����� �����.';
    TEXT_RECEIVED_FILENAME_SIZE='������ ����� ������������� �������� ����� � ������: %s.';
    TEXT_RECEIVED_FILENAME='�������� ��� ������������� �������� �����: [%s].';
    TEXT_POSTED_FILESIZE_QUERY='��������� ������ �� ������ ������������� �����.';
  begin
    LogDebug(TEXT_RECEIVED_CLIENT_SENDS_FILENAME_NOTIFICATION);

    LogDebug(Format(TEXT_RECEIVED_FILENAME_SIZE, [IntToStr(Int64(dwSize))]));
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug(TEXT_CHUNK_OBJECT_CREATED);
      end;
    try
      FSharedMem.Mapped:=True;
      FSharedMem.Read(dwSize, FChunk);
      FSharedMem.Mapped:=False;
      FFilename:=StringOf(FChunk.Data);
    finally
      FreeAndNil(FChunk);
      LogDebug(TEXT_CHUNK_OBJECT_DESTROYED);
    end;
    LogInfo(Format(TEXT_RECEIVED_FILENAME, [FFileName]));

    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILESIZE, 0); // ������� �� ������� ������ �����
    LogDebug(TEXT_POSTED_FILESIZE_QUERY);
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILESIZE(const dwSize: cardinal);
  resourcestring
    TEXT_RECEIVED_FILESIZE_STRING_NOTIFICATION='������� ������ ������ ������������� �������� ������� ����� � ������: %s.';
    TEXT_FILESIZE_STRING='������ ������� ����� � ������: %s.';
    TEXT_FILESIZE='������ ����� � ������: %s.';
    TEXT_RECEIVING_STARTED='����� ���� ������ �����.';
    TEXT_SENDED_CHUNK_DATA_QUERY='��������� ������ �� ��������� ��������� ������ ������.';
  var
    aSize: Int64;
    s: string;
  begin
    LogDebug(Format(TEXT_RECEIVED_FILESIZE_STRING_NOTIFICATION, [IntToStr(Int64(dwSize))]));

    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug(TEXT_CHUNK_OBJECT_CREATED);
      end;
    try
      FSharedMem.Mapped:=True;
      FSharedMem.Read(dwSize, FChunk);
      FSharedMem.Mapped:=False;
      s:=StringOf(FChunk.Data);
      LogDebug(Format(TEXT_FILESIZE_STRING, [s]));
      aSize:=StrToInt64Def(s, -1);
    finally
      FreeAndNil(FChunk);
      LogDebug(TEXT_CHUNK_OBJECT_DESTROYED);
    end;
    LogInfo(Format(TEXT_FILESIZE, [IntToStr(aSize)]));

    if not Assigned(FChunkedFile) then
      begin
        FChunkedFile:=TChunkedFileClass.Create(Configuration.DestinationFolder+FFilename, Configuration.SharedMemSize, aSize);
        pbMain.Max:=FChunkedFile.Count;
        pbMain.Position:=pbMain.Min;
        pbMain.Visible:=True;
        LogDebug(TEXT_CHUNKEDFILE_OBJECT_CREATED);
        LogInfo(TEXT_RECEIVING_STARTED);
        PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, FChunkedFile.Index); // ������� �� ������� ��������� ���� �����
        LogDebug(TEXT_SENDED_CHUNK_DATA_QUERY);
      end
    else
      raise Exception.Create(TEXT_CHUNKEDFILE_OBJECT_CREATION_ERROR);
  end;

  procedure Do_WPARAM_CLIENT_SENDS_DATA(const dwSize: cardinal);
  resourcestring
    TEXT_RECEIVED_CLIENT_SENDS_DATA_NOTIFICATION='�������� ����������� � �������� �������� ������ ������ �����.';
    TEXT_CHUNK_SIZE='������ ������ ������ ������������� �������� ����� � ������: %s.';
    TEXT_CRC32_OF_CHUNK_QUERY='��������� ������ �� ��������� ����������� ����� ��������� ������ ������.';
  begin
    LogDebug(TEXT_RECEIVED_CLIENT_SENDS_DATA_NOTIFICATION);

    LogDebug(Format(TEXT_CHUNK_SIZE, [IntToStr(Int64(dwSize))]));
    if not Assigned(FChunk) then
      begin
        FChunk:=TChunkClass.Create;
        LogDebug(TEXT_CHUNK_OBJECT_CREATED);
      end;
    FSharedMem.Mapped:=True;
    FSharedMem.Read(dwSize, FChunk);
    FSharedMem.Mapped:=False;

    // ������ �������� � ������� ������ ������
    // ������ ������� CRC32 �����
    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_CRC32, FChunkedFile.Index); // ������� �� ������� CRC32 ��������� ������ ������ �����
    LogDebug(TEXT_CRC32_OF_CHUNK_QUERY);
  end;

  procedure Do_WPARAM_CLIENT_SENDS_CRC32(const dwCRC32: cardinal);
  resourcestring
    TEXT_RECEIVED_CRC32_OF_CHUNK='�������� ����������� ����� ���������� �������� ������ ������ �����.';
    TEXT_CRC32_OF_CHUNK='����������� ����� ���������� �������� ������ ������ �����: %s.';
    TEXT_CRC32_OF_CHUNK_IS_LEGAL='����������� ����� ������ ������ �������.';
    TEXT_SENDED_CHUNK_QUERY='��������� ������ �� ��������� ��������� ������ ������.';
    TEXT_FILE_TRANSFER_COMPLETE='������� ���� ������ �����.';
    TEXT_FILE_TRANSFER_COMPLETE_SUCCESSFULLY_NOTIFICATION='���������� ����������� �� �������� �������� �����.';
    TEXT_FILE_TRANSFER_COMPLETE_SUCCESSFULLY='���� ������� ������.';
    TEXT_FILE_TRANSFER_COMPLETE_ERROR_NOTIFICATION='���������� ����������� �� ������ ��� �������� �����.';
    TEXT_FILE_TRANSFER_COMPLETE_ERROR='���� �� ��� ������!';
    TEXT_WRONG_CRC32_OF_CHUNK='����������� ����� ������ ������ ����� %s �� �������!';
    TEXT_REPEAT_RECEIVING_OF_CHUNK='�������� ��������� ��������� ������ ������ ����� %s.';
    TEXT_SENDED_REPEAT_RECEIVING_OF_CHUNK_QUERY='��������� ������ �� ��������� ��������� ������ ������.';
  begin
    LogDebug(TEXT_RECEIVED_CRC32_OF_CHUNK);

    LogDebug(Format(TEXT_CRC32_OF_CHUNK, [IntToHex(dwCRC32, 8)]));
    // �������� ������ ���������� ����������� ����� � ����������� ����� ����� ���������� ������ ������ �����
    if FChunk.CRC32=dwCRC32 then
      begin
        LogDebug(TEXT_CRC32_OF_CHUNK_IS_LEGAL);
        // ����������� ����� �������, ����� ���������� ������ � ����
        FChunkedFile.Write(FChunk);
        // ��������, ���� �� �������� ��������� ������ ������ �����
        FChunkedFile.Index:=FChunkedFile.Index+1;
        if FChunkedFile.Index<FChunkedFile.Count then
          begin
            pbMain.StepBy(1);
            // ����� ��������� ��������� ������ ������
            PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, FChunkedFile.Index); // ������� �� ������� ��������� ���� �����
            LogDebug(TEXT_SENDED_CHUNK_QUERY);
          end
        else
          begin
            // ��������� ������ ������, ����� ��������� ������ �� �������� �������� ������ � ������� ����
            try
              try
                LogInfo(TEXT_FILE_TRANSFER_COMPLETE);
                FChunkedFile.Complete:=True;

                PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_TRANSFER_COMPLETE, 0); // ���������� ������ �� �������� ��������� �������� �����
                LogDebug(TEXT_FILE_TRANSFER_COMPLETE_SUCCESSFULLY_NOTIFICATION);

                LogInfo(TEXT_FILE_TRANSFER_COMPLETE_SUCCESSFULLY);
              except
                on E: Exception do
                  begin
                    FReceiving:=False;

                    PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_TRANSFER_ERROR, 0); // ���������� ������ �� ������ ��� �������� �����
                    LogDebug(TEXT_FILE_TRANSFER_COMPLETE_ERROR_NOTIFICATION);

                    LogError(E.Message);
                    LogWarning(TEXT_FILE_TRANSFER_COMPLETE_ERROR);
                  end;
              end;
            finally
              pbMain.Visible:=False;
              Application.ProcessMessages;

              FreeAndNil(FChunkedFile); // ������� ������ ������� � ����������� �����
              LogDebug(TEXT_CHUNKEDFILE_OBJECT_DESTROYED);

              FreeAndNil(FSharedMem); // ������� ������� ������ ������� � ����� ������
              LogDebug(TEXT_SHARED_MEMORY_OBJECT_DESTROYED);

              if Configuration.PlaySoundOnComplete then
                Do_PlaySound;
            end;
          end;
      end
    else
      begin
        // ����������� ����� �� �������, ��������� �������� �������� ������ ������ �����
        LogError(Format(TEXT_WRONG_CRC32_OF_CHUNK, [IntToStr(FChunkedFile.Index)]));
        LogInfo(Format(TEXT_REPEAT_RECEIVING_OF_CHUNK, [IntToStr(FChunkedFile.Index)]));
        PostMessage(FClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, FChunkedFile.Index); // ������� �� ������� ��������� ���� �����
        LogDebug(TEXT_SENDED_REPEAT_RECEIVING_OF_CHUNK_QUERY);
      end;
  end;

begin
  inherited;
  if message.Msg=WM_CLIENT then
    begin
      if message.WParam=WPARAM_CLIENT_SHUTDOWN then // ������ �������� � ���� ���������� �� �������
        Do_WPARAM_CLIENT_SHUTDOWN
      else
        if FClientConnected then
          case message.WParam of
            WPARAM_CLIENT_WANNA_SEND_FILE: // ������ ����� ������� ��������� ����
              Do_WPARAM_CLIENT_WANNA_SEND_FILE;
            WPARAM_CLIENT_SENDS_FILENAME: // ������ ���������� ��� ����� (LPARAM = ������ ����� ����� � ������)
              Do_WPARAM_CLIENT_SENDS_FILENAME(message.LParam);
            WPARAM_CLIENT_SENDS_FILESIZE: // ������ ���������� ������ ����� (LPARAM = ������ ����������� ������������� ������� ����� � ������)
              Do_WPARAM_CLIENT_SENDS_FILESIZE(message.LParam);
            WPARAM_CLIENT_SENDS_DATA: // ������ ���������� ��������� ���� ������ (LPARAM = ������ ���������� ������ � ������)
              Do_WPARAM_CLIENT_SENDS_DATA(message.LParam);
            WPARAM_CLIENT_SENDS_CRC32: // ������ ���������� ����������� ����� ���������� ����� ������ (LPARAM = ���32)
              Do_WPARAM_CLIENT_SENDS_CRC32(message.LParam);
            WPARAM_CLIENT_WANNA_CANCEL_SENDING: // ������ ����� ���������� �������� �����
              Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
            WPARAM_CLIENT_LOST: // �����-������ �������� � ���, ��� ���� ������� ���������� �������
              Do_WPARAM_CLIENT_LOST;
          end
        else
          if message.WParam=WPARAM_CLIENT_SENDS_HANDLE then // ������ ���������� ���� handle (LPARAM = handle �������)
            Do_WPARAM_CLIENT_SENDS_HANDLE(message.LParam);
    end;
end;

procedure TMainForm.chkbxScrollLogToBottomClick(Sender: TObject);
begin
  Configuration.ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
  LogInfo(Format(TEXT_SCROLLLOG_SWITCHED, [CommonFunctions.GetConditionalString(Configuration.ScrollLogToBottom, TEXT_SCROLLLOG_ON, TEXT_SCROLLLOG_OFF)]));
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

var
  s: WideString;
begin
  FFirstRun:=True; // ����� ������ ������� ��������� �������
  FClientConnected:=False; // ���������� ������ �� ��������
  FReceiving:=False; // ����� �������� ������ ��������
  Caption:=TEXT_MAINFORM_CAPTION; // ��������� ��������� ����
  ilMainFormSmallImages.GetIcon(ICON_MAIN, Icon); // ��������� ������ ����
  FConfiguration:=TConfigurationClass.Create; // �������� � �������������� ������� ������������
  BindMainProgressBarToStatusBar;
  BindStateImageToStatusBar;
  Do_RefreshConnectionState;
  Application.OnHint:=ApplicationOnHint;
  Do_LoadConfiguration; // �������� �������� �� �����
  Do_ApplyConfiguration; // ���������� �������� � ����������
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
  FReceiving:=False; // ����� �������� ������ ��������
  Do_WatchThreadTerminate;
  Do_ConnectionThreadTerminate;
  FreeAndNil(FChunk);
  FreeAndNil(FChunkedFile);
  FreeAndNil(FSharedMem);
  FreeAndNil(FConfiguration);
end;

end.
