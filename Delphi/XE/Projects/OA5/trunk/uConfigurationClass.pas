unit uConfigurationClass;

interface

uses
  uMySQLConnectionClass;

type
  TConfiguration=class
  strict private
    FUseLog: boolean; // ����� �� ����� ��� ������ ���������
    FKeepErrorLog: boolean; // ����� �� ����� ��� ��������� ���� error
    FKeepWarningLog: boolean; // ����� �� ����� ��� ��������� ���� warning
    FKeepInfoLog: boolean; // ����� �� ����� ��� ��������� ���� info
    FKeepSQLLog: boolean; // ����� �� ����� ��� �������� MySQL
    FKeepDebugLog: boolean; // ����� �� ����� ��� ���������� ����������
    FStoreLastLogin: boolean; // ����� �� ������� ��������� �������� �����
    FStoreLastPassword: boolean; // ����� �� ������� ��������� �������� ������
    FAutoLogon: boolean; // ����� �� ��������� ���������������
    procedure SetKeepErrorLog(const Value: boolean);
    procedure SetUseLog(const Value: boolean);
    procedure SetKeepDebugLog(const Value: boolean);
    procedure SetKeepInfoLog(const Value: boolean);
    procedure SetKeepSQLLog(const Value: boolean);
    procedure SetKeepWarningLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
  public
    RNE4Server, MessagesServer: TMySQLConnection;
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
    // sCustomLogClientFile: string;
  public
    property UseLog: boolean read FUseLog write SetUseLog default True; // ����� �� ����� ��� ������ ���������
    property KeepErrorLog: boolean read FKeepErrorLog write SetKeepErrorLog default True; // ����� �� ����� ��� ��������� ���� error
    property KeepWarningLog: boolean read FKeepWarningLog write SetKeepWarningLog default True; // ����� �� ����� ��� ��������� ���� warning
    property KeepInfoLog: boolean read FKeepInfoLog write SetKeepInfoLog default True; // ����� �� ����� ��� ��������� ���� info
    property KeepSQLLog: boolean read FKeepSQLLog write SetKeepSQLLog default False; // ����� �� ����� ��� �������� MySQL
    property KeepDebugLog: boolean read FKeepDebugLog write SetKeepDebugLog default False; // ����� �� ����� ��� ���������� ����������

    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // ����� �� ������� ��������� �������� �����
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // ����� �� ������� ��������� �������� ������
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // ����� �� ��������� ���������������
  end;

implementation

uses
  SysUtils;

procedure TConfiguration.SetKeepInfoLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('��� ��������� �������� �������������� ��������� ���������� ������� �������� ���������������� ������ ���������!')
  else
    FKeepInfoLog:=Value;
end;

procedure TConfiguration.SetKeepSQLLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('��� ��������� �������� ������ �������� MySQL ���������� ������� �������� ���������������� ������ ���������!')
  else
    FKeepSQLLog:=Value;
end;

procedure TConfiguration.SetKeepWarningLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('��� ��������� �������� �������������� ���������� ������� �������� ���������������� ������ ���������!')
  else
    FKeepWarningLog:=Value;
end;

procedure TConfiguration.SetUseLog(const Value: boolean);
begin
  FUseLog:=Value;
  KeepErrorLog:=False;
  KeepWarningLog:=False;
  KeepInfoLog:=False;
  KeepSQLLog:=False;
  KeepDebugLog:=False;
end;

procedure TConfiguration.SetKeepDebugLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('��� ��������� �������� ���������� ��������� ���������� ������� �������� ���������������� ������ ���������!')
  else
    FKeepDebugLog:=Value;
end;

procedure TConfiguration.SetKeepErrorLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('��� ��������� �������� ��������� �� ������� ���������� ������� �������� ���������������� ������ ���������!')
  else
    FKeepErrorLog:=Value;
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

end.
