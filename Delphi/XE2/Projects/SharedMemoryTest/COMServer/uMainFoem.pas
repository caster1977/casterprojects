unit uMainFoem;

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
  TTestCOMServerClassTestCOMServerClass=class(TTypedComObject, ITestCOMServer)
  public
//    function GetOut(out vText: WideString): HRESULT; safecall;
    function GetOut(out vText: WideString): HRESULT; stdcall;
  end;

  TMainForm=class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FText: WideString;
  public
    property Text: WideString read FText;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  ComServ,
  System.IOUtils;

function TTestCOMServerClassTestCOMServerClass.GetOut(out vText: WideString): HRESULT;
begin
  if Assigned(MainForm) then
    begin
      vText:=MainForm.Text;
      Result:=S_OK;
    end
  else Result:=S_FALSE;
end;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FText:=TPath.GetGUIDFileName(True);
end;

initialization

TTypedComObjectFactory.Create(ComServer, TTestCOMServerClassTestCOMServerClass, CLASS_TestCOMServerCoClass, ciMultiInstance, tmApartment);

finalization

ComServer:=nil;

end.
