unit Unit3;

interface

uses
  Controls,
  Forms,
  CheckLst,
  StdCtrls,
  Classes,
  ExtCtrls,
  Actions,
  ActnList,
  DB;

type
  TItemSelectionForm = class(TForm)
    pnlBottom: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    clbList: TCheckListBox;
    ActionList1: TActionList;
    actApply: TAction;
    actCancel: TAction;
    procedure actCancelExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
  private
    FConnection: TCustomConnection;
    FStoredProcName: string;
    FResultTableName: string;
    procedure SetCaptions;
  public
    constructor Create(const AConnection: TCustomConnection; const ACaption, AStoredProcName, AResultTableName: string);
      reintroduce;
  end;

function ShowItemSelectionForm(const AConnection: TCustomConnection;
  const ACaption, AStoredProcName, AResultTableName: string): TModalResult;

implementation

{$R *.dfm}

uses
  SysUtils;

resourcestring
  RsAConnectionIsNil = 'AConnection is nil';
  RsAStoredProcNameIsEmptyStr = 'AStoredProcName is EmptyStr';
  RsAResultTableNameIsEmptyStr = 'AResultTableName is EmptyStr';
  RsApply = '&Применить';
  RsCancel = '&Отмена';

function ShowItemSelectionForm(const AConnection: TCustomConnection;
  const ACaption, AStoredProcName, AResultTableName: string): TModalResult;
var
  form: TItemSelectionForm;
begin
  form := TItemSelectionForm.Create(AConnection, ACaption, AStoredProcName, AResultTableName);
  try
    Result := form.ShowModal;
  finally
    form.Free;
  end;
end;

procedure TItemSelectionForm.actApplyExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TItemSelectionForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

constructor TItemSelectionForm.Create(const AConnection: TCustomConnection;
  const ACaption, AStoredProcName, AResultTableName: string);
begin
  Assert(Assigned(AConnection), RsAConnectionIsNil);
  Assert(Trim(AStoredProcName) > EmptyStr, RsAStoredProcNameIsEmptyStr);
  Assert(Trim(AResultTableName) > EmptyStr, RsAResultTableNameIsEmptyStr);
  FConnection := AConnection;
  FStoredProcName := AStoredProcName;
  FResultTableName := AResultTableName;
  Caption := ACaption;
  SetCaptions;
end;

procedure TItemSelectionForm.SetCaptions;
begin
  actApply.Caption := RsApply;
  actCancel.Caption := RsCancel;
end;

end.
