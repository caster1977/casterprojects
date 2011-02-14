unit Main;

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
  AppEvnts,
  StdCtrls,
  ExtCtrls,
  Buttons;

type
  TMainForm=class(TForm)
    ApplicationEvents1: TApplicationEvents;
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure TrackMouseMove(AHandle: HWND);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainForm.Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-MainForm.Height;
  MainForm.Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-MainForm.Width;
  // SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  case Msg.message of
    WM_MOUSEHOVER:
      begin
        Application.BringToFront;
        MainForm.AlphaBlend:=False;
      end;
    WM_MOUSELEAVE:
      MainForm.AlphaBlend:=True;
  end;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  TrackMouseMove(MainForm.Handle);
end;

procedure TMainForm.FormDblClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.TrackMouseMove(AHandle: HWND);
var
  t: tagTRACKMOUSEEVENT;
begin
  with t do
    begin
      cbSize:=sizeof(tagTRACKMOUSEEVENT);
      dwFlags:=TME_HOVER or TME_LEAVE;
      hwndTrack:=AHandle;
      dwHoverTime:=HOVER_DEFAULT;
    end;
  if not TrackMouseEvent(t) then
    MessageBox(Application.Handle, 'Возникла ошибка при вызове функции TrackMouseEvent(@t)', 'Внимание!', MB_OK+MB_ICONERROR);
end;

procedure TMainForm.ApplicationEvents1Deactivate(Sender: TObject);
begin
  // MainForm.AlphaBlend:=True;
end;

procedure TMainForm.ApplicationEvents1Activate(Sender: TObject);
begin
  // MainForm.AlphaBlend:=False;
end;

end.
