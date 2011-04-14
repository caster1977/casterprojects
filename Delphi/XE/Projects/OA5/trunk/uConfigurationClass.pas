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
    FEnableFlushLogOnStringsQuantity: boolean; // ���������� �������� ������ � ��������� ���� ��� ���������� ���������� �����
    FFlushLogOnStringsQuantity: integer; // ���������� �������� ������ � ��������� ���� ��� ���������� ���������� ����� (��������������� ����������)
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
    FAutoLogon: boolean; // ��������� �������������� ����, ��������� ����������� ����� � ������ ������������

    // ������� "��������� ����������� � ������� ���� ������ ������"

    // ������� "��������� ����������� � ������� ������� ������ �����������"

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
    FOrganizationPanelHeight: word; // ������ ������ �����������
    FOrganizationPanelHalfHeight: boolean; // �������� ������ ����
    FDataPanelWidth: word; // ������ ������ ������
    FDataPanelHalfWidth: boolean; // �������� ������ ����
    FShowDataInOtherInfoPanel: boolean; // � ������ ��������� ���������� ������ � ���� ������ ����������
    FShowMeasuresListAsRichEdit: boolean; // � ������ ��������� ���������� ���������� � ����� ���c��
    FMarkSearchedStrings: boolean; // � ������ ��������� �������� ������� ��������� �����
    FPutTownAtTheEnd: boolean; // ��������� �������� ������ � ����� ������ ������

    FLastLogin: string;
    FLastPassword: string;

    procedure SetUseLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    function GetTempFolder: string;
    function GetApplicationFolder: string;
    function GetReportFolder: string;
  public
    RNE4Server, MessagesServer: TMySQLConnection;
    //
    iConfigurationFormPage: integer; // ����� ��������� �������� �������� ���� ������������ ���������
    //
    // sDefaultAction: string;
    // sApplicationFolder: string;
    // sTempFolder: string;
    // sCustomFolder: string;
    // trfReportFolder: TReportFolders;
    // bImmediatelyQuit: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;
    // bFullScreen: boolean;
  public
    property UseLog: boolean read FUseLog write SetUseLog default True; // ����� �� ����� ��� ������ ���������
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError,lmtWarning,lmtInfo];

    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // ����� �� ������� ��������� �������� �����
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // ����� �� ������� ��������� �������� ������
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // ����� �� ��������� ���������������

    property LastLogin: string read FLastLogin;
    property LastPassword: string read FLastPassword;

    property ReportFolder: string read GetReportFolder stored False;
    property FlushLogOnStringsQuantity: integer read FFlushLogOnStringsQuantity write FFlushLogOnStringsQuantity;
    property AutoGetMessagesCycleDuration: integer read FAutoGetMessagesCycleDuration write FAutoGetMessagesCycleDuration;

  end;

implementation

uses
  SysUtils, Windows, Forms;

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

function TConfiguration.GetReportFolder: string;
begin
  case FReportFolder of
    rfTempFolder: GetReportFolder:=GetTempFolder;
    rfApplicationFolder: GetReportFolder:=GetApplicationFolder;
    rfCustomFolder: GetReportFolder:=FSelectedReportFolder;
  end;
end;

function TConfiguration.GetApplicationFolder: string;
var
  s, sErrorMessage: string;
  bError: boolean;
begin
  bError:=False;
  GetApplicationFolder:='';

  s:=ExtractFilePath(ExpandFileName(Application.ExeName));
  if DirectoryExists(s) then
      GetApplicationFolder:=s
  else
    raise Exception.Create('�������� ������ ��� ������� ��������� ���� ������� ����� ���������!')
end;

function TConfiguration.GetTempFolder: string;
var
  sErrorMessage: string;
  bError: boolean;
  r: cardinal;
  TempPathNameBuffer: PWideChar;
begin
  bError:=False;
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

end.
