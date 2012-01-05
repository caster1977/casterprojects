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
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FITest: ITest;
  private
    procedure SetSharedMemoryName(const Value: WideString);
  public
    property SharedMemoryName: WideString write SetSharedMemoryName;
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
  strict private
    FActiveX_ID: longint;
    FSharedMemoryName: WideString;
  protected
    function GetSharedMemoryName: WideString; stdcall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Application.Exename+' -RegServer')), SW_NORMAL);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FITest:=nil;
  FITest:=CreateOleObject('SharedMemoryCOM.Test') as ITest;
  SharedMemoryName:=FITest.GetSharedMemoryName;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FITest:=nil;
end;

procedure TMainForm.SetSharedMemoryName(const Value: WideString);
begin
  if Edit1.Text<>Value then
    Edit1.Text:=Value;
end;

{ TTest }

function TTest.GetSharedMemoryName: WideString;
begin
  Result:=FSharedMemoryName;
end;

procedure TTest.Initialize;
begin
  inherited;
  RegisterActiveObject(Self as Iunknown, CLASS_Test, ACTIVEOBJECT_WEAK, FActiveX_ID);
  FSharedMemoryName:=TPath.GetGUIDFileName(True);
end;

destructor TTest.Destroy;
begin
  RevokeActiveObject(FActiveX_ID, nil);
  inherited;
end;

initialization

TAutoObjectFactory.Create(ComServer, TTest, Class_Test, ciMultiInstance, tmApartment);

finalization

ComServer:=nil;

end.
