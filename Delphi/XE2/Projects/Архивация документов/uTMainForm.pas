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
    Button1: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Button2: TButton;
    Button3: TButton;
    ActionList: TActionList;
    actDeleteLastDocument: TAction;
    ADOConnection: TADOConnection;
    SQLConnection: TSQLConnection;
    Button4: TButton;
    Button5: TButton;
    actTestLogic: TAction;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure actDeleteLastDocumentExecute(Sender: TObject);
    procedure actDeleteLastDocumentUpdate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure actTestLogicUpdate(Sender: TObject);
    procedure actTestLogicExecute(Sender: TObject);
  private
    FLogic: IBSOArchivingLogic;
    function GetLogic: IBSOArchivingLogic;
    property Logic: IBSOArchivingLogic read GetLogic nodefault;
  private
    procedure AddAndShowDocument(const ADocumentClass: TDocumentClass;
      const AParent: TCustomControl);
    procedure DisplayMessage(const AType: TMessageType; const AText: string);
  private
    FBox: IArchiveBox;
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

procedure TMainForm.Button2Click(Sender: TObject);
begin
//  AddAndShowDocument(TDamagedBSO, GroupBox1);
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
//  AddAndShowDocument(TShipmentBSO, GroupBox1);
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
//  AddAndShowDocument(TShipmentBSOWithAct, GroupBox1);
end;

procedure TMainForm.AddAndShowDocument(const ADocumentClass: TDocumentClass;
  const AParent: TCustomControl);
//var
//  i: Integer;
begin
//  if not Assigned(FBox) then
//  begin
//    FBox := TAcriveBox.Create;
//  end;
//  i := FBox.AddDocument(ADocumentClass.Create);
//  if i > -1 then
//  begin
//    Logic.Connection.Connected := True;
//    try
//      //FBox.Documents[i].Load(Logic.Connection);
//    finally
//      Logic.Connection.Connected := False;
//    end;
//    FBox.Document[i].Show(AParent);
//    AutoSize := True;
//  end;
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

procedure TMainForm.actDeleteLastDocumentExecute(Sender: TObject);
begin
//  FBox.DeleteLastDocument;
//  if FBox.DocumentCount > 0 then
//  begin
//    FBox.Document[FBox.DocumentCount - 1].Show;
//  end;
end;

procedure TMainForm.actDeleteLastDocumentUpdate(Sender: TObject);
//var
//  b: Boolean;
begin
//  b := False;
//  if Assigned(FBox) then
//  begin
//    b := FBox.DocumentCount > 0;
//  end;
//  actDeleteLastDocument.Enabled := b;
end;

procedure TMainForm.actTestLogicExecute(Sender: TObject);
var
  ac: IArchiveCompany;
  doc: IDocument;
  box: TArchiveBox;
  idocl: TLoadableItemClass;
  ll: TLoadableItem;
begin
  Logic.Connection.Connected := True;
  try
  finally
    Logic.Connection.Connected := False;
  end;
end;

procedure TMainForm.actTestLogicUpdate(Sender: TObject);
//var
//  b: Boolean;
begin
//  b := False;
//  if Assigned(FBox) then
//  begin
//    b := FBox.DocumentCount > 0;
//  end;
//  actTestLogic.Enabled := b;
end;

end.
