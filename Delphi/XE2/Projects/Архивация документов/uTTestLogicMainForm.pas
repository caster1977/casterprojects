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
  Vcl.ToolWin;

type
  TTestLogicMainForm = class(TForm)
    btnTestLogic: TButton;
    gbInfo: TGroupBox;
    pnlButtons: TPanel;
    SQLConnection: TSQLConnection;
    ADOConnection: TADOConnection;
    ActionList: TActionList;
    actTestLogic: TAction;
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
    procedure actTestLogicExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
  private
    FLogic: IDocumentArchivingBusinessLogic;
    function GetLogic: IDocumentArchivingBusinessLogic;
    property Logic: IDocumentArchivingBusinessLogic read GetLogic nodefault;
  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string);
  end;

var
  TestLogicMainForm: TTestLogicMainForm;

implementation

{$R *.dfm}

uses
  uCommonRoutines,
  uIArchiveBoxItem,
  uTArchiveBoxItem,
  uIArchiveDocumentList,
  uTDocumentArchivingBusinessLogic;

procedure TTestLogicMainForm.DisplayMessage(const AType: TMessageType; const AText: string);
var
  s: string;
begin
  case AType of
    mtInfo:
      begin
        s := Trim('Info: ' + Trim(AText));
      end;
    mtSuccess:
      begin
        s := Trim('Success: ' + Trim(AText));
      end;
    mtError:
      begin
        s := Trim('Error: ' + Trim(AText));
      end;
  else
    begin
      s := EmptyStr;
    end;
  end;
  lblHint.Caption := s;
end;

function TTestLogicMainForm.GetLogic: IDocumentArchivingBusinessLogic;
begin
  if not Assigned(FLogic) then
  begin
    FLogic := TDocumentArchivingBusinessLogic.Create(ADOConnection, DisplayMessage);
  end;
  Result := FLogic;
end;

procedure TTestLogicMainForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TTestLogicMainForm.actTestLogicExecute(Sender: TObject);
var
  box: IArchiveBoxItem;
  doc_list: IArchiveDocumentList;
begin
  Logic.Connection.Connected := True;
  try
    box := TArchiveBoxItem.Create;
    box.TypeId := 1;
    if box.Save(Logic.Connection) then
      begin
        Logic.DisplaySuccessMessage('Saving box ok.');
      end
      else
      begin
        Logic.DisplayErrorMessage('Error saving box!');
      end;
    if Assigned(doc_list) then
    begin
      box.Documents.Add;
      box.Documents.Add;
      if box.Documents.Save(Logic.Connection) then
      begin
        Logic.DisplaySuccessMessage('Saving docs ok.');
      end
      else
      begin
        Logic.DisplayErrorMessage('Error saving docs!');
      end;
    end;
  finally
    Logic.Connection.Connected := False;
  end;
end;

end.
