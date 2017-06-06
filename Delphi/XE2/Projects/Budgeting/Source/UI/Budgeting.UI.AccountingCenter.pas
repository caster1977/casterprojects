unit Budgeting.UI.AccountingCenter;

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
  Budgeting.Logic.Interfaces.Views.IAccountingCenterView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar,
  Vcl.StdCtrls, Utils.Modules.SMSSender.Manager.UI.CustomEdit;

type
  TfrmAccountingCenter = class(TfrmCustomEdit, IAccountingCenterView)
    cxlblName: TcxLabel;
    edtName: TcxTextEdit;
    cxlblCode: TcxLabel;
    edtCode: TcxTextEdit;
    cxlblDescription: TcxLabel;
    edtDescription: TcxTextEdit;
    chkActivity: TcxCheckBox;
    procedure edtNamePropertiesChange(Sender: TObject);
    procedure edtNamePropertiesEditValueChanged(Sender: TObject);
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

  System.Variants,

  Budgeting.Logic.Interfaces.Models.IAccountingCenterModel,
  Budgeting.Logic.Classes.Models.TAccountingCenterModel,
  Budgeting.Logic.Types.TViewEnumEvent;

procedure TfrmAccountingCenter.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmAccountingCenter.chkActivityPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmAccountingCenter.edtDescriptionPropertiesChange(Sender: TObject);
begin
  edtDescription.EditValue := edtDescription.EditingValue;
end;

procedure TfrmAccountingCenter.edtDescriptionPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmAccountingCenter.edtCodePropertiesChange(Sender: TObject);
begin
  edtCode.EditValue := edtCode.EditingValue;
end;

procedure TfrmAccountingCenter.edtCodePropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmAccountingCenter.edtNamePropertiesChange(Sender: TObject);
begin
  edtName.EditValue := edtName.EditingValue;
end;

procedure TfrmAccountingCenter.edtNamePropertiesEditValueChanged(Sender: TObject);
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

function TfrmAccountingCenter.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpName: string;
  tmpCode: string;
  tmpDescription: string;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpCode := string.Empty;
  tmpName := string.Empty;
  tmpDescription := string.Empty;
  tmpActivity := True;

  if not VarIsNull(edtCode.EditValue) then
  begin
    tmpCode := edtCode.EditValue;
  end;

  if not VarIsNull(edtName.EditValue) then
  begin
    tmpName := edtName.EditValue;
  end;

  if not VarIsNull(edtDescription.EditValue) then
  begin
    tmpDescription := edtDescription.EditValue;
  end;

  if not VarIsNull(chkActivity.EditValue) then
  begin
    tmpActivity := chkActivity.EditValue;
  end;

  Result := TAccountingCenterModel.Create(tmpId, tmpCode, tmpName, tmpDescription, tmpActivity);
end;

procedure TfrmAccountingCenter.SetItem(const aValue: IInterface);
var
  tmpItem: IAccountingCenterModel;
begin
  inherited;
  edtName.EditValue := string.Empty;
  edtCode.EditValue := string.Empty;
  edtDescription.EditValue := string.Empty;
  chkActivity.EditValue := True;
  if Supports(aValue, IAccountingCenterModel, tmpItem) then
  begin
    edtCode.EditValue := tmpItem.Code;
    edtName.EditValue := tmpItem.Name;
    edtDescription.EditValue := tmpItem.Description;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
