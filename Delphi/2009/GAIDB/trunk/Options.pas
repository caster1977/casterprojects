unit Options;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, ExtCtrls, StdCtrls, Grids, Buttons;

type
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
		TabSheet6: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edbxMySQLHost: TEdit;
    Label2: TLabel;
    edbxMySQLPort: TEdit;
    Label3: TLabel;
    edbxMySQLTimeout: TEdit;
    chkbxMySQLCompress: TCheckBox;
    GroupBox3: TGroupBox;
    sgAutoReplaceList: TStringGrid;
    edbxMySQLDatabase: TEdit;
    edbxMySQLPassword: TEdit;
    edbxMySQLUser: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    chkbxStoreLastLogin: TCheckBox;
    chkbxStoreLastPassword: TCheckBox;
    chkbxStartMainRect: TCheckBox;
    chkbxStartupFullScreen: TCheckBox;
    chkbxSaveSize: TCheckBox;
    Label9: TLabel;
    edbxMainFormWidth: TEdit;
    Label10: TLabel;
    edbxMainFormHeight: TEdit;
    lblAutoReplaceSorry: TLabel;
    btbtnLineUp: TBitBtn;
    btbtnLineDown: TBitBtn;
    GroupBox4: TGroupBox;
    chkbxCustomLogClientFile: TCheckBox;
    edbxCustomLogClientFile: TEdit;
    btnChoiseCustomLogClientFile: TButton;
    GroupBox5: TGroupBox;
    chkbxNoLogo: TCheckBox;
    chkbxShowID: TCheckBox;
    chkbxCustomHelpFile: TCheckBox;
    edbxCustomHelpFile: TEdit;
    btnChoiseCustomHelpFile: TButton;
    chkbxAutoLogon: TCheckBox;
    chkbxNoToolBar: TCheckBox;
    chkbxNoStatusBar: TCheckBox;
    chkbxShowFullSearchBar: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure chkbxStoreLastPasswordClick(Sender: TObject);
    procedure btnChoiseCustomLogClientFileClick(Sender: TObject);
    procedure chkbxCustomLogClientFileClick(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure chkbxStoreLastLoginClick(Sender: TObject);
    procedure btnChoiseCustomHelpFileClick(Sender: TObject);
    procedure chkbxSaveSizeClick(Sender: TObject);
    procedure chkbxStartupFullScreenClick(Sender: TObject);
    procedure chkbxStartMainRectClick(Sender: TObject);
    procedure chkbxCustomHelpFileClick(Sender: TObject);
		procedure TreeView2Change(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionsForm: TOptionsForm;

implementation

{$R *.dfm}

uses mysql;

procedure TOptionsForm.btnChoiseCustomHelpFileClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter:='Файл HTML-справки (*.chm)|*.chm|Файл справки (*.hlp)|*.hlp';
      DefaultExt:='chm';
      Title:='Выберите файл справки к данной программе...';
      FilterIndex:=1;
      Options:=[ofReadOnly,ofFileMustExist];
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

procedure TOptionsForm.btnChoiseCustomLogClientFileClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter:='Файл модуля лог-клиента (GAIDBLogClient.exe)|GAIDBLogClient.exe|Исполняемые файлы (*.exe)|*.exe';
      DefaultExt:='exe';
      Title:='Выберите файл модуля лог-клиента...';
      FilterIndex:=1;
      Options:=[ofReadOnly,ofFileMustExist];
      if Execute then
        if FileName='' then
          MessageDlg('Не выбран файл модуля лог-клиента!', mtError, [mbOk], 0)
        else
          begin
            if FileExists(FileName) then
              edbxCustomLogClientFile.Text:=FileName;
          end;
    finally
      Free;
    end;
end;

procedure TOptionsForm.btnDefaultsClick(Sender: TObject);
begin
  if PageControl1.ActivePage.Caption='Интерфейс' then
    begin
      chkbxStoreLastLogin.Checked:=False;
      chkbxNoToolBar.Checked:=False;
      chkbxNoStatusBar.Checked:=False;
      chkbxShowFullSearchBar.Checked:=False;
      chkbxStartMainRect.Checked:=False;
      edbxMainFormWidth.Text:='1024';
      edbxMainFormHeight.Text:='768';
      chkbxSaveSize.Checked:=False;
      chkbxStartupFullScreen.Checked:=False;
    end;
  if PageControl1.ActivePage.Caption='Сервер и база данных' then
    begin
      if edbxMySQLHost.Enabled then
        edbxMySQLHost.Text:='localhost';
      if edbxMySQLPort.Enabled then
        edbxMySQLPort.Text:=IntToStr(MYSQL_PORT);
      if edbxMySQLTimeout.Enabled then
        edbxMySQLTimeout.Text:='30';
      if chkbxMySQLCompress.Enabled then
        chkbxMySQLCompress.Checked:=True;
      if edbxMySQLDatabase.Enabled then
        edbxMySQLDatabase.Text:='gai';
      if edbxMySQLUser.Enabled then
        edbxMySQLUser.Text:='gai';
      if edbxMySQLPassword.Enabled then
        edbxMySQLPassword.Text:='sqladmin';
    end;
  if PageControl1.ActivePage.Caption='Лог-клиент' then
    begin
      chkbxCustomLogClientFile.Checked:=False;
    end;
  if PageControl1.ActivePage.Caption='Лог-сервер' then
    begin
      //
    end;
  if PageControl1.ActivePage.Caption='Прочее' then
    begin
      chkbxNoLogo.Checked:=False;
      chkbxShowID.Checked:=False;
      chkbxCustomHelpFile.Checked:=False;
    end;
end;

procedure TOptionsForm.chkbxCustomHelpFileClick(Sender: TObject);
begin
  edbxCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
  btnChoiseCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
  if not edbxCustomHelpFile.Enabled then
    edbxCustomHelpFile.Clear;
end;

procedure TOptionsForm.chkbxCustomLogClientFileClick(Sender: TObject);
begin
  edbxCustomLogClientFile.Enabled:=chkbxCustomLogClientFile.Checked;
  btnChoiseCustomLogClientFile.Enabled:=chkbxCustomLogClientFile.Checked;
  if not edbxCustomLogClientFile.Enabled then
    edbxCustomLogClientFile.Clear;
end;

procedure TOptionsForm.chkbxSaveSizeClick(Sender: TObject);
begin
  if chkbxSaveSize.Checked then
    begin
      chkbxStartupFullScreen.Checked:=False;
      chkbxStartMainRect.Checked:=False;
    end;
  chkbxStartupFullScreen.Enabled:=not chkbxSaveSize.Checked;
  chkbxStartMainRect.Enabled:=not chkbxSaveSize.Checked;
end;

procedure TOptionsForm.chkbxStartMainRectClick(Sender: TObject);
begin
  edbxMainFormWidth.Enabled:=chkbxStartMainRect.Checked;
  edbxMainFormHeight.Enabled:=chkbxStartMainRect.Checked;
  if chkbxStartMainRect.Checked then
    begin
      chkbxStartupFullScreen.Checked:=False;
      chkbxSaveSize.Checked:=False;
    end;
  chkbxStartupFullScreen.Enabled:=not chkbxStartMainRect.Checked;
  chkbxSaveSize.Enabled:=not chkbxStartMainRect.Checked;
end;

procedure TOptionsForm.chkbxStartupFullScreenClick(Sender: TObject);
begin
  if chkbxStartupFullScreen.Checked then
    begin
      chkbxStartMainRect.Checked:=False;
      chkbxSaveSize.Checked:=False;
    end;
  chkbxStartMainRect.Enabled:=not chkbxStartupFullScreen.Checked;
  chkbxSaveSize.Enabled:=not chkbxStartupFullScreen.Checked;
end;

procedure TOptionsForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  if not chkbxStoreLastLogin.Checked then
    chkbxStoreLastPassword.Checked:=False;
  chkbxStoreLastPassword.Enabled:=chkbxStoreLastLogin.Checked;
end;

procedure TOptionsForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  if not chkbxStoreLastPassword.Checked then
    chkbxAutoLogon.Checked:=False;
  chkbxAutoLogon.Enabled:=chkbxStoreLastPassword.Checked;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  lblAutoReplaceSorry.Caption:='Извините, но список доступен только для пользователей'+#10#13+
  'с правами редактирования базы данных'+#10#13+'при подлючении к базе данных!';
end;

procedure TOptionsForm.TreeView2Change(Sender: TObject; Node: TTreeNode);
var
  i: integer;
begin
  for i:=0 to PageControl1.PageCount-1 do
    begin
      if PageControl1.Pages[i].Caption=Node.Text then
        PageControl1.ActivePageIndex:=i;
    end;
  btbtnLineUp.Visible:=(PageControl1.ActivePage.Caption='Список автозамены') and sgAutoReplaceList.Visible;
  btbtnLineDown.Visible:=(PageControl1.ActivePage.Caption='Список автозамены') and sgAutoReplaceList.Visible;
  btnDefaults.Visible:=not (PageControl1.ActivePage.Caption='Список автозамены');
  if PageControl1.ActivePage.Caption='Сервер и база данных' then
    btnDefaults.Enabled:=edbxMySQLHost.Enabled
  else btnDefaults.Enabled:=True;
end;

end.
