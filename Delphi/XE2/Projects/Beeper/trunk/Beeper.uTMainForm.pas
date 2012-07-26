unit Beeper.uTMainForm;

interface

uses
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.AppEvnts,
  Vcl.ActnMan,
  Vcl.ActnCtrls,
  Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.ToolWin,
  CastersPackage.Actions.Classes,
  Vcl.StdActns;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    TrayIcon: TTrayIcon;
    ImageList: TImageList;
    ActionManager: TActionManager;
    MainMenu: TMainMenu;
    TrayPopupMenu: TPopupMenu;
    ActionToolBar1: TActionToolBar;
    QuitAction: TQuitAction;
    N1: TMenuItem;
    N2: TMenuItem;
    FileMenuGroupAction: TFileMenuGroupAction;
    ListView1: TListView;
    HelpMenuGroupAction: THelpMenuGroupAction;
    HelpContentsAction: THelpContentsAction;
    N3: TMenuItem;
    N4: TMenuItem;
    EraseSignalAction: TAction;
    EditSignalAction: TAction;
    CreateSignalAction: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    ActionMenuGroupAction: TActionMenuGroupAction;
    procedure EraseSignalActionUpdate(Sender: TObject);
    procedure EditSignalActionUpdate(Sender: TObject);
    procedure CreateSignalActionExecute(Sender: TObject);
    procedure EditSignalActionExecute(Sender: TObject);
    procedure EraseSignalActionExecute(Sender: TObject);
  private
    procedure DisplayHint(Sender: TObject);
    procedure ShowErrorMessageBox(const AMessage: string);
    procedure RegisterHotKeys;
    procedure UnregisterHotKeys;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Winapi.Windows,
  Beeper.uTConfiguration,
  Beeper.uConsts,
  Beeper.uResourceStrings;

procedure TMainForm.DisplayHint(Sender: TObject);
begin
  StatusBar.SimpleText := GetLongHint(Application.Hint);
end;

procedure TMainForm.ShowErrorMessageBox(const AMessage: string);
begin
  MessageBox(Handle, PWideChar(AMessage), PWideChar(Format(RsErrorMessageCaption, [UpperCase(Application.Title)])), MESSAGE_TYPE_ERROR);
end;

procedure TMainForm.RegisterHotKeys;
begin
  if not RegisterHotkey(Handle, 1, Configuration.ModifierOn, Configuration.VirtualKeyOn) then
    ShowErrorMessageBox(RsErrorResisterStartHotKey);
  if not RegisterHotkey(Handle, 2, Configuration.ModifierOff, Configuration.VirtualKeyOff) then
    ShowErrorMessageBox(RsErrorResisterStopHotKey);
end;

procedure TMainForm.UnregisterHotKeys;
begin
  if not UnRegisterHotkey(Handle, 2) then
    ShowErrorMessageBox(RsErrorUnresisterStartHotKey);
  if not UnRegisterHotkey(Handle, 1) then
    ShowErrorMessageBox(RsErrorUnresisterStopHotKey);
end;

procedure TMainForm.EditSignalActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := ListView1.Selected <> nil;
end;

procedure TMainForm.EraseSignalActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := ListView1.Selected <> nil;
end;

procedure TMainForm.CreateSignalActionExecute(Sender: TObject);
begin
  //
end;

procedure TMainForm.EditSignalActionExecute(Sender: TObject);
begin
  //
end;

procedure TMainForm.EraseSignalActionExecute(Sender: TObject);
begin
  //
end;

end.
