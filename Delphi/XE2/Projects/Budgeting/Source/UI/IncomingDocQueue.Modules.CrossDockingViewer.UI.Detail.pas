unit IncomingDocQueue.Modules.CrossDockingViewer.UI.Detail;

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
  Data.DB,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumEvent,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumAction,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumActionArray,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IView,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IViewDetail,
  cxCurrencyEdit,
  cxSpinEdit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  cxCalendar,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxClasses,
  cxGridCustomView,
  cxGrid;

type
  TfrmDetail = class(TForm, IView, IViewDetail)
    ActionList: TActionList;
    actClose: TAction;
    pnlButtons: TPanel;
    btnCancel: TButton;
    bvl1: TBevel;
    cxgrdDetail: TcxGrid;
    cxgrdtblvwGrid1TableView: TcxGridTableView;
    colCreateDate: TcxGridColumn;
    colDocumentStatusName: TcxGridColumn;
    colErrorText: TcxGridColumn;
    colRetryCount: TcxGridColumn;
    cxgrdlvlMain: TcxGridLevel;
    procedure actCloseExecute(Sender: TObject);
    procedure actCloseUpdate(Sender: TObject);
    procedure cxgrdtblvwGrid1TableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  strict private
    FOnEventSimple: TProc<TViewEnumEvent>;
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    procedure RefreshStates();
    procedure ShowMessage(const aMessage: string; const aStatus: Integer);
    procedure SetList(const aValue: TDataSet);
    procedure StorePresenter(const aPresenter: IInterface);
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Variants,
  Vcl.Clipbrd,
  ERP.Package.CustomGlobalFunctions.UserFunctions,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TQuery;

procedure TfrmDetail.actCloseExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veCloseExecute);
    ModalResult := mrCancel;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmDetail.actCloseUpdate(Sender: TObject);
begin
  FOnEventSimple(veCloseUpdate);
  (Sender as TAction).Enabled := FActionStates[vaClose];
end;

procedure TfrmDetail.cxgrdtblvwGrid1TableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmDetail.SetList(const aValue: TDataSet);
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
      cxgrdtblvwGrid1TableView.DataController.Values[i, colCreateDate.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingHistorySel.Field.CreateDate).AsDateTime;

      cxgrdtblvwGrid1TableView.DataController.Values[i, colErrorText.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingHistorySel.Field.ErrorText).AsString;

      cxgrdtblvwGrid1TableView.DataController.Values[i, colRetryCount.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingHistorySel.Field.RetryCount).AsInteger;

      cxgrdtblvwGrid1TableView.DataController.Values[i, colDocumentStatusName.Index] :=
        aValue.FieldByName(TQuery.SpCrossDockingViewerCrossDockingHistorySel.Field.DocumentStatusName).AsString;

      aValue.Next();
    end;
  finally
    cxgrdtblvwGrid1TableView.EndUpdate();
  end;
end;

end.
