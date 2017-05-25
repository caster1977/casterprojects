unit UE.Modules.FakeItemsManager.UI.Main;

interface

uses
  ERP.Package.CustomForm.TERPCustomForm,
  ERP.Package.ClientInterface.IERPClientData,
  ERP.Package.ClientInterface.IModuleInfo,
  ERP.Package.ClientInterface.IModuleAccess,
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  cxGraphics,
  Vcl.ImgList,
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxStatusBar,
  cxPC,
  UE.Package.Core.UI.LabeledComboFrame,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxBarBuiltInMenu,
  cxClasses,
  Data.DB,
  cxProgressBar,
  cxBarEditItem,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  cxCalc,
  cxLabel,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridCustomView,
  cxGrid,
  UE.Modules.FakeItemsManager.Logic.TViewEnumActionArray,
  UE.Modules.FakeItemsManager.Logic.TViewEnumAction,
  UE.Modules.FakeItemsManager.Logic.TViewEnumEvent,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IView,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IViewMain,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IFake;

type
  TfrmMain = class(TERPCustomForm, IView, IViewMain)
    dxstsbrMain: TdxStatusBar;
    actlstMain: TActionList;
    actRefresh: TAction;
    dxbrmngrMain: TdxBarManager;
    dxbrmngrMainBar1: TdxBar;
    dxbrlrgbtn3: TdxBarLargeButton;
    cxmglstActions: TcxImageList;
    dxbrlrgbtn4: TdxBarLargeButton;
    dxbrlrgbtn5: TdxBarLargeButton;
    dxbrlrgbtn6: TdxBarLargeButton;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    cxbrdtmProgress: TcxBarEditItem;
    cxgrdMain: TcxGrid;
    cxgrdtblvwGrid1TableView: TcxGridTableView;
    colCustomerId: TcxGridColumn;
    colCustomerName: TcxGridColumn;
    colItemDomainId: TcxGridColumn;
    colItemDomainName: TcxGridColumn;
    colItemNo: TcxGridColumn;
    colQuantity: TcxGridColumn;
    cxgrdlvlMain: TcxGridLevel;
    procedure actRefreshExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actAddUpdate(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actRefreshUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgrdtblvwGrid1TableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);

  public
    constructor Create(aERPClientData: IERPClientData); reintroduce;

  strict private
    FOnEventSimple: TProc<TViewEnumEvent>;
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;
    procedure AssignImages();
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    procedure RefreshStates();
    procedure ShowProgress(const aTitle: string; const aMax: Integer);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress();
    procedure Initialize();
    procedure ShowMessage(const aMessage: string; const aStatus: Integer);
    procedure SetFakes(const aValue: TDataSet);
    function GetCurrentFake(): IFake;
    procedure SetCaption(const aValue: string);
    procedure StorePresenter(const aPresenter: IInterface);
  end;

implementation

{$R *.dfm}

uses
  ERP.Package.CustomClasses.Consts,
  ERP.Package.GlobalData.DataModule,
  ERP.Package.CustomGlobalFunctions.UserFunctions,
  UE.Modules.FakeItemsManager.Logic.Classes.TModule,
  UE.Modules.FakeItemsManager.Logic.Classes.TQuery,
  UE.Modules.FakeItemsManager.Logic.Classes.TFake;

constructor TfrmMain.Create(aERPClientData: IERPClientData);
begin
  inherited Create(TModule.ModuleName, aERPClientData);
end;

procedure TfrmMain.cxgrdtblvwGrid1TableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veSelectedRecordChanged);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Initialize();
end;

procedure TfrmMain.actAddExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veAddExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.actEditExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veEditExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.actAddUpdate(Sender: TObject);
begin
  FOnEventSimple(veAddUpdate);
  (Sender as TAction).Enabled := FActionStates[vaAdd];
end;

procedure TfrmMain.actEditUpdate(Sender: TObject);
begin
  FOnEventSimple(veEditUpdate);
  (Sender as TAction).Enabled := FActionStates[vaEdit];
end;

procedure TfrmMain.actDeleteUpdate(Sender: TObject);
begin
  FOnEventSimple(veDeleteUpdate);
  (Sender as TAction).Enabled := FActionStates[vaDelete];
end;

procedure TfrmMain.actRefreshExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veRefreshExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.actRefreshUpdate(Sender: TObject);
begin
  FOnEventSimple(veRefreshUpdate);
  (Sender as TAction).Enabled := FActionStates[vaRefresh];
end;

procedure TfrmMain.AssignImages();
  function CopyIL(aIndex: Integer): Integer;
  var
    tmpIcon: TIcon;
  begin
    tmpIcon := TIcon.Create();
    try
      GDDM.ilGlobal32.GetIcon(aIndex, tmpIcon);
      Result := cxmglstActions.AddIcon(tmpIcon);
    finally
      tmpIcon.Free();
    end;
  end;

begin
  actAdd.ImageIndex := CopyIL(IL_ADD);
  actEdit.ImageIndex := CopyIL(IL_EDIT);
  actDelete.ImageIndex := CopyIL(IL_DELETE);
  actRefresh.ImageIndex := CopyIL(IL_REFRESH);
end;

procedure TfrmMain.actDeleteExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veDeleteExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.ShowMessage(const aMessage: string; const aStatus: Integer);
begin
  TERPMessageHelp.ShowMessage(TERPQueryResult.Create(aStatus, aMessage, 0));
end;

procedure TfrmMain.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  FOnEventSimple := aValue;
end;

function TfrmMain.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

procedure TfrmMain.ShowProgress(const aTitle: string; const aMax: Integer);
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aTitle.Trim();
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Max := aMax;
  cxbrdtmProgress.EditValue := 0;
  cxbrdtmProgress.Visible := ivAlways;
  Application.ProcessMessages();
end;

procedure TfrmMain.StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
var
  i: Integer;
begin
  if aNewTitle <> EmptyStr then
  begin
    (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aNewTitle.Trim();
  end;
  if aToPosition > -1 then
  begin
    cxbrdtmProgress.EditValue := aToPosition;
  end
  else
  begin
    i := cxbrdtmProgress.EditValue;
    cxbrdtmProgress.EditValue := Succ(i);
  end;
end;

procedure TfrmMain.StorePresenter(const aPresenter: IInterface);
begin
  FPresenter := aPresenter;
end;

procedure TfrmMain.HideProgress();
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := EmptyStr;
  cxbrdtmProgress.Visible := ivNever;
end;

procedure TfrmMain.Initialize();
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    AssignImages();
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.RefreshStates();
var
  i: Integer;
begin
  for i := 0 to Pred(actlstMain.ActionCount) do
  begin
    actlstMain.Actions[i].Update();
  end;
end;

procedure TfrmMain.SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TfrmMain.SetCaption(const aValue: string);
begin
  Caption := aValue;
end;

procedure TfrmMain.SetFakes(const aValue: TDataSet);
var
  i: Integer;
begin
  cxgrdtblvwGrid1TableView.BeginUpdate();
  try
    cxgrdtblvwGrid1TableView.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    cxgrdtblvwGrid1TableView.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      cxgrdtblvwGrid1TableView.DataController.Values[i, colCustomerId.Index] := aValue.FieldByName(TQuery.SpFIManagerSelFakeItem.Field.CustomerId).AsInteger;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colCustomerName.Index] := aValue.FieldByName(TQuery.SpFIManagerSelFakeItem.Field.CustomerNo).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colItemDomainId.Index] := aValue.FieldByName(TQuery.SpFIManagerSelFakeItem.Field.ItemDomainId)
        .AsInteger;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colItemDomainName.Index] :=
        aValue.FieldByName(TQuery.SpFIManagerSelFakeItem.Field.ItemDomainName).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colItemNo.Index] := aValue.FieldByName(TQuery.SpFIManagerSelFakeItem.Field.ItemNo).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colQuantity.Index] := aValue.FieldByName(TQuery.SpFIManagerSelFakeItem.Field.Quantity).AsInteger;

      StepProgress();

      aValue.Next();
    end;
  finally
    cxgrdtblvwGrid1TableView.EndUpdate();
  end;
end;

function TfrmMain.GetCurrentFake(): IFake;
begin
  Result := nil;
  if cxgrdtblvwGrid1TableView.Controller.SelectedRecordCount = 1 then
  begin
    Result := TFake.Create(cxgrdtblvwGrid1TableView.Controller.SelectedRecords[0].Values[colCustomerId.Index],
      cxgrdtblvwGrid1TableView.Controller.SelectedRecords[0].Values[colItemDomainId.Index], cxgrdtblvwGrid1TableView.Controller.SelectedRecords[0].Values
      [colItemNo.Index], cxgrdtblvwGrid1TableView.Controller.SelectedRecords[0].Values[colQuantity.Index]);
  end;
end;

end.
