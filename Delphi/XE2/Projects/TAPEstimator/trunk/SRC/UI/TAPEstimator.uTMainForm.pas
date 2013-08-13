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
  CastersPackage.uIInitializable,
  AboutPackage.uTAboutWindow,
  Data.Bind.EngExt,
  Vcl.Bind.DBEngExt,
  System.Rtti,
  System.Bindings.Outputs,
  Vcl.Bind.Editors,
  Data.Bind.Components,
  Vcl.Touch.GestureCtrls,
  CastersPackage.Actions.Classes,
  CastersPackage.uTListViewEx,
  TAPEstimator.Profile.uTProfile,
  TAPEstimator.Configuration.uIRecents,
  TAPEstimator.Configuration.uTConfiguration,
  Vcl.Buttons,
  TAPEstimator.uTDirect3D9Gear,
  Winapi.Direct3D9,
  Vcl.AppEvnts;

type
  TMainForm = class(TForm, IInitializable)
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
    N10: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
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
    lvTAP: TListViewEx;
    AboutWindow: TAboutWindow;
    Splitter1: TSplitter;
    gpToolBar: TGridPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    pnlModel: TPanel;
    ApplicationEvents1: TApplicationEvents;
    procedure actQuitExecute(Sender: TObject);
    procedure actRecentProfilesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actRecentProfilesPropertiesExecute(Sender: TObject);
    procedure actProfilePropertiesExecute(Sender: TObject);
    procedure actCreateProfileExecute(Sender: TObject);
    procedure actLoadProfileExecute(Sender: TObject);
    procedure actStatusBarExecute(Sender: TObject);
    procedure actToolBarExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure lvTAPCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  strict private
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    procedure ApplyConfiguration;
    procedure OnHint(ASender: TObject);
    procedure RefreshRecentsMenu;
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

  strict private
    procedure CreateProfile(const AProfileName: string = '');
    procedure FreeProfile;
    procedure FreeConfiguration;
  private
    FWindowStateLoaded: Boolean;
    procedure SaveWindowState;
    procedure LoadWindowState;
  public
    destructor Destroy; override;

  strict private
    procedure LoadTAPFile(const AFileName: string);
  strict private
    FDirect3D9Gear: TDirect3D9Gear;
    procedure InitializeDirect3D;
    procedure FinalizeDirect3D;
  strict private
    procedure WMEraseBkgnd(var AMessage: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure WndProc(var AMessage: TMessage); override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Winapi.DXTypes,
  TAPEstimator.uConsts,
  TAPEstimator.Configuration.uEConfiguration,
  TAPEstimator.Configuration.uTInterfaceSection,
  TAPEstimator.Configuration.uTOtherSection,
  TAPEstimator.Configuration.uTMainFormStateSection,
  TAPEstimator.Configuration.uTRecents,
  TAPEstimator.Configuration.uIRecent,
  TAPEstimator.Configuration.uTRecent,
  TAPEstimator.uTConfigurationForm,
  TAPEstimator.uTRecentsPropertiesForm,
  TAPEstimator.uTProfileForm,
  TAPEstimator.Profile.uEProfile,
  TAPEstimator.uResourceStrings,
  TAPEstimator.uTTAPStringRoutines,
  TAPEstimator.uETAPWrongSymbol;

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
  RsOpenProfileDefaultExt = 'profile';
  RsOpenProfileFilters = 'Файлы профилей (*.profile)|*.profile|Все файлы (*.*)|*.*';
  RsOpenDefaultExt = 'tap';
  RsOpenFilters = 'Файлы TAP (*.tap)|*.tap|Все файлы (*.*)|*.*';
  RsTryAgain = '%s.' + sLineBreak + 'Вы желаете повторить попытку?';
  RsConfigurationSaveError = 'Не удалось выполнить запись настроек программы в файл.';
  RsEmptyProfileName = 'Не задано имя файла профиля.';

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutWindow.Show;
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
var
  form: TConfigurationForm;
begin
  form := TConfigurationForm.Create(Self, Configuration);
  try
    form.ShowModal;
  finally
    if form.ModalResult = mrOk then
    begin
      ApplyConfiguration;
    end;
    form.Free;
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

destructor TMainForm.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if Configuration.Section<TInterfaceSection>.EnableQuitConfirmation then
  begin
    CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage),
      PWideChar(Format(RsExitConfirmationCaption, [APPLICATION_NAME])),
      MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDOK;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

function TMainForm.GetConfiguration: TConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := TConfiguration.Create;
  end;
  Result := FConfiguration;
end;

procedure TMainForm.FreeConfiguration;
begin
  if Assigned(FConfiguration) then
  begin
    FreeAndNil(FConfiguration);
  end;
end;

procedure TMainForm.CreateProfile(const AProfileName: string);
begin
  FProfile := TProfile.Create(True, AProfileName);
end;

procedure TMainForm.FreeProfile;
begin
  if Assigned(FProfile) then
  begin
    FreeAndNil(FProfile);
  end;
end;

function TMainForm.GetProfile: TProfile;
begin
  if not Assigned(FProfile) then
  begin
    CreateProfile;
  end;
  Result := FProfile;
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
    FreeProfile;
  end;
end;

procedure TMainForm.actLoadProfileExecute(Sender: TObject);
var
  form: TOpenDialog;
begin
  form := TOpenDialog.Create(Self);
  try
    form.DefaultExt := RsOpenProfileDefaultExt;
    form.Filter := RsOpenProfileFilters;
    form.Options := form.Options + [ofFileMustExist];
    if form.Execute(Handle) then
    begin
      FreeProfile;
      CreateProfile(form.FileName);
      // Profile.Load;
    end;
  finally
    form.Free;
  end;
end;

procedure TMainForm.actProfilePropertiesExecute(Sender: TObject);
var
  form: TProfileForm;
begin
  form := TProfileForm.Create(Self);
  try
    form.ShowModal;
    if form.ModalResult = mrOk then
    begin
    end;
  finally
    form.Free;
  end;
end;

procedure TMainForm.actRecentProfilesPropertiesExecute(Sender: TObject);
var
  form: TRecentsPropertiesForm;
begin
  form := TRecentsPropertiesForm.Create(Self, Configuration.Recents, 20);
  try
    form.ShowModal;
    if form.ModalResult = mrOk then
    begin
      RefreshRecentsMenu;
    end;
  finally
    form.Free;
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

procedure TMainForm.actStatusBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actStatusBar.Checked;
  StatusBar.Visible := b;
  Configuration.Section<TInterfaceSection>.EnableStatusbar := b;
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actToolBar.Checked;
  ToolBar.Visible := b;
  Configuration.Section<TInterfaceSection>.EnableToolbar := b;
end;

procedure TMainForm.lvTAPCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvTAP.Canvas.Font.color := clBlack;
  if TTAPStringRoutines.IsComment(Item.Caption) then
  begin
    lvTAP.Canvas.Font.color := clGreen;
  end;
end;

procedure TMainForm.InitializeDirect3D;
begin
  FDirect3D9Gear := TDirect3D9Gear.Create(pnlModel.Handle, pnlModel.ClientWidth,
    pnlModel.ClientHeight, False);
end;

procedure TMainForm.WMEraseBkgnd(var AMessage: TWMEraseBkgnd);
begin
  if (WindowFromDC(AMessage.DC)) = (pnlModel.Handle) then
  begin
    AMessage.Result := 1;
  end
  else
  begin
    inherited;
  end;
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
var
  form: TOpenDialog;
begin
  form := TOpenDialog.Create(Self);
  try
    form.DefaultExt := RsOpenDefaultExt;
    form.Filter := RsOpenFilters;
    form.Options := form.Options + [ofFileMustExist];
    if form.Execute(Handle) then
    begin
      LoadTAPFile(form.FileName);
    end;
  finally
    form.Free;
  end;
end;

procedure TMainForm.LoadTAPFile(const AFileName: string);
var
  sl: TStringList;
  i: Integer;
  s: string;
  cWrongSymbol: Char;
  li: TListItem;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(AFileName);
    for i := 0 to sl.Count - 1 do
    begin
      try
        s := TTAPStringRoutines.Normalize(sl[i]);
        if TTAPStringRoutines.Valid(s, cWrongSymbol) then
        begin
          sl[i] := s;
        end
        else
        begin
          raise ETAPWrongSymbol.Create('Некорректный символ [%s] в строке.', cWrongSymbol);
        end;
      except
        on E: Exception do
        begin
          ShowMessage(E.Message);
        end;
      end;
    end;
    lvTAP.Clear;
    for i := 0 to sl.Count - 1 do
    begin
      li := lvTAP.Items.Add;
      li.Caption := sl[i];
    end;
  finally
    FreeAndNil(sl);
  end;
end;

procedure TMainForm.Initialize;
// var
// r: IRecent;
// i: Integer;
begin
  FWindowStateLoaded := False;
  Application.OnHint := OnHint;
  if Configuration.Section<TInterfaceSection>.EnableSplashAtStart then
  begin
    AboutWindow.Show(True);
  end;

  // Configuration.Recents.Clear;
  // for i := 0 to 19 do
  // begin
  // r := GetIRecent;
  // r.FullName := IntToStr(i);
  // Configuration.Recents.Add(r);
  // end;

  ApplyConfiguration;
  LoadWindowState;

  RefreshRecentsMenu;
  InitializeDirect3D;
end;

procedure TMainForm.Finalize;
begin
  FinalizeDirect3D;
  FreeProfile;
  SaveWindowState;
  FreeConfiguration;
end;

procedure TMainForm.FinalizeDirect3D;
begin
  FreeAndNil(FDirect3D9Gear);
end;

procedure TMainForm.FormPaint(Sender: TObject);
type
  TCustomVertex = packed record
    x, y, z, rwh: Single;
    color: DWORD;
  end;
var
  vertex_buf: IDirect3DVertexBuffer9; // буфер вернин
  Pixel: array [0 .. 11] of TCustomVertex;
  pPixel: Pointer;
  d3dviewport: td3dviewport9;
begin
  // inherited;
  // получаем параметры окна вывода
  FDirect3D9Gear.Direct3DDevice9.GetViewport(d3dviewport);
  // связываем буфер вершин с потоком данных устройства
  FDirect3D9Gear.Direct3DDevice9.CreateVertexBuffer(SizeOf(Pixel), 0,
    D3DFVF_XYZRHW or D3DFVF_DIFFUSE, D3DPOOL_DEFAULT, vertex_buf, nil);
  // установка параметров вершин
  ZeroMemory(@Pixel, SizeOf(Pixel));

  Pixel[0].x := 10;
  Pixel[0].y := 10;
  Pixel[0].rwh := 1;
  Pixel[0].color := $00C0C0C0; // $AARRGGBB

  Pixel[1].x := 10;
  Pixel[1].y := d3dviewport.Height - 10;
  Pixel[1].rwh := 1;
  Pixel[1].color := $00C0C0C0; // $AARRGGBB

  Pixel[2].x := 10;
  Pixel[2].y := d3dviewport.Height - 10;
  Pixel[2].rwh := 1;
  Pixel[2].color := $00C0C0C0; // $AARRGGBB

  Pixel[3].x := d3dviewport.Width - 10;
  Pixel[3].y := d3dviewport.Height - 10;
  Pixel[3].rwh := 1;
  Pixel[3].color := $00C0C0C0; // $AARRGGBB

  Pixel[4].x := 10;
  Pixel[4].y := 10;
  Pixel[4].rwh := 1;
  Pixel[4].color := $00C0C0C0; // $AARRGGBB

  Pixel[5].x := 15;
  Pixel[5].y := 15;
  Pixel[5].rwh := 1;
  Pixel[5].color := $00C0C0C0; // $AARRGGBB

  Pixel[6].x := 10;
  Pixel[6].y := 10;
  Pixel[6].rwh := 1;
  Pixel[6].color := $00C0C0C0; // $AARRGGBB

  Pixel[7].x := 5;
  Pixel[7].y := 15;
  Pixel[7].rwh := 1;
  Pixel[7].color := $00C0C0C0; // $AARRGGBB

  Pixel[8].x := d3dviewport.Width - 10;
  Pixel[8].y := d3dviewport.Height - 10;
  Pixel[8].rwh := 1;
  Pixel[8].color := $00C0C0C0; // $AARRGGBB

  Pixel[9].x := d3dviewport.Width - 15;
  Pixel[9].y := d3dviewport.Height - 15;
  Pixel[9].rwh := 1;
  Pixel[9].color := $00C0C0C0; // $AARRGGBB

  Pixel[10].x := d3dviewport.Width - 10;
  Pixel[10].y := d3dviewport.Height - 10;
  Pixel[10].rwh := 1;
  Pixel[10].color := $00C0C0C0; // $AARRGGBB

  Pixel[11].x := d3dviewport.Width - 15;
  Pixel[11].y := d3dviewport.Height - 5;
  Pixel[11].rwh := 1;
  Pixel[11].color := $00C0C0C0; // $AARRGGBB
  // блокировка доступа к буферу вершин
  vertex_buf.Lock(0, SizeOf(Pixel), pPixel, 0);
  // копируем в буфер данные
  CopyMemory(pPixel, @Pixel, SizeOf(Pixel));
  // разблокировка буфера
  vertex_buf.Unlock;
  // очищаем обслассть для рисования
  FDirect3D9Gear.Direct3DDevice9.Clear(0, nil, D3DCLEAR_TARGET, D3DCOLOR_XRGB(255, 255, 255), 1, 0);
  // начало сцены
  FDirect3D9Gear.Direct3DDevice9.BeginScene;
  // связываем буфер вершин с потоком данных устройства
  FDirect3D9Gear.Direct3DDevice9.SetStreamSource(0, vertex_buf, 0, SizeOf(TCustomVertex));
  // устанавливаем формат вершин
  FDirect3D9Gear.Direct3DDevice9.SetFVF(D3DFVF_XYZRHW or D3DFVF_DIFFUSE);
  // рисуем примитив
  FDirect3D9Gear.Direct3DDevice9.DrawPrimitive(D3DPT_LINELIST, 0, 6);
  // завершаем сцену
  FDirect3D9Gear.Direct3DDevice9.EndScene;
  // переключение буферов}
  FDirect3D9Gear.Direct3DDevice9.Present(nil, nil, 0, nil);
end;

procedure TMainForm.ApplyConfiguration;
begin
  actStatusBar.Checked := Configuration.Section<TInterfaceSection>.EnableStatusbar;
  StatusBar.Visible := Configuration.Section<TInterfaceSection>.EnableStatusbar;
  actToolBar.Checked := Configuration.Section<TInterfaceSection>.EnableToolbar;
  ToolBar.Visible := Configuration.Section<TInterfaceSection>.EnableToolbar;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if Assigned(FDirect3D9Gear) then
  begin
    FDirect3D9Gear.CreateDirect3DDevice9(pnlModel.Handle, pnlModel.ClientWidth,
      pnlModel.ClientHeight, False);
  end;
end;

procedure TMainForm.LoadWindowState;
begin
  // установка позиции и размеров главного окна в соответсвии с параметрами конфигурации
  WindowState := wsNormal;
  if (Configuration.Section<TMainFormStateSection>.State = CONFIGURATION_DEFAULT_MAINFORM_STATE) and
    (Configuration.Section<TMainFormStateSection>.Left = CONFIGURATION_DEFAULT_MAINFORM_LEFT) and
    (Configuration.Section<TMainFormStateSection>.Top = CONFIGURATION_DEFAULT_MAINFORM_TOP) and
    (Configuration.Section<TMainFormStateSection>.Width = CONFIGURATION_DEFAULT_MAINFORM_WIDTH) and
    (Configuration.Section<TMainFormStateSection>.Height = CONFIGURATION_DEFAULT_MAINFORM_HEIGHT)
  then
  begin
    Position := poScreenCenter;
{$REGION}
    // Configuration.Section<TMainFormStateSection>.Left := Left;
    // Configuration.Section<TMainFormStateSection>.Top := Top;
    // Configuration.Section<TMainFormStateSection>.Width := Width;
    // Configuration.Section<TMainFormStateSection>.Height := Height;
{$ENDREGION}
  end
  else
  begin
    Position := poDesigned;
    Left := Configuration.Section<TMainFormStateSection>.Left;
    Top := Configuration.Section<TMainFormStateSection>.Top;
    Width := Configuration.Section<TMainFormStateSection>.Width;
    Height := Configuration.Section<TMainFormStateSection>.Height;
  end;
  WindowState := TWindowState(Configuration.Section<TMainFormStateSection>.State);
  FWindowStateLoaded := True;
end;

procedure TMainForm.SaveWindowState;
begin
  if WindowState = wsNormal then
  begin
    Configuration.Section<TMainFormStateSection>.Left := Left;
    Configuration.Section<TMainFormStateSection>.Top := Top;
    Configuration.Section<TMainFormStateSection>.Width := Width;
    Configuration.Section<TMainFormStateSection>.Height := Height;
  end;
  Configuration.Section<TMainFormStateSection>.State := Integer(WindowState);
end;

procedure TMainForm.WndProc(var AMessage: TMessage);
begin
  if FWindowStateLoaded then
  begin
    if AMessage.Msg = WM_WINDOWPOSCHANGED then
    begin
      SaveWindowState;
    end;
  end;
  inherited;
end;

end.
