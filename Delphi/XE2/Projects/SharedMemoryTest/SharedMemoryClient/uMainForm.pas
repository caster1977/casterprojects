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
    procedure Action_SekectFileExecute(Sender: TObject);
    procedure lvLogResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FDataBufferSize: cardinal;
    FFirstRun: boolean;
    FServerHandle: THandle;
    FConnectedToServer: boolean;
    FCanceling: boolean;
    FFilename: string;

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
    procedure Do_UpdateAcrions;
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
  // ���������� �������� � ������ �������
  miStatusbar.Checked:=Configuration.ShowStatusbar;
  StatusBar1.Visible:=Configuration.ShowStatusbar;
  // ���������� �������� � ��������� ��������� ���������
  chkbxScrollLogToBottom.Checked:=chkbxScrollLogToBottom.Enabled and Configuration.ScrollLogToBottom;
  chkbxScrollLogToBottom.OnClick:=chkbxScrollLogToBottomClick;

  LogInfo('���������� �������� ��������� ������ �������.');
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

procedure TMainForm.Do_LoadConfiguration;
var
  bError: boolean;
  sErrorMessage: string;
begin
  if not FFirstRun then
    begin
      bError:=False;
      LogDebug('������������ ������� ������ �������� ��������� �� �����...');
    end;
  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Load;
      LogInfo('������ �������� ��������� �� ����� ������������ ������ �������.');
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    if not FFirstRun then
      CommonFunctions.GenerateError('��������� ������ ��� ������� ������ �������� ��������� �� �����!', sErrorMessage, bError);
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
        if MessageBox(Handle, PWideChar('�� ������� ��������� ������� ������ �������� ��������� � ����?'), PWideChar(MainForm.Caption+' - ��������������'), MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON1)=IDOK then
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

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Do_SaveConfiguration; // ������ ������������
  if FConnectedToServer then // ���� ���������� � �������� �����������, ���������� ������� ����������� � ���������� ������ �������
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
  FFirstRun:=True; // ����� ������ ������� ��������� �������
  FConnectedToServer:=False; // ���������� ������ �� ��������
  FServerHandle:=0; // ����� ������� ������
  FCanceling:=False; // ����� ������ �������� ��������
  FFilename:='';
  Caption:=TEXT_MAINFORM_CAPTION; // ��������� ��������� ����
  ilMainFormSmallImages.GetIcon(ICON_MAIN, Icon); // ��������� ������ ����
  FConfiguration:=TConfigurationClass.Create; // �������� � �������������� ������� ������������
  BindMainProgressBarToStatusBar; // �������� ������������ � ������� �� ������ �������
  BindStateImageToStatusBar; // �������� ������ ���������� � ������� �� ������ �������
  Refresh_ConnectionState;
  Do_LoadConfiguration; // �������� �������� �� �����
  Do_ApplyConfiguration; // ���������� �������� � ����������
  Configuration.SharedMemoryName:='{6579B61D-DA05-480A-A29B-B0998A354860}';
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
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
    end;
  Do_UpdateAcrions;
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

procedure TMainForm.lvLogResize(Sender: TObject);
begin
  Do_UpdateColumnWidth;
end;

procedure TMainForm.Do_UpdateAcrions;
begin
  Action_Send.Enabled:=FConnectedToServer and FileExists(FFileName);
  LogDebug('�������� "'+Action_Send.Caption+'" '+CommonFunctions.GetConditionalString(Action_Send.Enabled, '�', '��')+'�������.');
  Action_Cancel.Enabled:=Action_Send.Enabled;
  LogDebug('�������� "'+Action_Cancel.Caption+'" '+CommonFunctions.GetConditionalString(Action_Cancel.Enabled, '�', '��')+'�������.');
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

procedure TMainForm.miStatusBarClick(Sender: TObject);
begin
  StatusBar1.Visible:=miStatusbar.Checked;
  Configuration.ShowStatusbar:=StatusBar1.Visible;
  LogInfo('������ ������� '+CommonFunctions.GetConditionalString(StatusBar1.Visible, '�', '��')+'�������.');
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
  LogDebug('��������� ���������� �'+CommonFunctions.GetConditionalString(FConnectedToServer, '', '�')+'������.');
  Application.ProcessMessages;
end;

procedure TMainForm.ShowErrorBox(const aHandle: THandle; const aErrorMessage: string);
begin
  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(TEXT_MAINFORM_CAPTION+' - ������!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
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

procedure TMainForm.Action_SekectFileExecute(Sender: TObject);
var
  sErrorMessage: string;
  bError: boolean;
begin
  bError:=False;
  with TOpenDialog.Create(Self) do
    try
      Filter:='��� ����� (*.*)|*.*';
      Title:='�������� ���� ��� �������� �� ������...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          ShowErrorBox(Handle, '�� ������ ���� ��� �������� �� ������!')
        else
          begin
            if FileExists(FileName) then
              begin
                FFilename:=FileName;
                ebSelectFile.Text:=FFileName;
                LogInfo('���� ��� �������� �� ������ ������ �������.');
                LogDebug('��� ����� ��� �������� �� ������: ['+FFileName+'].');
              end
            else
              CommonFunctions.GenerateError('��������� ���� �� ����������!', sErrorMessage, bError);
          end;
    finally
      Free;
      Do_UpdateAcrions;
    end;
  PreFooter(Handle, bError, sErrorMessage);
end;

procedure TMainForm.Action_SendExecute(Sender: TObject);
begin
  LogInfo('������������ �������� ��������� �������� ����� �� ������.');
  btnSend_btnCancel.Action:=Action_Cancel;
  Action_Send.Visible:=False;
  Action_Cancel.Visible:=True;
  if FConnectedToServer then
    PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_WANNA_SEND_FILE, 0); // ���������� ������ ������� � ������� ������ �������� �����
end;

procedure TMainForm.Action_CancelExecute(Sender: TObject);
begin
  LogWarning('������� ����� �� ������ �������� �������������.');
  btnSend_btnCancel.Action:=Action_Send;
  Action_Cancel.Visible:=False;
  Action_Send.Visible:=True;
  if FConnectedToServer then
    PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_WANNA_CANCEL_SENDING, 0); // ���������� ������ ������� �� ������ �������� �����
end;

procedure TMainForm.SetConfiguration(const Value: TConfigurationClass);
begin
  FConfiguration:=Value;
end;

procedure TMainForm.SetDataBufferSize(const Value: cardinal);
begin
  { TODO : �������� �������� �� ������ ������ � ������ (��� ����� ������ ����������, ��� �������) }
  if FDataBufferSize<>Value then
    FDataBufferSize:=Value;
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

  procedure Do_WPARAM_SERVER_SHUTDOWN;
  begin
    LogWarning('�������� ����������� � ���������� ������ �������.');
    FConnectedToServer:=False; // ������� ���� ����������
    FServerHandle:=0; // �������� ����� �������
    LogDebug('Handle ���� ���������� ���������� ������.');
    FreeAndNil(FSharedMem); // ������� ������ ������� � ����� ������
    LogDebug('������ ������� � ����� ������ ���������.');
    Refresh_ConnectionState;
    btnSend_btnCancel.Action:=Action_Send;
    Do_UpdateAcrions;
    LogInfo('���������� � �������� ��������.');
  end;

  procedure Do_WPARAM_SERVER_WANNA_HANDLE(const dwHandle: THandle);
  begin
    if FServerHandle<>dwHandle then
      begin
        LogInfo('������� ������������� ���������� �������.');
        LogDebug('Handle ���� ���������� �������: '+IntToStr(dwHandle)+'.');
        FServerHandle:=dwHandle; // ���������� ������ ���� �������
        PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_HANDLE, Handle); // �������� ������ ���� ������� �������
        LogInfo('��������� ������ �� ����������� � �������.');
        LogDebug('���������� Handle �������: '+IntToStr(Handle)+'.');
      end;
  end;

  procedure Do_WPARAM_SERVER_ACCEPT_CLIENT;
  begin
    LogInfo('�������� ������������� �� �������� ����������� � �������.');
    FConnectedToServer:=True; // ������ ���� ����������
    Refresh_ConnectionState;
    Do_UpdateAcrions;
    LogInfo('���������� � �������� �����������.');
  end;

  procedure Do_WPARAM_SERVER_SENDS_SHAREDMEM_SIZE(const dwSize: cardinal);
  begin
    LogInfo('������� ������ ������ ����� ������ � ������.');
    DataBufferSize:=dwSize; // ������������� ������ ������ � ����� ������
    LogDebug('������ ������ ����� ������ � ������: '+IntToStr(Int64(dwSize))+'.');
    // �������� ������ � ����� ������
    FSharedMem:=TSharedMemClass.Create(Configuration.SharedMemoryName, Configuration.DataBlockSize);
    LogDebug('������ ������ ������� � ����� ������.');
  end;

  procedure Do_WPARAM_SERVER_WANNA_FILENAME;
  var
    s: WideString;
    a: TArray<byte>;
    i: integer;
  begin
    LogInfo('������� ������ ����� �����.');
    if not Assigned(FChunk) then
      FChunk:=TChunkClass.Create;
    try
      SetLength(a,Length(FFilename));
      for i:=0 to Length(FFilename) do
        a[i]:=Byte(FFilename[i+1]);
      FChunk.Size:=Length(a);
      FChunk.Data:=Copy(a,0,FChunk.Size);
      FSharedMem.Mapped:=True;
      FSharedMem.Write(FChunk);
      FSharedMem.Mapped:=False;
      PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_FILENAME, FChunk.Size); // �������� ������ ���� ������� ������� (LPARAM = ������ ����� ����� � ������)
      LogDebug('���������� ��� ������������� �����.');
    finally
      FreeAndNil(FChunk);
    end;
  end;

  procedure Do_WPARAM_SERVER_WANNA_FILESIZE;
  begin
    LogInfo('������� ������ ������� ����� � ������.');
    if not Assigned(FChunkedFile) then
      begin
        FChunkedFile:=TChunkedFileClass.Create(FFilename,DataBufferSize);
        LogDebug('������ ������ ������� � ����������� �����.');
        PostMessage(FServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_FILESIZE, FChunkedFile.Size); // �������� ������ ���� ������� ������� (LPARAM = ������ ����� ����� � ������)
        LogDebug('���������� ��� ������������� �����.');
        LogDebug('��������� ������ ������������� ����� � ������.');
      end
    else
      raise Exception.Create('������ ����������� ����� ��� ��� ����� ������!');
  end;

  procedure Do_WPARAM_SERVER_WANNA_DATA(const dwBlockNumber: cardinal);
  begin
    LogInfo('������� ������ �� �������� ������ ������ �����.');

    LogDebug('���������� ������ ������ ������������� �����.');
  end;

  procedure Do_WPARAM_SERVER_WANNA_CRC32(const dwBlockNumber: cardinal);
  begin
    LogInfo('������� ������ �� �������� ����������� ����� ������ ������ �����.');

    LogDebug('���������� ����������� ����� ������ ������ ������������� �����.');
  end;

  procedure Do_WPARAM_SERVER_TRANSFER_COMPLETE;
  begin
    LogInfo('�������� ������������� �� �������� �������� �����.');
    FreeAndNil(FSharedMem); // ������� ������ ������� � ����� ������
    LogDebug('������ ������� � ����� ������ ���������.');
    btnSend_btnCancel.Action:=Action_Send;
    Do_UpdateAcrions;
    LogInfo('�������� ����� ���������.');
  end;

begin
  Handled:=False;
  if Msg.message=WM_SERVER then
    begin
      if Msg.wParam=WPARAM_SERVER_SHUTDOWN then // ������ �������� ������� � ���� ����������
        Do_WPARAM_SERVER_SHUTDOWN
      else
        if FConnectedToServer then
          case Msg.wParam of
            WPARAM_SERVER_SENDS_SHAREDMEM_SIZE: // ������ ������� ������ ������ ����� ������
              Do_WPARAM_SERVER_SENDS_SHAREDMEM_SIZE(Msg.lParam);
            WPARAM_SERVER_WANNA_FILENAME: // ������ ����� ��� �����
              Do_WPARAM_SERVER_WANNA_FILENAME;
            WPARAM_SERVER_WANNA_FILESIZE: // ������ ����� ���������� ������ � �����
              Do_WPARAM_SERVER_WANNA_FILESIZE;
            WPARAM_SERVER_WANNA_DATA: // ������ ����� ���� ������
              Do_WPARAM_SERVER_WANNA_DATA(Msg.lParam);
            WPARAM_SERVER_WANNA_CRC32: // ������ ����� CRC32
              Do_WPARAM_SERVER_WANNA_CRC32(Msg.lParam);
            WPARAM_SERVER_TRANSFER_COMPLETE: // ������ �������� ��� ������� ���� ���������
              Do_WPARAM_SERVER_TRANSFER_COMPLETE;
          end
        else
          case Msg.wParam of
            WPARAM_SERVER_WANNA_HANDLE: // ������ ������� ���� ����� � ����� �������� ����� ���� �������
              Do_WPARAM_SERVER_WANNA_HANDLE(Msg.lParam);
            WPARAM_SERVER_ACCEPT_CLIENT: // ������ ������������ ���������� � ������ ��������
              Do_WPARAM_SERVER_ACCEPT_CLIENT;
          end;
      Handled:=True;
    end;
end;

procedure TMainForm.chkbxScrollLogToBottomClick(Sender: TObject);
begin
  Configuration.ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
  LogInfo('���������� � ���������� ��������� ��������� '+CommonFunctions.GetConditionalString(Configuration.ScrollLogToBottom, '�', '��')+'�������.');
end;

end.
