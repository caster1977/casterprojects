unit Options;

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
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  Grids,
  Buttons,
  Main;

type
  TStringGridX = class(TStringGrid)
  public
    procedure MoveRow(FromIndex, ToIndex: Longint);
  end;

  TOptionsForm = class(TForm)
    TreeView2: TTreeView;
    Panel2: TPanel;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    sgAutoReplaceList: TStringGrid;
    lblAutoReplaceSorry: TLabel;
    btbtnLineUp: TBitBtn;
    btbtnLineDown: TBitBtn;
    chkbxNoLogo: TCheckBox;
    chkbxShowID: TCheckBox;
    chkbxCustomHelpFile: TCheckBox;
    edbxCustomHelpFile: TEdit;
    btnChoiseCustomHelpFile: TButton;
    ScrollBox1: TScrollBox;
    GroupBox1: TGroupBox;
    lblLoginFormPosition: TLabel;
    lblLoginFormPositionX: TLabel;
    lblLoginFormPositionY: TLabel;
    lblOptionsFormPositionY: TLabel;
    lblOptionsFormPositionX: TLabel;
    lblOptionsFormPosition: TLabel;
    lblUsersFormPosition: TLabel;
    lblUsersFormPositionX: TLabel;
    lblUsersFormPositionY: TLabel;
    lblSetPasswordFormPosition: TLabel;
    lblSetPasswordFormPositionX: TLabel;
    lblSetPasswordFormPositionY: TLabel;
    lblStatisticFormPosition: TLabel;
    lblStatisticFormPositionX: TLabel;
    lblStatisticFormPositionY: TLabel;
    lblMaintenanceFormPosition: TLabel;
    lblMaintenanceFormPositionX: TLabel;
    lblMaintenanceFormPositionY: TLabel;
    lblClearingFormPosition: TLabel;
    lblClearingFormPositionX: TLabel;
    lblClearingFormPositionY: TLabel;
    lblCreateViewPostFormPosition: TLabel;
    lblPhonesFormPosition: TLabel;
    lblAddEditPhoneFormPosition: TLabel;
    lblViewPostListFormPosition: TLabel;
    lblViewPostListFormPositionX: TLabel;
    lblViewPostListFormPositionY: TLabel;
    lblCreateViewPostFormPositionX: TLabel;
    lblCreateViewPostFormPositionY: TLabel;
    lblPhonesFormPositionX: TLabel;
    lblPhonesFormPositionY: TLabel;
    lblAddEditPhoneFormPositionX: TLabel;
    lblAddEditPhoneFormPositionY: TLabel;
    edbxLoginFormPositionX: TEdit;
    edbxLoginFormPositionY: TEdit;
    chkbxLoginFormPositionByCenter: TCheckBox;
    chkbxOptionsFormPositionByCenter: TCheckBox;
    edbxOptionsFormPositionY: TEdit;
    edbxOptionsFormPositionX: TEdit;
    edbxUsersFormPositionX: TEdit;
    edbxUsersFormPositionY: TEdit;
    chkbxUsersFormPositionByCenter: TCheckBox;
    edbxSetPasswordFormPositionX: TEdit;
    edbxSetPasswordFormPositionY: TEdit;
    chkbxSetPasswordFormPositionByCenter: TCheckBox;
    edbxStatisticFormPositionX: TEdit;
    edbxStatisticFormPositionY: TEdit;
    chkbxStatisticFormPositionByCenter: TCheckBox;
    edbxMaintenanceFormPositionX: TEdit;
    edbxMaintenanceFormPositionY: TEdit;
    chkbxMaintenanceFormPositionByCenter: TCheckBox;
    edbxClearingFormPositionX: TEdit;
    edbxClearingFormPositionY: TEdit;
    chkbxClearingFormPositionByCenter: TCheckBox;
    edbxViewPostListFormPositionX: TEdit;
    edbxViewPostListFormPositionY: TEdit;
    chkbxViewPostListFormPositionByCenter: TCheckBox;
    edbxCreateViewPostFormPositionX: TEdit;
    edbxCreateViewPostFormPositionY: TEdit;
    chkbxCreateViewPostFormPositionByCenter: TCheckBox;
    edbxPhonesFormPositionX: TEdit;
    edbxPhonesFormPositionY: TEdit;
    chkbxPhonesFormPositionByCenter: TCheckBox;
    edbxAddEditPhoneFormPositionX: TEdit;
    edbxAddEditPhoneFormPositionY: TEdit;
    chkbxAddEditPhoneFormPositionByCenter: TCheckBox;
    GroupBox3: TGroupBox;
    GroupBox2: TGroupBox;
    chkbxStoreLastLogin: TCheckBox;
    chkbxStoreLastPassword: TCheckBox;
    chkbxAutoLogon: TCheckBox;
    GroupBox4: TGroupBox;
    chkbxNoToolBar: TCheckBox;
    chkbxNoStatusBar: TCheckBox;
    chkbxStartupFullScreen: TCheckBox;
    lblMainFormWidth: TLabel;
    lblMainFormHeight: TLabel;
    edbxMainFormWidth: TEdit;
    edbxMainFormHeight: TEdit;
    lblOrgPanelHalfHeight: TLabel;
    edbxOrgPanelHeight: TEdit;
    chkbxOrgPanelHalfHeight: TCheckBox;
    lblDataPanelHalfWidth: TLabel;
    edbxDataPanelWidth: TEdit;
    chkbxDataPanelHalfWidth: TCheckBox;
    lblMainFormPosition: TLabel;
    lblMainFormPositionX: TLabel;
    lblMainFormPositionY: TLabel;
    edbxMainFormPositionX: TEdit;
    edbxMainFormPositionY: TEdit;
    chkbxMainFormPositionByCenter: TCheckBox;
    lblMainFormSize: TLabel;
    chkbxDontShowQuitConfirmation: TCheckBox;
    chkbxShowDataInOtherInfoPanel: TCheckBox;
    chkbxMarkSearchedStrings: TCheckBox;
    chkbxPutTownAtTheEnd: TCheckBox;
    chkbxHideEditBoxToolTips: TCheckBox;
    chkbxShowSearchAddressOtherEditBox: TCheckBox;
    chkbxShowMeasuresListAsRichEdit: TCheckBox;
    chkbxUseMultiBuffer: TCheckBox;
    GroupBox5: TGroupBox;
    chkbxGetMessages: TCheckBox;
    edbxGetMessagesCycleDuration: TEdit;
    lblGetMessagesCycleDuration: TLabel;
    GroupBox6: TGroupBox;
    chkbxCustomLogClientFile: TCheckBox;
    edbxCustomLogClientFile: TEdit;
    btnChoiseCustomLogClientFile: TButton;
    chkbxUseLog: TCheckBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edbxMySQLHost: TEdit;
    edbxMySQLPort: TEdit;
    edbxMySQLTimeout: TEdit;
    chkbxMySQLCompress: TCheckBox;
    edbxMySQLDatabase: TEdit;
    edbxMySQLUser: TEdit;
    edbxMySQLPassword: TEdit;
    lblAddMassMsrFormPosition: TLabel;
    lblAddMassMsrFormPositionX: TLabel;
    edbxAddMassMsrFormPositionX: TEdit;
    lblAddMassMsrFormPositionY: TLabel;
    edbxAddMassMsrFormPositionY: TEdit;
    chkbxAddMassMsrFormPositionByCenter: TCheckBox;
    TabSheet7: TTabSheet;
    GroupBox9: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edbxMessagesMySQLHost: TEdit;
    edbxMessagesMySQLPort: TEdit;
    edbxMessagesMySQLTimeout: TEdit;
    chkbxMessagesMySQLCompress: TCheckBox;
    edbxMessagesMySQLDatabase: TEdit;
    edbxMessagesMySQLUser: TEdit;
    edbxMessagesMySQLPassword: TEdit;
    procedure chkbxGetMessagesClick(Sender: TObject);
    procedure edbxGetMessagesCycleDurationChange(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
      var Handled: Boolean);
    procedure edbxOrgPanelHeightChange(Sender: TObject);
    procedure edbxDataPanelWidthChange(Sender: TObject);
    procedure chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
    procedure chkbxPhonesFormPositionByCenterClick(Sender: TObject);
    procedure chkbxCreateViewPostFormPositionByCenterClick(Sender: TObject);
    procedure chkbxViewPostListFormPositionByCenterClick(Sender: TObject);
    procedure chkbxClearingFormPositionByCenterClick(Sender: TObject);
    procedure chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
    procedure chkbxStatisticFormPositionByCenterClick(Sender: TObject);
    procedure chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
    procedure chkbxUsersFormPositionByCenterClick(Sender: TObject);
    procedure chkbxOptionsFormPositionByCenterClick(Sender: TObject);
    procedure chkbxLoginFormPositionByCenterClick(Sender: TObject);
    procedure chkbxMainFormPositionByCenterClick(Sender: TObject);
    procedure edbxMainFormWidthKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxDataPanelHalfWidthClick(Sender: TObject);
    procedure chkbxOrgPanelHalfHeightClick(Sender: TObject);
    procedure btbtnLineDownClick(Sender: TObject);
    procedure btbtnLineUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkbxStoreLastPasswordClick(Sender: TObject);
    procedure btnChoiseCustomLogClientFileClick(Sender: TObject);
    procedure chkbxCustomLogClientFileClick(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure chkbxStoreLastLoginClick(Sender: TObject);
    procedure btnChoiseCustomHelpFileClick(Sender: TObject);
    procedure chkbxStartupFullScreenClick(Sender: TObject);
    procedure chkbxCustomHelpFileClick(Sender: TObject);
    procedure TreeView2Change(Sender: TObject; Node: TTreeNode);
  private
    bNormalizeNow: Boolean;
    procedure OnMove(var Msg: TWMMove); message WM_MOVE;
  end;

var
  OptionsForm: TOptionsForm;

implementation

{$R *.dfm}

uses
  CastersPackage.uMysql,
  System.UITypes;

procedure TStringGridX.MoveRow(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

procedure TOptionsForm.btbtnLineDownClick(Sender: TObject);
begin
  if (sgAutoReplaceList.Selection.Top + 1) <= (sgAutoReplaceList.RowCount - 1) then
    TStringGridX(sgAutoReplaceList).MoveRow(sgAutoReplaceList.Selection.Top,
      sgAutoReplaceList.Selection.Top + 1);
end;

procedure TOptionsForm.btbtnLineUpClick(Sender: TObject);
begin
  if (sgAutoReplaceList.Selection.Top - 1) >= 1 then
    TStringGridX(sgAutoReplaceList).MoveRow(sgAutoReplaceList.Selection.Top,
      sgAutoReplaceList.Selection.Top - 1);
end;

procedure TOptionsForm.btnChoiseCustomHelpFileClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter := 'Файл HTML-справки (*.chm)|*.chm|Файл справки (*.hlp)|*.hlp';
      DefaultExt := 'chm';
      Title := 'Выберите файл справки к данной программе...';
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName = '' then
          MessageDlg('Не выбран файл справки!', mtError, [mbOk], 0)
        else
        begin
          if FileExists(FileName) then
            edbxCustomHelpFile.Text := FileName;
        end;
    finally
      Free;
    end;
end;

procedure TOptionsForm.btnChoiseCustomLogClientFileClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter := 'Файл модуля лог-клиента (OA4LogClient.exe)|OA4LogClient.exe|Исполняемые файлы (*.exe)|*.exe';
      DefaultExt := 'exe';
      Title := 'Выберите файл модуля лог-клиента...';
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName = '' then
          MessageDlg('Не выбран файл модуля лог-клиента!', mtError, [mbOk], 0)
        else
        begin
          if FileExists(FileName) then
            edbxCustomLogClientFile.Text := FileName;
        end;
    finally
      Free;
    end;
end;

procedure TOptionsForm.chkbxCustomHelpFileClick(Sender: TObject);
begin
  edbxCustomHelpFile.Enabled := chkbxCustomHelpFile.Checked;
  btnChoiseCustomHelpFile.Enabled := chkbxCustomHelpFile.Checked;
  if not edbxCustomHelpFile.Enabled then
    edbxCustomHelpFile.Clear;
end;

procedure TOptionsForm.chkbxCustomLogClientFileClick(Sender: TObject);
begin
  edbxCustomLogClientFile.Enabled := chkbxCustomLogClientFile.Checked;
  btnChoiseCustomLogClientFile.Enabled := chkbxCustomLogClientFile.Checked;
  if not edbxCustomLogClientFile.Enabled then
    edbxCustomLogClientFile.Clear;
end;

procedure TOptionsForm.chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
begin
  edbxAddEditPhoneFormPositionX.Enabled := not chkbxAddEditPhoneFormPositionByCenter.Checked;
  if edbxAddEditPhoneFormPositionX.Enabled then
    edbxAddEditPhoneFormPositionX.Text := IntToStr(MainForm.Configuration.fpAddEditPhoneForm.x)
  else
    edbxAddEditPhoneFormPositionX.Clear;

  edbxAddEditPhoneFormPositionY.Enabled := not chkbxAddEditPhoneFormPositionByCenter.Checked;
  if edbxAddEditPhoneFormPositionY.Enabled then
    edbxAddEditPhoneFormPositionY.Text := IntToStr(MainForm.Configuration.fpAddEditPhoneForm.y)
  else
    edbxAddEditPhoneFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxClearingFormPositionByCenterClick(Sender: TObject);
begin
  edbxClearingFormPositionX.Enabled := not chkbxClearingFormPositionByCenter.Checked;
  if edbxClearingFormPositionX.Enabled then
    edbxClearingFormPositionX.Text := IntToStr(MainForm.Configuration.fpClearingForm.x)
  else
    edbxClearingFormPositionX.Clear;

  edbxClearingFormPositionY.Enabled := not chkbxClearingFormPositionByCenter.Checked;
  if edbxClearingFormPositionY.Enabled then
    edbxClearingFormPositionY.Text := IntToStr(MainForm.Configuration.fpClearingForm.y)
  else
    edbxClearingFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxCreateViewPostFormPositionByCenterClick(Sender: TObject);
begin
  edbxCreateViewPostFormPositionX.Enabled := not chkbxCreateViewPostFormPositionByCenter.Checked;
  if edbxCreateViewPostFormPositionX.Enabled then
    edbxCreateViewPostFormPositionX.Text := IntToStr(MainForm.Configuration.fpCreateViewPostForm.x)
  else
    edbxCreateViewPostFormPositionX.Clear;

  edbxCreateViewPostFormPositionY.Enabled := not chkbxCreateViewPostFormPositionByCenter.Checked;
  if edbxCreateViewPostFormPositionY.Enabled then
    edbxCreateViewPostFormPositionY.Text := IntToStr(MainForm.Configuration.fpCreateViewPostForm.y)
  else
    edbxCreateViewPostFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxPhonesFormPositionByCenterClick(Sender: TObject);
begin
  edbxPhonesFormPositionX.Enabled := not chkbxPhonesFormPositionByCenter.Checked;
  if edbxPhonesFormPositionX.Enabled then
    edbxPhonesFormPositionX.Text := IntToStr(MainForm.Configuration.fpPhonesForm.x)
  else
    edbxPhonesFormPositionX.Clear;

  edbxPhonesFormPositionY.Enabled := not chkbxPhonesFormPositionByCenter.Checked;
  if edbxPhonesFormPositionY.Enabled then
    edbxPhonesFormPositionY.Text := IntToStr(MainForm.Configuration.fpPhonesForm.y)
  else
    edbxPhonesFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxLoginFormPositionByCenterClick(Sender: TObject);
begin
  edbxLoginFormPositionX.Enabled := not chkbxLoginFormPositionByCenter.Checked;
  if edbxLoginFormPositionX.Enabled then
    edbxLoginFormPositionX.Text := IntToStr(MainForm.Configuration.fpLoginForm.x)
  else
    edbxLoginFormPositionX.Clear;

  edbxLoginFormPositionY.Enabled := not chkbxLoginFormPositionByCenter.Checked;
  if edbxLoginFormPositionY.Enabled then
    edbxLoginFormPositionY.Text := IntToStr(MainForm.Configuration.fpLoginForm.y)
  else
    edbxLoginFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
begin
  edbxMaintenanceFormPositionX.Enabled := not chkbxMaintenanceFormPositionByCenter.Checked;
  if edbxMaintenanceFormPositionX.Enabled then
    edbxMaintenanceFormPositionX.Text := IntToStr(MainForm.Configuration.fpMaintenanceForm.x)
  else
    edbxMaintenanceFormPositionX.Clear;

  edbxMaintenanceFormPositionY.Enabled := not chkbxMaintenanceFormPositionByCenter.Checked;
  if edbxMaintenanceFormPositionY.Enabled then
    edbxMaintenanceFormPositionY.Text := IntToStr(MainForm.Configuration.fpMaintenanceForm.y)
  else
    edbxMaintenanceFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
begin
  edbxSetPasswordFormPositionX.Enabled := not chkbxSetPasswordFormPositionByCenter.Checked;
  if edbxSetPasswordFormPositionX.Enabled then
    edbxSetPasswordFormPositionX.Text := IntToStr(MainForm.Configuration.fpSetPasswordForm.x)
  else
    edbxSetPasswordFormPositionX.Clear;

  edbxSetPasswordFormPositionY.Enabled := not chkbxSetPasswordFormPositionByCenter.Checked;
  if edbxSetPasswordFormPositionY.Enabled then
    edbxSetPasswordFormPositionY.Text := IntToStr(MainForm.Configuration.fpSetPasswordForm.y)
  else
    edbxSetPasswordFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxMainFormPositionByCenterClick(Sender: TObject);
begin
  edbxMainFormPositionX.Enabled := not chkbxMainFormPositionByCenter.Checked;
  if edbxMainFormPositionX.Enabled then
    edbxMainFormPositionX.Text := IntToStr(MainForm.Configuration.fpMainForm.x)
  else
    edbxMainFormPositionX.Clear;

  edbxMainFormPositionY.Enabled := not chkbxMainFormPositionByCenter.Checked;
  if edbxMainFormPositionY.Enabled then
    edbxMainFormPositionY.Text := IntToStr(MainForm.Configuration.fpMainForm.y)
  else
    edbxMainFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxStartupFullScreenClick(Sender: TObject);
begin
  chkbxMainFormPositionByCenter.Enabled := not chkbxStartupFullScreen.Checked;
  if not chkbxMainFormPositionByCenter.Enabled then
    chkbxMainFormPositionByCenter.Checked := False;

  edbxMainFormPositionX.Enabled := not(chkbxMainFormPositionByCenter.Checked or
    chkbxStartupFullScreen.Checked);
  if edbxMainFormPositionX.Enabled then
    edbxMainFormPositionX.Text := IntToStr(MainForm.Configuration.fpMainForm.x)
  else
    edbxMainFormPositionX.Clear;

  edbxMainFormPositionY.Enabled := not(chkbxMainFormPositionByCenter.Checked or
    chkbxStartupFullScreen.Checked);
  if edbxMainFormPositionY.Enabled then
    edbxMainFormPositionY.Text := IntToStr(MainForm.Configuration.fpMainForm.y)
  else
    edbxMainFormPositionY.Clear;

  edbxMainFormWidth.Enabled := not chkbxStartupFullScreen.Checked;
  if edbxMainFormWidth.Enabled then
    edbxMainFormWidth.Text := IntToStr(MainForm.Configuration.iMainFormWidth)
  else
    edbxMainFormWidth.Clear;

  edbxMainFormHeight.Enabled := not chkbxStartupFullScreen.Checked;
  if edbxMainFormHeight.Enabled then
    edbxMainFormHeight.Text := IntToStr(MainForm.Configuration.iMainFormHeight)
  else
    edbxMainFormHeight.Clear;
end;

procedure TOptionsForm.chkbxStatisticFormPositionByCenterClick(Sender: TObject);
begin
  edbxStatisticFormPositionX.Enabled := not chkbxStatisticFormPositionByCenter.Checked;
  if edbxStatisticFormPositionX.Enabled then
    edbxStatisticFormPositionX.Text := IntToStr(MainForm.Configuration.fpStatisticForm.x)
  else
    edbxStatisticFormPositionX.Clear;

  edbxStatisticFormPositionY.Enabled := not chkbxStatisticFormPositionByCenter.Checked;
  if edbxStatisticFormPositionY.Enabled then
    edbxStatisticFormPositionY.Text := IntToStr(MainForm.Configuration.fpStatisticForm.y)
  else
    edbxStatisticFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  if not chkbxStoreLastLogin.Checked then
    chkbxStoreLastPassword.Checked := False;
  chkbxStoreLastPassword.Enabled := chkbxStoreLastLogin.Checked;
end;

procedure TOptionsForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  if not chkbxStoreLastPassword.Checked then
    chkbxAutoLogon.Checked := False;
  chkbxAutoLogon.Enabled := chkbxStoreLastPassword.Checked;
end;

procedure TOptionsForm.chkbxUsersFormPositionByCenterClick(Sender: TObject);
begin
  edbxUsersFormPositionX.Enabled := not chkbxUsersFormPositionByCenter.Checked;
  if edbxUsersFormPositionX.Enabled then
    edbxUsersFormPositionX.Text := IntToStr(MainForm.Configuration.fpUsersForm.x)
  else
    edbxUsersFormPositionX.Clear;

  edbxUsersFormPositionY.Enabled := not chkbxUsersFormPositionByCenter.Checked;
  if edbxUsersFormPositionY.Enabled then
    edbxUsersFormPositionY.Text := IntToStr(MainForm.Configuration.fpUsersForm.y)
  else
    edbxUsersFormPositionY.Clear;
end;

procedure TOptionsForm.chkbxViewPostListFormPositionByCenterClick(Sender: TObject);
begin
  edbxViewPostListFormPositionX.Enabled := not chkbxViewPostListFormPositionByCenter.Checked;
  if edbxViewPostListFormPositionX.Enabled then
    edbxViewPostListFormPositionX.Text := IntToStr(MainForm.Configuration.fpViewPostListForm.x)
  else
    edbxViewPostListFormPositionX.Clear;

  edbxViewPostListFormPositionY.Enabled := not chkbxViewPostListFormPositionByCenter.Checked;
  if edbxViewPostListFormPositionY.Enabled then
    edbxViewPostListFormPositionY.Text := IntToStr(MainForm.Configuration.fpViewPostListForm.y)
  else
    edbxViewPostListFormPositionY.Clear;
end;

procedure TOptionsForm.edbxDataPanelWidthChange(Sender: TObject);
begin
  if StrToIntDef(edbxDataPanelWidth.Text, DEFAULT_DATAPANELWIDTH) < DEFAULT_DATAPANELWIDTH then
    edbxDataPanelWidth.Text := IntToStr(DEFAULT_DATAPANELWIDTH);
end;

procedure TOptionsForm.edbxMainFormWidthKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8, '-']) then
    Key := #0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.edbxOrgPanelHeightChange(Sender: TObject);
begin
  if StrToIntDef(edbxOrgPanelHeight.Text, 100) < 100 then
    edbxOrgPanelHeight.Text := '100';
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  btnHelp.Enabled := Application.HelpFile <> '';
  ScrollBox1.VertScrollBar.Position := 0;
  lblAutoReplaceSorry.Caption := 'Извините, но список доступен только для пользователей' +
    sLineBreak + 'с правами редактирования базы данных' + sLineBreak +
    'при подлючении к базе данных!';
  bNormalizeNow := False;
end;

procedure TOptionsForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption = 'Интерфейс' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

procedure TOptionsForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption = 'Интерфейс' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

procedure TOptionsForm.TreeView2Change(Sender: TObject; Node: TTreeNode);
var
  i: Integer;
begin
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    ScrollBox1.VertScrollBar.Position := 0;
    if PageControl1.Pages[i].Caption = Node.Text then
      PageControl1.ActivePageIndex := i;
  end;
  btbtnLineUp.Visible := (PageControl1.ActivePage.Caption = 'Список автозамены') and
    sgAutoReplaceList.Visible;
  btbtnLineDown.Visible := (PageControl1.ActivePage.Caption = 'Список автозамены') and
    sgAutoReplaceList.Visible;
  btnDefaults.Visible := not(PageControl1.ActivePage.Caption = 'Список автозамены');
  if PageControl1.ActivePage.Caption = 'Сервер и база данных' then
    btnDefaults.Enabled := edbxMySQLHost.Enabled
  else
    btnDefaults.Enabled := True;
end;

procedure TOptionsForm.chkbxOptionsFormPositionByCenterClick(Sender: TObject);
begin
  edbxOptionsFormPositionX.Enabled := not chkbxOptionsFormPositionByCenter.Checked;
  if edbxOptionsFormPositionX.Enabled then
    edbxOptionsFormPositionX.Text := IntToStr(MainForm.Configuration.fpOptionsForm.x)
  else
    edbxOptionsFormPositionX.Clear;

  edbxOptionsFormPositionY.Enabled := not chkbxOptionsFormPositionByCenter.Checked;
  if edbxOptionsFormPositionY.Enabled then
    edbxOptionsFormPositionY.Text := IntToStr(MainForm.Configuration.fpOptionsForm.y)
  else
    edbxOptionsFormPositionY.Clear;

  bNormalizeNow := True;

  if chkbxOptionsFormPositionByCenter.Checked then
    Position := poScreenCenter
  else
  begin
    Position := poDesigned;
    Left := MainForm.Configuration.fpOptionsForm.x;
    edbxOptionsFormPositionX.Text := IntToStr(MainForm.Configuration.fpOptionsForm.x);
    Top := MainForm.Configuration.fpOptionsForm.y;
    edbxOptionsFormPositionY.Text := IntToStr(MainForm.Configuration.fpOptionsForm.y);
  end;

  bNormalizeNow := False;
end;

procedure TOptionsForm.OnMove(var Msg: TWMMove);
begin
  inherited;
  if not bNormalizeNow then
  begin
    MainForm.Configuration.fpOptionsForm.x := Left;
    MainForm.Configuration.fpOptionsForm.y := Top;
  end;
  // if not chkbxOptionsFormPositionByCenter.Checked then
  // begin
  // edbxOptionsFormPositionX.Text:=IntToStr(Left);
  // edbxOptionsFormPositionY.Text:=IntToStr(Top);
  // end;
end;

procedure TOptionsForm.chkbxOrgPanelHalfHeightClick(Sender: TObject);
begin
  edbxOrgPanelHeight.Enabled := not chkbxOrgPanelHalfHeight.Checked;
  if edbxOrgPanelHeight.Enabled then
    edbxOrgPanelHeight.Text := IntToStr(MainForm.Configuration.iOrgPanelHeight)
  else
    edbxOrgPanelHeight.Clear;
end;

procedure TOptionsForm.chkbxDataPanelHalfWidthClick(Sender: TObject);
begin
  edbxDataPanelWidth.Enabled := not chkbxDataPanelHalfWidth.Checked;
  if edbxDataPanelWidth.Enabled then
    edbxDataPanelWidth.Text := IntToStr(MainForm.Configuration.iDataPanelWidth)
  else
    edbxDataPanelWidth.Clear;
end;

procedure TOptionsForm.chkbxGetMessagesClick(Sender: TObject);
begin
  edbxGetMessagesCycleDuration.Enabled := chkbxGetMessages.Checked;
  // if edbxGetMessagesCycleDuration.Enabled then
  edbxGetMessagesCycleDuration.Text := IntToStr(MainForm.Configuration.iGetMessagesCycleDuration);
  // else edbxGetMessagesCycleDuration.Clear;
end;

procedure TOptionsForm.edbxGetMessagesCycleDurationChange(Sender: TObject);
begin
  if StrToIntDef(edbxGetMessagesCycleDuration.Text, 1) > 60 then
    edbxGetMessagesCycleDuration.Text := '60';
end;

procedure TOptionsForm.btnDefaultsClick(Sender: TObject);
begin
  if PageControl1.ActivePage.Caption = 'Интерфейс' then
  begin
    chkbxStartupFullScreen.Checked := False;
    edbxMainFormWidth.Text := IntToStr(DEFAULT_MAINFORMWIDTH);
    edbxMainFormHeight.Text := IntToStr(DEFAULT_MAINFORMHEIGHT);
    chkbxMainFormPositionByCenter.Checked := True;

    { TODO : заменить умолчания для высоты панели организаций }
    edbxOrgPanelHeight.Text := '256';
    chkbxOrgPanelHalfHeight.Checked := True;
    edbxDataPanelWidth.Text := IntToStr(DEFAULT_DATAPANELWIDTH);
    chkbxDataPanelHalfWidth.Checked := False;

    chkbxLoginFormPositionByCenter.Checked := True;
    chkbxOptionsFormPositionByCenter.Checked := True;
    chkbxUsersFormPositionByCenter.Checked := True;
    chkbxSetPasswordFormPositionByCenter.Checked := True;
    chkbxStatisticFormPositionByCenter.Checked := True;
    chkbxMaintenanceFormPositionByCenter.Checked := True;
    chkbxClearingFormPositionByCenter.Checked := True;
    chkbxViewPostListFormPositionByCenter.Checked := True;
    chkbxCreateViewPostFormPositionByCenter.Checked := True;
    chkbxPhonesFormPositionByCenter.Checked := True;
    chkbxAddEditPhoneFormPositionByCenter.Checked := True;

    chkbxStoreLastLogin.Checked := False;
    chkbxNoToolBar.Checked := False;
    chkbxNoStatusBar.Checked := False;
  end;

  if PageControl1.ActivePage.Caption = 'Сервер и база данных' then
  begin
    if edbxMySQLHost.Enabled then
      edbxMySQLHost.Text := 'RNE4SERVER';
    if edbxMySQLPort.Enabled then
      edbxMySQLPort.Text := IntToStr(MYSQL_PORT);
    if edbxMySQLTimeout.Enabled then
      edbxMySQLTimeout.Text := '30';
    if chkbxMySQLCompress.Enabled then
      chkbxMySQLCompress.Checked := True;
    if edbxMySQLDatabase.Enabled then
      edbxMySQLDatabase.Text := 'rne4';
    if edbxMySQLUser.Enabled then
      edbxMySQLUser.Text := 'rne4';
    if edbxMySQLPassword.Enabled then
      edbxMySQLPassword.Text := 'rne4admin';
  end;

  if PageControl1.ActivePage.Caption = 'Обмен сообщениями' then
  begin
    if edbxMessagesMySQLHost.Enabled then
      edbxMessagesMySQLHost.Text := 'RNE4SERVER';
    if edbxMessagesMySQLPort.Enabled then
      edbxMessagesMySQLPort.Text := IntToStr(MYSQL_PORT);
    if edbxMessagesMySQLTimeout.Enabled then
      edbxMessagesMySQLTimeout.Text := '30';
    if chkbxMessagesMySQLCompress.Enabled then
      chkbxMessagesMySQLCompress.Checked := True;
    if edbxMessagesMySQLDatabase.Enabled then
      edbxMessagesMySQLDatabase.Text := 'rne4messages';
    if edbxMessagesMySQLUser.Enabled then
      edbxMessagesMySQLUser.Text := 'rne4';
    if edbxMessagesMySQLPassword.Enabled then
      edbxMessagesMySQLPassword.Text := 'rne4admin';
  end;

  if PageControl1.ActivePage.Caption = 'Ведение лога' then
  begin
    chkbxUseLog.Checked := True;
    chkbxCustomLogClientFile.Checked := False;
  end;

  if PageControl1.ActivePage.Caption = 'Прочее' then
  begin
    chkbxNoLogo.Checked := False;
    chkbxShowID.Checked := False;
    chkbxCustomHelpFile.Checked := False;
    chkbxDontShowQuitConfirmation.Checked := False;
  end;
end;

end.
