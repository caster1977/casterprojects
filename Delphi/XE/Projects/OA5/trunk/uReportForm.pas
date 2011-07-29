unit uReportForm;

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
  CheckLst,
  ComCtrls,
  PlatformDefaultStyleActnCtrls,
  ActnList,
  ActnMan,
  uLogProvider,
  ImgList;

type
  TReportForm=class(TForm)
    Panel1: TPanel;
    chklbxUsers: TCheckListBox;
    Label1: TLabel;
    btnSelectNone: TButton;
    btnSelectAll: TButton;
    Panel2: TPanel;
    Bevel1: TBevel;
    btnClose: TButton;
    btnHelp: TButton;
    btnCreate: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    GroupBox2: TGroupBox;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateTimePicker1: TDateTimePicker;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ilStatisticFormSmallImages: TImageList;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_SelectAll: TAction;
    Action_SelectNone: TAction;
    Action_Close: TAction;
    Action_Create: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_SelectAllExecute(Sender: TObject);
    procedure Action_SelectNoneExecute(Sender: TObject);
    procedure Action_CreateExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure ProcedureFooter;
    procedure Do_Create;
    procedure Do_Close;
    procedure Do_Help;
    procedure Do_SelectAll;
    procedure Do_SelectNone;
    procedure Do_UpdateActions;
  end;

var
  ReportForm: TReportForm;

implementation

{$R *.dfm}

uses
  uRoutines,
  uMainForm;

procedure TReportForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TReportForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('��������� ��������� ��� ������.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TReportForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TReportForm.Action_SelectAllExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_SelectAll.Caption+'"', '{14A91B39-D3D7-49C4-9F19-D253DE7AB611}');
  Do_SelectAll;
  ProcedureFooter;
end;

procedure TReportForm.Action_SelectNoneExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_SelectNone.Caption+'"', '{2E28DFC0-7D3C-4E6E-B105-CFEC8B796E11}');
  Do_SelectNone;
  ProcedureFooter;
end;

procedure TReportForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Close.Caption+'"', '{D290B7F6-9D16-47E1-90F0-FEAAB5120E56}');
  Do_Close;
  ProcedureFooter;
end;

procedure TReportForm.Action_CreateExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Create.Caption+'"', '{C4CEAC65-3699-4660-871E-12985753ECBB}');
  Do_Create;
  ProcedureFooter;
end;

procedure TReportForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', '{EA5978B9-4365-4889-B596-01C327D07D72}');
  Do_Help;
  ProcedureFooter;
end;

procedure TReportForm.Do_Create;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrOk', '{4B55786C-4198-48B1-8F00-56DBD8D6736A}');
  ModalResult:=mrOk;
  Log.SendInfo('������� ������������ ��������������� ������ �� ������ ������������� ���� ������������ �������������.');
  Log.SendInfo('���� ������������ �������������� ������� �� ������ ������������� �������.');
  ProcedureFooter;
end;

procedure TReportForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{95ED87E6-F0C7-48B0-9108-4B59EDC3B329}');

  ModalResult:=mrClose;
  Log.SendInfo('������� ������������ �������������� ������� �� ������ ������������� ���� �������� �������������.');
  Log.SendInfo('���� ������������ �������������� ������� �� ������ ������������� �������.');

  ProcedureFooter;
end;

procedure TReportForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('��������� ������ ����������� �������', '{5CAE68D5-AECE-492A-8CA8-7A802E28F93B}');
  bError:=False;

  Log.SendInfo('������������ ������� �������� ����������� ����� ���������...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TReportForm.Do_SelectAll;
var
  i: integer;
begin
  ProcedureHeader('��������� ��������� ���� ��������� ����� �������������', '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i:=0 to chklbxUsers.Count-1 do
    chklbxUsers.Checked[i]:=True;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TReportForm.Do_SelectNone;
var
  i: integer;
begin
  ProcedureHeader('��������� ������ ��������� �� ���� ��������� ����� �������������', '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i:=0 to chklbxUsers.Count-1 do
    chklbxUsers.Checked[i]:=False;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TReportForm.FormCreate(Sender: TObject);
const
  ICON_STATISTIC=0;
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{9C442450-6D58-4C07-A359-B1A1FB7F9ED0}');

  ilStatisticFormSmallImages.GetIcon(ICON_STATISTIC, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';

  ProcedureFooter;
end;

procedure TReportForm.Do_UpdateActions;
var
  i: integer;
  b: boolean;
begin
  ProcedureHeader('��������� ���������� ��������� ��������', '{C46D65CB-16C9-4200-8F05-DBA4AE839B73}');

  b:=False;
  for i:=0 to chklbxUsers.Count-1 do
    b:=b or chklbxUsers.Checked[i];
//  Action_Create.Enabled:=(RadioButton1.Checked or RadioButton2.Checked or RadioButton3.Checked)and b;
  btnClose.Default:=not Action_Create.Enabled;
  btnCreate.Default:=Action_Create.Enabled;

  ProcedureFooter;
end;

end.
