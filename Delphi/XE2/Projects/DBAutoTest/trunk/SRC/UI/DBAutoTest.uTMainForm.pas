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
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.StdActns,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ActnMenus,
  Vcl.ToolWin,
  Vcl.ActnMan,
  Vcl.ActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup,
  System.Actions;

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
    atbMain: TActionToolBar;
    N7: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
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
    actRecentProfilesProperties: TAction;
    N30: TMenuItem;
    N31: TMenuItem;
    actProfileProperties: TAction;
    procedure actQuitExecute(Sender: TObject);
    procedure lvTaskListResize(Sender: TObject);
    procedure actRecentProfilesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actCreateTaskExecute(Sender: TObject);
    procedure actEditTaskUpdate(Sender: TObject);
    procedure actDeleteTaskUpdate(Sender: TObject);
    procedure actClearTasksUpdate(Sender: TObject);
    procedure actCreateTaskUpdate(Sender: TObject);
    procedure actProcessUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actRecentProfilesPropertiesExecute(Sender: TObject);
    procedure actProfilePropertiesUpdate(Sender: TObject);
    procedure actProfilePropertiesExecute(Sender: TObject);
  strict private
    procedure OnHint(ASender: TObject);
    procedure ShowAboutWindow(const AShowCloseButton: Boolean);
    procedure RefreshTaskList;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  DBAutoTest.uTConfigurationForm,
  DBAutoTest.uTAboutForm,
  DBAutoTest.uTTaskForm,
  DBAutoTest.uConsts,
  DBAutoTest.uTRecentsPropertiesForm,
  DBAutoTest.uTProfileForm;

resourcestring
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  ShowAboutWindow(True);
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
begin
  with TConfigurationForm.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

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

procedure TMainForm.ShowAboutWindow(const AShowCloseButton: Boolean);
begin
  with TAboutForm.Create(Self, AShowCloseButton) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage),
    PWideChar(Format(RsExitConfirmationCaption, [APPLICATION_NAME])),
    MESSAGE_TYPE_CONFIRMATION) = IDOK;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnHint := OnHint;
end;

procedure TMainForm.lvTaskListResize(Sender: TObject);
// var
// h: HWND;
begin
  // h:=lvTaskList.Handle;
  // lvTaskList.Column[0].Width:=lvTaskList.Width-100-(lvTaskList.BevelWidth*2)-2;
  // if (GetWindowLong(h, GWL_STYLE)and WS_VSCROLL)=WS_VSCROLL then
  // begin
  // lvTaskList.Column[0].Width:=lvTaskList.Column[0].Width-GetSystemMetrics(SM_CXVSCROLL);
  // end;
  // lvTaskList.Column[1].Width:=100;
  // lvTaskList.FlatScrollBars:=False;
  // lvTaskList.FlatScrollBars:=True;
end;

procedure TMainForm.actCreateTaskExecute(Sender: TObject);
var
  i: Integer;
begin
  i := lvTaskList.ItemIndex;
  with TTaskForm.Create(Self, nil { Profile.TaskList } ) do
    try
      ShowModal;
      if ModalResult = mrOk then
      begin
        i := TaskListIndex;
      end;
    finally
      Free;
    end;
  if lvTaskList.ItemIndex <> i then
  begin
    RefreshTaskList;
    lvTaskList.ItemIndex := i;
  end;
end;

procedure TMainForm.actCreateTaskUpdate(Sender: TObject);
begin
  // actCreateTask.Enabled := not FProcessActive;
end;

procedure TMainForm.actDeleteTaskUpdate(Sender: TObject);
begin
  actDeleteTask.Enabled := Assigned(lvTaskList.Selected); // and (not FProcessActive);
end;

procedure TMainForm.actEditTaskUpdate(Sender: TObject);
begin
  actEditTask.Enabled := Assigned(lvTaskList.Selected); // and (not FProcessActive);
end;

procedure TMainForm.actProcessUpdate(Sender: TObject);
begin
  actProcess.Enabled := (lvTaskList.Items.Count > 0); // and (not FProcessActive);
end;

procedure TMainForm.actProfilePropertiesExecute(Sender: TObject);
begin
  with TProfileForm.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.actProfilePropertiesUpdate(Sender: TObject);
begin
  // actProfileProperties.Enabled := not FProcessActive;
end;

procedure TMainForm.actRecentProfilesPropertiesExecute(Sender: TObject);
begin
  with TRecentsPropertiesForm.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.actClearTasksUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (lvTaskList.Items.Count > 0); // and (not FProcessActive);
end;

procedure TMainForm.RefreshTaskList;
begin
end;

end.
