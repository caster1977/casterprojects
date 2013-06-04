unit TAPEstimator.uTMainForm;

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
  TAPEstimator.uIProfile,
  TAPEstimator.uIRecents,
  Data.DB,
  Data.Win.ADODB,
  TAPEstimator.uIConfiguration,
  CastersPackage.uICustomized, CastersPackage.uTAboutWindow, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components;

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
    actOpen: TAction;
    N12: TMenuItem;
    N13: TMenuItem;
    AboutWindow: TAboutWindow;
    meTap: TMemo;
    procedure actQuitExecute(Sender: TObject);
    procedure actRecentProfilesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure actProcessUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actRecentProfilesPropertiesExecute(Sender: TObject);
    procedure actProfilePropertiesUpdate(Sender: TObject);
    procedure actProfilePropertiesExecute(Sender: TObject);
    procedure actCreateProfileExecute(Sender: TObject);
    procedure actProcessExecute(Sender: TObject);
    procedure actLoadProfileExecute(Sender: TObject);
    procedure actStatusBarExecute(Sender: TObject);
    procedure actToolBarExecute(Sender: TObject);
    procedure actSaveProfileExecute(Sender: TObject);
    procedure actSaveProfileUpdate(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
  strict private
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    procedure LoadConfiguration;
    procedure ApplyConfiguration;
    procedure SaveConfiguration;
    procedure OnHint(ASender: TObject);
    procedure RefreshRecentsMenu;
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
  strict private
    FThreadMessage: Cardinal;
    function RegisterThreadMessage: Boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  TAPEstimator.uConsts,
  TAPEstimator.uTConfigurationForm,
  TAPEstimator.uTRecentsPropertiesForm,
  TAPEstimator.uTProfileForm,
  TAPEstimator.uTRecents,
  TAPEstimator.uIRecent,
  TAPEstimator.uTRecent,
  TAPEstimator.uTProfile,
  TAPEstimator.uTConfiguration,
  TAPEstimator.uEConfiguration,
  TAPEstimator.uResourceStrings,
  System.IniFiles;

resourcestring
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';
  RsWarningCaption = '%s - Предупреждение';
  RsCannotRegisterThreadMessage = 'Не удалось зарегистрировать оконное сообщение для дочерних потоков.';
  RsOpenRecent = 'Нажмите для загрузки файла профиля с указанным именем';
  RsCreateProfileConfirmationMessage = 'Вы действительно хотите создать новый профиль, предварительно не сохранив текущий?';
  RsCreateProfileConfirmationCaption = '%s - Подтверждение создания нового профиля';
  RsOpenProfileDefaultExt = 'profile';
  RsOpenProfileFilters = 'Файлы профилей (*.profile)|*.profile|Все файлы (*.*)|*.*';
  RsOpenDefaultExt = 'tap';
  RsOpenFilters = 'Файлы TAP (*.tap)|*.tap|Все файлы (*.*)|*.*';
  RsTryAgain = '%s.' + sLineBreak + 'Вы желаете повторить попытку?';
  RsConfigurationSaveError = 'Не удалось выполнить запись настроек программы в файл.';

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutWindow.Show;
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
  // заглушка, необзодимая для того, чтобы пункт меню был активным
end;

procedure TMainForm.OnHint(ASender: TObject);
begin
  StatusBar.SimpleText := GetLongHint(Application.Hint);
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
  if not RegisterThreadMessage then
  begin
    MessageBox(Handle, PWideChar(RsCannotRegisterThreadMessage), PWideChar(Format(RsErrorCaption, [APPLICATION_NAME])), MESSAGE_TYPE_ERROR);
    Application.Terminate;
  end;
  LoadConfiguration;
  if Configuration.EnableSplashAtStart then
  begin
    AboutWindow.Show;
  end;

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
  end;
end;

procedure TMainForm.actCreateProfileExecute(Sender: TObject);
begin
  { TODO :
    добавить проверку сохранённости текущего профиля:
    если профиль был изменён и не сохранён, задать вопрос юзеру }
  if MessageBox(Handle, PWideChar(RsCreateProfileConfirmationMessage), PWideChar(Format(RsCreateProfileConfirmationCaption, [APPLICATION_NAME])), MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL) = IDOK then
  begin
    Profile := GetIProfile;
    { TODO : нужно как-то изменить алгоритм работы с именем файла }
  end;
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      DefaultExt := RsOpenDefaultExt;
      Filter := RsOpenFilters;
      Options := Options + [ofFileMustExist];
      if Execute(Handle) then
      begin
        //TAPFile.Load;
        meTap.Lines.LoadFromFile(FileName);
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.ApplyConfiguration;
begin
  actStatusBar.Checked := Configuration.EnableStatusbar;
  StatusBar.Visible := Configuration.EnableStatusbar;
  actToolBar.Checked := Configuration.EnableToolbar;
  ToolBar.Visible := Configuration.EnableToolbar;
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
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.actProcessExecute(Sender: TObject);
begin
  { TODO : реализовать функционал выполнения выбранных тестов в параллельных тредах }
  //Profile.Tasks.Run(Profile.ADOConnectionString);
end;

procedure TMainForm.actProcessUpdate(Sender: TObject);
var
//  i: Integer;
  b: Boolean;
begin
  b := False;
  { TODO : переписать алгоритм с использованием Profile.Tasks }
  {for i := 0 to lvTaskList.Items.Count - 1 do
  begin
    if lvTaskList.Items[i].Checked then
    begin
      b := True;
      Break;
    end;
  end;}
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
