unit uTArchivingMainForm;

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
  uIDocumentArchivingBusinessLogic,
  uTMessageType,
  ImgList,
  ComCtrls,
  ToolWin,
  frxClass,
  frxBarcode;

type
  TArchivingMainForm = class(TForm)
    pnlButtons: TPanel;
    SQLConnection: TSQLConnection;
    ADOConnection: TADOConnection;
    ActionList: TActionList;
    ToolBar: TToolBar;
    tbPrintSticker: TToolButton;
    tbDeleteLastDocument: TToolButton;
    tbSeparator: TToolButton;
    actPrintSticker: TAction;
    actDeleteLastDocument: TAction;
    ImageList: TImageList;
    gbCurrentBox: TGroupBox;
    gbLastDocument: TGroupBox;
    gbBarcode: TGroupBox;
    edBarcode: TEdit;
    gbHint: TGroupBox;
    btnClose: TButton;
    actClose: TAction;
    lblHint: TLabel;
    procedure actCloseExecute(Sender: TObject);
    procedure actPrintStickerExecute(Sender: TObject);
    procedure actPrintStickerUpdate(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actDeleteLastDocumentExecute(Sender: TObject);
    procedure actDeleteLastDocumentUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FLogic: IDocumentArchivingBusinessLogic;
    function GetLogic: IDocumentArchivingBusinessLogic;
    property Logic: IDocumentArchivingBusinessLogic read GetLogic nodefault;
  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string);
  private
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
    property Barcode: string read GetBarcode write SetBarcode nodefault;
  end;

var
  ArchivingMainForm: TArchivingMainForm;

implementation

{$R *.dfm}

uses
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
  uTDamagedBSOArchivingBusinessLogic;

/// <summary>
/// Функция, возвращающая класс бизнес-логики по указанному типу архивного короба
/// </summary>
function GetArchiveDocumentBusinessLogicClassByTypeId(const ATypeId: Integer): TDocumentArchivingBusinessLogicClass;
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
end;

procedure TArchivingMainForm.DisplayMessage(const AType: TMessageType; const AText: string);
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
end;

function TArchivingMainForm.GetBarcode: string;
begin
  Result := Trim(edBarcode.Text);
end;

function TArchivingMainForm.GetLogic: IDocumentArchivingBusinessLogic;
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
end;

procedure TArchivingMainForm.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if edBarcode.Text <> s then
  begin
    edBarcode.Text := s;
  end;
end;

procedure TArchivingMainForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TArchivingMainForm.actDeleteLastDocumentUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Logic) then
  begin
    b := Logic.GetCurrentBoxDocumentCount > 0;
  end;
  (Sender as TAction).Enabled := b;
end;

procedure TArchivingMainForm.actDeleteLastDocumentExecute(Sender: TObject);
begin
  Logic.ManualDeleteLastDocumentFromCurrentBox;
end;

procedure TArchivingMainForm.actPrintStickerExecute(Sender: TObject);
begin
  Logic.ManualPrintCurrentBoxSticker;
end;

procedure TArchivingMainForm.actPrintStickerUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Logic) then
  begin
    b := Logic.GetCurrentBoxDocumentCount > 1;
  end;
  (Sender as TAction).Enabled := b;
end;

procedure TArchivingMainForm.edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Logic.ProcessString(Barcode);
    Barcode := EmptyStr;
    Key := 0;
  end;
end;

procedure TArchivingMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FLogic := nil; // не убирать!
end;

end.
