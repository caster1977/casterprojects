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
    procedure SetAddEditPhoneFormPosition(const Value: TFormPosition);
    procedure SetAddMassMsrFormPosition(const Value: TFormPosition);
    procedure SetAskForFileName(const Value: boolean);
    procedure SetAutoGetMessagesCycleDuration(const Value: integer);
    procedure SetClearingFormPosition(const Value: TFormPosition);
    procedure SetCreateViewPostFormPosition(const Value: TFormPosition);
    procedure SetCustomHelpFile(const Value: string);
    procedure SetCustomLogClientFile(const Value: boolean);
    procedure SetCustomLogClientFileValue(const Value: string);
    procedure SetDataPanelHalfWidth(const Value: boolean);
    procedure SetDataPanelWidth(const Value: integer);
    procedure SetDontDemandOverwriteConfirmation(const Value: boolean);
    procedure SetEnableAutoGetMessages(const Value: boolean);
    procedure SetEnableCustomHelpFile(const Value: boolean);
    procedure SetFlushLogOnApply(const Value: boolean);
    procedure SetFlushLogOnClearingLog(const Value: boolean);
    procedure SetFlushLogOnExit(const Value: boolean);
    procedure SetFlushLogOnStringsQuantity(const Value: boolean);
    procedure SetFlushLogOnStringsQuantityValue(const Value: integer);
    procedure SetFullScreenAtLaunch(const Value: boolean);
    procedure SetLaunchAtStartup(const Value: boolean);
    procedure SetLoginFormPosition(const Value: TFormPosition);
    procedure SetMainFormPositionByCenter(const Value: boolean);
    procedure SetMainFormRect(const Value: TRect);
    procedure SetMaintenanceFormPosition(const Value: TFormPosition);
    procedure SetMarkSearchedStrings(const Value: boolean);
    procedure SetMessagesServer(const Value: TMySQLConnection);
    procedure SetOptionsFormPosition(const Value: TFormPosition);
    procedure SetOrganizationPanelHalfHeight(const Value: boolean);
    procedure SetOrganizationPanelHeight(const Value: integer);
    procedure SetPhonesFormPosition(const Value: TFormPosition);
    procedure SetPlaySoundOnComplete(const Value: boolean);
    procedure SetPutTownAtTheEnd(const Value: boolean);
    procedure SetReportFolder(const Value: TReportFolders);
    procedure SetRNE4Server(const Value: TMySQLConnection);
    procedure SetSelectedReportFolder(const Value: string);
    procedure SetSetPasswordFormPosition(const Value: TFormPosition);
    procedure SetShowAboutWindowAtLaunch(const Value: boolean);
    procedure SetShowCommonSearchEditbox(const Value: boolean);
    procedure SetShowConfirmationAtQuit(const Value: boolean);
    procedure SetShowDataInOtherInfoPanel(const Value: boolean);
    procedure SetShowEditboxHints(const Value: boolean);
    procedure SetShowID(const Value: boolean);
    procedure SetShowMeasuresListAsRichEdit(const Value: boolean);
    procedure SetShowStatusbarAtLaunch(const Value: boolean);
    procedure SetShowToolbarAtLaunch(const Value: boolean);
    procedure SetStatisticFormPosition(const Value: TFormPosition);
    procedure SetUseMultibuffer(const Value: boolean);
    procedure SetUsersFormPosition(const Value: TFormPosition);
    procedure SetViewPostListFormPosition(const Value: TFormPosition);
  public
    // sDefaultAction: string;
    // bImmediatelyQuit: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;
    constructor Create; override;
    procedure Load;
    procedure Save;
    destructor Destroy; override;

    property FileName: string read FFileName write SetFileName stored False;
    property ConfigurationFormPage: integer read FConfigurationFormPage write FConfigurationFormPage default 0;
    property LastLogin: string read FLastLogin stored False;
    property LastPassword: string read FLastPassword stored False;

    // ������� "��������� ����������"
    property ShowAboutWindowAtLaunch: boolean read FShowAboutWindowAtLaunch write SetShowAboutWindowAtLaunch default True;
    property ShowToolbarAtLaunch: boolean read FShowToolbarAtLaunch write SetShowToolbarAtLaunch default True;
    property ShowStatusbarAtLaunch: boolean read FShowStatusbarAtLaunch write SetShowStatusbarAtLaunch default True;
    property ShowEditboxHints: boolean read FShowEditboxHints write SetShowEditboxHints default True;
    property ShowCommonSearchEditbox: boolean read FShowCommonSearchEditbox write SetShowCommonSearchEditbox default True;
    property ShowID: boolean read FShowID write SetShowID default False;
    property UseMultibuffer: boolean read FUseMultibuffer write SetUseMultibuffer default True;
    property ShowConfirmationAtQuit: boolean read FShowConfirmationAtQuit write SetShowConfirmationAtQuit default True;

    // ������� "��������� ������� ��������� ������"
    property EnableLog: boolean read FEnableLog write SetUseLog default True;
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError, lmtWarning, lmtInfo];
    property FlushLogOnExit: boolean read FFlushLogOnExit write SetFlushLogOnExit default True;
    property FlushLogOnStringsQuantity: boolean read FFlushLogOnStringsQuantity write SetFlushLogOnStringsQuantity default True;
    property FlushLogOnStringsQuantityValue: integer read FFlushLogOnStringsQuantityValue write SetFlushLogOnStringsQuantityValue default -1;
    property FlushLogOnClearingLog: boolean read FFlushLogOnClearingLog write SetFlushLogOnClearingLog default True;
    property FlushLogOnApply: boolean read FFlushLogOnApply write SetFlushLogOnApply default False;
    property CustomLogClientFile: boolean read FCustomLogClientFile write SetCustomLogClientFile default False;
    property CustomLogClientFileValue: string read FCustomLogClientFileValue write SetCustomLogClientFileValue stored False;

    // ������� "��������� ��������� ���������� ����"
    property LoginFormPosition: TFormPosition read FLoginFormPosition write SetLoginFormPosition stored False;
    property OptionsFormPosition: TFormPosition read FOptionsFormPosition write SetOptionsFormPosition stored False;
    property UsersFormPosition: TFormPosition read FUsersFormPosition write SetUsersFormPosition stored False;
    property SetPasswordFormPosition: TFormPosition read FSetPasswordFormPosition write SetSetPasswordFormPosition stored False;
    property StatisticFormPosition: TFormPosition read FStatisticFormPosition write SetStatisticFormPosition stored False;
    property MaintenanceFormPosition: TFormPosition read FMaintenanceFormPosition write SetMaintenanceFormPosition stored False;
    property ClearingFormPosition: TFormPosition read FClearingFormPosition write SetClearingFormPosition stored False;
    property ViewPostListFormPosition: TFormPosition read FViewPostListFormPosition write SetViewPostListFormPosition stored False;
    property CreateViewPostFormPosition: TFormPosition read FCreateViewPostFormPosition write SetCreateViewPostFormPosition stored False;
    property PhonesFormPosition: TFormPosition read FPhonesFormPosition write SetPhonesFormPosition stored False;
    property AddEditPhoneFormPosition: TFormPosition read FAddEditPhoneFormPosition write SetAddEditPhoneFormPosition stored False;
    property AddMassMsrFormPosition: TFormPosition read FAddMassMsrFormPosition write SetAddMassMsrFormPosition stored False;

    // ������� "��������� ��������� �����������"
    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // ����� �� ������� ��������� �������� �����
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // ����� �� ������� ��������� �������� ������
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // ����� �� ��������� ���������������

    // ������� "��������� ����������� � ������� ���� ������ ������"
    property RNE4Server: TMySQLConnection read FRNE4Server write SetRNE4Server stored False;

    // ������� "��������� ����������� � ������� ������� ������ �����������"
    property MessagesServer: TMySQLConnection read FMessagesServer write SetMessagesServer stored False;

    // ������� "��������� ������������ �������"
    property ReportFolder: TReportFolders read FReportFolder write SetReportFolder stored False;
    property ReportFolderValue: string read GetReportFolderValue stored False;
    property SelectedReportFolder: string read FSelectedReportFolder write SetSelectedReportFolder stored False;
    property DontDemandOverwriteConfirmation: boolean read FDontDemandOverwriteConfirmation write SetDontDemandOverwriteConfirmation default False;
    property AskForFileName: boolean read FAskForFileName write SetAskForFileName default True;

    // ������� "��������� ������"
    property LaunchAtStartup: boolean read FLaunchAtStartup write SetLaunchAtStartup default False;
    property PlaySoundOnComplete: boolean read FPlaySoundOnComplete write SetPlaySoundOnComplete default True;
    property EnableAutoGetMessages: boolean read FEnableAutoGetMessages write SetEnableAutoGetMessages default True;
    property AutoGetMessagesCycleDuration: integer read FAutoGetMessagesCycleDuration write SetAutoGetMessagesCycleDuration default 5;
    property EnableCustomHelpFile: boolean read FEnableCustomHelpFile write SetEnableCustomHelpFile default False;
    property CustomHelpFile: string read FCustomHelpFile write SetCustomHelpFile stored False;

    // ������� "��������� �������� ����"
    property MainFormRect: TRect read FMainFormRect write SetMainFormRect stored False;
    property MainFormPositionByCenter: boolean read FMainFormPositionByCenter write SetMainFormPositionByCenter default True;
    property FullScreenAtLaunch: boolean read FFullScreenAtLaunch write SetFullScreenAtLaunch default False;

    // ������� "��������� ����������� ����������"
    property OrganizationPanelHeight: integer read FOrganizationPanelHeight write SetOrganizationPanelHeight default 100;
    property OrganizationPanelHalfHeight: boolean read FOrganizationPanelHalfHeight write SetOrganizationPanelHalfHeight default True;
    property DataPanelWidth: integer read FDataPanelWidth write SetDataPanelWidth default 340;
    property DataPanelHalfWidth: boolean read FDataPanelHalfWidth write SetDataPanelHalfWidth default False;
    property ShowDataInOtherInfoPanel: boolean read FShowDataInOtherInfoPanel write SetShowDataInOtherInfoPanel default True;
    property ShowMeasuresListAsRichEdit: boolean read FShowMeasuresListAsRichEdit write SetShowMeasuresListAsRichEdit default True;
    property MarkSearchedStrings: boolean read FMarkSearchedStrings write SetMarkSearchedStrings default True;
    property PutTownAtTheEnd: boolean read FPutTownAtTheEnd write SetPutTownAtTheEnd default False;
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

        // ������� "��������� ������������ �������"
        ReportFolder:=TReportFolders(ReadInteger('������������ �������', 'iReportFolder', integer(rfApplicationFolder)));
        SelectedReportFolder:=ReadString('������������ �������', 'sSelectedReportFolder', '');
        DontDemandOverwriteConfirmation:=ReadBool('������������ �������', 'bDontDemandOverwriteConfirmation', False);
        AskForFileName:=ReadBool('������������ �������', 'bAskForFileName', True);

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
var
  IniFile: TIniFile;

  procedure WriteFormPosition(IniFile: TIniFile; FormPosition: TFormPosition; const FormPositionName: string);
  begin
    with IniFile do
      begin
        WriteBool('��������� ���������� ����', FormPositionName+'.bCenter', FormPosition.bCenter);
        WriteInteger('��������� ���������� ����', FormPositionName+'.x', FormPosition.x);
        WriteInteger('��������� ���������� ����', FormPositionName+'.y', FormPosition.y);
      end;
  end;

begin
  if FileName>'' then
    begin
      IniFile:=TIniFile.Create(FileName);
      with IniFile do
        try
          // ������� "��������� ����������"
          WriteBool('���������', 'bShowAboutWindowAtLaunch', ShowAboutWindowAtLaunch);
          WriteBool('���������', 'bShowToolbarAtLaunch', ShowToolbarAtLaunch);
          WriteBool('���������', 'bShowStatusbarAtLaunch', ShowStatusbarAtLaunch);
          WriteBool('���������', 'bShowEditboxHints', ShowEditboxHints);
          WriteBool('���������', 'bShowCommonSearchEditbox', ShowCommonSearchEditbox);
          WriteBool('���������', 'bShowID', ShowID);
          WriteBool('���������', 'bUseMultibuffer', UseMultibuffer);
          WriteBool('���������', 'bShowConfirmationAtQuit', ShowConfirmationAtQuit);

          // ������� "��������� ������� ��������� ������"
          WriteBool('����������������', 'bEnableLog', EnableLog);
          WriteBool('����������������', 'bFlushLogOnExit', FlushLogOnExit);
          WriteBool('����������������', 'bFlushLogOnStringsQuantity', FlushLogOnStringsQuantity);
          WriteInteger('����������������', 'iFlushLogOnStringsQuantityValue', FlushLogOnStringsQuantityValue);
          WriteBool('����������������', 'bFlushLogOnClearingLog', FlushLogOnClearingLog);
          WriteBool('����������������', 'bFlushLogOnApply', FlushLogOnApply);
          WriteBool('����������������', 'bCustomLogClientFile', CustomLogClientFile);
          WriteString('����������������', 'sCustomLogClientFileValue', CustomLogClientFileValue);

          WriteBool('����������������', 'bKeepErrorLog', lmtError in KeepLogTypes);
          WriteBool('����������������', 'bKeepWarningLog', lmtWarning in KeepLogTypes);
          WriteBool('����������������', 'bKeepInfoLog', lmtInfo in KeepLogTypes);
          WriteBool('����������������', 'bKeepSQLLog', lmtSQL in KeepLogTypes);
          WriteBool('����������������', 'bKeepDebugLog', lmtDebug in KeepLogTypes);

          // ������� "��������� ��������� ���������� ����"
          WriteFormPosition(IniFile, LoginFormPosition, 'LoginFormPosition');
          WriteFormPosition(IniFile, OptionsFormPosition, 'OptionsFormPosition');
          WriteFormPosition(IniFile, UsersFormPosition, 'UsersFormPosition');
          WriteFormPosition(IniFile, SetPasswordFormPosition, 'SetPasswordFormPosition');
          WriteFormPosition(IniFile, StatisticFormPosition, 'StatisticFormPosition');
          WriteFormPosition(IniFile, MaintenanceFormPosition, 'MaintenanceFormPosition');
          WriteFormPosition(IniFile, ClearingFormPosition, 'ClearingFormPosition');
          WriteFormPosition(IniFile, ViewPostListFormPosition, 'ViewPostListFormPosition');
          WriteFormPosition(IniFile, CreateViewPostFormPosition, 'CreateViewPostFormPosition');
          WriteFormPosition(IniFile, PhonesFormPosition, 'PhonesFormPosition');
          WriteFormPosition(IniFile, AddEditPhoneFormPosition, 'AddEditPhoneFormPosition');
          WriteFormPosition(IniFile, AddMassMsrFormPosition, 'AddMassMsrFormPosition');

          // ������� "��������� ��������� �����������"
          WriteBool('�������������', 'bStoreLastLogin', StoreLastLogin);
          WriteBool('�������������', 'bStoreLastPassword', StoreLastPassword);
          WriteBool('�������������', 'bAutoLogon', AutoLogon);

          // ������� "����������� � ������� ���� ������ ������"
          with RNE4Server do
            begin
              WriteString('������ � ���� ������', 'RNE4Server.sHost', Host);
              WriteInteger('������ � ���� ������', 'RNE4Server.iPort', Port);
              WriteInteger('������ � ���� ������', 'RNE4Server.iTimeout', Timeout);
              WriteBool('������ � ���� ������', 'RNE4Server.bCompression', Compression);
              // WriteString('������ � ���� ������', 'RNE4Server.sLogin', Login);
              // WriteString('������ � ���� ������', 'RNE4Server.sPassword', Password);
              WriteString('������ � ���� ������', 'RNE4Server.sDatabase', Database);
            end;

          // ������� "����������� � ������� ������� ������ �����������"
          with MessagesServer do
            begin
              WriteString('������ � ���� ������', 'MessagesServer.sHost', Host);
              WriteInteger('������ � ���� ������', 'MessagesServer.iPort', Port);
              WriteInteger('������ � ���� ������', 'MessagesServer.iTimeout', Timeout);
              WriteBool('������ � ���� ������', 'MessagesServer.bCompression', Compression);
              // WriteString('������ � ���� ������', 'MessagesServer.sLogin', Login);
              // WriteString('������ � ���� ������', 'MessagesServer.sPassword', Password);
              WriteString('������ � ���� ������', 'MessagesServer.sDatabase', Database);
            end;

          // ������� "��������� ������������ �������"
          WriteInteger('������������ �������', 'iReportFolder', integer(ReportFolder));
          WriteString('������������ �������', 'sSelectedReportFolder', SelectedReportFolder);
          WriteBool('������������ �������', 'bDontDemandOverwriteConfirmation', DontDemandOverwriteConfirmation);
          WriteBool('������������ �������', 'bAskForFileName', AskForFileName);

          // ������� "��������� ������"
          WriteBool('������', 'bLaunchAtStartup', LaunchAtStartup);
          WriteBool('������', 'bPlaySoundOnComplete', PlaySoundOnComplete);
          WriteBool('������', 'bEnableAutoGetMessages', EnableAutoGetMessages);
          WriteInteger('������', 'bAutoGetMessagesCycleDuration', AutoGetMessagesCycleDuration);
          WriteBool('������', 'bEnableCustomHelpFile', EnableCustomHelpFile);
          WriteString('������', 'bCustomHelpFile', CustomHelpFile);

          // ������� "��������� �������� ����"
          WriteInteger('������� ����', 'MainFormRect.iLeft', MainFormRect.Left);
          WriteInteger('������� ����', 'MainFormRect.iTop', MainFormRect.Top);
          WriteInteger('������� ����', 'MainFormRect.iRight', MainFormRect.Right);
          WriteInteger('������� ����', 'MainFormRect.iBottom', MainFormRect.Bottom);
          WriteBool('������� ����', 'bMainFormPositionByCenter', MainFormPositionByCenter);
          WriteBool('������� ����', 'bFullScreenAtLaunch', FullScreenAtLaunch);

          // ������� "��������� ����������� ����������"
          WriteInteger('����������� ����������', 'iOrganizationPanelHeight', OrganizationPanelHeight);
          WriteBool('����������� ����������', 'bOrganizationPanelHalfHeight', OrganizationPanelHalfHeight);
          WriteInteger('����������� ����������', 'iDataPanelWidth', DataPanelWidth);
          WriteBool('����������� ����������', 'bOrganizationPanelHalfHeight', OrganizationPanelHalfHeight);
          WriteBool('����������� ����������', 'bShowDataInOtherInfoPanel', ShowDataInOtherInfoPanel);
          WriteBool('����������� ����������', 'bShowMeasuresListAsRichEdit', ShowMeasuresListAsRichEdit);
          WriteBool('����������� ����������', 'bMarkSearchedStrings', MarkSearchedStrings);
          WriteBool('����������� ����������', 'bPutTownAtTheEnd', PutTownAtTheEnd);
        finally
          IniFile.Free;
        end
    end
  else
    raise Exception.Create('��� ����� ������������ �� ������ ���� ������!');
end;

procedure TConfiguration.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes:=Value;
end;

procedure TConfiguration.SetLaunchAtStartup(const Value: boolean);
begin
  if FLaunchAtStartup<>Value then
    FLaunchAtStartup:=Value;
end;

procedure TConfiguration.SetLoginFormPosition(const Value: TFormPosition);
begin
  if ((FLoginFormPosition.bCenter<>Value.bCenter) or (FLoginFormPosition.x<>Value.x) or (FLoginFormPosition.y<>Value.y)) then
    FLoginFormPosition:=Value;
end;

procedure TConfiguration.SetMainFormPositionByCenter(const Value: boolean);
begin
  if FMainFormPositionByCenter<>Value then
    FMainFormPositionByCenter:=Value;
end;

procedure TConfiguration.SetMainFormRect(const Value: TRect);
begin
  if ((FMainFormRect.Left<>Value.Left) or (FMainFormRect.Top<>Value.Top) or (FMainFormRect.Right<>Value.Right) or (FMainFormRect.Bottom<>Value.Bottom)) then
    FMainFormRect:=Value;
end;

procedure TConfiguration.SetMaintenanceFormPosition(const Value: TFormPosition);
begin
  if ((FMaintenanceFormPosition.bCenter<>Value.bCenter) or (FMaintenanceFormPosition.x<>Value.x) or (FMaintenanceFormPosition.y<>Value.y)) then
    FMaintenanceFormPosition:=Value;
end;

procedure TConfiguration.SetMarkSearchedStrings(const Value: boolean);
begin
  if FMarkSearchedStrings<>Value then
    FMarkSearchedStrings:=Value;
end;

procedure TConfiguration.SetMessagesServer(const Value: TMySQLConnection);
begin
  if FMessagesServer<>Value then
    FMessagesServer:=Value;
end;

procedure TConfiguration.SetOptionsFormPosition(const Value: TFormPosition);
begin
  if ((FOptionsFormPosition.bCenter<>Value.bCenter) or (FOptionsFormPosition.x<>Value.x) or (FOptionsFormPosition.y<>Value.y)) then
    FOptionsFormPosition:=Value;
end;

procedure TConfiguration.SetOrganizationPanelHalfHeight(const Value: boolean);
begin
  if FOrganizationPanelHalfHeight<>Value then
    FOrganizationPanelHalfHeight:=Value;
end;

procedure TConfiguration.SetOrganizationPanelHeight(const Value: integer);
begin
  if FOrganizationPanelHeight<>Value then
    FOrganizationPanelHeight:=Value;
end;

procedure TConfiguration.SetPhonesFormPosition(const Value: TFormPosition);
begin
  if ((FPhonesFormPosition.bCenter<>Value.bCenter) or (FPhonesFormPosition.x<>Value.x) or (FPhonesFormPosition.y<>Value.y)) then
    FPhonesFormPosition:=Value;
end;

procedure TConfiguration.SetPlaySoundOnComplete(const Value: boolean);
begin
  if FPlaySoundOnComplete<>Value then
    FPlaySoundOnComplete:=Value;
end;

procedure TConfiguration.SetPutTownAtTheEnd(const Value: boolean);
begin
  if FPutTownAtTheEnd<>Value then
    FPutTownAtTheEnd:=Value;
end;

procedure TConfiguration.SetReportFolder(const Value: TReportFolders);
begin
  if FReportFolder<>Value then
    FReportFolder:=Value;
end;

procedure TConfiguration.SetRNE4Server(const Value: TMySQLConnection);
begin
  if FRNE4Server<>Value then
    FRNE4Server:=Value;
end;

procedure TConfiguration.SetUseLog(const Value: boolean);
begin
  if FEnableLog<>Value then
    FEnableLog:=Value;
end;

procedure TConfiguration.SetSelectedReportFolder(const Value: string);
begin
  if FSelectedReportFolder<>Value then
    FSelectedReportFolder:=Value;
end;

procedure TConfiguration.SetSetPasswordFormPosition(const Value: TFormPosition);
begin
  if ((FSetPasswordFormPosition.bCenter<>Value.bCenter) or (FSetPasswordFormPosition.x<>Value.x) or (FSetPasswordFormPosition.y<>Value.y)) then
    FSetPasswordFormPosition:=Value;
end;

procedure TConfiguration.SetShowAboutWindowAtLaunch(const Value: boolean);
begin
  if FShowAboutWindowAtLaunch<>Value then
    FShowAboutWindowAtLaunch:=Value;
end;

procedure TConfiguration.SetShowCommonSearchEditbox(const Value: boolean);
begin
  if FShowCommonSearchEditbox<>Value then
    FShowCommonSearchEditbox:=Value;
end;

procedure TConfiguration.SetShowConfirmationAtQuit(const Value: boolean);
begin
  if FShowConfirmationAtQuit<>Value then
    FShowConfirmationAtQuit:=Value;
end;

procedure TConfiguration.SetShowDataInOtherInfoPanel(const Value: boolean);
begin
  if FShowDataInOtherInfoPanel<>Value then
    FShowDataInOtherInfoPanel:=Value;
end;

procedure TConfiguration.SetShowEditboxHints(const Value: boolean);
begin
  if FShowEditboxHints<>Value then
    FShowEditboxHints:=Value;
end;

procedure TConfiguration.SetShowID(const Value: boolean);
begin
  if FShowID<>Value then
    FShowID:=Value;
end;

procedure TConfiguration.SetShowMeasuresListAsRichEdit(const Value: boolean);
begin
  if FShowMeasuresListAsRichEdit<>Value then
    FShowMeasuresListAsRichEdit:=Value;
end;

procedure TConfiguration.SetShowStatusbarAtLaunch(const Value: boolean);
begin
  if FShowStatusbarAtLaunch<>Value then
    FShowStatusbarAtLaunch:=Value;
end;

procedure TConfiguration.SetShowToolbarAtLaunch(const Value: boolean);
begin
  if FShowToolbarAtLaunch<>Value then
    FShowToolbarAtLaunch:=Value;
end;

procedure TConfiguration.SetStatisticFormPosition(const Value: TFormPosition);
begin
  if ((FStatisticFormPosition.bCenter<>Value.bCenter) or (FStatisticFormPosition.x<>Value.x) or (FStatisticFormPosition.y<>Value.y)) then
    FStatisticFormPosition:=Value;
end;

procedure TConfiguration.SetUseMultibuffer(const Value: boolean);
begin
  if FUseMultibuffer<>Value then
    FUseMultibuffer:=Value;
end;

procedure TConfiguration.SetUsersFormPosition(const Value: TFormPosition);
begin
  if ((FUsersFormPosition.bCenter<>Value.bCenter) or (FUsersFormPosition.x<>Value.x) or (FUsersFormPosition.y<>Value.y)) then
    FUsersFormPosition:=Value;
end;

procedure TConfiguration.SetViewPostListFormPosition(const Value: TFormPosition);
begin
  if ((FViewPostListFormPosition.bCenter<>Value.bCenter) or (FViewPostListFormPosition.x<>Value.x) or (FViewPostListFormPosition.y<>Value.y)) then
    FViewPostListFormPosition:=Value;
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
      Result:=SelectedReportFolder;
  end;
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

procedure TConfiguration.SetAddEditPhoneFormPosition(const Value: TFormPosition);
begin
  if ((FAddEditPhoneFormPosition.bCenter<>Value.bCenter) or (FAddEditPhoneFormPosition.x<>Value.x) or (FAddEditPhoneFormPosition.y<>Value.y)) then
    FAddEditPhoneFormPosition:=Value;
end;

procedure TConfiguration.SetAddMassMsrFormPosition(const Value: TFormPosition);
begin
  if ((FAddMassMsrFormPosition.bCenter<>Value.bCenter) or (FAddMassMsrFormPosition.x<>Value.x) or (FAddMassMsrFormPosition.y<>Value.y)) then
    FAddMassMsrFormPosition:=Value;
end;

procedure TConfiguration.SetAskForFileName(const Value: boolean);
begin
  if FAskForFileName<>Value then
    FAskForFileName:=Value;
end;

procedure TConfiguration.SetAutoGetMessagesCycleDuration(const Value: integer);
begin
  if FAutoGetMessagesCycleDuration<>Value then
    FAutoGetMessagesCycleDuration:=Value;
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

procedure TConfiguration.SetClearingFormPosition(const Value: TFormPosition);
begin
  if ((FClearingFormPosition.bCenter<>Value.bCenter) or (FClearingFormPosition.x<>Value.x) or (FClearingFormPosition.y<>Value.y)) then
    FClearingFormPosition:=Value;
end;

procedure TConfiguration.SetCreateViewPostFormPosition(const Value: TFormPosition);
begin
  if ((FCreateViewPostFormPosition.bCenter<>Value.bCenter) or (FCreateViewPostFormPosition.x<>Value.x) or (FCreateViewPostFormPosition.y<>Value.y)) then
    FCreateViewPostFormPosition:=Value;
end;

procedure TConfiguration.SetCustomHelpFile(const Value: string);
begin
  if FCustomHelpFile<>Value then
    FCustomHelpFile:=Value;
end;

procedure TConfiguration.SetCustomLogClientFile(const Value: boolean);
begin
  if FCustomLogClientFile<>Value then
    FCustomLogClientFile:=Value;
end;

procedure TConfiguration.SetCustomLogClientFileValue(const Value: string);
begin
  if FCustomLogClientFileValue<>Value then
    FCustomLogClientFileValue:=Value;
end;

procedure TConfiguration.SetDataPanelHalfWidth(const Value: boolean);
begin
  if FDataPanelHalfWidth<>Value then
    FDataPanelHalfWidth:=Value;
end;

procedure TConfiguration.SetDataPanelWidth(const Value: integer);
begin
  if FDataPanelWidth<>Value then
    FDataPanelWidth:=Value;
end;

procedure TConfiguration.SetDontDemandOverwriteConfirmation(const Value: boolean);
begin
  if FDontDemandOverwriteConfirmation<>Value then
    FDontDemandOverwriteConfirmation:=Value;
end;

procedure TConfiguration.SetEnableAutoGetMessages(const Value: boolean);
begin
  if FEnableAutoGetMessages<>Value then
    FEnableAutoGetMessages:=Value;
end;

procedure TConfiguration.SetEnableCustomHelpFile(const Value: boolean);
begin
  if FEnableCustomHelpFile<>Value then
    FEnableCustomHelpFile:=Value;
end;

procedure TConfiguration.SetFileName(const Value: string);
begin
  if FFileName<>Value then
    if Trim(Value)<>'' then
      FFileName:=Trim(Value)
    else
      raise Exception.Create('��� ����� ������������ �� ������ ���� ������!');
end;

procedure TConfiguration.SetFlushLogOnApply(const Value: boolean);
begin
  if FFlushLogOnApply<>Value then
    FFlushLogOnApply:=Value;
end;

procedure TConfiguration.SetFlushLogOnClearingLog(const Value: boolean);
begin
  if FFlushLogOnClearingLog<>Value then
    FFlushLogOnClearingLog:=Value;
end;

procedure TConfiguration.SetFlushLogOnExit(const Value: boolean);
begin
  if FFlushLogOnExit<>Value then
    FFlushLogOnExit:=Value;
end;

procedure TConfiguration.SetFlushLogOnStringsQuantity(const Value: boolean);
begin
  if FFlushLogOnStringsQuantity<>Value then
    FFlushLogOnStringsQuantity:=Value;
end;

procedure TConfiguration.SetFlushLogOnStringsQuantityValue(const Value: integer);
begin
  if FFlushLogOnStringsQuantityValue<>Value then
    FFlushLogOnStringsQuantityValue:=Value;
end;

procedure TConfiguration.SetFullScreenAtLaunch(const Value: boolean);
begin
  if FFullScreenAtLaunch<>Value then
    FFullScreenAtLaunch:=Value;
end;

constructor TConfiguration.Create;
begin
  inherited;

  // ������������� ������������ ������ ������
  RNE4Server:=TMySQLConnection.Create;
  MessagesServer:=TMySQLConnection.Create;

  // ������������� ���������� ������
  FFileName:=ExtractFilePath(ExpandFileName(Application.ExeName))+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.ini', [rfIgnoreCase]);
  FConfigurationFormPage:=0;
  FLastLogin:='';
  FLastPassword:='';

  // ������� "��������� ����������"
  FShowAboutWindowAtLaunch:=True;
  FShowToolbarAtLaunch:=True;
  FShowStatusbarAtLaunch:=True;
  FShowEditboxHints:=True;
  FShowCommonSearchEditbox:=True;
  FShowID:=False;
  FUseMultibuffer:=True;
  FShowConfirmationAtQuit:=True;

  // ������� "��������� ������� ��������� ������"
  FEnableLog:=True;
  FKeepLogTypes:=[lmtError, lmtWarning, lmtInfo];
  FFlushLogOnExit:=True;
  FFlushLogOnStringsQuantity:=True;
  FFlushLogOnStringsQuantityValue:=-1;
  FFlushLogOnClearingLog:=True;
  FFlushLogOnApply:=False;
  FCustomLogClientFile:=False;
  FCustomLogClientFileValue:='';

  // ������� "��������� ��������� ���������� ����"
  with FLoginFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FOptionsFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FUsersFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FSetPasswordFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FStatisticFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FMaintenanceFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FClearingFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FViewPostListFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FCreateViewPostFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FPhonesFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FAddEditPhoneFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  with FAddMassMsrFormPosition do
    begin
      bCenter:=True;
      FLoginFormPosition.x:=0;
      FLoginFormPosition.y:=0;
    end;

  // ������� "��������� ��������� �����������"
  FStoreLastLogin:=False;
  FStoreLastPassword:=False;
  FAutoLogon:=False;

  // ������� "��������� ����������� � ������� ���� ������ ������"
  with FRNE4Server do
    begin
      Connected:=False;
      Connection:=nil;
      LogProvider:=nil;
      Host:='';
      Port:=MYSQL_PORT;
      Timeout:=30;
      Compression:=True;
      Login:='';
      Password:='';
      Database:='';
    end;

  // ������� "��������� ����������� � ������� ������� ������ �����������"
  with FMessagesServer do
    begin
      Connected:=False;
      Connection:=nil;
      LogProvider:=nil;
      Host:='';
      Port:=MYSQL_PORT;
      Timeout:=30;
      Compression:=True;
      Login:='';
      Password:='';
      Database:='';
    end;

  // ������� "��������� ������������ �������"
  FReportFolder:=rfApplicationFolder;
  FSelectedReportFolder:='';
  FDontDemandOverwriteConfirmation:=False;
  AskForFileName:=True;

  // ������� "��������� ������"
  FLaunchAtStartup:=False;
  FPlaySoundOnComplete:=True;
  FEnableAutoGetMessages:=True;
  FAutoGetMessagesCycleDuration:=5;
  FEnableCustomHelpFile:=False;
  FCustomHelpFile:='';

  // ������� "��������� �������� ����"
  with FMainFormRect do
    begin
      Left:=0;
      Top:=0;
      Right:=800;
      Bottom:=600;
    end;
  FMainFormPositionByCenter:=True;
  FFullScreenAtLaunch:=False;

  // ������� "��������� ����������� ����������"
  FOrganizationPanelHeight:=100;
  FOrganizationPanelHalfHeight:=True;
  FDataPanelWidth:=340;
  FDataPanelHalfWidth:=False;
  FShowDataInOtherInfoPanel:=True;
  FShowMeasuresListAsRichEdit:=True;
  FMarkSearchedStrings:=True;
  FPutTownAtTheEnd:=False;
end;

end.
