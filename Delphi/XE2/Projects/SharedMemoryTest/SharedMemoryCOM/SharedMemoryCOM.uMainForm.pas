unit SharedMemoryCOM.uMainForm;

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
  SharedMemoryCommon.SharedMemoryCOMLibrary_TLB,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan;

type
  TSharedMemoryCOMCoClass = class(TTypedComObject, ISharedMemoryCOMInterface)
  protected
    function GetSharedMemoryName(out vName: WideString): HResult; stdcall;
  end;

  TMainForm = class(TForm)
    btnRegisterCOMServer: TButton;
    lblSharedMemoryName: TLabel;
    edbxSharedMemoryName: TEdit;
    btnUnregisterCOMServer: TButton;
    ActionManager1: TActionManager;
    Action_Register: TAction;
    Action_Unregister: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_UnregisterExecute(Sender: TObject);
    procedure Action_RegisterExecute(Sender: TObject);
    procedure Action_RegisterUpdate(Sender: TObject);
    procedure Action_UnregisterUpdate(Sender: TObject);
  strict private
    FSharedMemoryName: WideString;
    procedure Do_RegisterCOMServer;
    procedure Do_UnregisterCOMServer;
    function Do_IsRegistered: boolean;
  private
    property SharedMemoryName: WideString read FSharedMemoryName;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Winapi.ShellAPI,
  System.IOUtils,
  System.Win.ComServ;

function TSharedMemoryCOMCoClass.GetSharedMemoryName(out vName: WideString): HResult;
begin
  if Assigned(MainForm) then
  begin
    vName := MainForm.SharedMemoryName;
    Result := S_OK;
  end
  else
    Result := S_FALSE;
end;

procedure TMainForm.Action_RegisterExecute(Sender: TObject);
begin
  Do_RegisterCOMServer;
end;

procedure TMainForm.Action_RegisterUpdate(Sender: TObject);
begin
  Action_Register.Enabled := not Do_IsRegistered;
end;

procedure TMainForm.Action_UnregisterExecute(Sender: TObject);
begin
  Do_UnregisterCOMServer;
end;

procedure TMainForm.Action_UnregisterUpdate(Sender: TObject);
begin
  Action_Unregister.Enabled := Do_IsRegistered;
end;

function TMainForm.Do_IsRegistered: boolean;
var
  i: integer;
begin
  Result := RegQueryValue(HKEY_CLASSES_ROOT,
    PWideChar(Format('CLSID\%s\TypeLib', [GUIDToString(CLASS_SharedMemoryCOMCoClass)])),
    PWideChar(GUIDToString(LIBID_SharedMemoryCOMLibrary)), i) = ERROR_SUCCESS;
end;

procedure TMainForm.Do_RegisterCOMServer;
var
  ShellExecuteInfo: TShellExecuteInfo;
begin
  Hide;
  ShellExecuteInfo.cbSize := SizeOf(TShellExecuteInfo);
  ShellExecuteInfo.fMask := 0;
  ShellExecuteInfo.Wnd := Handle;
  ShellExecuteInfo.lpVerb := 'runas';
  ShellExecuteInfo.lpFile := PWideChar(WideString(Application.ExeName));
  ShellExecuteInfo.lpParameters := PWideChar('/RegServer');
  ShellExecuteInfo.lpDirectory := nil;
  ShellExecuteInfo.nShow := SW_NORMAL;
  ShellExecuteEx(@ShellExecuteInfo);
  Sleep(2000);
  Show;
end;

procedure TMainForm.Do_UnregisterCOMServer;
var
  ShellExecuteInfo: TShellExecuteInfo;
begin
  Hide;
  ShellExecuteInfo.cbSize := SizeOf(TShellExecuteInfo);
  ShellExecuteInfo.fMask := 0;
  ShellExecuteInfo.Wnd := Handle;
  ShellExecuteInfo.lpVerb := 'runas';
  ShellExecuteInfo.lpFile := PWideChar(WideString(Application.ExeName));
  ShellExecuteInfo.lpParameters := PWideChar('/UnregServer');
  ShellExecuteInfo.lpDirectory := nil;
  ShellExecuteInfo.nShow := SW_NORMAL;
  ShellExecuteEx(@ShellExecuteInfo);
  Sleep(2000);
  Show;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FSharedMemoryName := TPath.GetGUIDFileName(True);
  edbxSharedMemoryName.Text := FSharedMemoryName;
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  BCM_SETSHIELD: integer = $160C; // Для отображения кнопки со щитом
begin
  SendMessage(btnRegisterCOMServer.Handle, BCM_SETSHIELD, 0, LPARAM($FFFFFFFF));
  SendMessage(btnUnregisterCOMServer.Handle, BCM_SETSHIELD, 0, LPARAM($FFFFFFFF));
end;

initialization

TTypedComObjectFactory.Create(ComServer, TSharedMemoryCOMCoClass, CLASS_SharedMemoryCOMCoClass, ciMultiInstance,
  tmApartment);

finalization

ComServer := nil;

end.
