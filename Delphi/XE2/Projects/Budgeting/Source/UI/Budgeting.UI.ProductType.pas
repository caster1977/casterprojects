unit Budgeting.UI.ProductType;

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
  Budgeting.Logic.Interfaces.Views.ICustomView,
  Budgeting.UI.CustomEdit,
  Budgeting.Logic.Interfaces.Views.IProductTypeView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar;

type
  TfrmProductType = class(TfrmCustomEdit, IProductTypeView)
    cxlblName: TcxLabel;
    edtName: TcxTextEdit;
    chkActivity: TcxCheckBox;
    procedure edtNamePropertiesChange(Sender: TObject);
    procedure edtNamePropertiesEditValueChanged(Sender: TObject);
    procedure chkActivityPropertiesChange(Sender: TObject);
    procedure chkActivityPropertiesEditValueChanged(Sender: TObject);

  strict protected
    function GetItem(): IInterface; override;
    procedure SetItem(const aValue: IInterface); override;
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.IProductTypeModel,
  Budgeting.Logic.Classes.Models.TProductTypeModel,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Consts;

procedure TfrmProductType.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmProductType.chkActivityPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmProductType.edtNamePropertiesChange(Sender: TObject);
begin
  edtName.EditValue := edtName.EditingValue;
end;

procedure TfrmProductType.edtNamePropertiesEditValueChanged(Sender: TObject);
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

function TfrmProductType.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpName: string;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpName := string.Empty;
  tmpActivity := True;

  if not VarIsNull(edtName.EditValue) then
  begin
    tmpName := edtName.EditValue;
  end;

  if not VarIsNull(chkActivity.EditValue) then
  begin
    tmpActivity := chkActivity.EditValue;
  end;

  Result := TProductTypeModel.Create(tmpId, tmpName, tmpActivity);
end;

procedure TfrmProductType.SetItem(const aValue: IInterface);
var
  tmpItem: IProductTypeModel;
begin
  inherited;
  edtName.EditValue := string.Empty;
  chkActivity.EditValue := True;
  if Supports(aValue, IProductTypeModel, tmpItem) then
  begin
    edtName.EditValue := tmpItem.Name;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
