unit Unit3;

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
  uTCustomDocumentClass,
  System.Actions,
  Vcl.ActnList,
  Data.DB,
  Data.Win.ADODB,
  Data.DBXMSSQL,
  Data.FMTBcd,
  Data.SqlExpr;

type
  TForm3 = class(TForm)
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
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure actDeleteLastDocumentExecute(Sender: TObject);
    procedure actDeleteLastDocumentUpdate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FBox: IArchiveBox;
  private
    procedure AddAndShowDocument(const ADocumentClass: TCustomDocumentClass;
      const AParent: TCustomControl);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
  uTArchiveBox,
  uICustomDocument,
  uTDamagedBSO,
  uTShipmentBSO,
  uTShipmentBSOWithAct;

procedure TForm3.AddAndShowDocument(const ADocumentClass: TCustomDocumentClass;
  const AParent: TCustomControl);
var
  i: Integer;
begin
  if not Assigned(FBox) then
  begin
    FBox := TAcriveBox.Create;
  end;
  i := FBox.AddDocument(ADocumentClass.Create);
  if i > -1 then
  begin
    ADOConnection.Connected := True;
    try
      FBox.Documents[i].Load(ADOConnection);
    finally
      ADOConnection.Connected := False;
    end;
    FBox.Documents[i].Show(AParent);
    AutoSize := True;
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  AddAndShowDocument(TDamagedBSO, GroupBox1);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  AddAndShowDocument(TShipmentBSO, GroupBox1);
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  AddAndShowDocument(TShipmentBSOWithAct, GroupBox1);
end;

procedure TForm3.actDeleteLastDocumentExecute(Sender: TObject);
begin
  FBox.DeleteLastDocument;
  if FBox.DocumentCount > 0 then
  begin
    FBox.Documents[FBox.DocumentCount - 1].Show;
  end;
end;

procedure TForm3.actDeleteLastDocumentUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(FBox) then
  begin
    b := FBox.DocumentCount > 0;
  end;
  actDeleteLastDocument.Enabled := b;
end;

end.
