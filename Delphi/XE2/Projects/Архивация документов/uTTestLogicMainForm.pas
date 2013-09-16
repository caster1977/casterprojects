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
  uTDocumentArchivingBusinessLogic,
  uIShowable;

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
    Logic.CurrentBoxInfoControl := gbCurrentBox;
    Logic.LastDocumentInfoControl := gbLastDocument;
  end;
  Result := FLogic;
end;

procedure TTestLogicMainForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TTestLogicMainForm.actTestLogicExecute(Sender: TObject);
begin
  Logic.Connection.Connected := True;
  try
    Logic.CurrentBox := TArchiveBoxItem.Create(Logic.Connection, 10);
    Logic.ShowCurrentBoxInfo;
    Logic.PrintCurrentBoxSticker;
    ShowMessage('ShowCurrentBoxInfo');

    Logic.CurrentBox := TArchiveBoxItem.Create(Logic.Connection, 11);
    Logic.ShowCurrentBoxInfo;
    Logic.PutCurrentBoxAside;
    ShowMessage('PutCurrentBoxAside');

    Logic.CurrentBox := TArchiveBoxItem.Create(Logic.Connection, 12);
    Logic.ShowCurrentBoxInfo;
    Logic.CloseCurrentBox;
    ShowMessage('CloseCurrentBox');

    Logic.CurrentBox := TArchiveBoxItem.Create(Logic.Connection, 16);
    Logic.ShowCurrentBoxInfo;
    Logic.DeleteCurrentBox;
    ShowMessage('DeleteCurrentBox');

    Logic.CurrentBox := TArchiveBoxItem.Create(Logic.Connection, 17);
    Logic.ShowCurrentBoxInfo;
    ShowMessage('CurrentBoxIsFull = ' + BoolToStr(Logic.CurrentBoxIsFull, True));
  finally
    Logic.Connection.Connected := False;
  end;
end;

end.
