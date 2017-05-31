unit Budgeting.UI.ActualBudget;

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
  Budgeting.UI.CustomEdit,
  Budgeting.Logic.Interfaces.Views.IActualBudgetView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar, Vcl.ComCtrls, dxCore, cxDateUtils, cxCalendar;

type
  TfrmActualBudget = class(TfrmCustomEdit, IActualBudgetView)
    cxlblBudgetItem: TcxLabel;
    cbbBudgetItem: TcxComboBox;
    cxlblDocument: TcxLabel;
    edtDocument: TcxTextEdit;
    cxlblDescription: TcxLabel;
    edtDescription: TcxTextEdit;
    cxlblAccountingCenter: TcxLabel;
    cbbAccountingCenter: TcxComboBox;
    cxlblCosignatory: TcxLabel;
    cbbCosignatory: TcxComboBox;
    cxlblProduct: TcxLabel;
    cbbProduct: TcxComboBox;
    cxlblCurrency: TcxLabel;
    cbbCurrency: TcxComboBox;
    pnlDocumentDate: TPanel;
    deDocumentDate: TcxDateEdit;
    cxlblDocumentDate: TcxLabel;
    cxlblAmount: TcxLabel;
    pnlAmount: TPanel;
    cxcrncydtAmount: TcxCurrencyEdit;
    procedure cbbBudgetItemPropertiesEditValueChanged(Sender: TObject);
    procedure cbbAccountingCenterPropertiesEditValueChanged(Sender: TObject);
    procedure cbbCosignatoryPropertiesEditValueChanged(Sender: TObject);
    procedure cbbProductPropertiesEditValueChanged(Sender: TObject);
    procedure cbbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure edtDocumentPropertiesChange(Sender: TObject);
    procedure edtDocumentPropertiesEditValueChanged(Sender: TObject);
    procedure deDocumentDatePropertiesEditValueChanged(Sender: TObject);
    procedure deDocumentDatePropertiesChange(Sender: TObject);
    procedure edtDescriptionPropertiesChange(Sender: TObject);
    procedure edtDescriptionPropertiesEditValueChanged(Sender: TObject);
    procedure cxcrncydtAmountPropertiesChange(Sender: TObject);
    procedure cxcrncydtAmountPropertiesEditValueChanged(Sender: TObject);

  strict protected
    function GetItem(): IInterface; override;
    procedure SetItem(const aValue: IInterface); override;
    procedure SetBudgetItems(const aValue: TStringList);
    procedure SetAccountingCenters(const aValue: TStringList);
    procedure SetCosignatories(const aValue: TStringList);
    procedure SetProducts(const aValue: TStringList);
    procedure SetCurrencies(const aValue: TStringList);
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.IActualBudgetModel,
  Budgeting.Logic.Classes.Models.TActualBudgetModel,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Consts;

procedure TfrmActualBudget.cxcrncydtAmountPropertiesChange(Sender: TObject);
begin
  cxcrncydtAmount.EditValue := cxcrncydtAmount.EditingValue;
end;

procedure TfrmActualBudget.cxcrncydtAmountPropertiesEditValueChanged(
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

procedure TfrmActualBudget.deDocumentDatePropertiesChange(Sender: TObject);
begin
  deDocumentDate.EditValue := deDocumentDate.EditingValue;
end;

procedure TfrmActualBudget.deDocumentDatePropertiesEditValueChanged(
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

procedure TfrmActualBudget.edtDocumentPropertiesChange(Sender: TObject);
begin
  edtDocument.EditValue := edtDocument.EditingValue;
end;

procedure TfrmActualBudget.edtDocumentPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmActualBudget.edtDescriptionPropertiesChange(Sender: TObject);
begin
  edtDescription.EditValue := edtDescription.EditingValue;
end;

procedure TfrmActualBudget.edtDescriptionPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmActualBudget.cbbAccountingCenterPropertiesEditValueChanged(
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

procedure TfrmActualBudget.cbbBudgetItemPropertiesEditValueChanged(
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

procedure TfrmActualBudget.cbbCosignatoryPropertiesEditValueChanged(
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

procedure TfrmActualBudget.cbbCurrencyPropertiesEditValueChanged(
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

procedure TfrmActualBudget.cbbProductPropertiesEditValueChanged(
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

function TfrmActualBudget.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpBudgetItemId : Integer;
  tmpAccountingCenterId : Integer;
  tmpCosignatoryId : Integer;
  tmpProductId : Integer;
  tmpCurrencyId : Integer;
  tmpDocument : string;
  tmpDocumentDate : TDate;
  tmpDescription : string;
  tmpAmount : Currency;
begin
  tmpId := FId;
  tmpBudgetItemId := -1;
  tmpAccountingCenterId := -1;
  tmpCosignatoryId := -1;
  tmpProductId := -1;
  tmpCurrencyId := -1;
  tmpDocument := string.Empty;
  tmpDocumentDate := Date();
  tmpDescription := string.Empty;
  tmpAmount := 0;

  if cbbBudgetItem.ItemIndex > -1 then
  begin
    tmpBudgetItemId := Integer(cbbBudgetItem.Properties.Items.Objects[cbbBudgetItem.ItemIndex]);
  end;

  if cbbAccountingCenter.ItemIndex > -1 then
  begin
    tmpAccountingCenterId := Integer(cbbAccountingCenter.Properties.Items.Objects[cbbAccountingCenter.ItemIndex]);
  end;

  if cbbCosignatory.ItemIndex > -1 then
  begin
    tmpCosignatoryId := Integer(cbbCosignatory.Properties.Items.Objects[cbbCosignatory.ItemIndex]);
  end;

  if cbbProduct.ItemIndex > -1 then
  begin
    tmpProductId := Integer(cbbProduct.Properties.Items.Objects[cbbProduct.ItemIndex]);
  end;

  if cbbCurrency.ItemIndex > -1 then
  begin
    tmpCurrencyId := Integer(cbbCurrency.Properties.Items.Objects[cbbCurrency.ItemIndex]);
  end;

  if not VarIsNull(edtDocument.EditValue) then
  begin
    tmpDocument := edtDocument.EditValue;
  end;

  if not VarIsNull(deDocumentDate.EditValue) then
  begin
    tmpDocumentDate := deDocumentDate.EditValue;
  end;

  if not VarIsNull(edtDescription.EditValue) then
  begin
    tmpDescription := edtDescription.EditValue;
  end;

  if not VarIsNull(cxcrncydtAmount.EditValue) then
  begin
    tmpAmount := cxcrncydtAmount.EditValue;
  end;

  Result := TActualBudgetModel.Create(tmpId, tmpBudgetItemId, tmpAccountingCenterId, tmpCosignatoryId, tmpProductId, tmpCurrencyId, tmpDocument, tmpDocumentDate, tmpDescription, tmpAmount);
end;

procedure TfrmActualBudget.SetAccountingCenters(const aValue: TStringList);
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

procedure TfrmActualBudget.SetBudgetItems(const aValue: TStringList);
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

procedure TfrmActualBudget.SetCosignatories(const aValue: TStringList);
var
  i: Integer;
begin
  cbbCosignatory.Properties.BeginUpdate();
  try
    cbbCosignatory.Properties.Items.Clear();

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
      cbbCosignatory.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbCosignatory.Properties.EndUpdate();
  end;
end;

procedure TfrmActualBudget.SetCurrencies(const aValue: TStringList);
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

procedure TfrmActualBudget.SetItem(const aValue: IInterface);
var
  tmpItem: IActualBudgetModel;
  i: Integer;
begin
  inherited;
  cbbBudgetItem.ItemIndex := -1;
  cbbAccountingCenter.ItemIndex := -1;
  cbbCosignatory.ItemIndex := -1;
  cbbProduct.ItemIndex := -1;
  cbbCurrency.ItemIndex := -1;
  edtDocument.EditValue := string.Empty;
  deDocumentDate.EditValue := Date();
  edtDescription.EditValue := string.Empty;
  cxcrncydtAmount.EditValue := 0;

  if Supports(aValue, IActualBudgetModel, tmpItem) then
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

    for i := 0 to Pred(cbbCosignatory.Properties.Items.Count) do
    begin
      if Integer(cbbCosignatory.Properties.Items.Objects[i]) = tmpItem.Id_Cosignatory then
      begin
        cbbCosignatory.ItemIndex := i;
        Break;
      end;
    end;

    for i := 0 to Pred(cbbProduct.Properties.Items.Count) do
    begin
      if Integer(cbbProduct.Properties.Items.Objects[i]) = tmpItem.Id_Product then
      begin
        cbbProduct.ItemIndex := i;
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

    edtDocument.EditValue := tmpItem.Document;
    deDocumentDate.EditValue := tmpItem.DocumentDate;
    edtDescription.EditValue := tmpItem.Description;
    cxcrncydtAmount.EditValue := tmpItem.Amount;
  end;
end;

procedure TfrmActualBudget.SetProducts(const aValue: TStringList);
var
  i: Integer;
begin
  cbbProduct.Properties.BeginUpdate();
  try
    cbbProduct.Properties.Items.Clear();

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
      cbbProduct.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbProduct.Properties.EndUpdate();
  end;
end;

end.
