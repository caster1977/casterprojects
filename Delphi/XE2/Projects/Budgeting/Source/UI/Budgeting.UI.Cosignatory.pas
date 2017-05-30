unit Budgeting.UI.Cosignatory;

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
  Budgeting.Logic.Interfaces.Views.ICosignatoryView,
  cxCurrencyEdit,
  cxSpinEdit,
  cxProgressBar, Vcl.ComCtrls, dxCore, cxDateUtils, cxCalendar;

type
  TfrmCosignatory = class(TfrmCustomEdit, ICosignatoryView)
    cxlblBankInfo: TcxLabel;
    cbbBankInfo: TcxComboBox;
    cxlblName: TcxLabel;
    edtName: TcxTextEdit;
    cxlblAddress: TcxLabel;
    edtAddress: TcxTextEdit;
    chkActivity: TcxCheckBox;
    cxlblUNP: TcxLabel;
    edtUNP: TcxTextEdit;
    cxlblAgreementNumber: TcxLabel;
    edtAgreementNumber: TcxTextEdit;
    cxlblAccount: TcxLabel;
    edtAccount: TcxTextEdit;
    cxlblAgreementPeriod: TcxLabel;
    deAgreementStart: TcxDateEdit;
    pnlAgreementPeriod: TPanel;
    cxlblAgreementStart: TcxLabel;
    cxlbl1: TcxLabel;
    deAgreementStop: TcxDateEdit;
    procedure edtNamePropertiesEditValueChanged(Sender: TObject);
    procedure chkActivityPropertiesChange(Sender: TObject);
    procedure chkActivityPropertiesEditValueChanged(Sender: TObject);
    procedure cbbBankInfoPropertiesEditValueChanged(Sender: TObject);
    procedure edtAddressPropertiesEditValueChanged(Sender: TObject);
    procedure edtUNPPropertiesChange(Sender: TObject);
    procedure edtNamePropertiesChange(Sender: TObject);
    procedure edtUNPPropertiesEditValueChanged(Sender: TObject);
    procedure edtAddressPropertiesChange(Sender: TObject);
    procedure edtAgreementNumberPropertiesChange(Sender: TObject);
    procedure edtAgreementNumberPropertiesEditValueChanged(Sender: TObject);
    procedure edtlAccountPropertiesChange(Sender: TObject);
    procedure edtlAccountPropertiesEditValueChanged(Sender: TObject);
    procedure deAgreementStartPropertiesChange(Sender: TObject);
    procedure deAgreementStartPropertiesEditValueChanged(Sender: TObject);
    procedure deAgreementStopPropertiesChange(Sender: TObject);
    procedure deAgreementStopPropertiesEditValueChanged(Sender: TObject);

  strict protected
    function GetItem(): IInterface; override;
    procedure SetItem(const aValue: IInterface); override;
    procedure SetBanks(const aValue: TStringList);
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.ICosignatoryModel,
  Budgeting.Logic.Classes.Models.TCosignatoryModel,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Consts;

procedure TfrmCosignatory.chkActivityPropertiesChange(Sender: TObject);
begin
  chkActivity.EditValue := chkActivity.EditingValue;
end;

procedure TfrmCosignatory.chkActivityPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmCosignatory.deAgreementStartPropertiesChange(Sender: TObject);
begin
  deAgreementStart.EditValue := deAgreementStart.EditingValue;
end;

procedure TfrmCosignatory.deAgreementStartPropertiesEditValueChanged(
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

procedure TfrmCosignatory.deAgreementStopPropertiesChange(Sender: TObject);
begin
  deAgreementStop.EditValue := deAgreementStop.EditingValue;
end;

procedure TfrmCosignatory.deAgreementStopPropertiesEditValueChanged(
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

procedure TfrmCosignatory.edtNamePropertiesChange(Sender: TObject);
begin
  edtName.EditValue := edtName.EditingValue;
end;

procedure TfrmCosignatory.edtNamePropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmCosignatory.edtUNPPropertiesChange(Sender: TObject);
begin
  edtUNP.EditValue := edtUNP.EditingValue;
end;

procedure TfrmCosignatory.edtUNPPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmCosignatory.edtAddressPropertiesChange(Sender: TObject);
begin
  edtAddress.EditValue := edtAddress.EditingValue;
end;

procedure TfrmCosignatory.edtAddressPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmCosignatory.edtAgreementNumberPropertiesChange(Sender: TObject);
begin
  edtAgreementNumber.EditValue := edtAgreementNumber.EditingValue;
end;

procedure TfrmCosignatory.edtAgreementNumberPropertiesEditValueChanged(
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

procedure TfrmCosignatory.edtlAccountPropertiesChange(Sender: TObject);
begin
  edtAccount.EditValue := edtAccount.EditingValue;
end;

procedure TfrmCosignatory.edtlAccountPropertiesEditValueChanged(
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

procedure TfrmCosignatory.cbbBankInfoPropertiesEditValueChanged(
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

function TfrmCosignatory.GetItem(): IInterface;
var
  tmpId: Integer;
  tmpBankId: Integer;
  tmpName: string;
  tmpUNP: string;
  tmpAddress: string;
  tmpAgreementNumber: string;
  tmpAgreementStart: TDate;
  tmpAgreementStop: TDate;
  tmpAccount: string;
  tmpActivity: Boolean;
begin
  tmpId := FId;
  tmpBankId := -1;
  tmpName := string.Empty;
  tmpUNP := string.Empty;
  tmpAddress := string.Empty;
  tmpAgreementNumber := string.Empty;
  tmpAgreementStart := Date();
  tmpAgreementStop := Date();
  tmpAccount := string.Empty;
  tmpActivity := True;

  if cbbBankInfo.ItemIndex > -1 then
  begin
    tmpBankId := Integer(cbbBankInfo.Properties.Items.Objects[cbbBankInfo.ItemIndex]);
  end;

  if not VarIsNull(edtName.EditValue) then
  begin
    tmpName := edtName.EditValue;
  end;

  if not VarIsNull(edtUNP.EditValue) then
  begin
    tmpUNP := edtUNP.EditValue;
  end;

  if not VarIsNull(edtAddress.EditValue) then
  begin
    tmpAddress := edtAddress.EditValue;
  end;

  if not VarIsNull(edtAgreementNumber.EditValue) then
  begin
    tmpAgreementNumber := edtAgreementNumber.EditValue;
  end;

  if not VarIsNull(deAgreementStart.EditValue) then
  begin
    tmpAgreementStart := deAgreementStart.EditValue;
  end;

  if not VarIsNull(deAgreementStop.EditValue) then
  begin
    tmpAgreementStop := deAgreementStop.EditValue;
  end;

  if not VarIsNull(edtAccount.EditValue) then
  begin
    tmpAccount := edtAccount.EditValue;
  end;

  if not VarIsNull(chkActivity.EditValue) then
  begin
    tmpActivity := chkActivity.EditValue;
  end;

  Result := TCosignatoryModel.Create(tmpId, tmpBankId, tmpName, tmpUNP, tmpAddress, tmpAgreementNumber, tmpAgreementStart, tmpAgreementStop, tmpAccount, tmpActivity);
end;

procedure TfrmCosignatory.SetBanks(const aValue: TStringList);
var
  i: Integer;
begin
  cbbBankInfo.Properties.BeginUpdate();
  try
    cbbBankInfo.Properties.Items.Clear();

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
      cbbBankInfo.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbBankInfo.Properties.EndUpdate();
  end;
end;

procedure TfrmCosignatory.SetItem(const aValue: IInterface);
var
  tmpItem: ICosignatoryModel;
  i: Integer;
begin
  inherited;
  cbbBankInfo.ItemIndex := -1;
  edtName.EditValue := string.Empty;
  edtUNP.EditValue := string.Empty;
  edtAddress.EditValue := string.Empty;
  edtAgreementNumber.EditValue := string.Empty;
  deAgreementStart.EditValue := Date();
  deAgreementStop.EditValue := Date();
  edtAccount.EditValue := string.Empty;
  chkActivity.EditValue := True;

  if Supports(aValue, ICosignatoryModel, tmpItem) then
  begin
    for i := 0 to Pred(cbbBankInfo.Properties.Items.Count) do
    begin
      if Integer(cbbBankInfo.Properties.Items.Objects[i]) = tmpItem.Id_Bank then
      begin
        cbbBankInfo.ItemIndex := i;
        Break;
      end;
    end;

    edtName.EditValue := tmpItem.Name;
    edtUNP.EditValue := tmpItem.UNP;
    edtAddress.EditValue := tmpItem.Address;
    edtAgreementNumber.EditValue := tmpItem.AgreementNumber;
    deAgreementStart.EditValue := tmpItem.AgreementStart;
    deAgreementStop.EditValue := tmpItem.AgreementStop;
    edtAccount.EditValue := tmpItem.Account;
    chkActivity.EditValue := tmpItem.Activity;
  end;
end;

end.
