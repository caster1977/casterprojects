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
  ActiveX,
  ComObj,
  TestCOMServerLib_TLB;

type
  TMainForm=class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FMyCOM: ITestCOMServer;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: WideString;
begin
  FMyCOM:=nil;
  FMyCOM:=CoTestCOMServerCoClass.Create;
  FMyCOM.GetOut(s);
  Caption:=s;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FMyCOM:=nil;
end;

end.
