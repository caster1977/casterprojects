unit Budgeting.UI.Details.Bank;

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
  Budgeting.Logic.TViewEnumEvent,
  Budgeting.Logic.TViewEnumAction,
  Budgeting.Logic.TViewEnumActionArray,
  Budgeting.Logic.Interfaces.View.ICustomView,
  Budgeting.Logic.Interfaces.View.IBank,
  cxCurrencyEdit,
  cxSpinEdit;

type
  TfrmBank = class(TForm, ICustomView, IBank)
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    bvl1: TBevel;
    cxlblName: TcxLabel;
    edtName: TcxTextEdit;
    cxlblCode: TcxLabel;
    edtCode: TcxTextEdit;
    cxlblAddress: TcxLabel;
    edtAddress: TcxTextEdit;
    chkActivity: TcxCheckBox;
    procedure actSaveUpdate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);

  strict private
    FOnEventSimple: TProc<TViewEnumEvent>;
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;
    FId: Variant;
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

    function GetItem(): IInterface;
    procedure SetItem(const aValue: IInterface);
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.IBank,
  Budgeting.Logic.Classes.TBank,
  Budgeting.Logic.Consts;

procedure TfrmBank.actCancelExecute(Sender: TObject);
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

procedure TfrmBank.actCancelUpdate(Sender: TObject);
begin
  FOnEventSimple(veCancelUpdate);
  (Sender as TAction).Enabled := FActionStates[vaCancel];
end;

procedure TfrmBank.actSaveExecute(Sender: TObject);
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

procedure TfrmBank.actSaveUpdate(Sender: TObject);
begin
  FOnEventSimple(veSaveUpdate);
  (Sender as TAction).Enabled := FActionStates[vaSave];
end;

function TfrmBank.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

function TfrmBank.GetControl(): TWinControl;
begin
  Result := Self;
end;

procedure TfrmBank.RefreshStates();
var
  i: Integer;
begin
  for i := 0 to Pred(ActionList.ActionCount) do
  begin
    ActionList.Actions[i].Update();
  end;
end;

procedure TfrmBank.SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TfrmBank.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  FOnEventSimple := aValue;
end;

function TfrmBank.ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;
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

procedure TfrmBank.ShowProgress(const aTitle: string; const aMax: Integer);
begin
end;

procedure TfrmBank.StepProgress(const aNewTitle: string;
  const aToPosition: Integer);
begin
end;

procedure TfrmBank.StorePresenter(const aPresenter: IInterface);
begin
  FPresenter := aPresenter;
end;

procedure TfrmBank.SetItem(const aValue: IInterface);
var
  tmpItem: IBank;
begin
  if Supports(aValue, IBank, tmpItem) then
  begin
    FId := tmpItem.Id;
    edtName.EditValue := string.Empty;
    edtCode.EditValue := string.Empty;
    edtAddress.EditValue := string.Empty;
    chkActivity.EditValue := False;

    if Supports(aValue, IBank, tmpItem) then
    begin
      edtName.EditValue := tmpItem.Name;
      edtCode.EditValue := tmpItem.Code;
      edtAddress.EditValue := tmpItem.Address;
      chkActivity.EditValue := tmpItem.Activity;
    end;
  end;
end;

function TfrmBank.GetItem(): IInterface;
var
  tmpId: Variant;
  tmpName: Variant;
  tmpCode: Variant;
  tmpAddress: Variant;
  tmpActivity: Variant;
begin
  tmpId := FId;
  tmpName := varNull;
  tmpCode := varNull;
  tmpAddress := varNull;
  tmpActivity := varNull;

  if not VarIsNull(edtName.EditValue) then
  begin
    tmpName := edtName.EditValue;
  end;

  if not VarIsNull(edtCode.EditValue) then
  begin
    tmpCode := edtCode.EditValue;
  end;

  if not VarIsNull(edtAddress.EditValue) then
  begin
    tmpAddress := edtAddress.EditValue;
  end;

  if not VarIsNull(chkActivity.EditValue) then
  begin
    tmpActivity := chkActivity.EditValue;
  end;

  Result := TBank.Create(tmpId, tmpName, tmpCode, tmpAddress, tmpActivity);
end;

procedure TfrmBank.HideProgress;
begin
end;

procedure TfrmBank.SetCaption(const aValue: string);
begin
  Caption := aValue;
end;

end.
