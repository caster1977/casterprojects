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
  Vcl.StdCtrls, Vcl.AppEvnts;

type
  TMainForm=class(TForm)
    ImageList1: TImageList;
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
    StatusBar1: TStatusBar;
    Button1: TButton;
    ApplicationEvents1: TApplicationEvents;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
  strict private
    WM_SERVER, WM_CLIENT: cardinal;
    hServerHandle: THandle;
    function Do_RegisterWindowMessages: boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uCommon;

//const
//  MUTEX_REQUEST_TIMEOUT=1000;

var
//  HMapMutex: THandle;
  Recipients: DWORD=BSM_APPLICATIONS;

  {
function LockMap: Boolean;
begin
  Result:=True;
  HMapMutex:=CreateMutex(nil, False, PWideChar('SharedMemoryMutex'));
  if HMapMutex=0 then
    begin
      ShowMessage('�� ���� ������� �������');
      Result:=False;
    end
  else
    if WaitForSingleObject(HMapMutex, MUTEX_REQUEST_TIMEOUT)=WAIT_FAILED then
      begin
        ShowMessage('���������� ������������� ������ ����������� �����');
        Result:=False;
      end;
end;

procedure UnlockMap;
begin
  ReleaseMutex(HMapMutex);
  CloseHandle(HMapMutex);
end;
}

procedure TMainForm.Button1Click(Sender: TObject);
var
  FileName: WideString;
  a: LPARAM;
begin
  FileName:='Hello, world!';
  a:=LPARAM(Addr(FileName));
  BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, WM_CLIENT, WPARAM_CLIENT_SENDS_FILENAME, a);
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
      MessageBox(Handle, PWideChar(E.Message), PWideChar(Caption+' - ������!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if not Do_RegisterWindowMessages then
    Application.Terminate;
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  Handled:=False;
  if Msg.message=WM_SERVER then
    case Msg.wParam of
      WPARAM_SERVER_SENDS_HANDLE: // ������ ������� � ���, ��� � LPARAM ��������� handle �������
        begin
          // ���������� ������ ���� �������
          hServerHandle:=Msg.lParam;
          // �������� ������ ���� ������� �������
          PostMessage(hServerHandle, WM_CLIENT, WPARAM_CLIENT_SENDS_HANDLE, Handle);
          { TODO : �������� }
          Handled:=True;
        end;
      WPARAM_SERVER_READY: // ������ �������� � ���, ��� ������ ����� � ��������� ����������, � LPARAM ��������� ������ ������ ��� �������� ������ � ������
        begin
          // ������ ����� ������������� ����� � ����� ������
          // �������� ��������� � ���, ��� ����� ������� ��� ����� �� ������
          { TODO : �������� }
          Handled:=True;
        end;
      WPARAM_SERVER_READING: // ������ ������� � ���, ��� ������ �������� ��������� ������ � ���� ������ � ������� ����� �����, ���� �� ������ ��������� � ������� ���������� ����� ������
        begin
          { TODO : �������� }
          Handled:=True;
        end;
      WPARAM_SERVER_WAITING_FOR_DATA: // ������ ������� � ���, ��� ������ ��� ������ ����� ��� ������ � � LPARAM ��������� ����� �����, ������� ��� ������
        begin
          { TODO : �������� }
          Handled:=True;
        end;
    end;
end;

end.
