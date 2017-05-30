unit Budgeting.UI.Product;

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
  Budgeting.Logic.Interfaces.Views.IProductView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar;

type
  TfrmProduct = class(TfrmCustomEdit, IProductView)
    cxlblProductType: TcxLabel;
    cbbProductType: TcxComboBox;
    cxlblCode: TcxLabel;
    edtCode: TcxTextEdit;
    cxlblDescription: TcxLabel;
    edtDescription: TcxTextEdit;
    chkActivity: TcxCheckBox;
    procedure edtCodePropertiesChange(Sender: TObject);
    procedure edtCodePropertiesEditValueChanged(Sender: TObject);
    procedure chkActivityPropertiesChange(Sender: TObject);
    procedure chkActivityPropertiesEditValueChanged(Sender: TObject);
    procedure cbbProductTypePropertiesEditValueChanged(Sender: TObject);
    procedure edtDescriptionPropertiesChange(Sender: TObject);
    procedure edtDescriptionPropertiesEditValueChanged(Sender: TObject);

  strict protected
    function GetItem(): IInterface; override;
    procedure SetItem(const aValue: IInterface); override;
    procedure SetProductTypes(const aValue: TStringList);
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.IProductModel,
  Budgeting.Logic.Classes.Models.TProductModel,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Consts;

procedure TfrmProduct.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmProduct.chkActivityPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmProduct.edtCodePropertiesChange(Sender: TObject);
begin
  edtCode.EditValue := edtCode.EditingValue;
end;

procedure TfrmProduct.edtCodePropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmProduct.edtDescriptionPropertiesChange(Sender: TObject);
begin
  edtDescription.EditValue := edtDescription.EditingValue;
end;

procedure TfrmProduct.edtDescriptionPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmProduct.cbbProductTypePropertiesEditValueChanged(
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

function TfrmProduct.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpProductTypeId: Integer;
  tmpName: string;
  tmpCode: string;
  tmpDescription: string;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpProductTypeId := -1;
  tmpCode := string.Empty;
  tmpName := string.Empty;
  tmpDescription := string.Empty;
  tmpActivity := True;

  if cbbProductType.ItemIndex > -1 then
  begin
    tmpProductTypeId := Integer(cbbProductType.Properties.Items.Objects[cbbProductType.ItemIndex]);
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

  Result := TProductModel.Create(tmpId, tmpProductTypeId, tmpCode, tmpDescription, tmpActivity);
end;

procedure TfrmProduct.SetProductTypes(const aValue: TStringList);
var
  i: Integer;
begin
  cbbProductType.Properties.BeginUpdate();
  try
    cbbProductType.Properties.Items.Clear();

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
      cbbProductType.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbProductType.Properties.EndUpdate();
  end;
end;

procedure TfrmProduct.SetItem(const aValue: IInterface);
var
  tmpItem: IProductModel;
  i: Integer;
begin
  inherited;
  cbbProductType.ItemIndex := -1;
  edtCode.EditValue := string.Empty;
  edtDescription.EditValue := string.Empty;
  chkActivity.EditValue := True;

  if Supports(aValue, IProductModel, tmpItem) then
  begin
    for i := 0 to Pred(cbbProductType.Properties.Items.Count) do
    begin
      if Integer(cbbProductType.Properties.Items.Objects[i]) = tmpItem.Id_ProductType then
      begin
        cbbProductType.ItemIndex := i;
        Break;
      end;
    end;

    edtCode.EditValue := tmpItem.Code;
    edtDescription.EditValue := tmpItem.Description;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
