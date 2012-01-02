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
  SharedMemoryCOM_TLB;

type
  TMainForm=class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FSharedMemoryName: WideString;
    FComServer: ITest;
  public
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

type
  TTest=class(TAutoObject, ITest)
  protected
    function GetSharedMemoryName: WideString; stdcall;
  end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Application.Exename+' -RegServer')), SW_NORMAL);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FComServer:=nil;
  FSharedMemoryName:=TPath.GetGUIDFileName(True);
  Edit1.Text:=FSharedMemoryName;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FComServer:=nil;
end;

{ TTest }

function TTest.GetSharedMemoryName: WideString;
begin
  Result:=MainForm.SharedMemoryName;
end;

initialization

TAutoObjectFactory.Create(ComServer, TTest, Class_Test, ciMultiInstance, tmApartment);

finalization

ComServer:=nil;

end.
