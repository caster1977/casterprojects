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
    actClearProfile: TAction;
    actSaveProfile: TAction;
    ActionManager: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    pabTaskList: TPopupActionBar;
    pabProfiles: TPopupActionBar;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actProfiles: TProfilesMenuGroupAction;
    actConfiguration: TAction_Configuration;
    TrayIcon: TTrayIcon;
    pabTray: TPopupActionBar;
    procedure actQuitExecute(Sender: TObject);
    procedure lvTaskListResize(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  Close;
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

