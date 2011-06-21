unit uConfigurationClass;

interface

uses
  uMySQLConnectionClass,
  LogKeeperData,
  Types,
  mysql,
  uSingleton;

type
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);

const
  // ������� "��������� ����������"
  DefaultValue_ShowAboutWindowAtLaunch: boolean=True;
  DefaultValue_ShowToolbarAtLaunch: boolean=True;
  DefaultValue_ShowStatusbarAtLaunch: boolean=True;
  DefaultValue_ShowEditboxHints: boolean=True;
  DefaultValue_ShowCommonSearchEditbox: boolean=True;
  DefaultValue_ShowID: boolean=False;
  DefaultValue_UseMultibuffer: boolean=True;
  DefaultValue_ShowConfirmationAtQuit: boolean=True;

  // ������� "��������� ������� ��������� ������"
  DefaultValue_EnableLog: boolean=True;
  DefaultValue_KeepLogTypes: TLogMessagesTypes=[lmtError, lmtWarning, lmtInfo];
  DefaultValue_FlushLogOnExit: boolean=True;
  DefaultValue_FlushLogOnStringsQuantity: boolean=True;
  DefaultValue_FlushLogOnStringsQuantityValue: integer=10000;
  DefaultValue_FlushLogOnClearingLog: boolean=True;
  DefaultValue_FlushLogOnApply: boolean=False;
  DefaultValue_CustomLogClientFile: boolean=False;
  DefaultValue_CustomLogClientFileValue: string='';

  // ������� "��������� ��������� ���������� ����"

  // ������� "��������� ��������� �����������"
  DefaultValue_StoreLastLogin: boolean=False;
  DefaultValue_StoreLastPassword: boolean=False;
  DefaultValue_AutoLogon: boolean=False;

  // ������� "����������� � ������� ���� ������ ������"
  DefaultValue_RNE4Server_Host: string='RNE4SERVER';
  DefaultValue_RNE4Server_Port: integer=MYSQL_PORT;
  DefaultValue_RNE4Server_Timeout: integer=30;
  DefaultValue_RNE4Server_Compression: boolean=True;
  DefaultValue_RNE4Server_Login: string='';
  DefaultValue_RNE4Server_Password: string='';
  DefaultValue_RNE4Server_Database: string='rne4';

  // ������� "����������� � ������� ������� ������ �����������"
  DefaultValue_MessagesServer_Host: string='RNE4MESSAGESSERVER';
  DefaultValue_MessagesServer_Port: integer=MYSQL_PORT;
  DefaultValue_MessagesServer_Timeout: integer=30;
  DefaultValue_MessagesServer_Compression: boolean=True;
  DefaultValue_MessagesServer_Login: string='';
  DefaultValue_MessagesServer_Password: string='';
  DefaultValue_MessagesServer_Database: string='rne4messages';

  // ������� "��������� ������������ �������"
  DefaultValue_ReportFolder: TReportFolders=rfApplicationFolder;
  DefaultValue_CustomReportFolderValue: string='';
  DefaultValue_DontDemandOverwriteConfirmation: boolean=False;
  DefaultValue_AskForFileName: boolean=True;

  // ������� "��������� ������"
  DefaultValue_LaunchAtStartup: boolean=False;
  DefaultValue_PlaySoundOnComplete: boolean=True;
  DefaultValue_EnableAutoGetMessages: boolean=True;
  DefaultValue_AutoGetMessagesCycleDuration: integer=5;
  DefaultValue_CustomHelpFile: boolean=False;
  DefaultValue_CustomHelpFileValue: string='';

  // ������� "��������� �������� ����"
  DefaultValue_MainFormRect_Left: integer=0;
  DefaultValue_MainFormRect_Top: integer=0;
  DefaultValue_MainFormRect_Right: integer=800;
  DefaultValue_MainFormRect_Bottom: integer=600;
  DefaultValue_MainFormPositionByCenter: boolean=True;
  DefaultValue_FullScreenAtLaunch: boolean=False;

  // ������� "��������� ����������� ����������"
  DefaultValue_OrganizationPanelHeight: integer=100;
  DefaultValue_OrganizationPanelHalfHeight: boolean=True;
  DefaultValue_DataPanelWidth: integer=340;
  DefaultValue_DataPanelHalfWidth: boolean=False;
  DefaultValue_ShowDataInOtherInfoPanel: boolean=True;
  DefaultValue_ShowMeasuresListAsRichEdit: boolean=True;
  DefaultValue_MarkSearchedStrings: boolean=True;
  DefaultValue_PutTownAtTheEnd: boolean=False;

type

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
    FCustomReportFolderValue: string; //
    FDontDemandOverwriteConfirmation: boolean; //
    FAskForFileName: boolean; //

    // ������� "��������� ������ ����������"

    // ������� "��������� ������"
    FLaunchAtStartup: boolean;
    FPlaySoundOnComplete: boolean;
    FEnableAutoGetMessages: boolean;
    FAutoGetMessagesCycleDuration: integer;
    FCustomHelpFile: boolean;
    FCustomHelpFileValue: string;

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
    procedure SetCustomHelpFile(const Value: boolean);
    procedure SetCustomHelpFileValue(const Value: string);
    procedure SetCustomLogClientFile(const Value: boolean);
    procedure SetCustomLogClientFileValue(const Value: string);
    procedure SetDataPanelHalfWidth(const Value: boolean);
    procedure SetDataPanelWidth(const Value: integer);
    procedure SetDontDemandOverwriteConfirmation(const Value: boolean);
    procedure SetEnableAutoGetMessages(const Value: boolean);
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
    procedure SetCustomReportFolderValue(const Value: string);
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
    property CustomReportFolderValue: string read FCustomReportFolderValue write SetCustomReportFolderValue stored False;
    property DontDemandOverwriteConfirmation: boolean read FDontDemandOverwriteConfirmation write SetDontDemandOverwriteConfirmation default False;
    property AskForFileName: boolean read FAskForFileName write SetAskForFileName default True;

    // ������� "��������� ������"
    property LaunchAtStartup: boolean read FLaunchAtStartup write SetLaunchAtStartup default False;
    property PlaySoundOnComplete: boolean read FPlaySoundOnComplete write SetPlaySoundOnComplete default True;
    property EnableAutoGetMessages: boolean read FEnableAutoGetMessages write SetEnableAutoGetMessages default True;
    property AutoGetMessagesCycleDuration: integer read FAutoGetMessagesCycleDuration write SetAutoGetMessagesCycleDuration default 5;
    property CustomHelpFile: boolean read FCustomHelpFile write SetCustomHelpFile default False;
    property CustomHelpFileValue: string read FCustomHelpFileValue write SetCustomHelpFileValue stored False;

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
  IniFiles;

procedure TConfiguration.Load;
var
  FormPosition: TFormPosition;
  Rect: TRect;
begin
  if FileName>'' then
    with TIniFile.Create(FileName) do
      begin
        // ������� "��������� ����������"
        ShowAboutWindowAtLaunch:=ReadBool('���������', 'bShowAboutWindowAtLaunch', DefaultValue_ShowAboutWindowAtLaunch);
        ShowToolbarAtLaunch:=ReadBool('���������', 'bShowToolbarAtLaunch', DefaultValue_ShowToolbarAtLaunch);
        ShowStatusbarAtLaunch:=ReadBool('���������', 'bShowStatusbarAtLaunch', DefaultValue_ShowStatusbarAtLaunch);
        ShowEditboxHints:=ReadBool('���������', 'bShowEditboxHints', DefaultValue_ShowEditboxHints);
        ShowCommonSearchEditbox:=ReadBool('���������', 'bShowCommonSearchEditbox', DefaultValue_ShowCommonSearchEditbox);
        ShowID:=ReadBool('���������', 'bShowID', DefaultValue_ShowID);
        UseMultibuffer:=ReadBool('���������', 'bUseMultibuffer', DefaultValue_UseMultibuffer);
        ShowConfirmationAtQuit:=ReadBool('���������', 'bShowConfirmationAtQuit', DefaultValue_ShowConfirmationAtQuit);

        // ������� "��������� ������� ��������� ������"
        EnableLog:=ReadBool('����������������', 'bEnableLog', DefaultValue_EnableLog);
        FlushLogOnExit:=ReadBool('����������������', 'bFlushLogOnExit', DefaultValue_FlushLogOnExit);
        FlushLogOnStringsQuantity:=ReadBool('����������������', 'bFlushLogOnStringsQuantity', DefaultValue_FlushLogOnStringsQuantity);
        FlushLogOnStringsQuantityValue:=ReadInteger('����������������', 'iFlushLogOnStringsQuantityValue', DefaultValue_FlushLogOnStringsQuantityValue);
        FlushLogOnClearingLog:=ReadBool('����������������', 'bFlushLogOnClearingLog', DefaultValue_FlushLogOnClearingLog);
        FlushLogOnApply:=ReadBool('����������������', 'bFlushLogOnApply', DefaultValue_FlushLogOnApply);
        CustomLogClientFile:=ReadBool('����������������', 'bCustomLogClientFile', DefaultValue_CustomLogClientFile);
        CustomLogClientFileValue:=ReadString('����������������', 'sCustomLogClientFileValue', DefaultValue_CustomLogClientFileValue);
        if ReadBool('����������������', 'bKeepErrorLog', lmtError in DefaultValue_KeepLogTypes) then
          KeepLogTypes:=KeepLogTypes+[lmtError]
        else
          KeepLogTypes:=KeepLogTypes-[lmtError];
        if ReadBool('����������������', 'bKeepWarningLog', lmtWarning in DefaultValue_KeepLogTypes) then
          KeepLogTypes:=KeepLogTypes+[lmtWarning]
        else
          KeepLogTypes:=KeepLogTypes-[lmtWarning];
        if ReadBool('����������������', 'bKeepInfoLog', lmtInfo in DefaultValue_KeepLogTypes) then
          KeepLogTypes:=KeepLogTypes+[lmtInfo]
        else
          KeepLogTypes:=KeepLogTypes-[lmtInfo];
        if ReadBool('����������������', 'bKeepSQLLog', lmtSQL in DefaultValue_KeepLogTypes) then
          KeepLogTypes:=KeepLogTypes+[lmtSQL]
        else
          KeepLogTypes:=KeepLogTypes-[lmtSQL];
        if ReadBool('����������������', 'bKeepDebugLog', lmtDebug in DefaultValue_KeepLogTypes) then
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
        StoreLastLogin:=ReadBool('�������������', 'bStoreLastLogin', DefaultValue_StoreLastLogin);
        StoreLastPassword:=ReadBool('�������������', 'bStoreLastPassword', DefaultValue_StoreLastPassword);
        AutoLogon:=ReadBool('�������������', 'bAutoLogon', DefaultValue_AutoLogon);

        // ������� "����������� � ������� ���� ������ ������"
        with RNE4Server do
          begin
            Host:=ReadString('������ � ���� ������', 'RNE4Server.sHost', DefaultValue_RNE4Server_Host);
            Port:=ReadInteger('������ � ���� ������', 'RNE4Server.iPort', DefaultValue_RNE4Server_Port);
            Timeout:=ReadInteger('������ � ���� ������', 'RNE4Server.iTimeout', DefaultValue_RNE4Server_Timeout);
            Compression:=ReadBool('������ � ���� ������', 'RNE4Server.bCompression', DefaultValue_RNE4Server_Compression);
            Login:=ReadString('������ � ���� ������', 'RNE4Server.sLogin', DefaultValue_RNE4Server_Login);
            Password:=ReadString('������ � ���� ������', 'RNE4Server.sPassword', DefaultValue_RNE4Server_Password);
            Database:=ReadString('������ � ���� ������', 'RNE4Server.sDatabase', DefaultValue_RNE4Server_Database);
          end;

        // ������� "����������� � ������� ������� ������ �����������"
        with MessagesServer do
          begin
            Host:=ReadString('������ � ���� ������', 'MessagesServer.sHost', DefaultValue_MessagesServer_Host);
            Port:=ReadInteger('������ � ���� ������', 'MessagesServer.iPort', DefaultValue_MessagesServer_Port);
            Timeout:=ReadInteger('������ � ���� ������', 'MessagesServer.iTimeout', DefaultValue_MessagesServer_Timeout);
            Compression:=ReadBool('������ � ���� ������', 'MessagesServer.bCompression', DefaultValue_MessagesServer_Compression);
            Login:=ReadString('������ � ���� ������', 'MessagesServer.sLogin', DefaultValue_MessagesServer_Login);
            Password:=ReadString('������ � ���� ������', 'MessagesServer.sPassword', DefaultValue_MessagesServer_Password);
            Database:=ReadString('������ � ���� ������', 'MessagesServer.sDatabase', DefaultValue_MessagesServer_Database);
          end;

        // ������� "��������� ������������ �������"
        ReportFolder:=TReportFolders(ReadInteger('������������ �������', 'iReportFolder', integer(rfApplicationFolder)));
        CustomReportFolderValue:=ReadString('������������ �������', 'sCustomReportFolderValue', '');
        DontDemandOverwriteConfirmation:=ReadBool('������������ �������', 'bDontDemandOverwriteConfirmation', False);
        AskForFileName:=ReadBool('������������ �������', 'bAskForFileName', True);

        // ������� "��������� ������"
        LaunchAtStartup:=ReadBool('������', 'bLaunchAtStartup', DefaultValue_LaunchAtStartup);
        PlaySoundOnComplete:=ReadBool('������', 'bPlaySoundOnComplete', DefaultValue_PlaySoundOnComplete);
        EnableAutoGetMessages:=ReadBool('������', 'bEnableAutoGetMessages', DefaultValue_EnableAutoGetMessages);
        AutoGetMessagesCycleDuration:=ReadInteger('����������������', 'iAutoGetMessagesCycleDuration', DefaultValue_AutoGetMessagesCycleDuration);
        CustomHelpFile:=ReadBool('������', 'bCustomHelpFile', DefaultValue_CustomHelpFile);
        CustomHelpFileValue:=ReadString('������', 'sCustomHelpFileValue', DefaultValue_CustomHelpFileValue);

        // ������� "��������� �������� ����"
        with Rect do
          begin
            Left:=ReadInteger('������� ����', 'MainFormRect.iLeft', DefaultValue_MainFormRect_Left);
            Top:=ReadInteger('������� ����', 'MainFormRect.iTop', DefaultValue_MainFormRect_Top);
            Right:=ReadInteger('������� ����', 'MainFormRect.iRight', DefaultValue_MainFormRect_Right);
            Bottom:=ReadInteger('������� ����', 'MainFormRect.iBottom', DefaultValue_MainFormRect_Bottom);
            MainFormRect:=Rect;
          end;
        MainFormPositionByCenter:=ReadBool('������� ����', 'bMainFormPositionByCenter', DefaultValue_MainFormPositionByCenter);
        FullScreenAtLaunch:=ReadBool('������� ����', 'bFullScreenAtLaunch', DefaultValue_FullScreenAtLaunch);

        // ������� "��������� ����������� ����������"
        OrganizationPanelHeight:=ReadInteger('����������� ����������', 'iOrganizationPanelHeight', DefaultValue_OrganizationPanelHeight);
        OrganizationPanelHalfHeight:=ReadBool('����������� ����������', 'bOrganizationPanelHalfHeight', DefaultValue_OrganizationPanelHalfHeight);
        DataPanelWidth:=ReadInteger('����������� ����������', 'iDataPanelWidth', DefaultValue_DataPanelWidth);
        DataPanelHalfWidth:=ReadBool('����������� ����������', 'bOrganizationPanelHalfHeight', DefaultValue_DataPanelHalfWidth);
        ShowDataInOtherInfoPanel:=ReadBool('����������� ����������', 'bShowDataInOtherInfoPanel', DefaultValue_ShowDataInOtherInfoPanel);
        ShowMeasuresListAsRichEdit:=ReadBool('����������� ����������', 'bShowMeasuresListAsRichEdit', DefaultValue_ShowMeasuresListAsRichEdit);
        MarkSearchedStrings:=ReadBool('����������� ����������', 'bMarkSearchedStrings', DefaultValue_MarkSearchedStrings);
        PutTownAtTheEnd:=ReadBool('����������� ����������', 'bPutTownAtTheEnd', DefaultValue_PutTownAtTheEnd);
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
          WriteString('������������ �������', 'sCustomReportFolderValue', CustomReportFolderValue);
          WriteBool('������������ �������', 'bDontDemandOverwriteConfirmation', DontDemandOverwriteConfirmation);
          WriteBool('������������ �������', 'bAskForFileName', AskForFileName);

          // ������� "��������� ������"
          WriteBool('������', 'bLaunchAtStartup', LaunchAtStartup);
          WriteBool('������', 'bPlaySoundOnComplete', PlaySoundOnComplete);
          WriteBool('������', 'bEnableAutoGetMessages', EnableAutoGetMessages);
          WriteInteger('������', 'bAutoGetMessagesCycleDuration', AutoGetMessagesCycleDuration);
          WriteBool('������', 'bCustomHelpFile', CustomHelpFile);
          WriteString('������', 'bCustomHelpFileValue', CustomHelpFileValue);

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
  if ((FLoginFormPosition.bCenter<>Value.bCenter)or(FLoginFormPosition.x<>Value.x)or(FLoginFormPosition.y<>Value.y)) then
    FLoginFormPosition:=Value;
end;

procedure TConfiguration.SetMainFormPositionByCenter(const Value: boolean);
begin
  if FMainFormPositionByCenter<>Value then
    FMainFormPositionByCenter:=Value;
end;

procedure TConfiguration.SetMainFormRect(const Value: TRect);
begin
  if ((FMainFormRect.Left<>Value.Left)or(FMainFormRect.Top<>Value.Top)or(FMainFormRect.Right<>Value.Right)or(FMainFormRect.Bottom<>Value.Bottom)) then
    FMainFormRect:=Value;
end;

procedure TConfiguration.SetMaintenanceFormPosition(const Value: TFormPosition);
begin
  if ((FMaintenanceFormPosition.bCenter<>Value.bCenter)or(FMaintenanceFormPosition.x<>Value.x)or(FMaintenanceFormPosition.y<>Value.y)) then
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
  if ((FOptionsFormPosition.bCenter<>Value.bCenter)or(FOptionsFormPosition.x<>Value.x)or(FOptionsFormPosition.y<>Value.y)) then
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
  if ((FPhonesFormPosition.bCenter<>Value.bCenter)or(FPhonesFormPosition.x<>Value.x)or(FPhonesFormPosition.y<>Value.y)) then
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

procedure TConfiguration.SetCustomReportFolderValue(const Value: string);
begin
  if FCustomReportFolderValue<>Value then
    FCustomReportFolderValue:=Value;
end;

procedure TConfiguration.SetSetPasswordFormPosition(const Value: TFormPosition);
begin
  if ((FSetPasswordFormPosition.bCenter<>Value.bCenter)or(FSetPasswordFormPosition.x<>Value.x)or(FSetPasswordFormPosition.y<>Value.y)) then
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
  if ((FStatisticFormPosition.bCenter<>Value.bCenter)or(FStatisticFormPosition.x<>Value.x)or(FStatisticFormPosition.y<>Value.y)) then
    FStatisticFormPosition:=Value;
end;

procedure TConfiguration.SetUseMultibuffer(const Value: boolean);
begin
  if FUseMultibuffer<>Value then
    FUseMultibuffer:=Value;
end;

procedure TConfiguration.SetUsersFormPosition(const Value: TFormPosition);
begin
  if ((FUsersFormPosition.bCenter<>Value.bCenter)or(FUsersFormPosition.x<>Value.x)or(FUsersFormPosition.y<>Value.y)) then
    FUsersFormPosition:=Value;
end;

procedure TConfiguration.SetViewPostListFormPosition(const Value: TFormPosition);
begin
  if ((FViewPostListFormPosition.bCenter<>Value.bCenter)or(FViewPostListFormPosition.x<>Value.x)or(FViewPostListFormPosition.y<>Value.y)) then
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
      Result:=CustomReportFolderValue;
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
  if ((FAddEditPhoneFormPosition.bCenter<>Value.bCenter)or(FAddEditPhoneFormPosition.x<>Value.x)or(FAddEditPhoneFormPosition.y<>Value.y)) then
    FAddEditPhoneFormPosition:=Value;
end;

procedure TConfiguration.SetAddMassMsrFormPosition(const Value: TFormPosition);
begin
  if ((FAddMassMsrFormPosition.bCenter<>Value.bCenter)or(FAddMassMsrFormPosition.x<>Value.x)or(FAddMassMsrFormPosition.y<>Value.y)) then
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
  if ((FClearingFormPosition.bCenter<>Value.bCenter)or(FClearingFormPosition.x<>Value.x)or(FClearingFormPosition.y<>Value.y)) then
    FClearingFormPosition:=Value;
end;

procedure TConfiguration.SetCreateViewPostFormPosition(const Value: TFormPosition);
begin
  if ((FCreateViewPostFormPosition.bCenter<>Value.bCenter)or(FCreateViewPostFormPosition.x<>Value.x)or(FCreateViewPostFormPosition.y<>Value.y)) then
    FCreateViewPostFormPosition:=Value;
end;

procedure TConfiguration.SetCustomHelpFileValue(const Value: string);
begin
  if FCustomHelpFileValue<>Value then
    FCustomHelpFileValue:=Value;
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

procedure TConfiguration.SetCustomHelpFile(const Value: boolean);
begin
  if FCustomHelpFile<>Value then
    FCustomHelpFile:=Value;
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
  FShowAboutWindowAtLaunch:=DefaultValue_ShowAboutWindowAtLaunch;
  FShowToolbarAtLaunch:=DefaultValue_ShowToolbarAtLaunch;
  FShowStatusbarAtLaunch:=DefaultValue_ShowStatusbarAtLaunch;
  FShowEditboxHints:=DefaultValue_ShowEditboxHints;
  FShowCommonSearchEditbox:=DefaultValue_ShowCommonSearchEditbox;
  FShowID:=DefaultValue_ShowID;
  FUseMultibuffer:=DefaultValue_UseMultibuffer;
  FShowConfirmationAtQuit:=DefaultValue_ShowConfirmationAtQuit;

  // ������� "��������� ������� ��������� ������"
  FEnableLog:=DefaultValue_EnableLog;
  FKeepLogTypes:=DefaultValue_KeepLogTypes;
  FFlushLogOnExit:=DefaultValue_FlushLogOnExit;
  FFlushLogOnStringsQuantity:=DefaultValue_FlushLogOnStringsQuantity;
  FFlushLogOnStringsQuantityValue:=DefaultValue_FlushLogOnStringsQuantityValue;
  FFlushLogOnClearingLog:=DefaultValue_FlushLogOnClearingLog;
  FFlushLogOnApply:=DefaultValue_FlushLogOnApply;
  FCustomLogClientFile:=DefaultValue_CustomLogClientFile;
  FCustomLogClientFileValue:=DefaultValue_CustomLogClientFileValue;

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
  FStoreLastLogin:=DefaultValue_StoreLastLogin;
  FStoreLastPassword:=DefaultValue_StoreLastPassword;
  FAutoLogon:=DefaultValue_AutoLogon;

  // ������� "��������� ����������� � ������� ���� ������ ������"
  with FRNE4Server do
    begin
      Connected:=False;
      Connection:=nil;
      LogProvider:=nil;
      Host:=DefaultValue_RNE4Server_Host;
      Port:=DefaultValue_RNE4Server_Port;
      Timeout:=DefaultValue_RNE4Server_Timeout;
      Compression:=DefaultValue_RNE4Server_Compression;
      Login:=DefaultValue_RNE4Server_Login;
      Password:=DefaultValue_RNE4Server_Password;
      Database:=DefaultValue_RNE4Server_Database;
    end;

  // ������� "��������� ����������� � ������� ������� ������ �����������"
  with FMessagesServer do
    begin
      Connected:=False;
      Connection:=nil;
      LogProvider:=nil;
      Host:=DefaultValue_MessagesServer_Host;
      Port:=DefaultValue_MessagesServer_Port;
      Timeout:=DefaultValue_MessagesServer_Timeout;
      Compression:=DefaultValue_MessagesServer_Compression;
      Login:=DefaultValue_MessagesServer_Login;
      Password:=DefaultValue_MessagesServer_Password;
      Database:=DefaultValue_MessagesServer_Database;
    end;

  // ������� "��������� ������������ �������"
  FReportFolder:=DefaultValue_ReportFolder;
  FCustomReportFolderValue:=DefaultValue_CustomReportFolderValue;
  FDontDemandOverwriteConfirmation:=DefaultValue_DontDemandOverwriteConfirmation;
  AskForFileName:=DefaultValue_AskForFileName;

  // ������� "��������� ������"
  FLaunchAtStartup:=DefaultValue_LaunchAtStartup;
  FPlaySoundOnComplete:=DefaultValue_PlaySoundOnComplete;
  FEnableAutoGetMessages:=DefaultValue_EnableAutoGetMessages;
  FAutoGetMessagesCycleDuration:=DefaultValue_AutoGetMessagesCycleDuration;
  FCustomHelpFile:=DefaultValue_CustomHelpFile;
  FCustomHelpFileValue:=DefaultValue_CustomHelpFileValue;

  // ������� "��������� �������� ����"
  with FMainFormRect do
    begin
      Left:=DefaultValue_MainFormRect_Left;
      Top:=DefaultValue_MainFormRect_Top;
      Right:=DefaultValue_MainFormRect_Right;
      Bottom:=DefaultValue_MainFormRect_Bottom;
    end;
  FMainFormPositionByCenter:=DefaultValue_MainFormPositionByCenter;
  FFullScreenAtLaunch:=DefaultValue_FullScreenAtLaunch;

  // ������� "��������� ����������� ����������"
  FOrganizationPanelHeight:=DefaultValue_OrganizationPanelHeight;
  FOrganizationPanelHalfHeight:=DefaultValue_OrganizationPanelHalfHeight;
  FDataPanelWidth:=DefaultValue_DataPanelWidth;
  FDataPanelHalfWidth:=DefaultValue_DataPanelHalfWidth;
  FShowDataInOtherInfoPanel:=DefaultValue_ShowDataInOtherInfoPanel;
  FShowMeasuresListAsRichEdit:=DefaultValue_ShowMeasuresListAsRichEdit;
  FMarkSearchedStrings:=DefaultValue_MarkSearchedStrings;
  FPutTownAtTheEnd:=DefaultValue_PutTownAtTheEnd;
end;

end.
