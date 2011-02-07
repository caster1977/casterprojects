unit OA5Types;

interface

uses
  mysql;

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug); // ���� ��������� ������������ � ���
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);

  TMySQLServerConnectionDetails=record
    bConnected: boolean;
    hConnection: PMYSQL;
    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLUser: string;
    sMySQLPassword: string;
    sMySQLDatabase: string;
  end;


  TUserRec=record
    bLogged: boolean;
    sID: string;
    sLogin: string;
    sPassword: string;
    sFullName: string;
//    sPosition: string;
//    sContactPhone: string;
    bIsAdmin: boolean;
//    bDBEdition: boolean;
//    bDBBackup: boolean;
//    bDBCleaning: boolean;
//    bDBDefragmentation: boolean;
//    bDBMaintenance: boolean;
//    bDBUsersEdition: boolean;
  end;

  TConfigurationRec=record
    RNE4Server, MessagesServer: TMySQLServerConnectionDetails;

//    bAutoLogon, bStoreLastLogin, bStoreLastPassword: boolean;
//    sLastLogin, sLastPassword: string;
//
//    sLocalHost: string;
    iConfigurationFormPage: integer; // ����� ��������� �������� �������� ���� ������������ ���������
//
//    bAlwaysShowTrayIcon: boolean; // ������ ���������� ������ � ����
//    bShowQuitConfirmation: boolean;
//    bUseExternalLog: boolean;
//    sDefaultAction: string;
//    bNoStatusBar: boolean;
//    bScrollToLastLogMessage: boolean;
//    bAutorun: boolean;
//    bStartInTray: boolean;
//    bPlaySoundAfterAction: boolean;
//    bShowBaloonHintAfterAction: boolean;
//
//    bKeepErrorLog: boolean; // ����� �� ����� ��� ��������� ���� error
//    bKeepWarningLog: boolean; // ����� �� ����� ��� ��������� ���� warning
//    bKeepInfoLog: boolean; // ����� �� ����� ��� ��������� ���� info
//    bKeepSQLLog: boolean; // ����� �� ����� ��� �������� MySQL
//    bKeepDebugLog: boolean; // ����� �� ����� ��� ���������� ����������
//    bFlushLogOnExit: boolean; // ��������� �� ���������� ���� � ���� ��� ������ �� ���������
    iFlushLogOnStringsQuantity: integer; // ��� ����� ���������� ����� ���� ��������� �� � ����
//    bFlushLogOnClearingLog: boolean; // ��������� �� ���������� ���� � ���� ��� ������� ����
//
//    sApplicationFolder: string;
//    sTempFolder: string;
//    sCustomFolder: string;
//    trfReportFolder: TReportFolders;
//    bDontDemandOverwriteConfirmation: boolean;
//    bAskForFileName: boolean;

//    bNoLogo: boolean;
//    bShowID: boolean;
//    bDontShowQuitConfirmation: boolean;
//    bImmediatelyQuit: boolean;
//    bNoToolBar: boolean;
//    bShowDataInOtherInfoPanel: boolean;
//    bShowMeasuresListAsRichEdit: boolean;
//    bMarkSearchedStrings: boolean;
//    bPutTownAtTheEnd: boolean;
//    bHideEditBoxToolTips: boolean;
//    bShowSearchAddressOtherEditBox: boolean;
//    bUseMultibuffer: boolean;
//    bGetMessages: boolean;
//    iGetMessagesCycleDuration: integer;
//    iOrgSortColumn: integer;
//    iMsrSortColumn: integer;
//    bFullScreen: boolean;
//    fpMainForm: TFormPosition;
//    iMainFormWidth: integer;
//    iMainFormHeight: integer;
//    iOrgPanelHeight: integer;
//    bOrgPanelHalfHeight: boolean;
//    iDataPanelWidth: integer;
//    bDataPanelHalfWidth: boolean;
//    fpLoginForm: TFormPosition;
//    fpOptionsForm: TFormPosition;
//    fpUsersForm: TFormPosition;
//    fpSetPasswordForm: TFormPosition;
//    fpStatisticForm: TFormPosition;
//    fpMaintenanceForm: TFormPosition;
//    fpClearingForm: TFormPosition;
//    fpViewPostListForm: TFormPosition;
//    fpCreateViewPostForm: TFormPosition;
//    fpPhonesForm: TFormPosition;
//    fpAddEditPhoneForm: TFormPosition;
//    fpAddMassMsrForm: TFormPosition;
//
//    sCustomHelpFile: string;
//    bUseLog: boolean;
//    sCustomLogClientFile: string;
  end;

implementation

end.
