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
  uSharedFileClass;

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
    FConfiguration: TConfigurationClass;
    bFirstRun: boolean;
    iBusyCounter: integer;
    bAboutWindowExist: boolean;

    WM_SERVER, WM_CLIENT: cardinal;
    ConnectionThread: TRetranslatorThreadClass;
    bClientConnected: boolean;
    hClientHandle: THandle;
    SharedFile: TSharedFileClass;
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
    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Configuration;

    function Do_RegisterWindowMessages: boolean;
    function Do_ConnectionThreadStart: boolean;
    procedure SetConfiguration(const Value: TConfigurationClass);
    procedure Do_TerminateConnectionThread;
  protected
    property Configuration: TConfigurationClass read FConfiguration write SetConfiguration stored False;
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
      StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=TCommonFunctions.GetConditionalString(iBusyCounter>0, '����������, ���������...', '������');
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
      TCommonFunctions.GenerateError('��������� ������ ��� ������� ������ �������� ��������� �� �����!', sErrorMessage, bError);
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
        if MessageBox(Handle, PWideChar('�� ������� ��������� ������� ������ �������� ��������� � ����?'), PWideChar(MainForm.Caption+' - ��������������'), MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON1)=IDOK then
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
  // �������� � �������������� ������� ������������
  FConfiguration:=TConfigurationClass.Create;
  // �������� ������������ � ������� �� ������ �������
  BindMainProgressBarToStatusBar;
  // �������� ������ ���������� � ������� �� ������ �������
  BindStateImageToStatusBar;
  // �������� �������� �� �����
  Do_LoadConfiguration;

  try
    SharedFile:=TSharedFileClass.Create;
    SharedFile.Mapped:=True;
  except
    on E: Exception do
      begin
        ShowErrorBox(Handle, E.Message);
        Application.Terminate;
      end;
  end;

  { TODO : �������� }
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(SharedFile) then
    SharedFile.Free;
//{$I-}
//  CloseFile(FDataFile);
//{$I+}
  Do_TerminateConnectionThread;
  {Do_CloseSharedFile;}
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
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

  procedure Do_WPARAM_CLIENT_SENDS_HANDLE(const Handle: THandle);
  begin
    Do_TerminateConnectionThread; // ������� ������, ������������ ����� �������
    hClientHandle:=Handle; // �������� ����� �������
    bClientConnected:=True; // ������������� ���� ����������
    { TODO : �������� }
  end;

  procedure Do_WPARAM_CLIENT_SHUTDOWN;
  begin
    bClientConnected:=False; // ������� ���� ����������
    if not Do_ConnectionThreadStart then // ������ ������ �������� ������ �������
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
            WPARAM_CLIENT_SENDS_CRC32: // ������ ���������� ����������� ����� ���������� ����� ������ (LPARAM = ������ ������ ���32 � ������)
              Do_WPARAM_CLIENT_SENDS_CRC32(Msg.lParam);
          end
        else
          if Msg.wParam=WPARAM_CLIENT_SENDS_HANDLE then // ������ ���������� ���� handle (LPARAM = handle �������)
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
