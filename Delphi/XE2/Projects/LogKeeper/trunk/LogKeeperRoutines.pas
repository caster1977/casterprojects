unit LogKeeperRoutines;

interface

uses
  LogKeeperTypes,
  Classes;

procedure Routines_GenerateError(const aMessage: string; var aErrorMessage: string; var aErrorFlag: boolean);
function Routines_GetMySQLErrorInfo(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails): string;
function Routines_GetConditionalMessage(const Condition: Boolean; TrueMessage, FalseMessage: string): string;
procedure Routines_CopyStringToClipboard(const Value: string);
function Routines_GetLocalIP: string;
procedure Routines_CutStringByLimiterToStringList(const Source: string; var Destination: TStringList; const Limiter: char);
function Routines_NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): string;

implementation

uses
  mysql,
  SysUtils,
  Clipbrd,
  WinSock;

procedure Routines_GenerateError(const aMessage: string; var aErrorMessage: string; var aErrorFlag: boolean);
begin
  aErrorMessage:=aMessage;
  aErrorFlag:=True;
end;

function Routines_GetMySQLErrorInfo(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails): string;
begin
  Result:=Routines_GetConditionalMessage(mysql_errno(aTMySQLServerConnectionDetails.hConnection)<>0,
    #10#13+#10#13+'Код ошибки: '+#10#13+IntToStr(mysql_errno(aTMySQLServerConnectionDetails.hConnection))+#10#13+#10#13+'Наименование ошибки: '+#10#13+string(mysql_error(aTMySQLServerConnectionDetails.hConnection)), '');
end;

function Routines_GetConditionalMessage(const Condition: Boolean; TrueMessage, FalseMessage: string): string;
begin
  if Condition then
    Result:=TrueMessage
  else
    Result:=FalseMessage;
end;

procedure Routines_CopyStringToClipboard(const Value: string);
begin
  ClipBoard.Clear;
  ClipBoard.SetTextBuf(PWideChar(Value));
end;

function Routines_GetLocalIP: string;
const
  WSVer=$101;
var
  wsaData: TWSAData;
  P: PHostEnt;
  Buf: array [0..127] of Char;
begin
  Result:='';
  if WSAStartup(WSVer, wsaData)=0 then
    begin
      if GetHostName(@Buf, 128)=0 then
        begin
          P:=GetHostByName(@Buf);
          if P<>nil then
            Result:=string(iNet_ntoa(PInAddr(p^.h_addr_list^)^));
        end;
      WSACleanup;
    end;
end;

procedure Routines_CutStringByLimiterToStringList(const Source: string; var Destination: TStringList; const Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  s:=Source;
  if Destination=nil then
    Destination:=TStringList.Create
  else
    Destination.Clear;
  Destination.Sorted:=False;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter, s);
      if i=0 then
        begin
          Destination.Add(s);
          Exit;
        end
      else
        begin
          s1:=Copy(s, 0, i-1);
          Destination.Append(s1);
          s1:=Copy(s, i+1, Length(s));
          s:=s1;
        end;
    end;
end;

function Routines_NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): string;
var
  z: PAnsiChar;
begin
  Routines_NormalizeStringForQuery:='';
  if ((ReturnNull)and(Trim(Source)='')) then
    Routines_NormalizeStringForQuery:='NULL'
  else
    begin
      z:=GetMemory(Length(PAnsiChar(AnsiString(Source)))*2+1);
      try
        mysql_escape_string(z, PAnsiChar(AnsiString(Source)), Length(PAnsiChar(AnsiString(Source))));
        if AddCommas then
          Routines_NormalizeStringForQuery:='"'+string(StrPas(z))+'"'
        else
          Routines_NormalizeStringForQuery:=string(StrPas(z));
      finally
        if z<>nil then
          FreeMemory(z);
      end;
    end;
end;

end.
