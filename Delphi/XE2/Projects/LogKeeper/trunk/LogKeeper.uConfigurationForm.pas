unit LogKeeper.uConfigurationForm;

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
  StdCtrls,
  ExtCtrls,
  LogKeeper.uMainForm,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ComCtrls;

type
  TConfigurationForm=class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    Panel3: TPanel;
    gbHeader: TGroupBox;
    cbPage: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    ActionManager1: TActionManager;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    Panel1: TPanel;
    gbPage: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    lblOrgPanelHalfHeight: TLabel;
    edbxMainFormHeight: TEdit;
    chkbxFullScreen: TCheckBox;
    lblMySQLHost: TLabel;
    lblMySQLPort: TLabel;
    lblMySQLTimeout: TLabel;
    lblMySQLPassword: TLabel;
    lblMySQLUser: TLabel;
    lblMySQLDatabase: TLabel;
    edbxMySQLHost: TEdit;
    edbxMySQLPort: TEdit;
    edbxMySQLTimeout: TEdit;
    chkbxMySQLCompress: TCheckBox;
    edbxMySQLDatabase: TEdit;
    edbxMySQLUser: TEdit;
    edbxMySQLPassword: TEdit;
    chkbxCustomHelpFile: TCheckBox;
    edbxCustomHelpFile: TEdit;
    btnChoiseCustomHelpFile: TButton;
    Label1: TLabel;
    cbMainFormAlignment: TComboBox;
    chkbxKeepInfoLog: TCheckBox;
    chkbxKeepWarningLog: TCheckBox;
    chkbxKeepErrorLog: TCheckBox;
    chkbxKeepSQLLog: TCheckBox;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Bevel2: TBevel;
    chkbxFlushLogOnExit: TCheckBox;
    chkbxFlushLogOnStringsQuantity: TCheckBox;
    edbxFlushLogOnStringsQuantity: TEdit;
    chkbxFlushLogOnClearingLog: TCheckBox;
    chkbxFlushLogOnApply: TCheckBox;
    chkbxAlwaysShowTrayIcon: TCheckBox;
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure cbPageSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edbxMainFormHeightKeyPress(Sender: TObject; var Key: Char);
    procedure btnDefaultsClick(Sender: TObject);
    procedure chkbxCustomHelpFileClick(Sender: TObject);
    procedure btnChoiseCustomHelpFileClick(Sender: TObject);
    procedure chkbxFullScreenClick(Sender: TObject);
    procedure edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

{$R *.dfm}

uses
  LogKeeper.uMysql;

procedure TConfigurationForm.Action_NextPageExecute(Sender: TObject);
var
  i: integer;
begin
  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  cbPageSelect(Sender);
end;

procedure TConfigurationForm.Action_PreviousPageExecute(Sender: TObject);
var
  i: integer;
begin
  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  cbPageSelect(Sender);
end;

procedure TConfigurationForm.btnChoiseCustomHelpFileClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter:='Файл HTML-справки (*.chm)|*.chm|Файл справки (*.hlp)|*.hlp';
      DefaultExt:='chm';
      Title:='Выберите файл справки к данной программе...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          MessageDlg('Не выбран файл справки!', mtError, [mbOk], 0)
        else
          begin
            if FileExists(FileName) then
              edbxCustomHelpFile.Text:=FileName;
          end;
    finally
      Free;
    end;
end;

procedure TConfigurationForm.btnDefaultsClick(Sender: TObject);
begin
  if PageControl1.ActivePage.Caption=' интерфейса' then
    begin
      chkbxAlwaysShowTrayIcon.Checked:=False;
      chkbxCustomHelpFile.Checked:=False;
      chkbxFullScreen.Checked:=False;
      edbxMainFormHeight.Text:='200';
      cbMainFormAlignment.ItemIndex:=1;
    end;
  if PageControl1.ActivePage.Caption=' параметров подключения к базе данных MySQL' then
    begin
      if edbxMySQLHost.Enabled then
        edbxMySQLHost.Text:='LOGKEEPERSERVER';
      if edbxMySQLPort.Enabled then
        edbxMySQLPort.Text:=IntToStr(MYSQL_PORT);
      if edbxMySQLTimeout.Enabled then
        edbxMySQLTimeout.Text:='30';
      if chkbxMySQLCompress.Enabled then
        chkbxMySQLCompress.Checked:=True;
      if edbxMySQLDatabase.Enabled then
        edbxMySQLDatabase.Text:='LogKeeper';
      if edbxMySQLUser.Enabled then
        edbxMySQLUser.Text:='LogKeeper';
      if edbxMySQLPassword.Enabled then
        edbxMySQLPassword.Text:='LogKeeperAdmin';
    end;
  if PageControl1.ActivePage.Caption=' ведения протокола работы' then
    begin
      chkbxKeepErrorLog.Checked:=True;
      chkbxKeepWarningLog.Checked:=True;
      chkbxKeepInfoLog.Checked:=True;
      chkbxKeepSQLLog.Checked:=False;
      chkbxFlushLogOnExit.Checked:=True;
      chkbxFlushLogOnStringsQuantity.Checked:=False;
      edbxFlushLogOnStringsQuantity.Text:='';
      chkbxFlushLogOnClearingLog.Checked:=True;
      chkbxFlushLogOnApply.Checked:=False;
    end;
end;

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to PageControl1.PageCount-1 do
    begin
      if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
        PageControl1.ActivePageIndex:=i;
    end;
  if PageControl1.ActivePage.Caption=' параметров подключения к базе данных MySQL' then
    btnDefaults.Enabled:=edbxMySQLHost.Enabled
  else
    btnDefaults.Enabled:=True;
end;

procedure TConfigurationForm.chkbxCustomHelpFileClick(Sender: TObject);
begin
  edbxCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
  btnChoiseCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
  if not edbxCustomHelpFile.Enabled then
    edbxCustomHelpFile.Clear;
end;

procedure TConfigurationForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
begin
  edbxFlushLogOnStringsQuantity.Enabled:=chkbxFlushLogOnStringsQuantity.Checked;
  if edbxFlushLogOnStringsQuantity.Enabled then
    begin
      if MainForm.Configuration.iFlushLogOnStringsQuantity>0 then
        edbxFlushLogOnStringsQuantity.Text:=IntToStr(MainForm.Configuration.iFlushLogOnStringsQuantity)
      else
        edbxFlushLogOnStringsQuantity.Text:='10000';
    end
  else
    edbxFlushLogOnStringsQuantity.Text:='';
end;

procedure TConfigurationForm.chkbxFullScreenClick(Sender: TObject);
begin
  edbxMainFormHeight.Enabled:=not chkbxFullScreen.Checked;
  if edbxMainFormHeight.Enabled then
    edbxMainFormHeight.Text:=IntToStr(MainForm.Configuration.iMainFormHeight)
  else
    edbxMainFormHeight.Text:='';
end;

procedure TConfigurationForm.edbxMainFormHeightKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TConfigurationForm.edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
begin
  btnHelp.Enabled:=Application.HelpFile<>'';
  cbPage.ItemIndex:=0;
  cbPageSelect(Sender);
end;

end.
