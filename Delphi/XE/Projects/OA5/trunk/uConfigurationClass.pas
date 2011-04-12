unit uConfigurationClass;

interface

uses
  uMySQLConnectionClass, LogKeeperData, Types;

type
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);

  TConfiguration=class
  type
    TFormPosition= record
      bCenter: boolean;
      x, y: integer;
    end;
  strict private
    // ������� "��������� ����������"
    FShowAboutWindowAtLaunch: boolean; // ���������� ���� "� ���������..." ��� �������
    FShowToolbarAtLaunch: boolean; // ���������� ������ ������ ��� ������� ���������
    FShowStatusbarAtLaunch: boolean; // ���������� ������ ������� ��� ������� ���������
    FShowEditboxHints: boolean; // ���������� ����������� ��������� ��� ����� �����
    FShowCommonSearchEditbox: boolean; // ���������� ������ ���� ����� ��� ������ ������
    FShowID: boolean; // ���������� ���� ID ������� ���� ������ ��� ������ ���������
    FUseMultibuffer: boolean; // ������������ ����������� ��� �������� ����������� �����������
    FShowConfirmationOnQuit: boolean; // ��������� ������������� ��� ������ �� ���������

    // ������� "��������� ������� ��������� ������"
    FUseLog: boolean; // ����� ��� ������ ���������
    FKeepLogTypes: TLogMessagesTypes; // �������� ��������� ������������� �����
    FFlushLogOnExit: boolean; // ���������� �������� ������ � ��������� ���� ��� ���������� ������ ���������
    FFlushLogOnStrings: boolean; // ���������� �������� ������ � ��������� ���� ��� ���������� ���������� �����
    FFlushLogOnStringsQuantity: word; // ���������� �������� ������ � ��������� ���� ��� ���������� ���������� ����� (��������������� ����������)
    FFlushLogOnClearingLog: boolean; // ���������� �������� ������ � ��������� ���� ��� �������� ������� ���������
    FFlushLogOnApply: boolean; // ���������� �������� ������ � ��������� ���� ��� ������� ������ "���������"
    FCustomLogClientFile: boolean; // ������������ ������� ������ ����������������
    FCustomLogClientFileName: string; // ��� ����� �������� ������� ����������������

    // ������� "��������� ��������� ���������� ����"
    FMainFormPosition,
    FLoginFormPosition,
    FOptionsFormPosition,
    FUsersFormPosition,
    FSetPasswordFormPosition,
    FStatisticFormPosition,
    FMaintenanceFormPosition,
    FClearingFormPosition,
    FViewPostListFormPosition,
    FCreateViewPostFormPosition,
    FPhonesFormPosition,
    FAddEditPhoneFormPosition,
    FAddMassMsrFormPosition: TFormPosition;

    // ������� "��������� ��������� �����������"
    FStoreLastLogin: boolean; // ��������� ����� ���������� ������������
    FStoreLastPassword: boolean; // ��������� ������ ���������� ������������
    FAutoLogon: boolean; // ��������� �������������� ����, ��������� ���������� ����� � ������ ������������

    // ������� "��������� ����������� � ������� ���� ������ ������"

    // ������� "��������� ����������� � ������� ������� ������ �����������"

    // ������� "��������� ������������ �������"
    FReportFolder: TReportFolders; //
    FSelectedReportFolder: string; //
    FDontDemandOverwriteConfirmation: boolean; //
    FAskForFileName: boolean; //

    // ������� "��������� ������ ����������"

    // ������� "��������� ������

    // ������� "��������� �������� ����
    FMainFormWidth: TPoint;
    FMainFormWidth: integer;
    FMainFormHeight: integer;

    // ������� "��������� ����������� ����������

    procedure SetUseLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
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

    // iOrgPanelHeight: integer;
    // bOrgPanelHalfHeight: boolean;
    // iDataPanelWidth: integer;
    // bDataPanelHalfWidth: boolean;
  public
    property UseLog: boolean read FUseLog write SetUseLog default True; // ����� �� ����� ��� ������ ���������
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError,lmtWarning,lmtInfo];

    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // ����� �� ������� ��������� �������� �����
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // ����� �� ������� ��������� �������� ������
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // ����� �� ��������� ���������������
  end;

implementation

uses
  SysUtils;

procedure TConfiguration.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes := Value;
end;

procedure TConfiguration.SetUseLog(const Value: boolean);
begin
  if FUseLog<>Value then
    FUseLog:=Value;
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
