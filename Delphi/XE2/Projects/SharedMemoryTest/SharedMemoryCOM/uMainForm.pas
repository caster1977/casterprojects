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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
begin
  WinExec(PAnsiChar(AnsiString(Application.Exename+' -RegServer')), SW_NORMAL);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FSharedMemoryName:=TPath.GetGUIDFileName(True);
  Edit1.Text:=FSharedMemoryName;
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  BCM_SETSHIELD: integer=$160C; // Для отображения кнопки со щитом
begin
  SendMessage(Button1.Handle, BCM_SETSHIELD, 0, $FFFFFFFF);
end;

initialization

TTypedComObjectFactory.Create(ComServer, TSharedMemoryCOMCoClass, Class_SharedMemoryCOMCoClass, ciMultiInstance, tmApartment);

finalization

ComServer:=nil;

end.
