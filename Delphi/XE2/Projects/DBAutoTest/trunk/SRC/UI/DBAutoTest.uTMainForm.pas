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
  System.Actions,
  DBAutoTest.uIProfile,
  DBAutoTest.uIRecents,
  Data.DB,
  Data.Win.ADODB,
  DBAutoTest.uIConfiguration,
  CastersPackage.uICustomized;

type
  TMainForm = class(TForm, ICustomized)
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
    miRecents: TMenuItem;
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
    actStatusBar: TAction;
    actToolBar: TAction;
    MainMenu: TMainMenu;
    ToolBar: TActionToolBar;
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
    OpenDialog1: TOpenDialog;
    actViewMenuGroupAction: TViewMenuGroupAction;
    N5: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    procedure actQuitExecute(Sender: TObject);
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
    procedure actCreateProfileExecute(Sender: TObject);
    procedure actClearTasksExecute(Sender: TObject);
    procedure actDeleteTaskExecute(Sender: TObject);
    procedure actEditTaskExecute(Sender: TObject);
    procedure actProcessExecute(Sender: TObject);
    procedure actLoadProfileExecute(Sender: TObject);
    procedure lvTaskListDblClick(Sender: TObject);
    procedure actStatusBarExecute(Sender: TObject);
    procedure actToolBarExecute(Sender: TObject);
    procedure actSaveProfileExecute(Sender: TObject);
    procedure actSaveProfileUpdate(Sender: TObject);
    procedure lvTaskListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
  strict private
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    procedure LoadConfiguration;
    procedure ApplyConfiguration;
    procedure SaveConfiguration;
    procedure OnHint(ASender: TObject);
    procedure ShowAboutWindow(const AShowCloseButton: Boolean);
    procedure RefreshTaskList;
    procedure RefreshRecentsMenu;
    procedure AddEditTask(const AIndex: Integer = -1);
  strict private
    procedure OnRecentsMenuItemClick(Sender: TObject);
  strict private
    FProfile: IProfile;
    function GetProfile: IProfile;
    procedure SetProfile(const AValue: IProfile);
  strict private
    FConfiguration: IConfiguration;
    function GetConfiguration: IConfiguration;
    property Configuration: IConfiguration read GetConfiguration nodefault;
  public
    property Profile: IProfile read GetProfile write SetProfile nodefault;
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  DBAutoTest.uConsts,
  DBAutoTest.uTConfigurationForm,
  DBAutoTest.uTAboutForm,
  DBAutoTest.uTTaskForm,
  DBAutoTest.uTRecentsPropertiesForm,
  DBAutoTest.uTProfileForm,
  DBAutoTest.uITask,
  DBAutoTest.uTRecents,
  DBAutoTest.uIRecent,
  DBAutoTest.uTRecent,
  DBAutoTest.uTProfile,
  DBAutoTest.uTConfiguration,
  DBAutoTest.uEConfiguration,
  System.IniFiles;

resourcestring
  RsExitConfirmationMessage = '�� ������������� ������ ��������� ������ ���������?';
  RsExitConfirmationCaption = '%s - ������������� ������';
  RsWarningCaption = '%s - ��������������';
  RsErrorCaption = '%s - ������';
  RsOpenRecent = '������� ��� �������� ����� ������� � ��������� ������';
  RsCreateProfileConfirmationMessage = '�� ������������� ������ ������� ����� �������, �������������� �� �������� �������?';
  RsCreateProfileConfirmationCaption = '%s - ������������� �������� ������ �������';
  RsOpenProfileFilters = '����� �������� (*.profile)|*.profile|��� ����� (*.*)|*.*';
  RsOpenProfileDefaultExt = 'profile';
  RsTryAgain = '%s.' + sLineBreak + '�� ������� ��������� �������?';
  RsConfigurationSaveError = '�� ������� ��������� ������ �������� ��������� � ����.';

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  ShowAboutWindow(True);
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
begin
  with TConfigurationForm.Create(Self, Configuration) do
    try
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
        ApplyConfiguration;
      end;
      Free;
    end;
end;

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actRecentProfilesExecute(Sender: TObject);
begin
  // ��������, ����������� ��� ����, ����� ����� ���� ��� ��������
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

procedure TMainForm.Finalize;
begin
  SaveConfiguration;
end;

destructor TMainForm.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TMainForm.SaveConfiguration;
begin
  Screen.Cursor := crHourGlass;
  try
    try
      Configuration.Save;
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on E: EConfiguration do
    begin
      if MessageBox(Handle, PWideChar(Format(RsTryAgain, [E.Message])), PWideChar(Format(RsWarningCaption, [APPLICATION_NAME])), MESSAGE_TYPE_CONFIRMATION_WARNING_OK) = IDOK then
      begin
        try
          Screen.Cursor := crHourGlass;
          try
            Configuration.Save;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on E: EConfiguration do
          begin
            MessageBox(Handle, PWideChar(E.Message), PWideChar(Format(RsErrorCaption, [APPLICATION_NAME])), MESSAGE_TYPE_ERROR);
          end;
          else
          begin
            Application.HandleException(Self);
          end;
        end;
      end;
    end;
    else
    begin
      Application.HandleException(Self);
    end;
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if Configuration.EnableQuitConfirmation then
  begin
    CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage), PWideChar(Format(RsExitConfirmationCaption, [APPLICATION_NAME])), MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDOK;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Initialize;
  if Configuration.EnableSplashAtStart then
  begin
    ShowAboutWindow(False);
  end;
end;

function TMainForm.GetConfiguration: IConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := GetIConfiguration;
  end;
  Result := FConfiguration;
end;

function TMainForm.GetProfile: IProfile;
begin
  if not Assigned(FProfile) then
  begin
    FProfile := GetIProfile;
  end;
  Result := FProfile;
end;

procedure TMainForm.Initialize;
// var
// r: IRecent;
// i: Integer;
begin
  Application.OnHint := OnHint;
  LoadConfiguration;

  // Configuration.Recents.Clear;
  // for i := 0 to 19 do
  // begin
  // r := GetIRecent;
  // r.FullName := IntToStr(i);
  // Configuration.Recents.Add(r);
  // end;

  ApplyConfiguration;
  RefreshRecentsMenu;
end;

procedure TMainForm.LoadConfiguration;
begin
  try
    Screen.Cursor := crHourGlass;
    try
      Configuration.Load;
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on E: Exception do
    begin
      MessageBox(Handle, PWideChar(E.Message), PWideChar(Format(RsErrorCaption, [APPLICATION_NAME])), MESSAGE_TYPE_ERROR);
    end;
  end;
end;

procedure TMainForm.SetProfile(const AValue: IProfile);
begin
  if FProfile <> AValue then
  begin
    FProfile := AValue;
    RefreshTaskList;
  end;
end;

procedure TMainForm.lvTaskListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  if Change = ctState then
  begin
    if Assigned(Item) then
    begin
      if Assigned(ITask(Item.Data)) then
      begin
        ITask(Item.Data).Enabled := Item.Checked;
      end;
    end;
  end;
end;

procedure TMainForm.lvTaskListDblClick(Sender: TObject);
begin
  actEditTask.Execute;
end;

procedure TMainForm.actCreateProfileExecute(Sender: TObject);
begin
  { TODO :
    �������� �������� ������������� �������� �������:
    ���� ������� ��� ������� � �� ��������, ������ ������ ����� }
  if MessageBox(Handle, PWideChar(RsCreateProfileConfirmationMessage), PWideChar(Format(RsCreateProfileConfirmationCaption, [APPLICATION_NAME])), MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL) = IDOK then
  begin
    Profile := GetIProfile;
    { TODO : ����� ���-�� �������� �������� ������ � ������ ����� }
    RefreshTaskList;
  end;
end;

procedure TMainForm.AddEditTask(const AIndex: Integer);
var
  i: Integer;
  t: ITask;
begin
  with TTaskForm.Create(Self, Profile.Tasks, AIndex) do
    try
      ShowModal;
      if TaskIndex > -1 then
      begin
        t := Profile.Tasks[TaskIndex];
      end;
    finally
      Free;
    end;
  RefreshTaskList;
  for i := 0 to lvTaskList.Items.Count - 1 do
  begin
    if lvTaskList.Items[i].Data = Pointer(t) then
    begin
      lvTaskList.Items[i].Selected := True;
      lvTaskList.Items[i].Focused := True;
      Break;
    end;
  end;
end;

procedure TMainForm.ApplyConfiguration;
begin
  actStatusBar.Checked := Configuration.EnableStatusbar;
  StatusBar.Visible := Configuration.EnableStatusbar;
  actToolBar.Checked := Configuration.EnableToolbar;
  ToolBar.Visible := Configuration.EnableToolbar;
end;

procedure TMainForm.actCreateTaskExecute(Sender: TObject);
begin
  AddEditTask;
end;

procedure TMainForm.actEditTaskExecute(Sender: TObject);
begin
  AddEditTask(lvTaskList.ItemIndex);
end;

procedure TMainForm.actCreateTaskUpdate(Sender: TObject);
begin
  // actCreateTask.Enabled := not FProcessActive;
end;

procedure TMainForm.actDeleteTaskExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := lvTaskList.Items.Count - 1 downto 0 do
  begin
    if lvTaskList.Items[i].Selected then
    begin
      Profile.Tasks.Remove(ITask(lvTaskList.Items[i].Data));
    end;
  end;
  RefreshTaskList;
end;

procedure TMainForm.actDeleteTaskUpdate(Sender: TObject);
var
  i: Integer;
  b: Boolean;
begin
  b := False;
  for i := 0 to lvTaskList.Items.Count - 1 do
  begin
    if lvTaskList.Items[i].Selected then
    begin
      b := True;
      Break;
    end;
  end;
  actDeleteTask.Enabled := b; // and (not FProcessActive);
end;

procedure TMainForm.actEditTaskUpdate(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  j := 0;
  for i := 0 to lvTaskList.Items.Count - 1 do
  begin
    if lvTaskList.Items[i].Selected then
    begin
      j := j + 1;
      if j > 1 then
      begin
        Break;
      end;
    end;
  end;
  actEditTask.Enabled := j = 1; // and (not FProcessActive);
end;

procedure TMainForm.actLoadProfileExecute(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      DefaultExt := RsOpenProfileDefaultExt;
      Filter := RsOpenProfileFilters;
      Options := Options + [ofFileMustExist];
      if Execute(Handle) then
      begin
        Profile.Load;
        RefreshTaskList;
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.actProcessExecute(Sender: TObject);
begin
  { TODO : ����������� ���������� ���������� ��������� ������ � ������������ ������ }
  Profile.Tasks.Run(Profile.ADOConnectionString);
end;

procedure TMainForm.actProcessUpdate(Sender: TObject);
var
  i: Integer;
  b: Boolean;
begin
  b := False;
  { TODO : ���������� �������� � �������������� Profile.Tasks }
  for i := 0 to lvTaskList.Items.Count - 1 do
  begin
    if lvTaskList.Items[i].Checked then
    begin
      b := True;
      Break;
    end;
  end;
  actProcess.Enabled := b; // and (not FProcessActive);
  btnProcess.Default := actProcess.Enabled;
end;

procedure TMainForm.actProfilePropertiesExecute(Sender: TObject);
begin
  with TProfileForm.Create(Self) do
    try
      ShowModal;
      if ModalResult = mrOk then
      begin
      end;
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
  with TRecentsPropertiesForm.Create(Self, Configuration.Recents, 20) do
    try
      ShowModal;
      if ModalResult = mrOk then
      begin
        RefreshRecentsMenu;
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.actClearTasksExecute(Sender: TObject);
begin
  Profile.Tasks.Clear;
  RefreshTaskList;
end;

procedure TMainForm.actClearTasksUpdate(Sender: TObject);
begin
  actClearTasks.Enabled := (lvTaskList.Items.Count > 0); // and (not FProcessActive);
end;

procedure TMainForm.RefreshRecentsMenu;
var
  i: Integer;
  Item: TMenuItem;
begin
  for i := miRecents.Count - 3 downto 0 do
  begin
    miRecents.Items[i].Free;
  end;
  for i := Configuration.Recents.Count - 1 downto 0 do
  begin
    Item := TMenuItem.Create(Self);
    Item.Caption := Configuration.Recents.Items[i].FullName;
    Item.Enabled := Configuration.Recents.Items[i].Exists;
    Item.OnClick := OnRecentsMenuItemClick;
    Item.Hint := RsOpenRecent;
    miRecents.Insert(0, Item);
  end;
end;

procedure TMainForm.OnRecentsMenuItemClick(Sender: TObject);
var
  mi: TMenuItem;
  r: IRecent;
begin
  if Sender is TMenuItem then
  begin
    mi := Sender as TMenuItem;
    ShowMessage(mi.Caption);
    r := Configuration.Recents[mi.MenuIndex];
    Configuration.Recents.Delete(mi.MenuIndex);
    Configuration.Recents.Insert(0, r);
    RefreshRecentsMenu;
  end;
end;

procedure TMainForm.RefreshTaskList;
  function GetGroupIDByHeader(const AValue: string): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to lvTaskList.Groups.Count - 1 do
    begin
      if lvTaskList.Groups[i].Header = Trim(AValue) then
      begin
        Result := lvTaskList.Groups[i].GroupID;
        Break;
      end;
    end;
  end;

  function AddGroup(const AHeader: string): Integer;
  var
    grp: TListGroup;
  begin
    grp := lvTaskList.Groups.Add;
    grp.Header := Trim(AHeader);
    grp.State := [lgsCollapsible];
    Result := grp.GroupID;
  end;

var
  i: Integer;
  t: ITask;
  node: TListItem;
begin
  lvTaskList.Items.BeginUpdate;
  try
    lvTaskList.Clear;
    if Assigned(Profile.Tasks) then
    begin
      for i := 0 to Profile.Tasks.Count - 1 do
      begin
        t := Profile.Tasks.Items[i];
        if Assigned(t) then
        begin
          node := lvTaskList.Items.Add;
          node.StateIndex := -1;
          node.ImageIndex := -1;
          node.Data := Pointer(t);
          node.GroupID := GetGroupIDByHeader(t.Group);
          if node.GroupID = -1 then
          begin
            node.GroupID := AddGroup(t.Group);
          end;
          node.Caption := t.name;
          node.SubItems.Add('');
          node.Checked := t.Enabled;
        end;
      end;
    end;
  finally
    lvTaskList.Items.EndUpdate;
  end;
end;

procedure TMainForm.actSaveProfileExecute(Sender: TObject);
begin
  //
end;

procedure TMainForm.actSaveProfileUpdate(Sender: TObject);
begin
  actSaveProfile.Enabled := Configuration.Modified;
end;

procedure TMainForm.actStatusBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actStatusBar.Checked;
  StatusBar.Visible := b;
  Configuration.EnableStatusbar := b;
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actToolBar.Checked;
  ToolBar.Visible := b;
  Configuration.EnableToolbar := b;
end;

end.
