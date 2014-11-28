unit MultiBuffer;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  ComCtrls;

type
  TMultiBufferForm = class(TForm)
    lvBuffer: TListView;
    pnlButtons: TPanel;
    btnPaste: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDelete: TButton;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lvBufferSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btnClearClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Update_ListViewScrollBarVisibility;
    procedure Update_ButtonState;
  end;

implementation

{$R *.dfm}

uses
  Main;

procedure TMultiBufferForm.FormCreate(Sender: TObject);
begin
  btnHelp.Enabled := Application.HelpFile <> '';
end;

procedure TMultiBufferForm.FormShow(Sender: TObject);
begin
  Update_ListViewScrollBarVisibility;
  Update_ButtonState;

  if lvBuffer.Items.Count > 0 then
    ActiveControl := lvBuffer
  else
    ActiveControl := btnClose;
end;

procedure TMultiBufferForm.lvBufferSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  Update_ButtonState;
  Update_ListViewScrollBarVisibility;
end;

procedure TMultiBufferForm.Update_ButtonState;
begin
  btnDelete.Enabled := lvBuffer.Selected <> nil;
  btnClear.Enabled := lvBuffer.Items.Count > 0;
  btnPaste.Enabled := lvBuffer.Items.Count > 0;
end;

procedure TMultiBufferForm.Update_ListViewScrollBarVisibility;
var
  h: HWND;
begin
  h := lvBuffer.Handle;
  lvBuffer.Column[0].Width := 75;
  if (GetWindowLong(h, GWL_STYLE) and WS_VSCROLL) = WS_VSCROLL then
    lvBuffer.Column[1].Width := lvBuffer.Width - (lvBuffer.BevelWidth * 2) - 2 -
      GetSystemMetrics(SM_CXVSCROLL) - lvBuffer.Column[0].Width
  else
    lvBuffer.Column[1].Width := lvBuffer.Width - (lvBuffer.BevelWidth * 2) - 2 -
      lvBuffer.Column[0].Width;
  lvBuffer.FlatScrollBars := False;
  lvBuffer.FlatScrollBars := True;
end;

procedure TMultiBufferForm.btnClearClick(Sender: TObject);
var
  i: integer;
begin
  lvBuffer.Clear;
  for i := 0 to (SizeOf(MainForm.raMultiBuffer) div (SizeOf(TMsrBufferRec))) - 1 do
    MainForm.raMultiBuffer[i].bStoredDataExists := False;
  Update_ButtonState;
  Update_ListViewScrollBarVisibility;
end;

procedure TMultiBufferForm.btnDeleteClick(Sender: TObject);
begin
  if lvBuffer.Selected <> nil then
  begin
    if StrToIntDef(lvBuffer.Selected.Caption, -1) > -1 then
    begin
      MainForm.raMultiBuffer[StrToInt(lvBuffer.Selected.Caption)].bStoredDataExists := False;
      lvBuffer.Selected.Delete;
    end;
  end;
  Update_ButtonState;
  Update_ListViewScrollBarVisibility;
end;

end.

// проработать алгоритм удаления данных из мультибуффера
