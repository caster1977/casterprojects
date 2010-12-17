{$WARN UNIT_PLATFORM OFF}
unit Configuration;

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
  ImgList,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ExtCtrls,
  Grids,
  ValEdit,
  ComCtrls,
  OA5Types;

type
  TConfigurationForm=class(TForm)
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_Defaults: TAction;
    Action_Close: TAction;
    Action_Apply: TAction;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    Action_ChooseLogClient: TAction;
    ilConfigurationFormSmallImages: TImageList;
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
    Panel1: TPanel;
    gbPage: TGroupBox;
    PageControl1: TPageControl;
    ts1: TTabSheet;
    vleInterface: TValueListEditor;
    ts4: TTabSheet;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Bevel2: TBevel;
    chkbxKeepInfoLog: TCheckBox;
    chkbxKeepWarningLog: TCheckBox;
    chkbxKeepErrorLog: TCheckBox;
    chkbxKeepSQLLog: TCheckBox;
    chkbxFlushLogOnStringsQuantity: TCheckBox;
    chkbxFlushLogOnExit: TCheckBox;
    edbxFlushLogOnStringsQuantity: TEdit;
    chkbxFlushLogOnClearingLog: TCheckBox;
    chkbxFlushLogOnApply: TCheckBox;
    chkbxKeepDebugLog: TCheckBox;
    ts5: TTabSheet;
    Bevel3: TBevel;
    rbSaveIntoTheTempFolder: TRadioButton;
    rbSaveIntoTheSelectedFolder: TRadioButton;
    rbSaveIntoTheApplicationFolder: TRadioButton;
    chkbxAskForFileName: TCheckBox;
    edbxSelectedFolder: TEdit;
    btnSelectFolder: TButton;
    chkbxDontDemandOverwriteConfirmation: TCheckBox;
    ts2: TTabSheet;
    vleRNE4SERVER: TValueListEditor;
    ts3: TTabSheet;
    vleMESSAGESERVER: TValueListEditor;
    chkbxCustomLogClientFile: TCheckBox;
    edbxCustomLogClientFile: TEdit;
    btnChoiseCustomLogClientFile: TButton;
    Action_ChooseReportFolder: TAction;
    chkbxUseLog: TCheckBox;
    Bevel4: TBevel;
    Bevel5: TBevel;
    ts6: TTabSheet;
    sgAutoReplaceList: TStringGrid;
    btnLineUp: TButton;
    btnLineDown: TButton;
    Action_LineUp: TAction;
    Action_LineDown: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_DefaultsExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure Action_ChooseReportFolderExecute(Sender: TObject);
    procedure Action_ChooseLogClientExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cbPageSelect(Sender: TObject);
    procedure chkbxCustomLogClientFileClick(Sender: TObject);
    procedure rbSaveIntoTheTempFolderClick(Sender: TObject);
    procedure chkbxUseLogClick(Sender: TObject);
    procedure edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
  public
    slBoolean: TStringList;
  private
    procedure Do_Help;
    procedure Do_Defaults;
    procedure Do_Close;
    procedure Do_Apply;
    procedure Do_NextPage;
    procedure Do_PreviousPage;
    procedure Do_ChooseReportFolder;
    procedure Do_ChooseLogClient;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

{$R *.dfm}

uses
  FileCtrl,
  Main,
  OA5Routines,
  OA5Consts;

procedure TConfigurationForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
var
  s: string;
  aCopyData: TCopyDataStruct;
begin
  case aMessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
    lmtDebug:
      s:='DEBUG';
  end;
  s:=IntToStr(WMCD_MODALLOG)+';'+s+';'+aMessage+';'+aLogGroupGUID;
  with aCopyData do
    begin
      dwData:=0;
      cbData:=Length(s)+1;
      lpData:=PAnsiChar(AnsiString(s));
    end;
  SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;

procedure TConfigurationForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('������ ���������...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TConfigurationForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('��������� ���������.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TConfigurationForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('��������� ��������� ��� ������.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TConfigurationForm.Action_ApplyExecute(Sender: TObject);
const
  LogGroupGUID: string='{CA167013-A754-476D-B36F-6CE012D8C21E}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Apply.Caption+'"', LogGroupGUID);
  Do_Apply;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Apply;
const
  LogGroupGUID: string='{33DF7021-2314-4BD2-8FE5-745D3C92231F}';
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrOk', LogGroupGUID);

  ModalResult:=mrOk;
  LogThis('������� ��������� �������� ��������� ���� ������������ �������������.', LogGroupGUID, lmtInfo);
  LogThis('���� ��������� �������� ��������� �������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{E29B1B88-55F3-4F04-A4E7-99D189526C44}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Close;
const
  LogGroupGUID: string='{A114BAEA-0279-44A9-AECA-1D6D0A1C12BA}';
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('������� ��������� �������� ��������� ���� �������� �������������.', LogGroupGUID, lmtInfo);
  LogThis('���� ��������� �������� ��������� �������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{C5006F00-F43A-40AE-A060-15853FF8290F}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Help;
const
  LogGroupGUID: string='{A107CDA0-8C13-4A7D-A685-15948B680D49}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('��������� ������ ����������� �������', LogGroupGUID);

  LogThis('������������ ������� �������� ����������� ����� ���������...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines_GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_PreviousPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{DEEC08B4-451D-480B-A392-1E3127868934}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_PreviousPage.Caption+'"', LogGroupGUID);
  Do_PreviousPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_PreviousPage;
const
  LogGroupGUID: string='{5C70F626-6F88-4F8B-9F16-93DDCDA4A919}';
var
  i: integer;
begin
  ProcedureHeader('��������� ����������� ���������� �������� �������� ���������', LogGroupGUID);

  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_NextPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{8AC3593F-EC49-4348-92E9-C34C15492737}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_NextPage.Caption+'"', LogGroupGUID);
  Do_NextPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_NextPage;
const
  LogGroupGUID: string='{207F2915-B5C9-4123-A435-AEA01A519A5A}';
var
  i: integer;
begin
  ProcedureHeader('��������� ����������� ��������� �������� �������� ���������', LogGroupGUID);

  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_ChooseReportFolderExecute(Sender: TObject);
const
  LogGroupGUID: string='{07B749FB-3200-4928-97AB-6C9ECE22181C}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ChooseReportFolder.Caption+'"', LogGroupGUID);
  Do_ChooseReportFolder;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_ChooseReportFolder;
const
  LogGroupGUID: string='{10574594-BB2E-4D66-B2B0-45CFE6B0BD58}';
var
  s, sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('��������� ������ ����� ��� ���������� �������', LogGroupGUID);
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
      iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
      Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������
    end;

  s:=edbxSelectedFolder.Text;

  if SelectDirectory('�������� �����', '', s, [sdNewFolder, sdNewUI], Self) then
    if (s<>'') then
      begin
        sPath:=s;
        if (sPath[Length(sPath)]<>'\') then
          sPath:=sPath+'\';
        if SysUtils.DirectoryExists(sPath) then
          begin
            edbxSelectedFolder.Text:=sPath;
            LogThis('� �������� ����� ��� ���������� ������� ������� ����� "'+sPath+'".', LogGroupGUID, lmtDebug);
          end
        else
          begin
            edbxSelectedFolder.Text:='';
            Routines_GenerateError('�������� ������ ��� ������ ����� - ��������� ����� �� ����������!', sErrorMessage, bError);
          end;
      end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
      Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_ChooseLogClientExecute(Sender: TObject);
const
  LogGroupGUID: string='{2D27F8F7-46A5-4A52-A527-F80BCE16C56D}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ChooseReportFolder.Caption+'"', LogGroupGUID);
  Do_ChooseLogClient;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_ChooseLogClient;
const
  LogGroupGUID: string='{94AC07F5-5E72-4F4E-9525-BD309C7C807C}';
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('��������� ������ ����� ��� ���������� �������', LogGroupGUID);
  bError:=False;

  { TODO : ��������, �.�. ���� �������� � ����. }

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
      iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
      Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������
    end;

  with TOpenDialog.Create(Self) do
    try
      Filter:='���� ������ ���-�������|LogKeeper.exe|����������� �����|*.exe';
      DefaultExt:='exe';
      Title:='�������� ���� �������� ������� ����������������...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          Routines_GenerateError('�������� ������ ��� ������ ����� �������� ������� ���������������� - ���� �� ��� ������!', sErrorMessage, bError)
        else
          if not FileExists(FileName) then
            Routines_GenerateError('�������� ������ ��� ������ ����� �������� ������� ���������������� - ��������� ���� �� ����������!', sErrorMessage, bError)
          else
            begin
              edbxCustomLogClientFile.Text:=FileName;
              LogThis('� �������� ����� ��� ���������� ������� ������� ����� "'+sPath+'".', LogGroupGUID, lmtDebug);
            end;
    finally
      Free;
    end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
      Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
var
  i: integer;
begin
  // ����� � �������� ������ �������� � ����������
  for i:=0 to PageControl1.PageCount-1 do
    begin
      if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
        PageControl1.ActivePageIndex:=i;
    end;

  { TODO : ��������, �.�. ���� ��� ������� � ����. }

  // ����������� �������� ������ �������� � �������� �� ���������
  if (PageControl1.ActivePage.Caption=' ����������� � ������� ���� ������ ������')or(PageControl1.ActivePage.Caption=' ����������� � ������� ������� ������ �����������') then
    begin
      if PageControl1.ActivePage.Caption=' ����������� � ������� ���� ������ ������' then
        begin
          Action_Defaults.Enabled:=vleRNE4SERVER.Enabled;
          // Action_Defaults.Visible:=Action_Defaults.Enabled;
        end;
      if PageControl1.ActivePage.Caption=' ����������� � ������� ������� ������ �����������' then
        begin
          Action_Defaults.Enabled:=vleMESSAGESERVER.Enabled;
          // Action_Defaults.Visible:=Action_Defaults.Enabled;
        end;
    end
  else
    if PageControl1.ActivePage.Caption=' ������ ����������' then
      begin
        Action_Defaults.Enabled:=False;
        // Action_Defaults.Visible:=False;
      end
    else
      begin
        Action_Defaults.Enabled:=True;
        // Action_Defaults.Visible:=True;
      end;

  // ����������� �������� �������� � ��������� ������ � ������ �����������
  Action_LineUp.Enabled:=(PageControl1.ActivePage.Caption=' ������ ����������')and sgAutoReplaceList.Visible and sgAutoReplaceList.Enabled;
  Action_LineDown.Enabled:=Action_LineUp.Enabled;
  // Action_LineUp.Visible:=Action_LineUp.Enabled;
  // Action_LineDown.Visible:=Action_LineUp.Enabled;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{E3A04C17-B2AB-461E-A4F5-2473EC4E9297}';
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', LogGroupGUID);
  LogThis('���������� ���� ��������� �������� ���������.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_DefaultsExecute(Sender: TObject);
const
  LogGroupGUID: string='{AB46AE80-4A60-4E43-8B6F-47A2D8E1049F}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Defaults.Caption+'"', LogGroupGUID);
  Do_Defaults;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
  LogGroupGUID: string='{307097C9-68DB-47A5-A46D-1432E3A70A84}';
begin
  slBoolean.Free;
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}';
  ICON_CONFIGURATION=5;
begin
  ProcedureHeader('���������-���������� ������� �������� ����', LogGroupGUID);

  ilConfigurationFormSmallImages.GetIcon(ICON_CONFIGURATION, Icon);

  Action_Help.Enabled:=Application.HelpFile<>'';
  slBoolean:=TStringList.Create;
  with slBoolean do
    begin
      Add('���');
      Add('��');
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Defaults;
const
  LogGroupGUID: string='{EDC577E6-6D47-4DC2-973E-AD820C7AC588}';
begin
  ProcedureHeader('��������� ������ �������� � ��������� �� ���������', LogGroupGUID);

  { TODO : �������� ��������� �������� ��������� �� �������� �� ��������� }

  if PageControl1.ActivePage.Caption=' ����������' then
    begin
    end;

  if PageControl1.ActivePage.Caption=' ����������� � ������� ���� ������ ������' then
    begin
    end;

  if PageControl1.ActivePage.Caption=' ����������� � ������� ������� ������ �����������' then
    begin
    end;

  if PageControl1.ActivePage.Caption=' ������� ��������� ������' then
    begin
      chkbxUseLog.Checked:=True;
      chkbxKeepErrorLog.Checked:=True;
      chkbxKeepWarningLog.Checked:=True;
      chkbxKeepInfoLog.Checked:=True;
      chkbxKeepSQLLog.Checked:=True;
      chkbxKeepDebugLog.Checked:=False;
      chkbxFlushLogOnExit.Checked:=True;
      chkbxFlushLogOnStringsQuantity.Checked:=False;
      edbxFlushLogOnStringsQuantity.Text:='';
      chkbxFlushLogOnClearingLog.Checked:=True;
      chkbxFlushLogOnApply.Checked:=False;
      chkbxCustomLogClientFile.Checked:=False;
    end;

  if PageControl1.ActivePage.Caption=' ������������ �������' then
    begin
      rbSaveIntoTheTempFolder.Checked:=True;
      edbxSelectedFolder.Text:='';
      chkbxDontDemandOverwriteConfirmation.Checked:=False;
      chkbxAskForFileName.Checked:=False;
    end;

  LogThis('��������� '+PageControl1.ActivePage.Caption+' ���� �������� ������������� � ��������� �� ���������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.chkbxUseLogClick(Sender: TObject);
const
  LogGroupGUID: string='{014B87F4-F1A4-43D2-B1C9-86C2ED00B302}';
var
  bUseLog: boolean;
begin
  { TODO : ��������, �.�. ���� �������� � ����. }
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxUseLog.Caption, LogGroupGUID);

  bUseLog:=chkbxUseLog.Enabled and chkbxUseLog.Checked;

  chkbxKeepInfoLog.Enabled:=bUseLog;
  chkbxKeepInfoLog.Checked:=chkbxKeepInfoLog.Checked and chkbxKeepInfoLog.Enabled;

  chkbxKeepWarningLog.Enabled:=bUseLog;
  chkbxKeepWarningLog.Checked:=chkbxKeepWarningLog.Checked and chkbxKeepWarningLog.Enabled;

  chkbxKeepErrorLog.Enabled:=bUseLog;
  chkbxKeepErrorLog.Checked:=chkbxKeepErrorLog.Checked and chkbxKeepErrorLog.Enabled;

  chkbxKeepSQLLog.Enabled:=bUseLog;
  chkbxKeepSQLLog.Checked:=chkbxKeepSQLLog.Checked and chkbxKeepSQLLog.Enabled;

  chkbxKeepDebugLog.Enabled:=bUseLog;
  chkbxKeepDebugLog.Checked:=chkbxKeepDebugLog.Checked and chkbxKeepDebugLog.Enabled;

  chkbxFlushLogOnExit.Enabled:=bUseLog;
  chkbxFlushLogOnExit.Checked:=chkbxFlushLogOnExit.Checked and chkbxFlushLogOnExit.Enabled;

  chkbxFlushLogOnStringsQuantity.Enabled:=bUseLog;
  chkbxFlushLogOnStringsQuantity.Checked:=chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;

  edbxFlushLogOnStringsQuantity.Enabled:=bUseLog and chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;

  if edbxFlushLogOnStringsQuantity.Enabled then
    begin
      // if Configuration.iFlushLogOnStringsQuantity>0 then
      // edbxFlushLogOnStringsQuantity.Text:=IntToStr(Configuration.iFlushLogOnStringsQuantity)
      // else
      edbxFlushLogOnStringsQuantity.Text:='10000';
    end
  else
    edbxFlushLogOnStringsQuantity.Text:='';

  chkbxFlushLogOnClearingLog.Enabled:=bUseLog;
  chkbxFlushLogOnClearingLog.Checked:=chkbxFlushLogOnClearingLog.Checked and chkbxFlushLogOnClearingLog.Enabled;

  chkbxFlushLogOnApply.Enabled:=bUseLog;
  chkbxFlushLogOnApply.Checked:=chkbxFlushLogOnApply.Checked and chkbxFlushLogOnApply.Enabled;

  chkbxCustomLogClientFile.Enabled:=bUseLog;
  chkbxCustomLogClientFile.Checked:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFile.Enabled:=bUseLog and chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;
  if not bUseLog then
    edbxCustomLogClientFile.Text:='';

  Action_ChooseLogClient.Enabled:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  LogThis('������ "'+chkbxUseLog.Caption+'"'+Routines_GetConditionalMessage(bUseLog, '�', '��')+'������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
const
  LogGroupGUID: string='{4BB27723-6126-479F-AA75-85258CB0B383}';
var
  bFlushLogOnStringsQuantity: boolean;
begin
  { TODO : ��������, �.�. ���� �������� � ����. }
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxFlushLogOnStringsQuantity.Caption, LogGroupGUID);

  bFlushLogOnStringsQuantity:=chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;

  edbxFlushLogOnStringsQuantity.Enabled:=bFlushLogOnStringsQuantity;
  if bFlushLogOnStringsQuantity then
    begin
      // if Configuration.iFlushLogOnStringsQuantity>0 then
      // edbxFlushLogOnStringsQuantity.Text:=IntToStr(Configuration.iFlushLogOnStringsQuantity)
      // else
      edbxFlushLogOnStringsQuantity.Text:='10000';
    end
  else
    edbxFlushLogOnStringsQuantity.Text:='';

  LogThis('������ "'+chkbxFlushLogOnStringsQuantity.Caption+'"'+Routines_GetConditionalMessage(bFlushLogOnStringsQuantity, '�', '��')+'������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.chkbxCustomLogClientFileClick(Sender: TObject);
const
  LogGroupGUID: string='{59642A4A-DADE-4683-9005-79FAC3BD0291}';
var
  bCustomLogClientFile: boolean;
begin
  { TODO : ��������, �.�. ���� �������� � ����. }
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxCustomLogClientFile.Caption, LogGroupGUID);

  bCustomLogClientFile:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFile.Enabled:=bCustomLogClientFile;
  Action_ChooseLogClient.Enabled:=bCustomLogClientFile;
  if not bCustomLogClientFile then
    edbxCustomLogClientFile.Text:='';

  LogThis('������ "'+chkbxCustomLogClientFile.Caption+'"'+Routines_GetConditionalMessage(bCustomLogClientFile, '�', '��')+'������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.rbSaveIntoTheTempFolderClick(Sender: TObject);
begin
  { TODO : ��������, �.�. ���� �������� � ����. }
  edbxSelectedFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;
  Action_ChooseReportFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;
end;

procedure TConfigurationForm.edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "��������" ��� ��������� �������
end;

end.
