unit uTBoxAcceptanceToArchiveMainForm;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Data.DBXMSSQL,
  System.Actions,
  Vcl.ActnList,
  Data.Win.ADODB,
  Data.DB,
  Data.SqlExpr,
  {uIDocumentArchivingBusinessLogic,
  uTMessageType,}
  Vcl.ImgList,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  frxClass,
  frxBarcode;

type
  TBoxAcceptanceToArchiveMainForm = class(TForm)
    pnlButtons: TPanel;
    SQLConnection: TSQLConnection;
    ADOConnection: TADOConnection;
    ActionList: TActionList;
    actPrintSticker: TAction;
    actDeleteLastDocument: TAction;
    ImageList: TImageList;
    gbCurrentBox: TGroupBox;
    gbBarcode: TGroupBox;
    edBarcode: TEdit;
    gbHint: TGroupBox;
    btnClose: TButton;
    actClose: TAction;
    lblHint: TLabel;
    procedure actCloseExecute(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  {private
    FLogic: IDocumentArchivingBusinessLogic;
    function GetLogic: IDocumentArchivingBusinessLogic;
    property Logic: IDocumentArchivingBusinessLogic read GetLogic nodefault;
  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string);}
  private
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
    property Barcode: string read GetBarcode write SetBarcode nodefault;
  end;

var
  BoxAcceptanceToArchiveMainForm: TBoxAcceptanceToArchiveMainForm;

implementation

{$R *.dfm}

{uses
  uTDocumentArchivingBarcodeType,
  uArchivingCommonRoutines,
  uIArchiveBoxItem,
  uTArchiveBoxItem,
  uIArchiveDocumentList,
  uTDocumentArchivingBusinessLogicClass,
  uIShowable,
  uICustomBSOItem,
  uTShipmentBSOArchivingBusinessLogic,
  uTShipmentBSOWithActArchivingBusinessLogic,
  uTDamagedBSOArchivingBusinessLogic;}

/// <summary>
/// Функция, возвращающая класс бизнес-логики по указанному типу архивного короба
/// </summary>
{function GetArchiveDocumentBusinessLogicClassByTypeId(const ATypeId: Integer): TDocumentArchivingBusinessLogicClass;
begin
  case ATypeId of
    1:
      begin
        Result := TShipmentBSOArchivingBusinessLogic;
      end;
    2:
      begin
        Result := TShipmentBSOWithActArchivingBusinessLogic;
      end;
    5:
      begin
        Result := TDamagedBSOArchivingBusinessLogic;
      end;
  else
    begin
      Result := nil;
    end;
  end;
end;}

{procedure TBoxAcceptanceToArchiveMainForm.DisplayMessage(const AType: TMessageType; const AText: string);
var
  s: string;
  c: TColor;
begin
  case AType of
    mtInfo:
      begin
        s := Trim(AText);
        c := clBlack;
      end;
    mtSuccess:
      begin
        s := Trim(AText);
        c := clGreen;
      end;
    mtError:
      begin
        s := Trim(AText);
        c := clRed;
      end;
  else
    begin
      s := EmptyStr;
      c := clBlack;
    end;
  end;
  lblHint.Font.Color := c;
  lblHint.Caption := s;
end;}

function TBoxAcceptanceToArchiveMainForm.GetBarcode: string;
begin
  Result := Trim(edBarcode.Text);
end;

{function TBoxAcceptanceToArchiveMainForm.GetLogic: IDocumentArchivingBusinessLogic;
var
  lc: TDocumentArchivingBusinessLogicClass;
begin
  if not Assigned(FLogic) then
  begin
    lc := GetArchiveDocumentBusinessLogicClassByTypeId(1);
    if Assigned(lc) then
    begin
      FLogic := lc.Create(ADOConnection, 222, DisplayMessage);
      if Assigned(FLogic) then
      begin
        FLogic.SetCurrentBoxInfoControl(gbCurrentBox);
        FLogic.SetLastDocumentInfoControl(gbLastDocument);
      end;
    end;
  end;
  Result := FLogic;
end;}

procedure TBoxAcceptanceToArchiveMainForm.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if edBarcode.Text <> s then
  begin
    edBarcode.Text := s;
  end;
end;

procedure TBoxAcceptanceToArchiveMainForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TBoxAcceptanceToArchiveMainForm.edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    try
//      Logic.ProcessString(Barcode);
      Barcode := EmptyStr;
    finally
//      Logic.Connection.Connected := False;
    end;
    Key := 0;
  end;
end;

procedure TBoxAcceptanceToArchiveMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  FLogic := nil; // не убирать!
end;

{ TODO -ov_ivanov : в процедуре AddDocument добавить проверку на существование БСО с указанным кодом }
{ TODO -ov_ivanov : убрать автоматическую печать стикера после передачи единственного документа }

end.
