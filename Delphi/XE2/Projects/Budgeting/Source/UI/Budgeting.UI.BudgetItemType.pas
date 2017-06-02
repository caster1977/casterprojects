unit Budgeting.UI.BudgetItemType;

interface

uses
  Winapi.Windows,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ActnList,

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

  Budgeting.UI.CustomEdit,
  Budgeting.Logic.Interfaces.Views.IBudgetItemTypeView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar,
  Vcl.StdCtrls;

type
  TfrmBudgetItemType = class(TfrmCustomEdit, IBudgetItemTypeView)
    cxlblName: TcxLabel;
    edtName: TcxTextEdit;
    chkActivity: TcxCheckBox;
    chkSign: TcxCheckBox;
    procedure edtNamePropertiesChange(Sender: TObject);
    procedure edtNamePropertiesEditValueChanged(Sender: TObject);
    procedure chkActivityPropertiesChange(Sender: TObject);
    procedure chkActivityPropertiesEditValueChanged(Sender: TObject);
    procedure chkSignPropertiesChange(Sender: TObject);
    procedure chkSignPropertiesEditValueChanged(Sender: TObject);

  strict protected
    function GetItem(): IInterface; override;
    procedure SetItem(const aValue: IInterface); override;
  end;

implementation

{$R *.dfm}

uses

  System.Variants,

  Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel,
  Budgeting.Logic.Classes.Models.TBudgetItemTypeModel,
  Budgeting.Logic.Types.TViewEnumEvent;

procedure TfrmBudgetItemType.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmBudgetItemType.chkActivityPropertiesEditValueChanged(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veItemChanged);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmBudgetItemType.chkSignPropertiesChange(Sender: TObject);
begin
  chkSign.EditValue := chkSign.EditingValue;
end;

procedure TfrmBudgetItemType.chkSignPropertiesEditValueChanged(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veItemChanged);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmBudgetItemType.edtNamePropertiesChange(Sender: TObject);
begin
  edtName.EditValue := edtName.EditingValue;
end;

procedure TfrmBudgetItemType.edtNamePropertiesEditValueChanged(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veItemChanged);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

function TfrmBudgetItemType.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpName: string;
  tmpSign: Boolean;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpName := string.Empty;
  tmpSign := False;
  tmpActivity := True;

  if not VarIsNull(edtName.EditValue) then
  begin
    tmpName := edtName.EditValue;
  end;

  if not VarIsNull(chkSign.EditValue) then
  begin
    tmpSign := chkSign.EditValue;
  end;

  if not VarIsNull(chkActivity.EditValue) then
  begin
    tmpActivity := chkActivity.EditValue;
  end;

  Result := TBudgetItemTypeModel.Create(tmpId, tmpName, tmpSign, tmpActivity);
end;

procedure TfrmBudgetItemType.SetItem(const aValue: IInterface);
var
  tmpItem: IBudgetItemTypeModel;
begin
  inherited;
  edtName.EditValue := string.Empty;
  chkSign.EditValue := False;
  chkActivity.EditValue := True;
  if Supports(aValue, IBudgetItemTypeModel, tmpItem) then
  begin
    edtName.EditValue := tmpItem.Name;
    chkSign.EditValue := tmpItem.Sign;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
