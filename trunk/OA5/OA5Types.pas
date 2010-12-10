unit OA5Types;

interface

uses
  mysql;

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug); // типы сообщений передаваемых в лог

  TMySQLServerConnectionDetails=record
    bConnected: boolean;
    hConnection: PMYSQL;
    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: string;
  end;

implementation

end.
