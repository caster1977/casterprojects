unit IncomingDocQueue.Modules.CrossDockingViewer.UI.Main;

interface

uses
  ERP.Package.CustomForm.TERPCustomForm,
  ERP.Package.ClientInterface.IERPClientData,
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
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxBarBuiltInMenu,
  cxClasses,
  cxContainer,
  cxEdit,
  cxProgressBar,
  cxCheckBox,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumActionArray,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumAction,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumEvent,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IView,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IViewMain,
  cxLabel,
  cxCalendar,
  cxBarEditItem,
  cxStyles,
  cxCustomData,
  cxDataStorage,
  cxNavigator,
  Data.DB,
  cxDBData,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  dxBarExtItems,
  Vcl.ExtCtrls,
  cxCheckComboBox,
  cxCheckGroup,
  cxCalc,
  Vcl.OleCtrls,
  cxSplitter,
  cxTextEdit,
  cxFilter,
  cxData;

type
  TfrmMain = class(TERPCustomForm, IView, IViewMain)
    sbMain: TdxStatusBar;
    actlstMain: TActionList;
    actRefresh: TAction;
    dxbrmngrMain: TdxBarManager;
    dxbrButtons: TdxBar;
    btnRefresh: TdxBarLargeButton;
    cxmglstActions: TcxImageList;
    dxbrFilter: TdxBar;
    cxbrdtmBeginDate: TcxBarEditItem;
    cxbrdtmEndDate: TcxBarEditItem;
    cxgrdlvlMain: TcxGridLevel;
    cxgrdMain: TcxGrid;
    cxbrdtmProgress: TcxBarEditItem;
    dxbrsbtmDocumentTypes: TdxBarSubItem;
    cxgrdtblvwGrid1TableView: TcxGridTableView;
    colIdCrossDocking: TcxGridColumn;
    colOrderDateTime: TcxGridColumn;
    colOrderNo: TcxGridColumn;
    colSalesOrderNo: TcxGridColumn;
    colExternalLocationCode: TcxGridColumn;
    colExternalUserID: TcxGridColumn;
    colExternalSystemID: TcxGridColumn;
    colDocumentStatusName: TcxGridColumn;
    colStatusMessageErrorText: TcxGridColumn;
    colStatusMessageRetryCount: TcxGridColumn;
    pnlMain: TPanel;
    cxbrdtmOrderCode: TcxBarEditItem;
    dxbrdt1: TdxBarEdit;
    actHistory: TAction;
    btnHistory: TdxBarLargeButton;
    procedure actRefreshExecute(Sender: TObject);
    procedure actRefreshUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxbrdtmOrderCodePropertiesChange(Sender: TObject);
    procedure cxgrdtblvwGrid1TableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxbrdtmOrderCodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actHistoryExecute(Sender: TObject);
    procedure actHistoryUpdate(Sender: TObject);
    procedure cxgrdtblvwGrid1TableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxgrdtblvwGrid1TableViewCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);

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
    procedure StepProgress(const aToPosition: Integer = -1);
    procedure HideProgress();
    function GetBeginDate(): TDate;
    procedure SetBeginDate(const aValue: TDate);
    function GetEndDate(): TDate;
    procedure SetEndDate(const aValue: TDate);
    function GetOrderCode(): string;
    procedure SetOrderCode(const aValue: string);
    procedure SetQueue(const aValue: TDataSet);
    procedure Initialize();
    procedure ShowMessage(const aMessage: string; const aStatus: Integer);
    function GetCurrentDocumentId(): Integer;
    procedure StorePresenter(const aPresenter: IInterface);
  end;

implementation

{$R *.dfm}

uses
  System.Math,
  System.DateUtils,
  System.Variants,
  Vcl.Clipbrd,
  ERP.Package.CustomClasses.Consts,
  ERP.Package.GlobalData.DataModule,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TModule,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TQuery,
  ERP.Package.CustomGlobalFunctions.UserFunctions;

constructor TfrmMain.Create(aERPClientData: IERPClientData);
begin
  inherited Create(TModule.ModuleName, aERPClientData);
end;

procedure TfrmMain.cxbrdtmOrderCodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    btnRefresh.Click();
  end;
end;

procedure TfrmMain.cxbrdtmOrderCodePropertiesChange(Sender: TObject);
var
  s: string;
begin
  cxbrdtmOrderCode.EditValue := cxbrdtmOrderCode.CurEditValue;
  s := cxbrdtmOrderCode.EditValue;
  cxbrdtmBeginDate.Enabled := Length(s) = 0;
  cxbrdtmEndDate.Enabled := Length(s) = 0;
end;

procedure TfrmMain.cxgrdtblvwGrid1TableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnHistory.Click();
end;

procedure TfrmMain.cxgrdtblvwGrid1TableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
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

procedure TfrmMain.cxgrdtblvwGrid1TableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Controller: TcxGridTableController;
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('C')) or (Key = VK_INSERT)) then
  begin
    Controller := cxgrdtblvwGrid1TableView.Controller;
    if Assigned(Controller.FocusedRecord) and Assigned(Controller.FocusedItem) then
      Clipboard.AsText := VarToStrDef(Controller.FocusedRecord.Values[Controller.FocusedItem.Index], '');
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Initialize();
end;

function TfrmMain.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

function TfrmMain.GetBeginDate(): TDate;
var
  tmpDate: TDateTime;
begin
  tmpDate := cxbrdtmBeginDate.EditValue;
  Result := DateOf(tmpDate);
end;

function TfrmMain.GetCurrentDocumentId(): Integer;
begin
  Result := -1;
  if cxgrdtblvwGrid1TableView.Controller.SelectedRecordCount = 1 then
  begin
    Result := cxgrdtblvwGrid1TableView.Controller.SelectedRecords[0].Values[colIdCrossDocking.Index];
  end;
end;

function TfrmMain.GetEndDate(): TDate;
var
  tmpDate: TDateTime;
begin
  tmpDate := cxbrdtmEndDate.EditValue;
  Result := DateOf(tmpDate);
end;

function TfrmMain.GetOrderCode(): string;
var
  tmpOrderCode: string;
begin
  tmpOrderCode := cxbrdtmOrderCode.EditValue;
  Result := tmpOrderCode.Trim();
end;

procedure TfrmMain.SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TfrmMain.SetBeginDate(const aValue: TDate);
begin
  cxbrdtmBeginDate.EditValue := DateOf(aValue);
end;

procedure TfrmMain.SetQueue(const aValue: TDataSet);
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
      cxgrdtblvwGrid1TableView.DataController.Values[i, colIdCrossDocking.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.Id_CrossDocking).AsInteger;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colOrderDateTime.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.OrderDateTime).AsDateTime;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colOrderNo.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.OrderNo).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colSalesOrderNo.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.SalesOrderNo).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colExternalLocationCode.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.ExternalLocationCode).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colExternalUserID.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.ExternalUserID).AsInteger;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colExternalSystemID.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.ExternalSystemID).AsInteger;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colDocumentStatusName.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.DocumentStatusName).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colStatusMessageErrorText.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.ErrorText).AsString;
      cxgrdtblvwGrid1TableView.DataController.Values[i, colStatusMessageRetryCount.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingSel.Field.RetryCount).AsInteger;

      StepProgress();

      aValue.Next();
    end;
  finally
    cxgrdtblvwGrid1TableView.EndUpdate();
  end;
end;

procedure TfrmMain.SetEndDate(const aValue: TDate);
begin
  cxbrdtmEndDate.EditValue := DateOf(aValue);
end;

procedure TfrmMain.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  FOnEventSimple := aValue;
end;

procedure TfrmMain.SetOrderCode(const aValue: string);
begin
  cxbrdtmOrderCode.EditValue := aValue.Trim();
end;

procedure TfrmMain.ShowProgress(const aTitle: string; const aMax: Integer);
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aTitle.Trim();
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Max := aMax;
  cxbrdtmProgress.EditValue := 0;
  cxbrdtmProgress.Visible := ivAlways;
  Application.ProcessMessages();
end;

procedure TfrmMain.StepProgress(const aToPosition: Integer);
var
  i: Integer;
begin
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
  tmpToday: TDateTime;
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    AssignImages();
    tmpToday := Date();
    SetBeginDate(tmpToday);
    SetEndDate(tmpToday);
    SetOrderCode(EmptyStr);
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

procedure TfrmMain.actHistoryExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veHistoryExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.actHistoryUpdate(Sender: TObject);
begin
  FOnEventSimple(veHistoryUpdate);
  (Sender as TAction).Enabled := FActionStates[vaHistory];
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
  actRefresh.ImageIndex := CopyIL(IL_REFRESH);
  actHistory.ImageIndex := CopyIL(IL_FIND);
end;

procedure TfrmMain.ShowMessage(const aMessage: string; const aStatus: Integer);
begin
  TERPMessageHelp.ShowMessage(TERPQueryResult.Create(aStatus, aMessage, 0));
end;

end.
