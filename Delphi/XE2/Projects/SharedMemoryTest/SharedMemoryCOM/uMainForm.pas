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
  Vcl.StdCtrls,
  System.Win.ComObj,
  Winapi.ActiveX,
  SharedMemoryCOMLibrary_TLB;

type
  TSharedMemoryCOMCoClass=class(TTypedComObject, ISharedMemoryCOMInterface)
  protected
    function GetSharedMemoryName(out vName: WideString): HResult; stdcall;
  end;

  TMainForm=class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  strict private
    FSharedMemoryName: WideString;
  private
    property SharedMemoryName: WideString read FSharedMemoryName;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  WinAPI.ShellAPI,
  System.IOUtils,
  System.Win.ComServ;

function TSharedMemoryCOMCoClass.GetSharedMemoryName(out vName: WideString): HResult;
begin
  if Assigned(MainForm) then
    begin
      vName:=MainForm.SharedMemoryName;
      Result:=S_OK;
    end
  else
    Result:=S_FALSE;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
  ShellExecuteInfo: TShellExecuteInfo;
begin
  Hide;
  ShellExecuteInfo.cbSize:=SizeOf(TShellExecuteInfo);
  ShellExecuteInfo.fMask:=0;
  ShellExecuteInfo.Wnd:=Handle;
  ShellExecuteInfo.lpVerb:='runas';
  ShellExecuteInfo.lpFile:=PWideChar(WideString(Application.ExeName));
  ShellExecuteInfo.lpParameters:=PWideChar('/RegServer');
  ShellExecuteInfo.lpDirectory:=nil;
  ShellExecuteInfo.nShow:=SW_NORMAL;
  ShellExecuteEx(@ShellExecuteInfo);
  Show;
end;

procedure TMainForm.Button2Click(Sender: TObject);
var
  ShellExecuteInfo: TShellExecuteInfo;
begin
  Hide;
  ShellExecuteInfo.cbSize:=SizeOf(TShellExecuteInfo);
  ShellExecuteInfo.fMask:=0;
  ShellExecuteInfo.Wnd:=Handle;
  ShellExecuteInfo.lpVerb:='runas';
  ShellExecuteInfo.lpFile:=PWideChar(WideString(Application.ExeName));
  ShellExecuteInfo.lpParameters:=PWideChar('/UnregServer');
  ShellExecuteInfo.lpDirectory:=nil;
  ShellExecuteInfo.nShow:=SW_NORMAL;
  ShellExecuteEx(@ShellExecuteInfo);
  Show;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: string;
  i: integer;
begin
  FSharedMemoryName:=TPath.GetGUIDFileName(True);
  Edit1.Text:=FSharedMemoryName;
  (*
    if ParamCount>0 then
    for i:=1 to ParamCount do
    begin
    s:=UpperCase(ParamStr(i));
    if ((s='/REGSERVER')or(s='-REGSERVER')or(s='/REGSERVERPERUSER')or(s='-REGSERVERPERUSER')) then
    begin
    MessageBox(Handle, PWideChar('Регистрация выполнена.'), PWideChar(Caption+' - Информация'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
    Application.Terminate;
    end;
    if ((s='/UNREGSERVER')or(s='-UNREGSERVER')or(s='/UNREGSERVERPERUSER')or(s='-UNREGSERVERPERUSER')) then
    begin
    MessageBox(Handle, PWideChar('Отмена регистрации выполнена.'), PWideChar(Caption+' - Информация'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
    Application.Terminate;
    end;
    end;
  *)
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  BCM_SETSHIELD: integer=$160C; // Для отображения кнопки со щитом
begin
  SendMessage(Button1.Handle, BCM_SETSHIELD, 0, $FFFFFFFF);
  SendMessage(Button2.Handle, BCM_SETSHIELD, 0, $FFFFFFFF);
end;

initialization

TTypedComObjectFactory.Create(ComServer, TSharedMemoryCOMCoClass, Class_SharedMemoryCOMCoClass, ciMultiInstance, tmApartment);

finalization

ComServer:=nil;

end.
