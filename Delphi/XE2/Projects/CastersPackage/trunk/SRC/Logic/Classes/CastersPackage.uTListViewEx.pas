unit CastersPackage.uTListViewEx;

(*

  ListView with ColumnResize events

  Code found on news:borland.* provided by Peter Below (a TeamB member)

  Placing a TProgressBar into a TListView

  http://delphi.about.com/library/weekly/aa053105a.htm

  Here's how to add a progress bar (or any other Delphi
  component) to a ListView control. Plus: full source code
  to the TListViewEx component (TListView descendant) with
  ColumnResize events!


  ~ Zarko Gajic
  http://delphi.about.com


*)

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.ComCtrls,
  Winapi.CommCtrl,
  Winapi.Messages,
  Winapi.Windows;

type
  TColumnResizeEvent = procedure(Sender: TCustomListview; columnIndex: Integer; columnWidth: Integer) of object;
  TScrollEvent = procedure(Sender: TCustomListview) of object;

  TListViewEx = class(TListView)
  strict private
    FColumnResizeEvent: TColumnResizeEvent;
    FEndColumnResizeEvent: TColumnResizeEvent;
    FBeginColumnResizeEvent: TColumnResizeEvent;
    FDividerDblClickEvent: TColumnResizeEvent;
    FOnScrollEvent: TScrollEvent;
    function FindColumnIndex(const AHeader: pNMHdr): Integer;
    function FindColumnWidth(const AHeader: pNMHdr): Integer;
    procedure DoBeginColumnResize(const AColumnIndex, AColumnWidth: Integer); virtual;
    procedure DoEndColumnResize(const AColumnIndex, AColumnWidth: Integer); virtual;
    procedure DoColumnResize(const AColumnIndex, AColumnWidth: Integer); virtual;
    procedure DoDividerDblClick(const AColumnIndex, AColumnWidth: Integer); virtual;
    procedure WMNotify(var AMsg: TWMNotify); message WM_NOTIFY;
    procedure WM_HScroll(var AMsg: TWMHScroll); message WM_HScroll;
    procedure WM_VScroll(var AMsg: TWMVScroll); message WM_VScroll;
  strict protected
    procedure CreateWnd; override;
  published
    property OnBeginColumnResize: TColumnResizeEvent read FBeginColumnResizeEvent write FBeginColumnResizeEvent nodefault;
    property OnEndColumnResize: TColumnResizeEvent read FEndColumnResizeEvent write FEndColumnResizeEvent nodefault;
    property OnColumnResize: TColumnResizeEvent read FColumnResizeEvent write FColumnResizeEvent nodefault;
    property OnDividerDblClick: TColumnResizeEvent read FDividerDblClickEvent write FDividerDblClickEvent nodefault;
    property OnScroll: TScrollEvent read FOnScrollEvent write FOnScrollEvent nodefault;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

procedure register;

implementation

procedure register;
begin
  RegisterComponents('CasterComponents', [TListViewEx]);
end;

procedure TListViewEx.CreateWnd;
var
  wnd: HWND;
begin
  inherited;
  wnd := GetWindow(handle, GW_CHILD);
  SetWindowLong(wnd, GWL_STYLE, GetWindowLong(wnd, GWL_STYLE) and not HDS_FULLDRAG);
end;

procedure TListViewEx.WM_HScroll(var AMsg: TWMHScroll);
begin
  inherited;
  if Assigned(FOnScrollEvent) then
  begin
    FOnScrollEvent(Self);
  end;
end;

procedure TListViewEx.WM_VScroll(var AMsg: TWMVScroll);
begin
  inherited;
  if Assigned(FOnScrollEvent) then
  begin
    FOnScrollEvent(Self);
  end;
end;

procedure TListViewEx.DoBeginColumnResize(const AColumnIndex, AColumnWidth: Integer);
begin
  if Assigned(FBeginColumnResizeEvent) then
  begin
    FBeginColumnResizeEvent(Self, AColumnIndex, AColumnWidth);
  end;
end;

procedure TListViewEx.DoColumnResize(const AColumnIndex, AColumnWidth: Integer);
begin
  if Assigned(FColumnResizeEvent) then
  begin
    FColumnResizeEvent(Self, AColumnIndex, AColumnWidth);
  end;
end;

procedure TListViewEx.DoDividerDblClick(const AColumnIndex, AColumnWidth: Integer);
begin
  if Assigned(FDividerDblClickEvent) then
  begin
    FDividerDblClickEvent(Self, AColumnIndex, AColumnWidth);
  end;
end;

procedure TListViewEx.DoEndColumnResize(const AColumnIndex, AColumnWidth: Integer);
begin
  if Assigned(FEndColumnResizeEvent) then
  begin
    FEndColumnResizeEvent(Self, AColumnIndex, AColumnWidth);
  end;
end;

function TListViewEx.FindColumnIndex(const AHeader: pNMHdr): Integer;
var
  hwndHeader: HWND;
  item_info: THdItem;
  item_index: Integer;
  buf: array [0 .. 128] of Char;
begin
  Result := -1;
  hwndHeader := AHeader^.hwndFrom;
  item_index := pHDNotify(AHeader)^.Item;
  FillChar(item_info, sizeof(item_info), 0);

  item_info.Mask := HDI_TEXT;
  item_info.pszText := buf;
  item_info.cchTextMax := sizeof(buf) - 1;

  Header_GetItem(hwndHeader, item_index, item_info);

  if CompareStr(Columns[item_index].Caption, item_info.pszText) = 0 then
  begin
    Result := item_index;
  end
  else
  begin
    for item_index := 0 to Columns.count - 1 do
    begin
      if CompareStr(Columns[item_index].Caption, item_info.pszText) = 0 then
      begin
        Result := item_index;
        Break;
      end;
    end;
  end;
end;

function TListViewEx.FindColumnWidth(const AHeader: pNMHdr): Integer;
begin
  Result := -1;
  if Assigned(pHDNotify(AHeader)^.pItem) and ((pHDNotify(AHeader)^.pItem^.Mask and HDI_WIDTH) <> 0) then
  begin
    Result := pHDNotify(AHeader)^.pItem^.cxy;
  end;
end;

procedure TListViewEx.WMNotify(var AMsg: TWMNotify);
begin
  inherited;
  case AMsg.NMHdr^.code of
    HDN_ENDTRACK:
      begin
        DoEndColumnResize(FindColumnIndex(AMsg.NMHdr), FindColumnWidth(AMsg.NMHdr));
      end;
    HDN_BEGINTRACK:
      begin
        DoBeginColumnResize(FindColumnIndex(AMsg.NMHdr), FindColumnWidth(AMsg.NMHdr));
      end;
    HDN_TRACK:
      begin
        DoColumnResize(FindColumnIndex(AMsg.NMHdr), FindColumnWidth(AMsg.NMHdr));
      end;
    HDN_DIVIDERDBLCLICK:
      begin
        DoDividerDblClick(FindColumnIndex(AMsg.NMHdr), FindColumnWidth(AMsg.NMHdr));
      end;
  end;
end;

end.
