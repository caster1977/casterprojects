unit DBAutoTest.uTMainForm;

interface

uses
  DBAutoTest.uITask,
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
  Data.DB,
  Data.Win.ADODB,
  CastersPackage.uICustomized,
  DBAutoTest.uTProfile,
  DBAutoTest.uTConfiguration,
  AboutPackage.uTAboutWindow, CastersPackage.uTApplicationOnHint;

type
  TMainForm = class(TForm, ICustomized)
    StatusBar: TStatusBar;
    ilActions: TImageList;
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
    actViewMenuGroupAction: TViewMenuGroupAction;
    N5: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    actMoveDown: TAction;
    actMoveUp: TAction;
    AboutWindow: TAboutWindow;
    ilStatuses: TImageList;
    aplctnhnt1: TApplicationOnHint;
    procedure actQuitExecute(Sender: TObject);
    procedure actRecentProfilesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
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
    procedure actMoveUpUpdate(Sender: TObject);
    procedure actMoveDownUpdate(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure actMoveDownExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
  strict private
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    // procedure LoadConfiguration;
    procedure ApplyConfiguration;
    // procedure SaveConfiguration;
    procedure RefreshRecentsMenu;
    procedure AddEditTask(const AIndex: Integer = -1);
    procedure RefreshTaskList;
    procedure RefreshTaskStatus(const ATask: ITask);
    procedure UpdateTaskListAvailability;
  strict private
    procedure OnRecentsMenuItemClick(Sender: TObject);
  strict private
    FProfile: TProfile;
    function GetProfile: TProfile;
    property Profile: TProfile read GetProfile nodefault;
  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;
  public
    destructor Destroy; override;
  strict private
    FThreadMessage: Cardinal;
    function RegisterThreadMessage: Boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  CastersPackage.uIIniFileDataStorage,
  CastersPackage.uIModified,
  DBAutoTest.uConsts,
  DBAutoTest.uTConfigurationForm,
  DBAutoTest.uTTaskForm,
  DBAutoTest.uTTaskStatus,
  DBAutoTest.uTRecentsPropertiesForm,
  DBAutoTest.uTProfileForm,
  DBAutoTest.uTRecents,
  DBAutoTest.uIRecent,
  DBAutoTest.uTRecent,
  DBAutoTest.uEConfiguration,
  DBAutoTest.uResourceStrings,
  DBAutoTest.Configuration.uTInterface,
  DBAutoTest.Configuration.uTConnection,
  DBAutoTest.Configuration.uTReports,
  DBAutoTest.Configuration.uTOther,
  System.IniFiles;

resourcestring
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';
  RsWarningCaption = '%s - Предупреждение';
  RsCannotRegisterThreadMessage =
    'Не удалось зарегистрировать оконное сообщение для дочерних потоков.';
  RsOpenRecent = 'Нажмите для загрузки файла профиля с указанным именем';
  RsCreateProfileConfirmationMessage =
    'Вы действительно хотите создать новый профиль, предварительно не сохранив текущий?';
  RsCreateProfileConfirmationCaption = '%s - Подтверждение создания нового профиля';
  RsOpenProfileFilters = 'Файлы профилей (*.profile)|*.profile|Все файлы (*.*)|*.*';
  RsOpenProfileDefaultExt = 'profile';
  RsTryAgain = '%s.' + sLineBreak + 'Вы желаете повторить попытку?';
  RsConfigurationSaveError = 'Не удалось выполнить запись настроек программы в файл.';

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
  // заглушка, необходимая для того, чтобы пункт меню был активным
end;

procedure TMainForm.WndProc(var Message: TMessage);
var
  t: ITask;
begin
  inherited;
  if message.Msg = FThreadMessage then
  begin
    t := ITask(message.WParam);
    if Assigned(t) then
    begin
      RefreshTaskStatus(t);
    end;
  end;
end;

procedure TMainForm.Finalize;
begin
  // SaveConfiguration;
  { if Assigned(Recents) then
    begin
    FreeAndNil(Recents);
    end; }
  if Assigned(Profile) then
  begin
    Profile.Free;
  end;
  if Assigned(Configuration) then
  begin
    Configuration.Free;
  end;
end;

destructor TMainForm.Destroy;
begin
  Finalize;
  inherited;
end;

{ procedure TMainForm.SaveConfiguration;
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
  end; }

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if Configuration.Section<TInterface>.EnableQuitConfirmation then
  begin
    CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage),
      PWideChar(Format(RsExitConfirmationCaption, [APPLICATION_NAME])),
      MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDOK;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Initialize;
  if Configuration.Section<TInterface>.EnableSplashAtStart then
  begin
    AboutWindow.Show(True);
    // ShowAboutWindow(False);
  end;
end;

function TMainForm.GetConfiguration: TConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := TConfiguration.Create;
  end;
  Result := FConfiguration;
end;

function TMainForm.GetProfile: TProfile;
begin
  if not Assigned(FProfile) then
  begin
    FProfile := TProfile.Create(True, ChangeFileExt(ExpandFileName(ParamStr(0)), '.profile'));
  end;
  Result := FProfile;
end;

{ function TMainForm.GetRecents: IRecents;
  begin
  if not Assigned(FRecents) then
  begin
  FRecents := GetIRecents;
  end;
  Result := FRecents;
  end; }

procedure TMainForm.Initialize;
// var
// r: IRecent;
// i: Integer;
begin
  if not RegisterThreadMessage then
  begin
    MessageBox(Handle, PWideChar(RsCannotRegisterThreadMessage),
      PWideChar(Format(RsErrorCaption, [APPLICATION_NAME])), MESSAGE_TYPE_ERROR);
    Application.Terminate;
  end;
  // LoadConfiguration;

  // Configuration.Recents.Clear;
  // for i := 0 to 19 do
  // begin
  // r := GetIRecent;
  // r.FullName := IntToStr(i);
  // Configuration.Recents.Add(r);
  // end;

  ApplyConfiguration;
  RefreshRecentsMenu;
  RefreshTaskList;
end;

{ procedure TMainForm.LoadConfiguration;
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
  end; }

procedure TMainForm.lvTaskListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  if Change = ctState then
  begin
    if Assigned(Item) then
    begin
      if Assigned(ITask(Item.Data)) then
      begin
        ITask(Item.Data).Enabled := Item.Checked;
        if not ITask(Item.Data).Enabled then
        begin
          ITask(Item.Data).Status := tsUnknown;
          RefreshTaskStatus(ITask(Item.Data));
        end;
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
    добавить проверку сохранённости текущего профиля:
    если профиль был изменён и не сохранён, задать вопрос юзеру }
  if MessageBox(Handle, PWideChar(RsCreateProfileConfirmationMessage),
    PWideChar(Format(RsCreateProfileConfirmationCaption, [APPLICATION_NAME])),
    MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL) = IDOK then
  begin
    if Assigned(Profile) then
    begin
      Profile.Free;
    end;
    { TODO : нужно как-то изменить алгоритм работы с именем файла }
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
  actStatusBar.Checked := Configuration.Section<TInterface>.EnableStatusbar;
  StatusBar.Visible := Configuration.Section<TInterface>.EnableStatusbar;
  actToolBar.Checked := Configuration.Section<TInterface>.EnableToolbar;
  ToolBar.Visible := Configuration.Section<TInterface>.EnableToolbar;
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
        if Assigned(Profile) then
        begin
          Profile.Free;
        end;
        FProfile := TProfile.Create(True, FileName);
        RefreshTaskList;
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.actMoveDownExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lvTaskList.Items.Count - 1 do
  begin
    if lvTaskList.Items[i].Selected then
    begin
      if Assigned(ITask(lvTaskList.Items[i].Data)) then
      begin
        if i < lvTaskList.Items.Count - 1 then
        begin
          Profile.Tasks.Exchange(Profile.Tasks.IndexOf(ITask(lvTaskList.Items[i].Data)),
            Profile.Tasks.IndexOf(ITask(lvTaskList.Items[i + 1].Data)));
        end;
      end;
    end;
  end;
  RefreshTaskList;
end;

procedure TMainForm.actMoveDownUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if lvTaskList.SelCount = 1 then
  begin
    if Assigned(lvTaskList.Selected) then
    begin
      b := lvTaskList.Selected.Index < lvTaskList.Items.Count - 1;
    end;
  end;
  actMoveDown.Enabled := b; // and (not FProcessActive);
end;

procedure TMainForm.actMoveUpExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := lvTaskList.Items.Count - 1 downto 0 do
  begin
    if lvTaskList.Items[i].Selected then
    begin
      if Assigned(ITask(lvTaskList.Items[i].Data)) then
      begin
        if i > 0 then
        begin
          Profile.Tasks.Exchange(Profile.Tasks.IndexOf(ITask(lvTaskList.Items[i].Data)),
            Profile.Tasks.IndexOf(ITask(lvTaskList.Items[i - 1].Data)));
        end;
      end;
    end;
  end;
  RefreshTaskList;
end;

procedure TMainForm.actMoveUpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if lvTaskList.SelCount = 1 then
  begin
    if Assigned(lvTaskList.Selected) then
    begin
      b := lvTaskList.Selected.Index > 0;
    end;
  end;
  actMoveUp.Enabled := b; // and (not FProcessActive);
end;

procedure TMainForm.actProfilePropertiesExecute(Sender: TObject);
var
  form: TProfileForm;
begin
  form := TProfileForm.Create(Self, Profile);
  try
    form.ShowModal;
    { if form.ModalResult = mrOk then
      begin
      ApplyProfile;
      end; }
  finally
    form.Free;
  end;
end;

procedure TMainForm.actProfilePropertiesUpdate(Sender: TObject);
begin
  // actProfileProperties.Enabled := not FProcessActive;
end;

procedure TMainForm.actRecentProfilesPropertiesExecute(Sender: TObject);
begin
  with TRecentsPropertiesForm.Create(Self, Configuration.Recents,
    Configuration.Section<TOther>.RecentsQuantity) do
    try
      ShowModal;
      if ModalResult = mrOk then
      begin
        Configuration.Section<TOther>.RecentsQuantity := Size;
        RefreshRecentsMenu;
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutWindow.Show;
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
          // node.ImageIndex := -1;
          node.Data := Pointer(t);
          node.GroupID := GetGroupIDByHeader(t.Group);
          if node.GroupID = -1 then
          begin
            node.GroupID := AddGroup(t.Group);
          end;
          node.Caption := t.name;
          node.SubItems.Add(TASK_STATUS_NAMES[t.Status]);
          if t.Status = tsUnknown then
          begin
            node.ImageIndex := -1;
          end
          else
          begin
            node.ImageIndex := Integer(t.Status);
          end;
          if t.Status in [tsError, tsComplete] then
          begin
            node.SubItems.Add(TimeToStr(t.Time));
          end
          else
          begin
            node.SubItems.Add(EmptyStr);
          end;
          node.Checked := t.Enabled;
        end;
      end;
    end;
  finally
    lvTaskList.Items.EndUpdate;
    UpdateTaskListAvailability;
  end;
end;

function TMainForm.RegisterThreadMessage: Boolean;
begin
  FThreadMessage := RegisterWindowMessage(PWideChar(WM_TASK_THREAD_MESSAGE));
  Result := FThreadMessage > 0;
end;

procedure TMainForm.actSaveProfileExecute(Sender: TObject);
begin
  //
end;

procedure TMainForm.actSaveProfileUpdate(Sender: TObject);
begin
  // actSaveProfile.Enabled := (Configuration as IModified).Modified;
end;

procedure TMainForm.actStatusBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actStatusBar.Checked;
  StatusBar.Visible := b;
  Configuration.Section<TInterface>.EnableStatusbar := b;
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actToolBar.Checked;
  ToolBar.Visible := b;
  Configuration.Section<TInterface>.EnableToolbar := b;
end;

procedure TMainForm.RefreshTaskStatus(const ATask: ITask);
var
  i: Integer;
  s: string;
begin
  if Assigned(ATask) then
  begin
    for i := 0 to lvTaskList.Items.Count - 1 do
    begin
      if lvTaskList.Items[i].Data = Pointer(ATask) then
      begin
        if lvTaskList.Items[i].SubItems.Count > 0 then
        begin
          if ATask.Status = tsUnknown then
          begin
            lvTaskList.Items[i].ImageIndex := -1;
          end
          else
          begin
            lvTaskList.Items[i].ImageIndex := Integer(ATask.Status);
          end;
          lvTaskList.Items[i].SubItems[0] := TASK_STATUS_NAMES[ATask.Status];
          s := EmptyStr;
          if ATask.Status in [tsError, tsComplete] then
          begin
            s := TimeToStr(ATask.Time);
          end;
          lvTaskList.Items[i].SubItems[1] := s;
          Break;
        end;
      end;
    end;
    UpdateTaskListAvailability;
  end;
end;

procedure TMainForm.actProcessExecute(Sender: TObject);
begin
  { TODO : реализовать функционал выполнения выбранных тестов в параллельных тредах }
  Profile.Tasks.Run(Profile.ADOConnectionString, Configuration.ADOConnectionString,
    Configuration.Section<TConnection>.Server, Configuration.Section<TConnection>.Database);
  RefreshTaskList;
end;

procedure TMainForm.actProcessUpdate(Sender: TObject);
var
  i: Integer;
  b: Boolean;
begin
  b := False;
  { TODO : переписать алгоритм с использованием Profile.Tasks }
  if Assigned(Profile) then
  begin
    if Assigned(Profile.Tasks) then
    begin
      b := True;
      for i := 0 to Profile.Tasks.Count - 1 do
      begin
        if Profile.Tasks[i].Status = tsExecuting then
        begin
          b := False;
          Break;
        end;
      end;
      if b then
      begin
        b := False;
        for i := 0 to Profile.Tasks.Count - 1 do
        begin
          if Profile.Tasks[i].Enabled then
          begin
            b := True;
            Break;
          end;
        end;
      end;
    end;
  end;
  actProcess.Enabled := b; // and (not FProcessActive);
  btnProcess.Default := actProcess.Enabled;
end;

procedure TMainForm.UpdateTaskListAvailability;
var
  i: Integer;
  b: Boolean;
begin
  b := True;
  for i := 0 to lvTaskList.Items.Count - 1 do
  begin
    if ITask(lvTaskList.Items[i].Data).Status = tsExecuting then
    begin
      b := False;
      Break;
    end;
  end;
  lvTaskList.Enabled := b;
end;

end.
