unit uTMainForm;

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
  uIArchiveBox,
  Vcl.ExtCtrls,
  uTDocumentClass,
  System.Actions,
  Vcl.ActnList,
  Data.DB,
  Data.Win.ADODB,
  Data.DBXMSSQL,
  Data.FMTBcd,
  Data.SqlExpr,
  uIBSOArchivingLogic,
  uTMessageType;

type
  TMainForm = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    ActionList: TActionList;
    actDeleteLastDocument: TAction;
    ADOConnection: TADOConnection;
    SQLConnection: TSQLConnection;
    Button5: TButton;
    actTestLogic: TAction;
    procedure actTestLogicExecute(Sender: TObject);
  private
    FLogic: IBSOArchivingLogic;
    function GetLogic: IBSOArchivingLogic;
    property Logic: IBSOArchivingLogic read GetLogic nodefault;
  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uTBSOArchivingLogic,
  uTArchiveBox,
  uIArchiveCompany,
  uIDocument,
  uTLoadableListClass,
  uTCustomBSO,
  uTDamagedBSO,
  uIDocuments,
  uTDocuments,
  uTLoadableItem,
  uTLoadableItemClass,
  uTShipmentBSO,
  uTShipmentBSOWithAct,
  uTDamagedBSOList,
  uTShipmentBSOList,
  uTLoadableList,
  uTShipmentBSOWithActList;

function TMainForm.GetLogic: IBSOArchivingLogic;
begin
  if not Assigned(FLogic) then
  begin
    FLogic := TBSOArchivingLogic.Create(ADOConnection);
    FLogic.OnDisplayMessage := DisplayMessage;
  end;
  Result := FLogic;
end;

procedure TMainForm.DisplayMessage(const AType: TMessageType; const AText: string);
begin
  case AType of
    mtInfo:
      begin
        Caption := Trim('Info' + ' ' + Trim(AText));
      end;
    mtSuccess:
      begin
        Caption := Trim('Success' + ' ' + Trim(AText));
      end;
    mtError:
      begin
        Caption := Trim('Error' + ' ' + Trim(AText));
      end;
    mtNone:
      begin
        Caption := EmptyStr;
      end;
  end;
end;

procedure TMainForm.actTestLogicExecute(Sender: TObject);
var
  doc: TShipmentBSO;
begin
  Logic.Connection.Connected := True;
  try
    Logic.CurrentBox := TArchiveBox.Create(Logic.Connection, TShipmentBSOList);
    doc := TShipmentBSO.Create;
    doc.CompanyName := '1';
    doc.Series := '2';
    doc.Barcode := '3';
    doc.Number := '4';
    doc.TypeName := '5';
    doc.Id := 6;
    Logic.CurrentBox.Documents.Add(doc);
    Logic.CurrentBox.Documents.Items[0].Show(GroupBox1);
    AutoSize := True;
    AutoSize := False;
  finally
    Logic.Connection.Connected := False;
  end;
end;

end.
