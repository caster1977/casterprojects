unit Budgeting.UI.PlannedBudget;

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
  Budgeting.Logic.Interfaces.Views.IPlannedBudgetView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  cxCalendar,
  Vcl.StdCtrls;

type
  TfrmPlannedBudget = class(TfrmCustomEdit, IPlannedBudgetView)
    cxlblBudgetItem: TcxLabel;
    cbbBudgetItem: TcxComboBox;
    cxlblMonth: TcxLabel;
    cxlblAccountingCenter: TcxLabel;
    cbbAccountingCenter: TcxComboBox;
    cxlblCurrency: TcxLabel;
    cbbCurrency: TcxComboBox;
    pnlDocumentDate: TPanel;
    cxlblYear: TcxLabel;
    cxlblAmount: TcxLabel;
    pnlAmount: TPanel;
    cxcrncydtAmount: TcxCurrencyEdit;
    pnlMonth: TPanel;
    cbbMonth: TcxComboBox;
    cbbYear: TcxComboBox;
    procedure cbbBudgetItemPropertiesEditValueChanged(Sender: TObject);
    procedure cbbAccountingCenterPropertiesEditValueChanged(Sender: TObject);
    procedure cbbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cbbYearPropertiesEditValueChanged(Sender: TObject);
    procedure cbbMonthPropertiesEditValueChanged(Sender: TObject);
    procedure cxcrncydtAmountPropertiesChange(Sender: TObject);
    procedure cxcrncydtAmountPropertiesEditValueChanged(Sender: TObject);

  strict protected
    function GetItem(): IInterface; override;
    procedure SetItem(const aValue: IInterface); override;
    procedure SetBudgetItems(const aValue: TStringList);
    procedure SetAccountingCenters(const aValue: TStringList);
    procedure SetCurrencies(const aValue: TStringList);
    procedure SetYears(const aValue: TStringList);
    procedure SetMonths(const aValue: TStringList);
  end;

implementation

{$R *.dfm}

uses
  System.Variants,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  Budgeting.Logic.Classes.Configuration.Sections.TGeneralSection,
  Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel,
  Budgeting.Logic.Classes.Models.TPlannedBudgetModel,
  Budgeting.Logic.Types.TViewEnumEvent;

procedure TfrmPlannedBudget.cxcrncydtAmountPropertiesChange(Sender: TObject);
begin
  cxcrncydtAmount.EditValue := cxcrncydtAmount.EditingValue;
end;

procedure TfrmPlannedBudget.cxcrncydtAmountPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPlannedBudget.cbbAccountingCenterPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPlannedBudget.cbbBudgetItemPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPlannedBudget.cbbCurrencyPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPlannedBudget.cbbMonthPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPlannedBudget.cbbYearPropertiesEditValueChanged(Sender: TObject);
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

function TfrmPlannedBudget.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpBudgetItemId: Integer;
  tmpAccountingCenterId: Integer;
  tmpCurrencyId: Integer;
  tmpYear: Integer;
  tmpMonth: Integer;
  tmpAmount: Currency;
begin
  tmpId := FId;
  tmpBudgetItemId := -1;
  tmpAccountingCenterId := -1;
  tmpCurrencyId := -1;
  tmpYear := -1;
  tmpMonth := -1;
  tmpAmount := 0;

  if cbbBudgetItem.ItemIndex > -1 then
  begin
    tmpBudgetItemId := Integer(cbbBudgetItem.Properties.Items.Objects[cbbBudgetItem.ItemIndex]);
  end;

  if cbbAccountingCenter.ItemIndex > -1 then
  begin
    tmpAccountingCenterId := Integer(cbbAccountingCenter.Properties.Items.Objects[cbbAccountingCenter.ItemIndex]);
  end;

  if cbbCurrency.ItemIndex > -1 then
  begin
    tmpCurrencyId := Integer(cbbCurrency.Properties.Items.Objects[cbbCurrency.ItemIndex]);
  end;

  if cbbYear.ItemIndex > -1 then
  begin
    tmpYear := Integer(cbbYear.Properties.Items.Objects[cbbYear.ItemIndex]);
  end;

  if cbbMonth.ItemIndex > -1 then
  begin
    tmpMonth := Integer(cbbMonth.Properties.Items.Objects[cbbMonth.ItemIndex]);
  end;

  if not VarIsNull(cxcrncydtAmount.EditValue) then
  begin
    tmpAmount := cxcrncydtAmount.EditValue;
  end;

  Result := TPlannedBudgetModel.Create(tmpId, tmpBudgetItemId, tmpAccountingCenterId, tmpCurrencyId, tmpYear, tmpMonth, tmpAmount);
end;

procedure TfrmPlannedBudget.SetAccountingCenters(const aValue: TStringList);
var
  i: Integer;
begin
  cbbAccountingCenter.Properties.BeginUpdate();
  try
    cbbAccountingCenter.Properties.Items.Clear();

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
      cbbAccountingCenter.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbAccountingCenter.Properties.EndUpdate();
  end;
end;

procedure TfrmPlannedBudget.SetBudgetItems(const aValue: TStringList);
var
  i: Integer;
begin
  cbbBudgetItem.Properties.BeginUpdate();
  try
    cbbBudgetItem.Properties.Items.Clear();

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
      cbbBudgetItem.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbBudgetItem.Properties.EndUpdate();
  end;
end;

procedure TfrmPlannedBudget.SetYears(const aValue: TStringList);
var
  i: Integer;
begin
  cbbYear.Properties.BeginUpdate();
  try
    cbbYear.Properties.Items.Clear();

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
      cbbYear.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbYear.Properties.EndUpdate();
  end;
end;

procedure TfrmPlannedBudget.SetCurrencies(const aValue: TStringList);
var
  i: Integer;
begin
  cbbCurrency.Properties.BeginUpdate();
  try
    cbbCurrency.Properties.Items.Clear();

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
      cbbCurrency.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbCurrency.Properties.EndUpdate();
  end;
end;

procedure TfrmPlannedBudget.SetItem(const aValue: IInterface);
var
  tmpItem: IPlannedBudgetModel;
  i: Integer;
  tmpYear: Integer;
begin
  inherited;
  cbbBudgetItem.ItemIndex := -1;
  cbbAccountingCenter.ItemIndex := -1;
  cbbCurrency.ItemIndex := -1;
  cbbYear.ItemIndex := -1;
  cbbMonth.ItemIndex := -1;
  cxcrncydtAmount.EditValue := 0;

  if Supports(aValue, IPlannedBudgetModel, tmpItem) then
  begin
    for i := 0 to Pred(cbbBudgetItem.Properties.Items.Count) do
    begin
      if Integer(cbbBudgetItem.Properties.Items.Objects[i]) = tmpItem.Id_BudgetItem then
      begin
        cbbBudgetItem.ItemIndex := i;
        Break;
      end;
    end;

    for i := 0 to Pred(cbbAccountingCenter.Properties.Items.Count) do
    begin
      if Integer(cbbAccountingCenter.Properties.Items.Objects[i]) = tmpItem.Id_AccountingCenter then
      begin
        cbbAccountingCenter.ItemIndex := i;
        Break;
      end;
    end;

    for i := 0 to Pred(cbbCurrency.Properties.Items.Count) do
    begin
      if Integer(cbbCurrency.Properties.Items.Objects[i]) = tmpItem.Id_Currency then
      begin
        cbbCurrency.ItemIndex := i;
        Break;
      end;
    end;

    for i := 0 to Pred(cbbYear.Properties.Items.Count) do
    begin
      if Integer(cbbYear.Properties.Items.Objects[i]) = tmpItem.Year then
      begin
        cbbYear.ItemIndex := i;
        Break;
      end;
    end;

    for i := 0 to Pred(cbbMonth.Properties.Items.Count) do
    begin
      if Integer(cbbMonth.Properties.Items.Objects[i]) = tmpItem.Month then
      begin
        cbbMonth.ItemIndex := i;
        Break;
      end;
    end;

    cxcrncydtAmount.EditValue := tmpItem.Amount;
    tmpYear := tmpItem.Year;
  end
  else
  begin
    tmpYear := TConfiguration.Get(TConfiguration).Section<TGeneralSection>.Year;
    if tmpYear = 0 then
    begin
      tmpYear := CurrentYear();
    end;
  end;

  for i := 0 to Pred(cbbYear.Properties.Items.Count) do
  begin
    if Integer(cbbYear.Properties.Items.Objects[i]) = tmpYear then
    begin
      cbbYear.ItemIndex := i;
      Break;
    end;
  end;
end;

procedure TfrmPlannedBudget.SetMonths(const aValue: TStringList);
var
  i: Integer;
begin
  cbbMonth.Properties.BeginUpdate();
  try
    cbbMonth.Properties.Items.Clear();

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
      cbbMonth.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbMonth.Properties.EndUpdate();
  end;
end;

end.
