unit uTAcceptanceOfBoxesToArchiveMainForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  DBXMSSQL,
  Actions,
  ActnList,
  ADODB,
  DB,
  SqlExpr,
  uIAcceptanceOfBoxesToArchiveBusinessLogic,
  uTMessageType,
  ImgList,
  ComCtrls,
  ToolWin;

type
  TAcceptanceOfBoxesToArchiveMainForm = class(TForm)
    pnlButtons: TPanel;
    SQLConnection: TSQLConnection;
    ADOConnection: TADOConnection;
    ActionList: TActionList;
    actPrintSticker: TAction;
    actDeleteLastDocument: TAction;
    ImageList: TImageList;
    gbLastBox: TGroupBox;
    gbBarcode: TGroupBox;
    edBarcode: TEdit;
    gbHint: TGroupBox;
    btnClose: TButton;
    actClose: TAction;
    lblHint: TLabel;
    procedure actCloseExecute(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FLogic: IAcceptanceOfBoxesToArchiveBusinessLogic;
    function GetLogic: IAcceptanceOfBoxesToArchiveBusinessLogic;
    property Logic: IAcceptanceOfBoxesToArchiveBusinessLogic read GetLogic nodefault;
  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string);
  private
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
    property Barcode: string read GetBarcode write SetBarcode nodefault;
  end;

var
  AcceptanceOfBoxesToArchiveMainForm: TAcceptanceOfBoxesToArchiveMainForm;

implementation

{$R *.dfm}

uses
  uTAcceptanceOfBoxesToArchiveBusinessLogic;

procedure TAcceptanceOfBoxesToArchiveMainForm.DisplayMessage(const AType: TMessageType; const AText: string);
var
  s: string;
  C: TColor;
begin
  case AType of
    mtInfo:
      begin
        s := Trim(AText);
        C := clBlack;
      end;
    mtSuccess:
      begin
        s := Trim(AText);
        C := clGreen;
      end;
    mtError:
      begin
        s := Trim(AText);
        C := clRed;
      end;
  else
    begin
      s := EmptyStr;
      C := clBlack;
    end;
  end;
  lblHint.Font.color := C;
  lblHint.Caption := s;
end;

function TAcceptanceOfBoxesToArchiveMainForm.GetBarcode: string;
begin
  Result := Trim(edBarcode.Text);
end;

function TAcceptanceOfBoxesToArchiveMainForm.GetLogic: IAcceptanceOfBoxesToArchiveBusinessLogic;
begin
  if not Assigned(FLogic) then
  begin
    FLogic := TAcceptanceOfBoxesToArchiveBusinessLogic.Create(ADOConnection, DisplayMessage);
    if Assigned(FLogic) then
    begin
      FLogic.SetLastBoxInfoControl(gbLastBox);
    end;
  end;
  Result := FLogic;
end;

procedure TAcceptanceOfBoxesToArchiveMainForm.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if edBarcode.Text <> s then
  begin
    edBarcode.Text := s;
  end;
end;

procedure TAcceptanceOfBoxesToArchiveMainForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TAcceptanceOfBoxesToArchiveMainForm.edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Logic.ProcessString(Barcode);
    Barcode := EmptyStr;
    Key := 0;
  end;
end;

procedure TAcceptanceOfBoxesToArchiveMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FLogic := nil; // не убирать!
end;

end.
