unit uTEnterStringForm;

interface

uses
  Windows,
  Messages,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  ActnList;

type
  TEnterStringForm = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    gbEnterString: TGroupBox;
    edtEnterString: TEdit;
    ActionList1: TActionList;
    actOk: TAction;
    actCancel: TAction;
    procedure actCancelExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actOkUpdate(Sender: TObject);
  private
    function GetValue: string;
  public
    constructor Create(const ACaption, ATitle: string; const AMaxLength: Integer; const ANumeric: Boolean); reintroduce;
    property Value: string read GetValue nodefault;
  end;

var
  EnterStringForm: TEnterStringForm;

implementation

{$R *.dfm}

uses
  SysUtils,
  uArchivingCommonRoutines;

procedure TEnterStringForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TEnterStringForm.actOkExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TEnterStringForm.actOkUpdate(Sender: TObject);
begin
  actOk.Enabled := Length(Value) > 0;
  btnOk.Default := actOk.Enabled;
end;

constructor TEnterStringForm.Create(const ACaption, ATitle: string; const AMaxLength: Integer; const ANumeric: Boolean);
var
  s: string;
begin
  inherited Create(Application.MainForm);
  Caption := Trim(ACaption);
  s := Trim(ATitle);
  if s > EmptyStr then
  begin
    s := ' ' + s + ' ';
  end;
  gbEnterString.Caption := s;
  if ANumeric then
  begin
    SetNumbersOnly(edtEnterString.Handle);
  end;
  edtEnterString.MaxLength := AMaxLength;
end;

function TEnterStringForm.GetValue: string;
begin
  Result := Trim(edtEnterString.Text);
end;

end.
