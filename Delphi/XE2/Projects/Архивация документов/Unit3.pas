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
  uTCustomDocumentClass;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FBox: IArchiveBox;
  private
    procedure AddAndShowDocument(const ADocumentClass: TCustomDocumentClass; const AParent: TCustomControl);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
  uTArchiveBox,
  uICustomDocument,
  uTDamagedBSO;

procedure TForm3.Button1Click(Sender: TObject);
var
  doc: ICustomDocument;
begin
  FBox.DeleteLastDocument;
  if FBox.DocumentCount > 0 then
  begin
    FBox.Documents[FBox.DocumentCount - 1].Show;
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  AddAndShowDocument(TDamagedBSO, GroupBox1);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  AddAndShowDocument(TDamagedBSO, Panel1);
end;

procedure TForm3.AddAndShowDocument(const ADocumentClass: TCustomDocumentClass; const AParent: TCustomControl);
begin
  if not Assigned(FBox) then
  begin
    FBox := TAcriveBox.Create;
  end;
  FBox.AddDocument(ADocumentClass.Create);
  FBox.Documents[FBox.DocumentCount - 1].Show(AParent);
  AutoSize := True;
end;

end.
