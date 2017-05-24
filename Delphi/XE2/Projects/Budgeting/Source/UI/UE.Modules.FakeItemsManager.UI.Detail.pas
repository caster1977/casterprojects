unit UE.Modules.FakeItemsManager.UI.Detail;

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
  UE.Modules.FakeItemsManager.Logic.TViewEnumEvent,
  UE.Modules.FakeItemsManager.Logic.TViewEnumAction,
  UE.Modules.FakeItemsManager.Logic.TViewEnumActionArray,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IView,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IViewDetail,
  cxCurrencyEdit,
  cxSpinEdit;

type
  TfrmDetail = class(TForm, IView, IViewDetail)
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    bvl1: TBevel;
    cxlblDomainName: TcxLabel;
    cxlblCustomerNo: TcxLabel;
    cxlblItemNo: TcxLabel;
    cxlblQuantity: TcxLabel;
    cbbCustomerNo: TcxComboBox;
    cbbDomainName: TcxComboBox;
    cbbItemNo: TcxComboBox;
    cxspndtQuantity: TcxSpinEdit;
    procedure actSaveUpdate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure cbbCustomerNoPropertiesEditValueChanged(Sender: TObject);
    procedure cbbDomainNamePropertiesEditValueChanged(Sender: TObject);
    procedure cbbItemNoPropertiesEditValueChanged(Sender: TObject);
    procedure cxspndtQuantityPropertiesEditValueChanged(Sender: TObject);
    procedure cxspndtQuantityPropertiesChange(Sender: TObject);

  strict private
    FOnEventSimple: TProc<TViewEnumEvent>;
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    procedure RefreshStates();

    procedure SetCustomers(const aValue: TStringList);
    procedure SetDomains(const aValue: TStringList);
    procedure SetItems(const aValue: TStringList);

    function GetItem(): IInterface;
    procedure SetItem(const aValue: IInterface);

    procedure ShowMessage(const aMessage: string; const aStatus: Integer);
    procedure SetCaption(const aValue: string);
    procedure StorePresenter(const aPresenter: IInterface);
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  ERP.Package.CustomGlobalFunctions.UserFunctions,
  UE.Modules.FakeItemsManager.Logic.Classes.TQuery,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IFake,
  UE.Modules.FakeItemsManager.Logic.Classes.TFake;

procedure TfrmDetail.actCancelExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veCancelExecute);
    ModalResult := mrCancel;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmDetail.actCancelUpdate(Sender: TObject);
begin
  FOnEventSimple(veCancelUpdate);
  (Sender as TAction).Enabled := FActionStates[vaCancel];
end;

procedure TfrmDetail.actSaveExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veSaveExecute);
    ModalResult := mrOk;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmDetail.actSaveUpdate(Sender: TObject);
begin
  FOnEventSimple(veSaveUpdate);
  (Sender as TAction).Enabled := FActionStates[vaSave];
end;

procedure TfrmDetail.cbbCustomerNoPropertiesEditValueChanged(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veCustomerChanged);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmDetail.cbbDomainNamePropertiesEditValueChanged(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veDomainChanged);
    cbbItemNo.Enabled := cbbDomainName.ItemIndex > -1;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmDetail.cbbItemNoPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmDetail.cxspndtQuantityPropertiesChange(Sender: TObject);
begin
  cxspndtQuantity.EditValue := cxspndtQuantity.EditingValue;
end;

procedure TfrmDetail.cxspndtQuantityPropertiesEditValueChanged(Sender: TObject);
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

function TfrmDetail.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

procedure TfrmDetail.RefreshStates();
var
  i: Integer;
begin
  for i := 0 to Pred(ActionList.ActionCount) do
  begin
    ActionList.Actions[i].Update();
  end;
end;

procedure TfrmDetail.SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TfrmDetail.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  FOnEventSimple := aValue;
end;

procedure TfrmDetail.ShowMessage(const aMessage: string; const aStatus: Integer);
begin
  TERPMessageHelp.ShowMessage(TERPQueryResult.Create(aStatus, aMessage, 0));
end;

procedure TfrmDetail.StorePresenter(const aPresenter: IInterface);
begin
  FPresenter := aPresenter;
end;

procedure TfrmDetail.SetItem(const aValue: IInterface);
var
  tmpFake: IFake;
  i: Integer;
begin
  cbbCustomerNo.ItemIndex := -1;
  cbbDomainName.ItemIndex := -1;
  cbbItemNo.ItemIndex := -1;
  cxspndtQuantity.EditValue := 0;

  if Supports(aValue, IFake, tmpFake) then
  begin
    for i := 0 to Pred(cbbCustomerNo.Properties.Items.Count) do
    begin
      if Integer(cbbCustomerNo.Properties.Items.Objects[i]) = tmpFake.CustomerId then
      begin
        cbbCustomerNo.ItemIndex := i;
        Break;
      end;
    end;

    for i := 0 to Pred(cbbDomainName.Properties.Items.Count) do
    begin
      if Integer(cbbDomainName.Properties.Items.Objects[i]) = tmpFake.ItemDomainId then
      begin
        cbbDomainName.ItemIndex := i;
        Break;
      end;
    end;

    for i := 0 to Pred(cbbItemNo.Properties.Items.Count) do
    begin
      if cbbItemNo.Properties.Items[i] = tmpFake.ItemNo then
      begin
        if Integer(cbbItemNo.Properties.Items.Objects[i]) = tmpFake.ItemDomainId then
        begin
          cbbItemNo.ItemIndex := i;
          Break;
        end;
      end;
    end;

    cxspndtQuantity.EditValue := tmpFake.Quantity;

    cbbCustomerNo.Enabled := False;
    cbbDomainName.Enabled := False;
    cbbItemNo.Enabled := False;
  end;
end;

function TfrmDetail.GetItem(): IInterface;
var
  tmpCustomerId: Integer;
  tmpDomainId: Integer;
  tmpItemNo: string;
  tmpQuantity: Integer;
begin
  tmpCustomerId := -1;
  tmpDomainId := -1;
  tmpItemNo := EmptyStr;
  tmpQuantity := 0;
  if cbbCustomerNo.ItemIndex > -1 then
  begin
    tmpCustomerId := Integer(cbbCustomerNo.Properties.Items.Objects[cbbCustomerNo.ItemIndex]);
  end;
  if cbbDomainName.ItemIndex > -1 then
  begin
    tmpDomainId := Integer(cbbDomainName.Properties.Items.Objects[cbbDomainName.ItemIndex]);
  end;
  if cbbItemNo.ItemIndex > -1 then
  begin
    tmpItemNo := cbbItemNo.Properties.Items[cbbItemNo.ItemIndex];
  end;

  if not VarIsNull(cxspndtQuantity.EditValue) then
  begin
    tmpQuantity := cxspndtQuantity.EditValue;
  end;

  Result := TFake.Create(tmpCustomerId, tmpDomainId, tmpItemNo, tmpQuantity);
end;

procedure TfrmDetail.SetCaption(const aValue: string);
begin
  Caption := aValue;
end;

procedure TfrmDetail.SetCustomers(const aValue: TStringList);
var
  i: Integer;
begin
  cbbCustomerNo.ItemIndex := -1;

  cbbCustomerNo.Properties.BeginUpdate();
  try
    cbbCustomerNo.Properties.Items.Clear();

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
      cbbCustomerNo.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbCustomerNo.Properties.EndUpdate();
  end;
end;

procedure TfrmDetail.SetDomains(const aValue: TStringList);
var
  i: Integer;
begin
  cbbDomainName.ItemIndex := -1;

  cbbItemNo.ItemIndex := -1;
  cbbItemNo.Properties.Items.Clear();

  cbbDomainName.Properties.BeginUpdate();
  try
    cbbDomainName.Properties.Items.Clear();

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
      cbbDomainName.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbDomainName.Properties.EndUpdate();
  end;
end;

procedure TfrmDetail.SetItems(const aValue: TStringList);
var
  i: Integer;
begin
  cbbItemNo.ItemIndex := -1;

  cbbItemNo.Properties.BeginUpdate();
  try
    cbbItemNo.Properties.Items.Clear();

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
      cbbItemNo.Properties.Items.AddObject(aValue[i], TObject(aValue.Objects[i]));
    end;
  finally
    cbbItemNo.Properties.EndUpdate();
  end;
end;

end.
