unit Budgeting.UI.Bank;

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
  Budgeting.Logic.Interfaces.Views.IBankView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar;

type
  TfrmBank = class(TfrmCustomEdit, IBankView)
    cxlblName: TcxLabel;
    edtName: TcxTextEdit;
    cxlblCode: TcxLabel;
    edtCode: TcxTextEdit;
    cxlblAddress: TcxLabel;
    edtAddress: TcxTextEdit;
    chkActivity: TcxCheckBox;
    procedure edtNamePropertiesChange(Sender: TObject);
    procedure edtNamePropertiesEditValueChanged(Sender: TObject);
    procedure edtCodePropertiesChange(Sender: TObject);
    procedure edtCodePropertiesEditValueChanged(Sender: TObject);
    procedure edtAddressPropertiesChange(Sender: TObject);
    procedure edtAddressPropertiesEditValueChanged(Sender: TObject);
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
  Budgeting.Logic.Interfaces.Models.IBankModel,
  Budgeting.Logic.Classes.Models.TBankModel,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Consts;

procedure TfrmBank.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmBank.chkActivityPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmBank.edtAddressPropertiesChange(Sender: TObject);
begin
  edtAddress.EditValue := edtAddress.EditingValue;
end;

procedure TfrmBank.edtAddressPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmBank.edtCodePropertiesChange(Sender: TObject);
begin
  edtCode.EditValue := edtCode.EditingValue;
end;

procedure TfrmBank.edtCodePropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmBank.edtNamePropertiesChange(Sender: TObject);
begin
  edtName.EditValue := edtName.EditingValue;
end;

procedure TfrmBank.edtNamePropertiesEditValueChanged(Sender: TObject);
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

function TfrmBank.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpName: string;
  tmpCode: string;
  tmpAddress: string;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpName := string.Empty;
  tmpCode := string.Empty;
  tmpAddress := string.Empty;
  tmpActivity := True;

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

  Result := TBankModel.Create(tmpId, tmpName, tmpCode, tmpAddress, tmpActivity);
end;

procedure TfrmBank.SetItem(const aValue: IInterface);
var
  tmpItem: IBankModel;
begin
  inherited;
  edtName.EditValue := string.Empty;
  edtCode.EditValue := string.Empty;
  edtAddress.EditValue := string.Empty;
  chkActivity.EditValue := True;
  if Supports(aValue, IBankModel, tmpItem) then
  begin
    edtName.EditValue := tmpItem.Name;
    edtCode.EditValue := tmpItem.Code;
    edtAddress.EditValue := tmpItem.Address;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
