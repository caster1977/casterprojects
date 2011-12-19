unit uConfigurationForm;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ImgList, Vcl.ComCtrls;

type
  TConfigurationForm=class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    ilConfigurationFormSmallImages: TImageList;
    ActionManager1: TActionManager;
    Action_Defaults: TAction;
    Action_Apply: TAction;
    Action_Close: TAction;
    Action_Help: TAction;
    Panel3: TPanel;
    gbHeader: TGroupBox;
    cbPage: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    Panel1: TPanel;
    gbPage: TGroupBox;
    PageControl1: TPageControl;
    ts1: TTabSheet;
    ts3: TTabSheet;
    ts4: TTabSheet;
    ts5: TTabSheet;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    ts2: TTabSheet;
    chkbxShowAboutWindowAtLaunch: TCheckBox;
    chkbxShowStatusbar: TCheckBox;
    chkbxShowConfirmationAtQuit: TCheckBox;
    CheckBox1: TCheckBox;
    lbOrganizationPanelHeight: TLabel;
    edbxOrganizationPanelHeightValue: TEdit;
    Edit1: TEdit;
    Label1: TLabel;
    edbxDestinationFolderValue: TEdit;
    btnDestinationFolder: TButton;
    lblDestinationFolder: TLabel;
    chkbxPlaySoundOnComplete: TCheckBox;
    chkbxKeepInfoLog: TCheckBox;
    chkbxKeepWarningLog: TCheckBox;
    chkbxKeepErrorLog: TCheckBox;
    chkbxKeepDebugLog: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    lblMainFormPositionX: TLabel;
    edbxMainFormPositionX: TEdit;
    lblMainFormPositionY: TLabel;
    edbxMainFormPositionY: TEdit;
    chkbxMainFormPositionByCenter: TCheckBox;
    lblMainFormWidth: TLabel;
    lblMainFormHeight: TLabel;
    edbxMainFormWidth: TEdit;
    edbxMainFormHeight: TEdit;
    chkbxFullScreenAtLaunch: TCheckBox;
    lblConfigurationFormPositionX: TLabel;
    edbxConfigurationFormPositionX: TEdit;
    lblConfigurationFormPositionY: TLabel;
    edbxConfigurationFormPositionY: TEdit;
    chkbxConfigurationFormPositionByCenter: TCheckBox;
    Action_ChooseDestinationFolder: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure Action_DefaultsExecute(Sender: TObject);
    procedure cbPageSelect(Sender: TObject);
    procedure Action_ChooseDestinationFolderExecute(Sender: TObject);
  strict private
    procedure Do_PageSelect;
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_Defaults;
    procedure Do_Apply;
    procedure Do_NextPage;
    procedure Do_PreviousPage;
    procedure Do_ChooseDestinationFolder;
  end;

implementation

{$R *.dfm}

uses
  uMainForm,
  uCommon,
  Vcl.FileCtrl;

procedure TConfigurationForm.Action_ApplyExecute(Sender: TObject);
begin
  Do_Apply;
end;

procedure TConfigurationForm.Action_ChooseDestinationFolderExecute(Sender: TObject);
begin
  Do_ChooseDestinationFolder;
end;

procedure TConfigurationForm.Action_CloseExecute(Sender: TObject);
begin
  Do_Close;
end;

procedure TConfigurationForm.Action_DefaultsExecute(Sender: TObject);
begin
  Do_Defaults;
end;

procedure TConfigurationForm.Action_HelpExecute(Sender: TObject);
begin
  Do_Help;
end;

procedure TConfigurationForm.Action_NextPageExecute(Sender: TObject);
begin
  Do_NextPage;
end;

procedure TConfigurationForm.Action_PreviousPageExecute(Sender: TObject);
begin
  Do_PreviousPage;
end;

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
begin
  Do_PageSelect;
end;

procedure TConfigurationForm.Do_Apply;
begin
  ModalResult:=mrOk;
  MainForm.LogInfo('������� ��������� �������� ��������� ���� ������������ �������������.');

  with MainForm.Configuration do
    begin

    end;

  MainForm.LogInfo('���� ��������� �������� ��������� �������.');
end;

procedure TConfigurationForm.Do_ChooseDestinationFolder;
var
  s, sPath: string;
  sErrorMessage: string;
  bError: boolean;
begin
  bError:=False;

  s:=edbxDestinationFolderValue.Text;

  if SelectDirectory('�������� �����', '', s, [sdNewFolder, sdNewUI], Self) then
    if (s<>'') then
      begin
        sPath:=IncludeTrailingPathDelimiter(sPath);
        if System.SysUtils.DirectoryExists(sPath) then
          begin
            edbxDestinationFolderValue.Text:=sPath;
            MainForm.LogDebug('� �������� ����� ��� ���������� ������� ������� ����� "'+sPath+'".');
          end
        else
          begin
            edbxDestinationFolderValue.Text:='';
            CommonFunctions.GenerateError('�������� ������ ��� ������ ����� - ��������� ����� �� ����������!', sErrorMessage, bError);
          end;
      end;

  MainForm.ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TConfigurationForm.Do_Close;
begin
  ModalResult:=mrClose;
  MainForm.LogInfo('������� ��������� �������� ��������� ���� �������� �������������.');
  MainForm.LogInfo('���� ��������� �������� ��������� �������.');
end;

procedure TConfigurationForm.Do_Defaults;
begin
  // ������� "��������� ����������"
  if PageControl1.ActivePage.Caption=' ����������' then
    begin

    end;
  // ������� "��������� ������� ��������� ������"
  if PageControl1.ActivePage.Caption=' ������� ��������� ������' then
    begin

    end;
  MainForm.LogInfo('��������� '+PageControl1.ActivePage.Caption+' ���� �������� ������������� � �������� �� ���������.');
end;

procedure TConfigurationForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  MainForm.LogInfo('������������ ������� �������� ����������� ����� ���������...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    CommonFunctions.GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  MainForm.ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TConfigurationForm.Do_NextPage;
var
  i: integer;
begin
  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  Do_PageSelect;
end;

procedure TConfigurationForm.Do_PageSelect;
var
  i: integer;
begin
  // ����� � �������� ������ �������� � ����������
  for i:=0 to PageControl1.PageCount-1 do
    if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
      PageControl1.ActivePageIndex:=i;
end;

procedure TConfigurationForm.Do_PreviousPage;
var
  i: integer;
begin
  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  Do_PageSelect;
end;

procedure TConfigurationForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  MainForm.Configuration.ConfigurationFormPage:=cbPage.ItemIndex;
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION=3;
begin
  ilConfigurationFormSmallImages.GetIcon(ICON_CONFIGURATION, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  MainForm.LogDebug('�������� "'+Action_Help.Caption+'" '+CommonFunctions.GetConditionalString(Action_Help.Enabled, '�', '��')+'�������.');

  with MainForm.Configuration do
    begin
      // ��������� ��������� ���� ������������ � ����������� �� ���������� ������������ ���������
      if ConfigurationFormPosition.Centered then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if ConfigurationFormPosition.Left<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if ConfigurationFormPosition.Left>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=ConfigurationFormPosition.Left;
          if ConfigurationFormPosition.Top<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if ConfigurationFormPosition.Top>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=ConfigurationFormPosition.Top;
        end;
    end;
  cbPage.ItemIndex:=MainForm.Configuration.ConfigurationFormPage;
  Do_PageSelect;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  MainForm.LogInfo('���������� ���� �������� ���������.');
end;

end.
