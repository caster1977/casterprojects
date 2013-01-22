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
  SysUtils,
  Classes,
  Controls,
  ComCtrls,
  CommCtrl,
  Messages,
  Windows;

type
  TColumnResizeEvent = procedure(Sender: TCustomListview; columnIndex: Integer;
    columnWidth: Integer) of object;
  TScrollEvent = procedure(Sender: TCustomListview) of object;

  TListViewEx = class(TListView)
  private
    fColumnResizeEvent: TColumnResizeEvent;
    fEndColumnResizeEvent: TColumnResizeEvent;
    fBeginColumnResizeEvent: TColumnResizeEvent;
    fDividerDblClickEvent: TColumnResizeEvent;
    fOnScrollEvent: TScrollEvent;
  protected
    procedure DoBeginColumnResize(columnIndex, columnWidth: Integer); virtual;
    procedure DoEndColumnResize(columnIndex, columnWidth: Integer); virtual;
    procedure DoColumnResize(columnIndex, columnWidth: Integer); virtual;
    procedure DoDividerDblClick(columnIndex, columnWidth: Integer); virtual;
    procedure WMNotify(var msg: TWMNotify); message WM_NOTIFY;
    procedure WM_HScroll(var msg: TWMHScroll); message WM_HScroll;
    procedure WM_VScroll(var msg: TWMVScroll); message WM_VScroll;
    function FindColumnIndex(pHeader: pNMHdr): Integer;
    function FindColumnWidth(pHeader: pNMHdr): Integer;
    procedure CreateWnd; override;
  published
    property OnBeginColumnResize: TColumnResizeEvent read fBeginColumnResizeEvent
      write fBeginColumnResizeEvent;
    property OnEndColumnResize: TColumnResizeEvent read fEndColumnResizeEvent
      write fEndColumnResizeEvent;
    property OnColumnResize: TColumnResizeEvent read fColumnResizeEvent write fColumnResizeEvent;
    property OnDividerDblClick: TColumnResizeEvent read fDividerDblClickEvent
      write fDividerDblClickEvent;
    property OnScroll: TScrollEvent read fOnScrollEvent write fOnScrollEvent;
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

{ TListViewEx }

procedure TListViewEx.CreateWnd;
var
  wnd: HWND;
begin
  inherited;
  wnd := GetWindow(handle, GW_CHILD);
  SetWindowLong(wnd, GWL_STYLE, GetWindowLong(wnd, GWL_STYLE) and not HDS_FULLDRAG);
end;

procedure TListViewEx.WM_HScroll(var msg: TWMHScroll);
begin
  inherited;
  if Assigned(fOnScrollEvent) then
    fOnScrollEvent(Self);
end;

procedure TListViewEx.WM_VScroll(var msg: TWMVScroll);
begin
  inherited;
  if Assigned(fOnScrollEvent) then
    fOnScrollEvent(Self);
end;

procedure TListViewEx.DoBeginColumnResize(columnIndex, columnWidth: Integer);
begin
  if Assigned(fBeginColumnResizeEvent) then
    fBeginColumnResizeEvent(Self, columnIndex, columnWidth);
end;

procedure TListViewEx.DoColumnResize(columnIndex, columnWidth: Integer);
begin
  if Assigned(fColumnResizeEvent) then
    fColumnResizeEvent(Self, columnIndex, columnWidth);
end;

procedure TListViewEx.DoDividerDblClick(columnIndex, columnWidth: Integer);
begin
  if Assigned(fDividerDblClickEvent) then
    fDividerDblClickEvent(Self, columnIndex, columnWidth);
end;

procedure TListViewEx.DoEndColumnResize(columnIndex, columnWidth: Integer);
begin
  if Assigned(fEndColumnResizeEvent) then
    fEndColumnResizeEvent(Self, columnIndex, columnWidth);
end;

function TListViewEx.FindColumnIndex(pHeader: pNMHdr): Integer;
var
  hwndHeader: HWND;
  iteminfo: THdItem;
  itemindex: Integer;
  buf: array [0 .. 128] of Char;
begin
  Result := -1;
  hwndHeader := pHeader^.hwndFrom;
  itemindex := pHDNotify(pHeader)^.Item;
  FillChar(iteminfo, sizeof(iteminfo), 0);

  iteminfo.Mask := HDI_TEXT;
  iteminfo.pszText := buf;
  iteminfo.cchTextMax := sizeof(buf) - 1;

  Header_GetItem(hwndHeader, itemindex, iteminfo);

  if CompareStr(Columns[itemindex].Caption, iteminfo.pszText) = 0 then
    Result := itemindex
  else
    for itemindex := 0 to Columns.count - 1 do
      if CompareStr(Columns[itemindex].Caption, iteminfo.pszText) = 0 then
      begin
        Result := itemindex;
        Break;
      end;
end;

function TListViewEx.FindColumnWidth(pHeader: pNMHdr): Integer;
begin
  Result := -1;
  if Assigned(pHDNotify(pHeader)^.pItem) and ((pHDNotify(pHeader)^.pItem^.Mask and HDI_WIDTH) <> 0)
  then
    Result := pHDNotify(pHeader)^.pItem^.cxy;
end;

procedure TListViewEx.WMNotify(var msg: TWMNotify);
begin
  inherited;
  case msg.NMHdr^.code of
    HDN_ENDTRACK:
      DoEndColumnResize(FindColumnIndex(msg.NMHdr), FindColumnWidth(msg.NMHdr));
    HDN_BEGINTRACK:
      DoBeginColumnResize(FindColumnIndex(msg.NMHdr), FindColumnWidth(msg.NMHdr));
    HDN_TRACK:
      DoColumnResize(FindColumnIndex(msg.NMHdr), FindColumnWidth(msg.NMHdr));
    HDN_DIVIDERDBLCLICK:
      DoDividerDblClick(FindColumnIndex(msg.NMHdr), FindColumnWidth(msg.NMHdr));
  end;
end;

end.
