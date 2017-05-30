unit Budgeting.UI.CustomEdit;

interface

uses
  Winapi.Windows,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ActnList,
  Vcl.StdCtrls,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxCheckBox,
  Vcl.Menus,
  cxTextEdit,
  System.Actions,
  FireDAC.Comp.Client,
  cxLabel,
  System.Classes,
  cxDropDownEdit,
  cxCalc,
  cxMaskEdit,
  System.SysUtils,
  System.Generics.Collections,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Types.TViewEnumAction,
  Budgeting.Logic.Types.TViewEnumActionArray,
  Budgeting.Logic.Interfaces.Views.ICustomView,
  Budgeting.Logic.Interfaces.Views.ICustomEditView,
  cxProgressBar;

type
  TfrmCustomEdit = class(TForm, ICustomView, ICustomEditView)
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    bvl1: TBevel;
    pbProgress: TcxProgressBar;
    procedure actSaveUpdate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);

  strict private
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    procedure RefreshStates();
    procedure ShowProgress(const aTitle: string; const aMax: Integer);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress();
    function ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;
    function GetControl: TWinControl;
    procedure SetCaption(const aValue: string);
    procedure StorePresenter(const aPresenter: IInterface);
    procedure OnEventSimpleStub(aValue: TViewEnumEvent);

  strict protected
    FId: Integer;
    FOnEventSimple: TProc<TViewEnumEvent>;
    FItemCanUpdate: Boolean;
    function GetItem(): IInterface; virtual; abstract;
    procedure SetItem(const aValue: IInterface); virtual;
    procedure Initialize(); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Consts;

procedure TfrmCustomEdit.actCancelExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veCancelExecute);
    ModalResult := mrCancel;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmCustomEdit.actCancelUpdate(Sender: TObject);
begin
  FOnEventSimple(veCancelUpdate);
  (Sender as TAction).Enabled := FActionStates[vaCancel];
end;

procedure TfrmCustomEdit.actSaveExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veSaveExecute);
    ModalResult := mrOk;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmCustomEdit.actSaveUpdate(Sender: TObject);
begin
  FOnEventSimple(veSaveUpdate);
  (Sender as TAction).Enabled := FActionStates[vaSave];
end;

constructor TfrmCustomEdit.Create(AOwner: TComponent);
begin
  inherited;
  FId := -1;
  FOnEventSimple := OnEventSimpleStub;
end;

function TfrmCustomEdit.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

function TfrmCustomEdit.GetControl(): TWinControl;
begin
  Result := Self;
end;

procedure TfrmCustomEdit.RefreshStates();
var
  i: Integer;
begin
  for i := 0 to Pred(ActionList.ActionCount) do
  begin
    ActionList.Actions[i].Update();
  end;
end;

procedure TfrmCustomEdit.SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TfrmCustomEdit.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  if Assigned(aValue) then
  begin
    FOnEventSimple := aValue;
  end
  else
  begin
    FOnEventSimple := OnEventSimpleStub;
  end;
end;

function TfrmCustomEdit.ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;
var
  sCaption: string;
begin
  case aStatus of
    MESSAGE_TYPE_OK:
      sCaption := Format('%s - Информация', [Application.Title]);
    MESSAGE_TYPE_ERROR:
      sCaption := Format('%s - Ошибка', [Application.Title]);
    MESSAGE_TYPE_WARNING, MESSAGE_TYPE_CONFIRMATION_WARNING_OK, MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL:
      sCaption := Format('%s - Внимание', [Application.Title]);
    MESSAGE_TYPE_CONFIRMATION_QUESTION:
      sCaption := Format('%s - Подтверждение', [Application.Title]);
  end;
  Result := MessageBox(Handle, PWideChar(aMessage), PWideChar(sCaption), aStatus);
end;

procedure TfrmCustomEdit.ShowProgress(const aTitle: string; const aMax: Integer);
begin
  pbProgress.Properties.Text := aTitle.Trim();
  pbProgress.Properties.Max := aMax;
  pbProgress.EditValue := 0;
  pbProgress.Visible := True;
  Application.ProcessMessages();
end;

procedure TfrmCustomEdit.StepProgress(const aNewTitle: string; const aToPosition: Integer);
var
  i: Integer;
begin
  if aNewTitle <> EmptyStr then
  begin
    pbProgress.Properties.Text := aNewTitle.Trim();
  end;
  if aToPosition > -1 then
  begin
    pbProgress.EditValue := aToPosition;
  end
  else
  begin
    i := pbProgress.EditValue;
    pbProgress.EditValue := Succ(i);
  end;
end;

procedure TfrmCustomEdit.StorePresenter(const aPresenter: IInterface);
begin
  FPresenter := aPresenter;
end;

procedure TfrmCustomEdit.HideProgress();
begin
  pbProgress.Properties.Text := EmptyStr;
  pbProgress.Visible := False;
end;

procedure TfrmCustomEdit.Initialize();
begin
end;

procedure TfrmCustomEdit.OnEventSimpleStub(aValue: TViewEnumEvent);
begin

end;

procedure TfrmCustomEdit.SetCaption(const aValue: string);
begin
  Caption := aValue;
end;

procedure TfrmCustomEdit.SetItem(const aValue: IInterface);
var
  tmpItem: ICustomModel;
begin
  FId := -1;

  if Supports(aValue, ICustomModel, tmpItem) then
  begin
    FId := tmpItem.Id;
  end;
end;

end.
