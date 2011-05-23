unit uConfigurationClass;

interface

uses
  uMySQLConnectionClass,
  LogKeeperData,
  Types,
  uSingleton;

type
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);

  TConfiguration=class(TSingleton)
  type
    TFormPosition=record
      bCenter: boolean;
      x, y: integer;
    end;
  strict private
    FFileName: string;
    FConfigurationFormPage: integer;
    FLastLogin: string;
    FLastPassword: string;

    // ������� "��������� ����������"
    FShowAboutWindowAtLaunch: boolean; // ���������� ���� "� ���������..." ��� �������
    FShowToolbarAtLaunch: boolean; // ���������� ������ ������ ��� ������� ���������
    FShowStatusbarAtLaunch: boolean; // ���������� ������ ������� ��� ������� ���������
    FShowEditboxHints: boolean; // ���������� ����������� ��������� ��� ����� �����
    FShowCommonSearchEditbox: boolean; // ���������� ������ ���� ����� ��� ������ ������
    FShowID: boolean; // ���������� ���� ID ������� ���� ������ ��� ������ ���������
    FUseMultibuffer: boolean; // ������������ ����������� ��� �������� ����������� �����������
    FShowConfirmationAtQuit: boolean; // ��������� ������������� ��� ������ �� ���������

    // ������� "��������� ������� ��������� ������"
    FEnableLog: boolean; // ����� ��� ������ ���������
    FKeepLogTypes: TLogMessagesTypes; // �������� ��������� ������������� �����
    FFlushLogOnExit: boolean; // ���������� �������� ������ � ��������� ���� ��� ���������� ������ ���������
    FFlushLogOnStringsQuantity: boolean; // ���������� �������� ������ � ��������� ���� ��� ���������� ���������� �����
    FFlushLogOnStringsQuantityValue: integer; // ���������� �������� ������ � ��������� ���� ��� ���������� ���������� ����� (��������������� ����������)
    FFlushLogOnClearingLog: boolean; // ���������� �������� ������ � ��������� ���� ��� �������� ������� ���������
    FFlushLogOnApply: boolean; // ���������� �������� ������ � ��������� ���� ��� ������� ������ "���������"
    FCustomLogClientFile: boolean; // ������������ ������� ������ ����������������
    FCustomLogClientFileValue: string; // ��� ����� �������� ������� ����������������

    // ������� "��������� ��������� ���������� ����"
    FLoginFormPosition: TFormPosition;
    FOptionsFormPosition: TFormPosition;
    FUsersFormPosition: TFormPosition;
    FSetPasswordFormPosition: TFormPosition;
    FStatisticFormPosition: TFormPosition;
    FMaintenanceFormPosition: TFormPosition;
    FClearingFormPosition: TFormPosition;
    FViewPostListFormPosition: TFormPosition;
    FCreateViewPostFormPosition: TFormPosition;
    FPhonesFormPosition: TFormPosition;
    FAddEditPhoneFormPosition: TFormPosition;
    FAddMassMsrFormPosition: TFormPosition;

    // ������� "��������� ��������� �����������"
    FStoreLastLogin: boolean; // ��������� ����� ���������� ������������
    FStoreLastPassword: boolean; // ��������� ������ ���������� ������������
    FAutoLogon: boolean; // ��������� �������������� ����, ��������� ���������� ����� � ������ ������������

    // ������� "��������� ����������� � ������� ���� ������ ������"
    FRNE4Server: TMySQLConnection;

    // ������� "��������� ����������� � ������� ������� ������ �����������"
    FMessagesServer: TMySQLConnection;

    // ������� "��������� ������������ �������"
    FReportFolder: TReportFolders; //
    FSelectedReportFolder: string; //
    FDontDemandOverwriteConfirmation: boolean; //
    FAskForFileName: boolean; //

    // ������� "��������� ������ ����������"

    // ������� "��������� ������"
    FLaunchAtStartup: boolean;
    FPlaySoundOnComplete: boolean;
    FEnableAutoGetMessages: boolean;
    FAutoGetMessagesCycleDuration: integer;
    FEnableCustomHelpFile: boolean;
    FCustomHelpFile: string;

    // ������� "��������� �������� ����"
    FMainFormRect: TRect;
    FMainFormPositionByCenter: boolean;
    FFullScreenAtLaunch: boolean;

    // ������� "��������� ����������� ����������"
    FOrganizationPanelHeight: integer; // ������ ������ �����������
    FOrganizationPanelHalfHeight: boolean; // �������� ������ ����
    FDataPanelWidth: integer; // ������ ������ ������
    FDataPanelHalfWidth: boolean; // �������� ������ ����
    FShowDataInOtherInfoPanel: boolean; // � ������ ��������� ���������� ������ � ���� ������ ����������
    FShowMeasuresListAsRichEdit: boolean; // � ������ ��������� ���������� ���������� � ����� ���c��
    FMarkSearchedStrings: boolean; // � ������ ��������� �������� ������� ��������� �����
    FPutTownAtTheEnd: boolean; // ��������� �������� ������ � ����� ������ ������

    procedure SetUseLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    function GetTempFolder: string;
    function GetApplicationFolder: string;
    function GetReportFolderValue: string;
    procedure SetFileName(const Value: string);
  public
    // sDefaultAction: string;
    // sApplicationFolder: string;
    // sTempFolder: string;
    // sCustomFolder: string;
    // trfReportFolder: TReportFolders;
    // bImmediatelyQuit: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;
    // bFullScreen: boolean;
    constructor Create; override;
    procedure Load;
    procedure Save;
    destructor Destroy; override;

    property FileName: string read FFileName write SetFileName stored False;
    property ConfigurationFormPage: integer read FConfigurationFormPage write FConfigurationFormPage default 0; // ����� ��������� �������� �������� ���� ������������ ���������
    property LastLogin: string read FLastLogin;
    property LastPassword: string read FLastPassword;

    // ������� "��������� ����������"
    property ShowAboutWindowAtLaunch: boolean read FShowAboutWindowAtLaunch write FShowAboutWindowAtLaunch default True;
    property ShowToolbarAtLaunch: boolean read FShowToolbarAtLaunch write FShowToolbarAtLaunch default True;
    property ShowStatusbarAtLaunch: boolean read FShowStatusbarAtLaunch write FShowStatusbarAtLaunch default True;
    property ShowEditboxHints: boolean read FShowEditboxHints write FShowEditboxHints default True;
    property ShowCommonSearchEditbox: boolean read FShowCommonSearchEditbox write FShowCommonSearchEditbox default True;
    property ShowID: boolean read FShowID write FShowID default False;
    property UseMultibuffer: boolean read FUseMultibuffer write FUseMultibuffer default True;
    property ShowConfirmationAtQuit: boolean read FShowConfirmationAtQuit write FShowConfirmationAtQuit default True;

    // ������� "��������� ������� ��������� ������"
    property EnableLog: boolean read FEnableLog write SetUseLog default True; // ����� �� ����� ��� ������ ���������
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError, lmtWarning, lmtInfo];
    property FlushLogOnExit: boolean read FFlushLogOnExit write FFlushLogOnExit default True;
    property FlushLogOnStringsQuantity: boolean read FFlushLogOnStringsQuantity write FFlushLogOnStringsQuantity default True;
    property FlushLogOnStringsQuantityValue: integer read FFlushLogOnStringsQuantityValue write FFlushLogOnStringsQuantityValue default -1;
    property FlushLogOnClearingLog: boolean read FFlushLogOnClearingLog write FFlushLogOnClearingLog default True;
    property FlushLogOnApply: boolean read FFlushLogOnApply write FFlushLogOnApply default False;
    property CustomLogClientFile: boolean read FCustomLogClientFile write FCustomLogClientFile default False;
    property CustomLogClientFileValue: string read FCustomLogClientFileValue write FCustomLogClientFileValue;

    // ������� "��������� ��������� ���������� ����"
    property LoginFormPosition: TFormPosition read FLoginFormPosition write FLoginFormPosition stored False;
    property OptionsFormPosition: TFormPosition read FOptionsFormPosition write FOptionsFormPosition stored False;
    property UsersFormPosition: TFormPosition read FUsersFormPosition write FUsersFormPosition stored False;
    property SetPasswordFormPosition: TFormPosition read FSetPasswordFormPosition write FSetPasswordFormPosition stored False;
    property StatisticFormPosition: TFormPosition read FStatisticFormPosition write FStatisticFormPosition stored False;
    property MaintenanceFormPosition: TFormPosition read FMaintenanceFormPosition write FMaintenanceFormPosition stored False;
    property ClearingFormPosition: TFormPosition read FClearingFormPosition write FClearingFormPosition stored False;
    property ViewPostListFormPosition: TFormPosition read FViewPostListFormPosition write FViewPostListFormPosition stored False;
    property CreateViewPostFormPosition: TFormPosition read FCreateViewPostFormPosition write FCreateViewPostFormPosition stored False;
    property PhonesFormPosition: TFormPosition read FPhonesFormPosition write FPhonesFormPosition stored False;
    property AddEditPhoneFormPosition: TFormPosition read FAddEditPhoneFormPosition write FAddEditPhoneFormPosition stored False;
    property AddMassMsrFormPosition: TFormPosition read FAddMassMsrFormPosition write FAddMassMsrFormPosition stored False;

    // ������� "��������� ��������� �����������"
    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // ����� �� ������� ��������� �������� �����
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // ����� �� ������� ��������� �������� ������
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // ����� �� ��������� ���������������

    // ������� "��������� ����������� � ������� ���� ������ ������"
    property RNE4Server: TMySQLConnection read FRNE4Server write FRNE4Server stored False;

    // ������� "��������� ����������� � ������� ������� ������ �����������"
    property MessagesServer: TMySQLConnection read FMessagesServer write FMessagesServer stored False;

    // ������� "��������� ������������ �������"
    property ReportFolder: TReportFolders write FReportFolder;
    property ReportFolderValue: string read GetReportFolderValue stored False;
    property SelectedReportFolder: string read FSelectedReportFolder write FSelectedReportFolder stored False;
    property DontDemandOverwriteConfirmation: boolean read FDontDemandOverwriteConfirmation write FDontDemandOverwriteConfirmation stored False;
    property AskForFileName: boolean read FAskForFileName write FAskForFileName default True;

    // ������� "��������� ������"
    property LaunchAtStartup: boolean read FLaunchAtStartup write FLaunchAtStartup default False;
    property PlaySoundOnComplete: boolean read FPlaySoundOnComplete write FPlaySoundOnComplete default True;
    property EnableAutoGetMessages: boolean read FEnableAutoGetMessages write FEnableAutoGetMessages default True;
    property AutoGetMessagesCycleDuration: integer read FAutoGetMessagesCycleDuration write FAutoGetMessagesCycleDuration default 5;
    property EnableCustomHelpFile: boolean read FEnableCustomHelpFile write FEnableCustomHelpFile default False;
    property CustomHelpFile: string read FCustomHelpFile write FCustomHelpFile;

    // ������� "��������� �������� ����"
    property MainFormRect: TRect read FMainFormRect write FMainFormRect stored False;
    property MainFormPositionByCenter: boolean read FMainFormPositionByCenter write FMainFormPositionByCenter default True;
    property FullScreenAtLaunch: boolean read FFullScreenAtLaunch write FFullScreenAtLaunch default False;

    // ������� "��������� ����������� ����������"
    property OrganizationPanelHeight: integer read FOrganizationPanelHeight write FOrganizationPanelHeight default 100;
    property OrganizationPanelHalfHeight: boolean read FOrganizationPanelHalfHeight write FOrganizationPanelHalfHeight default True;
    property DataPanelWidth: integer read FDataPanelWidth write FDataPanelWidth default 340;
    property DataPanelHalfWidth: boolean read FDataPanelHalfWidth write FDataPanelHalfWidth default False;
    property ShowDataInOtherInfoPanel: boolean read FShowDataInOtherInfoPanel write FShowDataInOtherInfoPanel default True;
    property ShowMeasuresListAsRichEdit: boolean read FShowMeasuresListAsRichEdit write FShowMeasuresListAsRichEdit default True;
    property MarkSearchedStrings: boolean read FMarkSearchedStrings write FMarkSearchedStrings default True;
    property PutTownAtTheEnd: boolean read FPutTownAtTheEnd write FPutTownAtTheEnd default False;
  end;

implementation

uses
  SysUtils,
  Windows,
  Forms,
  IniFiles,
  mysql;

procedure TConfiguration.Load;
var
  FormPosition: TFormPosition;
  Rect: TRect;
begin
  if FileName>'' then
    with TIniFile.Create(FileName) do
      begin
        // ������� "��������� ����������"
        ShowAboutWindowAtLaunch:=ReadBool('���������', 'bShowAboutWindowAtLaunch', True);
        ShowToolbarAtLaunch:=ReadBool('���������', 'bShowToolbarAtLaunch', True);
        ShowStatusbarAtLaunch:=ReadBool('���������', 'bShowStatusbarAtLaunch', True);
        ShowEditboxHints:=ReadBool('���������', 'bShowEditboxHints', True);
        ShowCommonSearchEditbox:=ReadBool('���������', 'bShowCommonSearchEditbox', True);
        ShowID:=ReadBool('���������', 'bShowID', False);
        UseMultibuffer:=ReadBool('���������', 'bUseMultibuffer', True);
        ShowConfirmationAtQuit:=ReadBool('���������', 'bShowConfirmationAtQuit', True);

        // ������� "��������� ������� ��������� ������"
        EnableLog:=ReadBool('����������������', 'bEnableLog', True);
        FlushLogOnExit:=ReadBool('����������������', 'bFlushLogOnExit', True);
        FlushLogOnStringsQuantity:=ReadBool('����������������', 'bFlushLogOnStringsQuantity', True);
        FlushLogOnStringsQuantityValue:=ReadInteger('����������������', 'iFlushLogOnStringsQuantityValue', -1);
        FlushLogOnClearingLog:=ReadBool('����������������', 'bFlushLogOnClearingLog', True);
        FlushLogOnApply:=ReadBool('����������������', 'bFlushLogOnApply', False);
        CustomLogClientFile:=ReadBool('����������������', 'bCustomLogClientFile', False);
        CustomLogClientFileValue:=ReadString('����������������', 'sCustomLogClientFileValue', '');
        if ReadBool('����������������', 'bKeepErrorLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtError]
        else
          KeepLogTypes:=KeepLogTypes-[lmtError];
        if ReadBool('����������������', 'bKeepWarningLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtWarning]
        else
          KeepLogTypes:=KeepLogTypes-[lmtWarning];
        if ReadBool('����������������', 'bKeepInfoLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtInfo]
        else
          KeepLogTypes:=KeepLogTypes-[lmtInfo];
        if ReadBool('����������������', 'bKeepSQLLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtSQL]
        else
          KeepLogTypes:=KeepLogTypes-[lmtSQL];
        if ReadBool('����������������', 'bKeepDebugLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtDebug]
        else
          KeepLogTypes:=KeepLogTypes-[lmtDebug];

        // ������� "��������� ��������� ���������� ����"
        with FormPosition do
          begin
            bCenter:=ReadBool('��������� ���������� ����', 'LoginFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'LoginFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'LoginFormPosition.iy', -1);
            LoginFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'OptionsFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'OptionsFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'OptionsFormPosition.iy', -1);
            OptionsFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'UsersFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'UsersFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'UsersFormPosition.iy', -1);
            UsersFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'SetPasswordFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'SetPasswordFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'SetPasswordFormPosition.iy', -1);
            SetPasswordFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'StatisticFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'StatisticFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'StatisticFormPosition.iy', -1);
            StatisticFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'MaintenanceFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'MaintenanceFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'MaintenanceFormPosition.iy', -1);
            MaintenanceFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'ClearingFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'ClearingFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'ClearingFormPosition.iy', -1);
            ClearingFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'ViewPostListFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'ViewPostListFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'ViewPostListFormPosition.iy', -1);
            ViewPostListFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'CreateViewPostFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'CreateViewPostFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'CreateViewPostFormPosition.iy', -1);
            CreateViewPostFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'PhonesFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'PhonesFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'PhonesFormPosition.iy', -1);
            PhonesFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'AddEditPhoneFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'AddEditPhoneFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'AddEditPhoneFormPosition.iy', -1);
            AddEditPhoneFormPosition:=FormPosition;

            bCenter:=ReadBool('��������� ���������� ����', 'AddMassMsrFormPosition.bCenter', True);
            x:=ReadInteger('��������� ���������� ����', 'AddMassMsrFormPosition.ix', -1);
            y:=ReadInteger('��������� ���������� ����', 'AddMassMsrFormPosition.iy', -1);
            AddMassMsrFormPosition:=FormPosition;
          end;

        // ������� "��������� ��������� �����������"
        StoreLastLogin:=ReadBool('�������������', 'bStoreLastLogin', False);
        StoreLastPassword:=ReadBool('�������������', 'bStoreLastPassword', False);
        AutoLogon:=ReadBool('�������������', 'bAutoLogon', False);

        // ������� "����������� � ������� ���� ������ ������"
        with RNE4Server do
          begin
            Host:=ReadString('������ � ���� ������', 'RNE4Server.sHost', 'localhost');
            Port:=ReadInteger('������ � ���� ������', 'RNE4Server.iPort', MYSQL_PORT);
            Timeout:=ReadInteger('������ � ���� ������', 'RNE4Server.iTimeout', 30);
            Compression:=ReadBool('������ � ���� ������', 'RNE4Server.bCompression', True);
            // Login:=ReadString('������ � ���� ������', 'RNE4Server.sLogin', '');
            // Password:=ReadString('������ � ���� ������', 'RNE4Server.sPassword', '');
            Database:=ReadString('������ � ���� ������', 'RNE4Server.sDatabase', 'rne4');
          end;

        // ������� "����������� � ������� ������� ������ �����������"
        with MessagesServer do
          begin
            Host:=ReadString('������ � ���� ������', 'MessagesServer.sHost', 'localhost');
            Port:=ReadInteger('������ � ���� ������', 'MessagesServer.iPort', MYSQL_PORT);
            Timeout:=ReadInteger('������ � ���� ������', 'MessagesServer.iTimeout', 30);
            Compression:=ReadBool('������ � ���� ������', 'MessagesServer.bCompression', True);
            // Login:=ReadString('������ � ���� ������', 'MessagesServer.sLogin', '');
            // Password:=ReadString('������ � ���� ������', 'MessagesServer.sPassword', '');
            Database:=ReadString('������ � ���� ������', 'MessagesServer.sDatabase', 'rne4messages');
          end;

        // ������� "��������� ������"
        LaunchAtStartup:=ReadBool('������', 'bLaunchAtStartup', False);
        PlaySoundOnComplete:=ReadBool('������', 'bPlaySoundOnComplete', True);
        EnableAutoGetMessages:=ReadBool('������', 'bEnableAutoGetMessages', True);
        AutoGetMessagesCycleDuration:=ReadInteger('����������������', 'iAutoGetMessagesCycleDuration', 5);
        EnableCustomHelpFile:=ReadBool('������', 'bEnableCustomHelpFile', False);
        CustomHelpFile:=ReadString('������', 'sCustomHelpFile', '');

        // ������� "��������� �������� ����"
        with Rect do
          begin
            Left:=ReadInteger('������� ����', 'MainFormRect.iLeft', 0);
            Top:=ReadInteger('������� ����', 'MainFormRect.iTop', 0);
            Right:=ReadInteger('������� ����', 'MainFormRect.iRight', 800);
            Bottom:=ReadInteger('������� ����', 'MainFormRect.iBottom', 600);
            MainFormRect:=Rect;
          end;
        MainFormPositionByCenter:=ReadBool('������� ����', 'bMainFormPositionByCenter', True);
        FullScreenAtLaunch:=ReadBool('������� ����', 'bFullScreenAtLaunch', False);

        // ������� "��������� ����������� ����������"
        OrganizationPanelHeight:=ReadInteger('����������� ����������', 'iOrganizationPanelHeight', 100);
        OrganizationPanelHalfHeight:=ReadBool('����������� ����������', 'bOrganizationPanelHalfHeight', True);
        DataPanelWidth:=ReadInteger('����������� ����������', 'iDataPanelWidth', 340);
        DataPanelHalfWidth:=ReadBool('����������� ����������', 'bOrganizationPanelHalfHeight', False);
        ShowDataInOtherInfoPanel:=ReadBool('����������� ����������', 'bShowDataInOtherInfoPanel', True);
        ShowMeasuresListAsRichEdit:=ReadBool('����������� ����������', 'bShowMeasuresListAsRichEdit', True);
        MarkSearchedStrings:=ReadBool('����������� ����������', 'bMarkSearchedStrings', True);
        PutTownAtTheEnd:=ReadBool('����������� ����������', 'bPutTownAtTheEnd', False);
      end
  else
    raise Exception.Create('��� ����� ������������ �� ������ ���� ������!');
end;

procedure TConfiguration.Save;
begin

end;

procedure TConfiguration.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes:=Value;
end;

procedure TConfiguration.SetUseLog(const Value: boolean);
begin
  if FEnableLog<>Value then
    FEnableLog:=Value;
end;

procedure TConfiguration.SetStoreLastLogin(const Value: boolean);
begin
  if FStoreLastLogin<>Value then
    begin
      FStoreLastLogin:=Value;
      if not(Value and StoreLastPassword) then
        AutoLogon:=False;
    end;
end;

procedure TConfiguration.SetStoreLastPassword(const Value: boolean);
begin
  if FStoreLastPassword<>Value then
    begin
      FStoreLastPassword:=Value;
      if not(Value and StoreLastLogin) then
        AutoLogon:=False;
    end;
end;

function TConfiguration.GetReportFolderValue: string;
begin
  case FReportFolder of
    rfTempFolder:
      Result:=GetTempFolder;
    rfApplicationFolder:
      Result:=GetApplicationFolder;
    rfCustomFolder:
      Result:=FSelectedReportFolder;
  end;
end;

constructor TConfiguration.Create;
begin
  inherited;
  RNE4Server:=TMySQLConnection.Create;
  MessagesServer:=TMySQLConnection.Create;
  FFileName:=ExtractFilePath(ExpandFileName(Application.ExeName))+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.ini', [rfIgnoreCase]);
end;

destructor TConfiguration.Destroy;
begin
  MessagesServer.Free;
  RNE4Server.Free;
  inherited;
end;

function TConfiguration.GetApplicationFolder: string;
var
  s: string;
begin
  GetApplicationFolder:='';

  s:=ExtractFilePath(ExpandFileName(Application.ExeName));
  if DirectoryExists(s) then
    GetApplicationFolder:=s
  else
    raise Exception.Create('�������� ������ ��� ������� ��������� ���� ������� ����� ���������!')
end;

function TConfiguration.GetTempFolder: string;
var
  r: cardinal;
  TempPathNameBuffer: PWideChar;
begin
  TempPathNameBuffer:=nil;
  GetTempFolder:='';

  try
    GetMem(TempPathNameBuffer, 1024+1);
    r:=GetTempPath(1024, TempPathNameBuffer);
    if r>0 then
      begin
        if r>1024 then
          begin
            FreeMem(TempPathNameBuffer);
            GetMem(TempPathNameBuffer, r+1);
          end;
        if DirectoryExists(TempPathNameBuffer) then
          GetTempFolder:=TempPathNameBuffer
        else
          raise Exception.Create('�������� ������ ��� ������� ��������� ���� ��������� �����!')
      end;
  finally
    if TempPathNameBuffer<>nil then
      FreeMem(TempPathNameBuffer);
  end;
end;

procedure TConfiguration.SetAutoLogon(const Value: boolean);
begin
  if Value then
    begin
      if not(StoreLastLogin and StoreLastPassword) then
        raise Exception.Create('��� ��������� ��������� ��������������� ���������� ������� �������� ���������� ������ � ������ ���������� ������������!')
    end
  else
    FAutoLogon:=Value;
end;

procedure TConfiguration.SetFileName(const Value: string);
begin
  if FFileName<>Value then
    if Trim(Value)<>'' then
      FFileName:=Trim(Value)
    else
      raise Exception.Create('��� ����� ������������ �� ������ ���� ������!');
end;

end.
