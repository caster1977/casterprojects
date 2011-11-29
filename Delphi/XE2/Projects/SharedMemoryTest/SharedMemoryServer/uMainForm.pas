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
  uReceiverClass,
  uCommon;

type
  THackControl=class(TControl);

  TMainForm=class(TForm)
    MainMenu1: TMainMenu;
    ActionManager1: TActionManager;
    ilMainFormSmallImages: TImageList;
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
    pbMain: TProgressBar;
    imState: TImage;
    ilMainFormStateIcons: TImageList;
    ApplicationEvents1: TApplicationEvents;
    ilLog: TImageList;
    N7: TMenuItem;
    miStatusBar: TMenuItem;
    Panel1: TPanel;
    chkbxScrollLogToBottom: TCheckBox;
    lvLog: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure chkbxScrollLogToBottomClick(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
  strict private
    FConfiguration: TConfigurationClass;
    Receiver: TReceiverClass;
    bFirstRun: boolean;
    iBusyCounter: integer;
    bAboutWindowExist: boolean;

    WM_SERVER, WM_CLIENT: cardinal;
    ConnectionThread: TRetranslatorThreadClass;
    bClientConnected: boolean;
    hClientHandle: THandle;
    bCanceling: boolean;

    procedure ProcedureHeader;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure ProcedureFooter;
    procedure PreShowModal(var aOldBusyState: integer);
    procedure PostShowModal(var aOldBusyState: integer);
    procedure Refresh_BusyState;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);

    procedure Do_LoadConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_ApplyConfiguration;
    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Configuration;

    function Do_RegisterWindowMessages: boolean;
    function Do_ConnectionThreadStart: boolean;
    procedure SetConfiguration(const Value: TConfigurationClass);
    procedure Do_TerminateConnectionThread;
    procedure Log(const aMessage: string; aMessageType: TLogMessagesType);
  protected
    property Configuration: TConfigurationClass read FConfiguration write SetConfiguration stored False;
  public
    procedure Inc_BusyState;
    procedure Dec_BusyState;
    procedure LogError(const aMessage: string);
    procedure LogWarning(const aMessage: string);
    procedure LogInfo(const aMessage: string);
    procedure LogDebug(const aMessage: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.IniFiles,
  Winapi.CommCtrl,
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
      aOldBusyState:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
      iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
      Refresh_BusyState; // ���������� ��������� ����������
    end;
end;

procedure TMainForm.PostShowModal(var aOldBusyState: integer);
begin
  with MainForm do
    begin
      iBusyCounter:=aOldBusyState; // ����������� ������� �������� ��������
      Refresh_BusyState; // ���������� ��������� ����������
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
      ListItem.ImageIndex:=i; // ��� ���������
      ListItem.Caption:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now);
      ListItem.SubItems.Add(aMessage); // ����� ���������
      if Configuration.ScrollLogToBottom then
        SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
    end;
end;

procedure TMainForm.miStatusBarClick(Sender: TObject);
begin
  ProcedureHeader;
  StatusBar1.Visible:=miStatusbar.Checked;
  Configuration.ShowStatusbar:=StatusBar1.Visible;
  LogInfo('������ ������� '+CommonFunctions.GetConditionalString(StatusBar1.Visible, '�', '��')+'�������.');
  ProcedureFooter;
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
      if Configuration.ShowStatusbar then
        StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=CommonFunctions.GetConditionalString(iBusyCounter>0, '����������, ���������...', '������');
    end;
  Application.ProcessMessages;
end;

procedure TMainForm.SetConfiguration(const Value: TConfigurationClass);
begin
  if FConfiguration<>Value then
    FConfiguration:=Value;
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);
var
  iOldBusyCounter: integer;
begin
  iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
  iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
  Refresh_BusyState; // ���������� ��������� ����������

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(TEXT_MAINFORM_CAPTION+' - ������!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
  Refresh_BusyState; // ���������� ��������� ����������
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
      LogInfo('������������ ������� ������ �������� ��������� �� �����...');
    end;
  try
    try
      Screen.Cursor:=crHourGlass;
      Configuration.Load;
      LogInfo('������ �������� ��������� �� ����� ������ �������.');
    finally
      Screen.Cursor:=crDefault;
    end;
  except
    if not bFirstRun then
      CommonFunctions.GenerateError('��������� ������ ��� ������� ������ �������� ��������� �� �����!', sErrorMessage, bError);
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
      LogInfo('������ �������� ��������� � ���� ������ �������.');
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
              LogInfo('������ �������� ��������� � ���� ������ �������.');
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

procedure TMainForm.Do_ApplyConfiguration;
begin
  ProcedureHeader;
  // ��������� ��������� ������ ������� � ������������ � ����������� ���������
  miStatusbar.Checked:=Configuration.ShowStatusbar;
  StatusBar1.Visible:=Configuration.ShowStatusbar;

  chkbxScrollLogToBottom.Checked:=chkbxScrollLogToBottom.Enabled and Configuration.ScrollLogToBottom;
  chkbxScrollLogToBottom.OnClick:=chkbxScrollLogToBottomClick;

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
  // ������ ������, ������������ ����������������� ��������� ��������
  if not Assigned(ConnectionThread) then
    begin
      ConnectionThread:=TRetranslatorThreadClass.Create(WM_SERVER, WPARAM_SERVER_WANNA_HANDLE, Handle);
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

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ProcedureHeader;
  Do_SaveConfiguration; // ������ ������������
  ProcedureFooter;
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
    THackControl(imState).SetParent(StatusBar1);
    SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
    imState.SetBounds(PanelRect.Left+2, PanelRect.Top+1, PanelRect.Right-PanelRect.Left-4, PanelRect.Bottom-PanelRect.Top-4);
  end;

begin
  bFirstRun:=True;
  bClientConnected:=False;
  bCanceling:=False;
  Caption:=TEXT_MAINFORM_CAPTION;
  ilMainFormSmallImages.GetIcon(ICON_MAIN, Icon);
  // �������� � �������������� ������� ������������
  FConfiguration:=TConfigurationClass.Create;
  // �������� ������������ � ������� �� ������ �������
  BindMainProgressBarToStatusBar;
  // �������� ������ ���������� � ������� �� ������ �������
  BindStateImageToStatusBar;
  // �������� �������� �� �����
  Do_LoadConfiguration;
  // ���������� �������� � ����������
  Do_ApplyConfiguration;
  { TODO : �������� }
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Do_TerminateConnectionThread;
  FreeAndNil(FConfiguration);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ProcedureHeader;

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
      // Do_About(False); // ����������� ���� "� ���������"

      // ����������� ������� ���������
      if not Do_RegisterWindowMessages then
        Application.Terminate;

      if not Do_ConnectionThreadStart then
        Application.Terminate;

      { TODO : �������� }
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
  if Configuration.ShowStatusbar then
    StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

  procedure Do_WPARAM_CLIENT_SENDS_HANDLE(const Handle: THandle);
  begin
    Do_TerminateConnectionThread; // ������������� �����, ����������� ����� �������
    hClientHandle:=Handle; // �������� ����� �������
    bClientConnected:=True; // ������������� ���� ����������
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_SHUTDOWN;
  begin
    bClientConnected:=False; // ������� ���� ����������
    if not Do_ConnectionThreadStart then // ��������� ����� �������� ������ �������
      Application.Terminate;
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_WANNA_SEND_FILE;
  begin
    bCanceling:=False;
    PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_SENDS_BUFFER_SIZE, Configuration.DataBlockSize); // ���������� ������� ������ ����� ����� ������ ��� ������ �������
    PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_FILENAME, 0); // ������� �� ������� ��� �����
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
  begin
    bCanceling:=True;
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY(const dwDataBlocksQuantity: cardinal);
  begin
    {
      // ��������� ���������� ������ � �����
      CurrentFileProperties.DataBlocksQuantity:=dwDataBlocksQuantity;
      // ������� ������ ���� ������ �����
      CurrentFileProperties.CurrentDataBlockNumber:=1;
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, CurrentFileProperties.CurrentDataBlockNumber); // ������� �� ������� ��������� ���� �����
    }
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_FILENAME(const dwSize: cardinal);
  {
    var
    s: string;
  }
  begin
    (*
      // ��������� ������ ����� �����
      SetLength(s, dwSize);
      CopyMemory(@s, PMapView, dwSize);
      CurrentFileProperties.FileName:=s;
      // ������ ���� �� ����� � ��������� � ���������� ��������� �����
      AssignFile(FDataFile, Configuration.DestinationFolder+CurrentFileProperties.FileName);
      try
      Rewrite(FDataFile);
      // ����������� ���������� ������ � �����
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_BLOCKS_QUANTITY, 0); // ������� �� ������� ���������� ������ � �����
      except
      on E: EInOutError do
      begin
      CloseFile(FDataFile);
      ShowErrorBox(Handle, TEXT_ERROR_CREATEFILE+TEXT_ERRORCODE+IntToStr(GetLastError) { +E.Message } );
      end;
      end;
    *)
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_DATA(const dwSize: cardinal);
  {
    var
    ab: Taob;
  }
  begin
    {
      // ��������� ������ ���������� ������ � ������
      CurrentFileProperties.CurrentDataBlockSize:=dwSize;
      // �������� ������ ����� � ������
      SetLength(ab, CurrentFileProperties.CurrentDataBlockSize);
      CopyMemory(@ab[0], PMapView, CurrentFileProperties.CurrentDataBlockSize);
      CurrentFileProperties.CurrentDataBlockData:=ab;
      // ������� CRC32 ����������� ����� ������
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_CRC32, CurrentFileProperties.CurrentDataBlockNumber); // ������� �� ������� CRC32 ���������� ����� �����
    }
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_SENDS_CRC32(const dwSize: cardinal);
  begin
    (*
      // �������� CRC32 ��������� ����� ������ �����
      // ���������� ������ CRC32
      // ���� �������� ������ �������, ���������� ������ � ����
      try
      BlockWrite(FDataFile, CurrentFileProperties.CurrentDataBlockData, CurrentFileProperties.CurrentDataBlockSize);
      // ������� �� ������� ��������� ���� ������
      CurrentFileProperties.CurrentDataBlockNumber:=CurrentFileProperties.CurrentDataBlockNumber+1;
      if not bCanceling then // ��������� ���� �������� �����
      PostMessage(hClientHandle, WM_SERVER, WPARAM_SERVER_WANNA_DATA, CurrentFileProperties.CurrentDataBlockNumber)
      else
      begin
      bCanceling:=False;
      CurrentFileProperties.FileName:='';
      CloseFile(FDataFile);
      { TODO : �������� �������� ������������� ����� � ����� }
      end;
      except
      on E: EInOutError do
      begin
      CloseFile(FDataFile);
      ShowErrorBox(Handle, TEXT_ERROR_CREATEFILE+TEXT_ERRORCODE+IntToStr(GetLastError) { +E.Message } );
      end;
      end;
    *)
    { TODO : �������� }
  end;

begin
  Handled:=False;
  if Msg.message=WM_CLIENT then
    begin
      if Msg.wParam=WPARAM_CLIENT_SHUTDOWN then // ������ �������� � ���� ���������� �� �������
        Do_WPARAM_CLIENT_SHUTDOWN
      else
        if bClientConnected then
          case Msg.wParam of
            WPARAM_CLIENT_WANNA_SEND_FILE: // ������ ����� ������� ��������� ����
              Do_WPARAM_CLIENT_WANNA_SEND_FILE;
            WPARAM_CLIENT_WANNA_CANCEL_SENDING: // ������ ����� ���������� �������� �����
              Do_WPARAM_CLIENT_WANNA_CANCEL_SENDING;
            WPARAM_CLIENT_SENDS_FILENAME: // ������ ���������� ��� ����� (LPARAM = ������ ����� ����� � ������)
              Do_WPARAM_CLIENT_SENDS_FILENAME(Msg.lParam);
            WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY: // ������ ���������� ���������� ������ � ����� (LPARAM = ���������� ������ � �����)
              Do_WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY(Msg.lParam);
            WPARAM_CLIENT_SENDS_DATA: // ������ ���������� ��������� ���� ������ (LPARAM = ������ ���������� ������ � ������)
              Do_WPARAM_CLIENT_SENDS_DATA(Msg.lParam);
            WPARAM_CLIENT_SENDS_CRC32: // ������ ���������� ����������� ����� ���������� ����� ������ (LPARAM = ���32)
              Do_WPARAM_CLIENT_SENDS_CRC32(Msg.lParam);
          end
        else
          if Msg.wParam=WPARAM_CLIENT_SENDS_HANDLE then // ������ ���������� ���� handle (LPARAM = handle �������)
            Do_WPARAM_CLIENT_SENDS_HANDLE(Msg.lParam);
      Handled:=True;
    end;
end;

procedure TMainForm.chkbxScrollLogToBottomClick(Sender: TObject);
begin
  Configuration.ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
  LogInfo('���������� � ���������� ��������� ��������� '+CommonFunctions.GetConditionalString(Configuration.ScrollLogToBottom, '�', '��')+'�������.');
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
  Edit2.Text:=IntToStr(DWORD(-1)); // ��������� ��� ������

  ffileMapObj:=CreateFileMapping(ffile, // ������ �� ����
  nil, // ��������� �� ������ ���� TSecurityAttributes
  PAGE_READWRITE, // ������ ����������� ������������� ������������ �������
  0, // ������� ������ 64-������� �������� ������� ����������� ������ ������ ��� ����������� �������
  1, // ������ ����� ��������
  'MySharedValue' // ��� ������� ��������� �����������
  );

  if (ffileMapObj<>0) then
  ShowMessage('�������� �������� Swap-����� �������');

  lpBaseAdd:=MapViewOfFile(ffileMapObj, FILE_MAP_WRITE, 0, 0, 0);

  if (lpBaseAdd=nil) then
  ShowMessage('�� ���� ���������� FileMapping!');
  SetLength(Str, 12);
  CopyMemory(Pointer(Str), lbBaseAdd, 12);
  Memo1.Lines.Add(str); // �� ���� ��� � � ���� ������ �������� ����� ������ ���������� �����, �� ����� �� ����������
}
end.
