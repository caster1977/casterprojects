unit DBAutoTest.uTMainForm;

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
  CastersPackage.Actions.Classes,
  System.Actions,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.StdActns, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnMenus, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    ImageList: TImageList;
    actHelpMenuGroup: THelpMenuGroupAction;
    actFileMenuGroup: TFileMenuGroupAction;
    actActionMenuGroup: TActionMenuGroupAction;
    actHelpContents: THelpContentsAction;
    actAbout: TAction;
    actQuit: TQuitAction;
    pnlMain: TPanel;
    pnlButtons: TPanel;
    btnProcess: TButton;
    btnProfiles: TButton;
    lvTaskList: TListView;
    actLoadProfile: TAction;
    actSaveProfileAs: TAction;
    actCreateProfile: TAction;
    actSaveProfile: TAction;
    ActionManager: TActionManager;
    pabTaskList: TPopupActionBar;
    pabProfiles: TPopupActionBar;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    actProfiles: TProfilesMenuGroupAction;
    actConfiguration: TAction_Configuration;
    TrayIcon: TTrayIcon;
    pabTray: TPopupActionBar;
    actProcess: TAction;
    actRecentProfiles: TAction;
    actCreateTask: TAction;
    actEditTask: TAction;
    actDeleteTask: TAction;
    actClearTasks: TAction;
    MainMenu: TMainMenu;
    ActionToolBar1: TActionToolBar;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    procedure actQuitExecute(Sender: TObject);
    procedure lvTaskListResize(Sender: TObject);
    procedure actRecentProfilesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
    procedure OnHint(ASender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actRecentProfilesExecute(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.OnHint(ASender: TObject);
begin
  StatusBar.SimpleText := GetLongHint(Application.Hint);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnHint := OnHint;
end;

procedure TMainForm.lvTaskListResize(Sender: TObject);
//var
//  h: HWND;
begin
//  h:=lvTaskList.Handle;
//  lvTaskList.Column[0].Width:=lvTaskList.Width-100-(lvTaskList.BevelWidth*2)-2;
//  if (GetWindowLong(h, GWL_STYLE)and WS_VSCROLL)=WS_VSCROLL then
//  begin
//    lvTaskList.Column[0].Width:=lvTaskList.Column[0].Width-GetSystemMetrics(SM_CXVSCROLL);
//  end;
//  lvTaskList.Column[1].Width:=100;
//  lvTaskList.FlatScrollBars:=False;
//  lvTaskList.FlatScrollBars:=True;
end;

end.

