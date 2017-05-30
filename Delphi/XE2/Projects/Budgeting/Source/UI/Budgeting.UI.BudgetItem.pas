unit Budgeting.UI.BudgetItem;

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
//  Budgeting.Logic.Interfaces.Views.ICustomView,
//  Budgeting.Logic.Interfaces.Views.ICustomEditView,
  Budgeting.UI.CustomEdit,
  Budgeting.Logic.Interfaces.Views.IBudgetItemView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar;

type
  TfrmBudgetItem = class(TfrmCustomEdit, {ICustomView, ICustomEditView,} IBudgetItemView)
    cxlblBudgetItemType: TcxLabel;
    cbbBudgetItemType: TcxComboBox;
    cxlblCode: TcxLabel;
    edtCode: TcxTextEdit;
    cxlblDescription: TcxLabel;
    edtDescription: TcxTextEdit;
    chkActivity: TcxCheckBox;
    procedure edtCodePropertiesChange(Sender: TObject);
    procedure edtCodePropertiesEditValueChanged(Sender: TObject);
    procedure edtAddressPropertiesChange(Sender: TObject);
    procedure edtAddressPropertiesEditValueChanged(Sender: TObject);
    procedure chkActivityPropertiesChange(Sender: TObject);
    procedure chkActivityPropertiesEditValueChanged(Sender: TObject);
    procedure cbbBudgetItemTypePropertiesEditValueChanged(Sender: TObject);

  strict protected
    function GetItem(): IInterface; override;
    procedure SetItem(const aValue: IInterface); override;
    procedure SetBudgetItemTypes(const aValue: TStringList);
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.IBudgetItemModel,
  Budgeting.Logic.Classes.Models.TBudgetItemModel,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Consts;

procedure TfrmBudgetItem.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmBudgetItem.chkActivityPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmBudgetItem.edtAddressPropertiesChange(Sender: TObject);
begin
  edtDescription.EditValue := edtDescription.EditingValue;
end;

procedure TfrmBudgetItem.edtAddressPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmBudgetItem.edtCodePropertiesChange(Sender: TObject);
begin
  edtCode.EditValue := edtCode.EditingValue;
end;

procedure TfrmBudgetItem.edtCodePropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmBudgetItem.cbbBudgetItemTypePropertiesEditValueChanged(
  Sender: TObject);
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

function TfrmBudgetItem.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpBudgetItemTypeId: Integer;
  tmpName: string;
  tmpCode: string;
  tmpDescription: string;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpBudgetItemTypeId := -1;
  tmpCode := string.Empty;
  tmpName := string.Empty;
  tmpDescription := string.Empty;
  tmpActivity := True;

  if cbbBudgetItemType.ItemIndex > -1 then
  begin
    tmpBudgetItemTypeId := Integer(cbbBudgetItemType.Properties.Items.Objects[cbbBudgetItemType.ItemIndex]);
  end;

  if not VarIsNull(edtCode.EditValue) then
  begin
    tmpCode := edtCode.EditValue;
  end;

  if not VarIsNull(edtDescription.EditValue) then
  begin
    tmpDescription := edtDescription.EditValue;
  end;

  if not VarIsNull(chkActivity.EditValue) then
  begin
    tmpActivity := chkActivity.EditValue;
  end;

  Result := TBudgetItemModel.Create(tmpId, tmpBudgetItemTypeId, tmpCode, tmpDescription, tmpActivity);
end;

procedure TfrmBudgetItem.SetBudgetItemTypes(const aValue: TStringList);
var
  i: Integer;
begin
  cbbBudgetItemType.Properties.BeginUpdate();
  try
    cbbBudgetItemType.Properties.Items.Clear();

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.Count = 0 then
    begin
      Exit;
    end;

    for i := 0 to Pred(aValue.Count) do
    begin
      cbbBudgetItemType.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbBudgetItemType.Properties.EndUpdate();
  end;
end;

procedure TfrmBudgetItem.SetItem(const aValue: IInterface);
var
  tmpItem: IBudgetItemModel;
  i: Integer;
begin
  inherited;
  cbbBudgetItemType.ItemIndex := -1;
  edtCode.EditValue := string.Empty;
  edtDescription.EditValue := string.Empty;
  chkActivity.EditValue := True;

  if Supports(aValue, IBudgetItemModel, tmpItem) then
  begin
    for i := 0 to Pred(cbbBudgetItemType.Properties.Items.Count) do
    begin
      if Integer(cbbBudgetItemType.Properties.Items.Objects[i]) = tmpItem.Id_BudgetItemType then
      begin
        cbbBudgetItemType.ItemIndex := i;
        Break;
      end;
    end;

    edtCode.EditValue := tmpItem.Code;
    edtDescription.EditValue := tmpItem.Description;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
