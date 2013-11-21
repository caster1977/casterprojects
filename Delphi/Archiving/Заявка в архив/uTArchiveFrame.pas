unit uTArchiveFrame;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  Data.DB,
  cxDBData,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  Vcl.ToolWin,
  Vcl.ActnMan,
  Vcl.ActnCtrls,
  Vcl.ComCtrls,
  Vcl.ImgList,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxStatusBar,
  dxBarExtItems,
  cxProgressBar,
  cxTrackBar,
  cxTimeEdit,
  cxCalendar,
  cxBarEditItem;

type
  TArchiveFrame = class(TFrame)
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    dxStatusBar: TdxStatusBar;
    dxBarManager: TdxBarManager;
    dxbmToolBar: TdxBar;
    dxbmPeriodBar: TdxBar;
    ImageList: TImageList;
    alToolBar: TActionList;
    actRefresh: TAction;
    actExportToExcel: TAction;
    cxbeiPeriodStart: TcxBarEditItem;
    dxbsPeriod: TdxBarStatic;
    cxbeiPeriodStop: TcxBarEditItem;
    dxbbApplyPeriod: TdxBarButton;
    alOther: TActionList;
    actApplyPeriod: TAction;
    dxbgPeriod: TdxBarGroup;
    procedure FrameResize(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actRefreshUpdate(Sender: TObject);
    procedure actExportToExcelUpdate(Sender: TObject);
    procedure actApplyPeriodExecute(Sender: TObject);
    procedure actApplyPeriodUpdate(Sender: TObject);
    procedure cxBarEditItem4PropertiesEditValueChanged(Sender: TObject);
    procedure cxBarEditItem5PropertiesEditValueChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Initialize(const AToolBarActionList: TActionList; const APeriodBarVisible: Boolean;
      const APeriodBarCaption: string; const APeriodStartDate, APeriodStopDate: TDate);
  private
    FPreviousPeriodStartDate: TDate;
    FPreviousPeriodStopDate: TDate;
    function GetPreviousPeriodStartDate: TDate;
    function GetPreviousPeriodStopDate: TDate;
    function GetCurrentPeriodStartDate: TDate;
    function GetCurrentPeriodStopDate: TDate;
    procedure SetCurrentPeriodStartDate(const AValue: TDate);
    procedure SetCurrentPeriodStopDate(const AValue: TDate);
    property PreviousPeriodStartDate: TDate read GetPreviousPeriodStartDate nodefault;
    property PreviousPeriodStopDate: TDate read GetPreviousPeriodStopDate nodefault;
    property CurrentPeriodStartDate: TDate read GetCurrentPeriodStartDate write SetCurrentPeriodStartDate nodefault;
    property CurrentPeriodStopDate: TDate read GetCurrentPeriodStopDate write SetCurrentPeriodStopDate nodefault;
  end;

implementation

{$R *.dfm}

uses
  DateUtils;

procedure TArchiveFrame.actApplyPeriodExecute(Sender: TObject);
begin
  if (CurrentPeriodStartDate > Today) then
  begin
    MessageBox(Self.Parent.Handle, PWideChar('Дата начала периода не должна быть больше текущей даты'),
      PWideChar('Ошибка'), MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
    Exit;
  end;
  if CurrentPeriodStopDate > Today then
  begin
    MessageBox(Self.Parent.Handle, PWideChar('Дата окончания периода не должна быть больше текущей даты'),
      PWideChar('Ошибка'), MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
    Exit;
  end;
  if CurrentPeriodStartDate > CurrentPeriodStopDate then
  begin
    MessageBox(Self.Parent.Handle, PWideChar('Дата начала периода не должна быть больше даты окончания периода'),
      PWideChar('Ошибка'), MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
    Exit;
  end;
  FPreviousPeriodStartDate := CurrentPeriodStartDate;
  FPreviousPeriodStopDate := CurrentPeriodStopDate;
end;

procedure TArchiveFrame.actApplyPeriodUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  b := (CurrentPeriodStartDate <> PreviousPeriodStartDate) or (CurrentPeriodStopDate <> PreviousPeriodStopDate);
  if (Sender as TAction).Enabled <> b then
  begin
    (Sender as TAction).Enabled := b;
  end;
end;

procedure TArchiveFrame.actExportToExcelUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(cxGrid.ActiveView) then
  begin
    if Assigned(cxGrid.ActiveView.DataController) then
    begin
      if cxGrid.ActiveView.DataController.RowCount > 0 then
      begin
        b := True;
      end;
    end;
  end;
  if (Sender as TAction).Enabled <> b then
  begin
    (Sender as TAction).Enabled := b;
  end;
end;

procedure TArchiveFrame.actRefreshExecute(Sender: TObject);
begin
  if Assigned(cxGrid.ActiveView) then
  begin
    cxGrid.ActiveView.DataController.BeginFullUpdate;
    try

    finally
      cxGrid.ActiveView.DataController.EndFullUpdate;
    end;
  end;
  cxGrid.ActiveView.DataController.Refresh;
end;

procedure TArchiveFrame.actRefreshUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(cxGrid.ActiveView) then
  begin
    if Assigned(cxGrid.ActiveView.DataController) then
    begin
      b := True;
    end;
  end;
  if (Sender as TAction).Enabled <> b then
  begin
    (Sender as TAction).Enabled := b;
  end;
end;

constructor TArchiveFrame.Create(AOwner: TComponent);
begin
  inherited;
  CurrentPeriodStartDate := Today;
  CurrentPeriodStopDate := Today;
end;

procedure TArchiveFrame.cxBarEditItem4PropertiesEditValueChanged(Sender: TObject);
begin
  CurrentPeriodStartDate := cxbeiPeriodStart.CurEditValue;
end;

procedure TArchiveFrame.cxBarEditItem5PropertiesEditValueChanged(Sender: TObject);
begin
  CurrentPeriodStopDate := cxbeiPeriodStop.CurEditValue;
end;

procedure TArchiveFrame.FrameResize(Sender: TObject);
begin
  if dxbmPeriodBar.Visible then
  begin
    dxbmPeriodBar.DockedLeft := Width;
  end;
end;

function TArchiveFrame.GetCurrentPeriodStartDate: TDate;
begin
  Result := DateOf(cxbeiPeriodStart.EditValue);
end;

function TArchiveFrame.GetCurrentPeriodStopDate: TDate;
begin
  Result := DateOf(cxbeiPeriodStop.EditValue);
end;

function TArchiveFrame.GetPreviousPeriodStartDate: TDate;
begin
  Result := FPreviousPeriodStartDate;
end;

function TArchiveFrame.GetPreviousPeriodStopDate: TDate;
begin
  Result := FPreviousPeriodStopDate;
end;

procedure TArchiveFrame.Initialize(const AToolBarActionList: TActionList; const APeriodBarVisible: Boolean;
  const APeriodBarCaption: string; const APeriodStartDate, APeriodStopDate: TDate);
var
  il: TdxBarItemLink;
  i: Integer;
begin
  dxbmToolBar.ItemLinks.Clear;
  if AToolBarActionList.ActionCount > 0 then
  begin
    for i := 0 to AToolBarActionList.ActionCount - 1 do
    begin
      il := dxbmToolBar.ItemLinks.AddButton;
      if Assigned(il) then
      begin
        (il.Item as TdxBarButton).Action := AToolBarActionList.Actions[i];
      end;
    end;
  end;
  if alToolBar.ActionCount > 0 then
  begin
    for i := 0 to alToolBar.ActionCount - 1 do
    begin
      il := dxbmToolBar.ItemLinks.AddButton;
      if Assigned(il) then
      begin
        (il.Item as TdxBarButton).Action := alToolBar.Actions[i];
      end;
    end;
  end;
  dxbmPeriodBar.Visible := APeriodBarVisible;
  if dxbmPeriodBar.Visible then
  begin
    dxbmPeriodBar.DockedLeft := Width;
    dxbsPeriod.Caption := APeriodBarCaption;
    CurrentPeriodStartDate := APeriodStartDate;
    CurrentPeriodStopDate := APeriodStopDate;
    if actApplyPeriod.Enabled then
    begin
      actApplyPeriod.Execute;
    end;
  end;
end;

procedure TArchiveFrame.SetCurrentPeriodStartDate(const AValue: TDate);
var
  d: TDate;
begin
  d := DateOf(AValue);
  if DateOf(cxbeiPeriodStart.EditValue) <> d then
  begin
    cxbeiPeriodStart.EditValue := d;
  end;
end;

procedure TArchiveFrame.SetCurrentPeriodStopDate(const AValue: TDate);
var
  d: TDate;
begin
  d := DateOf(AValue);
  if DateOf(cxbeiPeriodStop.EditValue) <> d then
  begin
    cxbeiPeriodStop.EditValue := d;
  end;
end;

end.
