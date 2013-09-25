unit uTTestLogicMainForm;

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
  uIDocumentArchivingBusinessLogic,
  uTMessageType,
  Vcl.ImgList,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  frxClass,
  frxBarcode;

type
  TTestLogicMainForm = class(TForm)
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
    ToolButton1: TToolButton;
    actTestAcceptBSOByAcceptanceRegister: TAction;
    tbTestAcceptBSOByAcceptanceRegister: TToolButton;
    procedure actCloseExecute(Sender: TObject);
    procedure actPrintStickerExecute(Sender: TObject);
    procedure actPrintStickerUpdate(Sender: TObject);
    procedure actTestAcceptBSOByAcceptanceRegisterExecute(Sender: TObject);
    procedure actTestAcceptBSOByAcceptanceRegisterUpdate(Sender: TObject);
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
  TestLogicMainForm: TTestLogicMainForm;

implementation

{$R *.dfm}

uses
  uTDocumentArchivingBarcodeType,
  uCommonRoutines,
  uIArchiveBoxItem,
  uTArchiveBoxItem,
  uIArchiveDocumentList,
  uTDocumentArchivingBusinessLogic,
  uIShowable,
  uICustomBSOItem;

procedure TTestLogicMainForm.DisplayMessage(const AType: TMessageType; const AText: string);
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

function TTestLogicMainForm.GetBarcode: string;
begin
  Result := Trim(edBarcode.Text);
end;

function TTestLogicMainForm.GetLogic: IDocumentArchivingBusinessLogic;
begin
  if not Assigned(FLogic) then
  begin
    FLogic := TDocumentArchivingBusinessLogic.Create(ADOConnection, 222, 1, DisplayMessage);
    Logic.SetCurrentBoxInfoControl(gbCurrentBox);
    Logic.SetLastDocumentInfoControl(gbLastDocument);
  end;
  Result := FLogic;
end;

procedure TTestLogicMainForm.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if edBarcode.Text <> s then
  begin
    edBarcode.Text := s;
  end;
end;

procedure TTestLogicMainForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TTestLogicMainForm.actDeleteLastDocumentUpdate(Sender: TObject);
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

procedure TTestLogicMainForm.actDeleteLastDocumentExecute(Sender: TObject);
begin
  Logic.ManualDeleteLastDocumentFromCurrentBox;
end;

procedure TTestLogicMainForm.actPrintStickerExecute(Sender: TObject);
begin
  Logic.ManualPrintCurrentBoxSticker;
end;

procedure TTestLogicMainForm.actPrintStickerUpdate(Sender: TObject);
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

procedure TTestLogicMainForm.edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Logic.Connection.Connected := True;
    try
      Logic.ProcessString(Barcode);
      Barcode := EmptyStr;
    finally
      Logic.Connection.Connected := False;
    end;
    Key := 0;
  end;
end;

procedure TTestLogicMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FLogic := nil; // не убирать!
end;

procedure TTestLogicMainForm.actTestAcceptBSOByAcceptanceRegisterExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
    if Logic.AcceptBSOByAcceptanceRegister(Logic.CurrentBox.Documents.Item[Logic.CurrentBox.Documents.Count - 1]
      as ICustomBSOItem) then
    begin
      Logic.DisplaySuccessMessage('Документ принят по реестру ЛП');
    end
    else
    begin
      Logic.DisplayErrorMessage('Документ не принят по реестру ЛП');
    end;
  finally
    Logic.Connection.Connected := False;
  end;
end;

procedure TTestLogicMainForm.actTestAcceptBSOByAcceptanceRegisterUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Logic) then
  begin
    if Assigned(Logic.CurrentBox) then
    begin
      if Assigned(Logic.CurrentBox.Documents) then
      begin
        b := (Logic.CurrentBox.Documents.Count > 0) and
          Supports(Logic.CurrentBox.Documents.Item[Logic.CurrentBox.Documents.Count - 1], ICustomBSOItem);
      end;
    end;
  end;
  (Sender as TAction).Enabled := b;
end;

end.
