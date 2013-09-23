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
    gbInfo: TGroupBox;
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
    actTestCloseCurrentBox: TAction;
    actTestPutCurrentBoxAside: TAction;
    actTestDeleteCurrentBox: TAction;
    actTestCurrentBoxIsFull: TAction;
    tbTestCloseCurrentBox: TToolButton;
    actTestAddDocument: TAction;
    actTestForceNewBox: TAction;
    tbTestAddDocument: TToolButton;
    tbTestCurrentBoxIsFull: TToolButton;
    tbTestPutCurrentBoxAside: TToolButton;
    tbTestForceNewBox: TToolButton;
    tbTestDeleteCurrentBox: TToolButton;
    actTestAcceptBSOByAcceptanceRegister: TAction;
    tbTestAcceptBSOByAcceptanceRegister: TToolButton;
    procedure actCloseExecute(Sender: TObject);
    procedure actPrintStickerExecute(Sender: TObject);
    procedure actPrintStickerUpdate(Sender: TObject);
    procedure actTestCloseCurrentBoxExecute(Sender: TObject);
    procedure actTestCloseCurrentBoxUpdate(Sender: TObject);
    procedure actTestPutCurrentBoxAsideExecute(Sender: TObject);
    procedure actTestPutCurrentBoxAsideUpdate(Sender: TObject);
    procedure actTestDeleteCurrentBoxUpdate(Sender: TObject);
    procedure actTestDeleteCurrentBoxExecute(Sender: TObject);
    procedure actTestCurrentBoxIsFullExecute(Sender: TObject);
    procedure actTestCurrentBoxIsFullUpdate(Sender: TObject);
    procedure actTestAcceptBSOByAcceptanceRegisterExecute(Sender: TObject);
    procedure actTestAcceptBSOByAcceptanceRegisterUpdate(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actTestAddDocumentExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actDeleteLastDocumentExecute(Sender: TObject);
    procedure actDeleteLastDocumentUpdate(Sender: TObject);
  private
    FLogic: IDocumentArchivingBusinessLogic;
    function GetLogic: IDocumentArchivingBusinessLogic;
    property Logic: IDocumentArchivingBusinessLogic read GetLogic nodefault;
  private
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
    property Barcode: string read GetBarcode write SetBarcode nodefault;
  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string);
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
    Logic.CurrentBoxInfoControl := gbCurrentBox;
    Logic.LastDocumentInfoControl := gbLastDocument;
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

procedure TTestLogicMainForm.actDeleteLastDocumentExecute(Sender: TObject);
begin
  Logic.DeleteLastDocument;
end;

procedure TTestLogicMainForm.actDeleteLastDocumentUpdate(Sender: TObject);
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
        b := Logic.CurrentBox.Documents.Count > 0;
      end;
    end;
  end;
  (Sender as TAction).Enabled := b;
end;

procedure TTestLogicMainForm.actPrintStickerExecute(Sender: TObject);
begin
  Logic.PrintCurrentBoxSticker;
end;

procedure TTestLogicMainForm.actPrintStickerUpdate(Sender: TObject);
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
        b := Logic.CurrentBox.Documents.Count > 1;
      end;
    end;
  end;
  (Sender as TAction).Enabled := b;
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

procedure TTestLogicMainForm.actTestCloseCurrentBoxExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
    Logic.CloseCurrentBox;
  finally
    Logic.Connection.Connected := False;
  end;
end;

procedure TTestLogicMainForm.actTestCloseCurrentBoxUpdate(Sender: TObject);
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
        b := Logic.CurrentBox.Documents.Count > 0;
      end;
    end;
  end;
  (Sender as TAction).Enabled := b;
end;

procedure TTestLogicMainForm.actTestCurrentBoxIsFullExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
    Logic.ArchiveBoxIsFull;
  finally
    Logic.Connection.Connected := False;
  end;
end;

procedure TTestLogicMainForm.actTestCurrentBoxIsFullUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Logic) then
  begin
    b := Assigned(Logic.CurrentBox);
  end;
  (Sender as TAction).Enabled := b;
end;

procedure TTestLogicMainForm.actTestDeleteCurrentBoxExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
    Logic.DeleteCurrentBox;
  finally
    Logic.Connection.Connected := False;
  end;
end;

procedure TTestLogicMainForm.actTestDeleteCurrentBoxUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Logic) then
  begin
    b := Assigned(Logic.CurrentBox);
  end;
  (Sender as TAction).Enabled := b;
end;

procedure TTestLogicMainForm.actTestPutCurrentBoxAsideExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
    Logic.PutCurrentBoxAside;
  finally
    Logic.Connection.Connected := False;
  end;
end;

procedure TTestLogicMainForm.actTestPutCurrentBoxAsideUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Logic) then
  begin
    b := Assigned(Logic.CurrentBox);
  end;
  (Sender as TAction).Enabled := b;
end;

procedure TTestLogicMainForm.actTestAcceptBSOByAcceptanceRegisterExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
    Logic.AcceptBSOByAcceptanceRegister(Logic.CurrentBox.Documents.Item[Logic.CurrentBox.Documents.Count - 1]
      as ICustomBSOItem);
  finally
    Logic.Connection.Connected := False;
  end;
end;

procedure TTestLogicMainForm.edBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Logic.Connection.Connected := True;
    try
      Logic.ProcessBarcode(Barcode);
      Barcode := EmptyStr;
    finally
      Logic.Connection.Connected := False;
    end;
    Key := 0;
  end;
end;

procedure TTestLogicMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(Logic) then
  begin
    Logic.PutCurrentBoxAside;
  end;
end;

procedure TTestLogicMainForm.actTestAddDocumentExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
  finally
    Logic.Connection.Connected := False;
  end;
end;

end.
