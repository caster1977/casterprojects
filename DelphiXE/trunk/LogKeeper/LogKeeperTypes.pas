unit LogKeeperTypes;

interface

uses
  mysql;

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug); // ���� ��������� ������������ � ���

  TMySQLServerConnectionDetails= record
    bConnected: boolean;
    hConnection: PMYSQL;
    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: string;
    sMySQLUser: AnsiString; // ��� ������������ ��� ����������� � ���� MySQL-�������
    sMySQLPassword: AnsiString; // ������ ������������ ��� ����������� � ���� MySQL-�������
  end;

  // ���� ��������� ������������ � ���
  TConfigurationRec= record
    LogServer: TMySQLServerConnectionDetails;

    bInterraptionInitiated: boolean; // ���� �� ������������ ���������� ������ ���������
    wExitCicleCounter: word; // ������� ������ �������� ����� ������� �� ���������
    sLocalHost: string; // ��� ���������� �����
    sCustomHelpFile: string; // ��� ���������� ����� �������
    bNoStatusBar: boolean; // ��������� ������ �������
    bFullScreen: boolean; // ��������� �� ���� � ����������������� ���������
    iMainFormHeight: integer; // ������������� ������ �������� ����
    bBottomMainFormAlignment: boolean; // ����������� �� ������������ � ���� (True) ��� � ����� (False) ��������
    bAlwaysShowTrayIcon: boolean; // ������ ���������� ������ � ����
    bKeepErrorLog: boolean; // ����� �� ����� ��� ��������� ���� error
    bKeepWarningLog: boolean; // ����� �� ����� ��� ��������� ���� warning
    bKeepInfoLog: boolean; // ����� �� ����� ��� ��������� ���� info
    bKeepSQLLog: boolean; // ����� �� ����� ��� �������� MySQL
    bKeepDebugLog: boolean; // ����� �� ����� ��� ���������� ����������
    bFlushLogOnExit: boolean; // ��������� �� ���������� ���� � ���� ��� ������ �� ���������
    iFlushLogOnStringsQuantity: integer; // ��� ����� ���������� ����� ���� ��������� �� � ����
    bFlushLogOnClearingLog: boolean; // ��������� �� ���������� ���� � ���� ��� ������� ����
    bShowBaloonHintAfterAction: boolean;
    bScrollToLastLogMessage: boolean;
  end;

implementation

end.
