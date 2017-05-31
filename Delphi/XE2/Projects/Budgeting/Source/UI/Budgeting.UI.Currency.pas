unit Budgeting.UI.Currency;

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
  Budgeting.Logic.Interfaces.Views.ICurrencyView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar;

type
  TfrmCurrency = class(TfrmCustomEdit, ICurrencyView)
    cxlblCode: TcxLabel;
    edtCode: TcxTextEdit;
    cxlblDescription: TcxLabel;
    edtDescription: TcxTextEdit;
    chkActivity: TcxCheckBox;
    procedure edtCodePropertiesChange(Sender: TObject);
    procedure edtCodePropertiesEditValueChanged(Sender: TObject);
    procedure edtDescriptionPropertiesChange(Sender: TObject);
    procedure edtDescriptionPropertiesEditValueChanged(Sender: TObject);
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
  Budgeting.Logic.Interfaces.Models.ICurrencyModel,
  Budgeting.Logic.Classes.Models.TCurrencyModel,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Consts;

procedure TfrmCurrency.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmCurrency.chkActivityPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmCurrency.edtDescriptionPropertiesChange(Sender: TObject);
begin
  edtDescription.EditValue := edtDescription.EditingValue;
end;

procedure TfrmCurrency.edtDescriptionPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmCurrency.edtCodePropertiesChange(Sender: TObject);
begin
  edtCode.EditValue := edtCode.EditingValue;
end;

procedure TfrmCurrency.edtCodePropertiesEditValueChanged(Sender: TObject);
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

function TfrmCurrency.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpCode: string;
  tmpDescription: string;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpCode := string.Empty;
  tmpDescription := string.Empty;
  tmpActivity := True;

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

  Result := TCurrencyModel.Create(tmpId, tmpCode, tmpDescription, tmpActivity);
end;

procedure TfrmCurrency.SetItem(const aValue: IInterface);
var
  tmpItem: ICurrencyModel;
begin
  inherited;
  edtCode.EditValue := string.Empty;
  edtDescription.EditValue := string.Empty;
  chkActivity.EditValue := True;
  if Supports(aValue, ICurrencyModel, tmpItem) then
  begin
    edtCode.EditValue := tmpItem.Code;
    edtDescription.EditValue := tmpItem.Description;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
