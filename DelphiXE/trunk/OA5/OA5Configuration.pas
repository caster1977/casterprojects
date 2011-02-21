unit OA5Configuration;

interface

uses
  MySQLConnection;

type
  TConfiguration=class
    RNE4Server, MessagesServer: TMySQLConnection;
    // bAutoLogon, bStoreLastLogin, bStoreLastPassword: boolean;
    // sLastLogin, sLastPassword: string;
    //
    // sLocalHost: string;
    iConfigurationFormPage: integer; // ����� ��������� �������� �������� ���� ������������ ���������
    //
    // bAlwaysShowTrayIcon: boolean; // ������ ���������� ������ � ����
    // bShowQuitConfirmation: boolean;
    // bUseExternalLog: boolean;
    // sDefaultAction: string;
    // bNoStatusBar: boolean;
    // bScrollToLastLogMessage: boolean;
    // bAutorun: boolean;
    // bStartInTray: boolean;
    // bPlaySoundAfterAction: boolean;
    // bShowBaloonHintAfterAction: boolean;
    //
    // bKeepErrorLog: boolean; // ����� �� ����� ��� ��������� ���� error
    // bKeepWarningLog: boolean; // ����� �� ����� ��� ��������� ���� warning
    // bKeepInfoLog: boolean; // ����� �� ����� ��� ��������� ���� info
    // bKeepSQLLog: boolean; // ����� �� ����� ��� �������� MySQL
    // bKeepDebugLog: boolean; // ����� �� ����� ��� ���������� ����������
    // bFlushLogOnExit: boolean; // ��������� �� ���������� ���� � ���� ��� ������ �� ���������
    iFlushLogOnStringsQuantity: integer; // ��� ����� ���������� ����� ���� ��������� �� � ����
    iGetMessagesCycleDuration: integer; // ���������� �����, ����� ������� ����� ��������� ����� ���������
    // bFlushLogOnClearingLog: boolean; // ��������� �� ���������� ���� � ���� ��� ������� ����
    //
    // sApplicationFolder: string;
    // sTempFolder: string;
    // sCustomFolder: string;
    // trfReportFolder: TReportFolders;
    // bDontDemandOverwriteConfirmation: boolean;
    // bAskForFileName: boolean;

    // bNoLogo: boolean;
    // bShowID: boolean;
    // bDontShowQuitConfirmation: boolean;
    // bImmediatelyQuit: boolean;
    // bNoToolBar: boolean;
    // bShowDataInOtherInfoPanel: boolean;
    // bShowMeasuresListAsRichEdit: boolean;
    // bMarkSearchedStrings: boolean;
    // bPutTownAtTheEnd: boolean;
    // bHideEditBoxToolTips: boolean;
    // bShowSearchAddressOtherEditBox: boolean;
    // bUseMultibuffer: boolean;
    // bGetMessages: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;
    // bFullScreen: boolean;
    // fpMainForm: TFormPosition;
    // iMainFormWidth: integer;
    // iMainFormHeight: integer;
    // iOrgPanelHeight: integer;
    // bOrgPanelHalfHeight: boolean;
    // iDataPanelWidth: integer;
    // bDataPanelHalfWidth: boolean;
    // fpLoginForm: TFormPosition;
    // fpOptionsForm: TFormPosition;
    // fpUsersForm: TFormPosition;
    // fpSetPasswordForm: TFormPosition;
    // fpStatisticForm: TFormPosition;
    // fpMaintenanceForm: TFormPosition;
    // fpClearingForm: TFormPosition;
    // fpViewPostListForm: TFormPosition;
    // fpCreateViewPostForm: TFormPosition;
    // fpPhonesForm: TFormPosition;
    // fpAddEditPhoneForm: TFormPosition;
    // fpAddMassMsrForm: TFormPosition;
    //
    // sCustomHelpFile: string;
    // bUseLog: boolean;
    // sCustomLogClientFile: string;
  end;

implementation

{ TConfiguration }

end.
