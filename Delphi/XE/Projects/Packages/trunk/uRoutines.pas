unit uRoutines;

interface

uses
  Classes;

type
  Routines=class
  public
    class function GetLocalIP: string;
    class function GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string; static;
    class procedure CopyStringToClipboard(const Value: string); static;
    class procedure CutStringByLimiterToStringList(const Source: string; var Destination: TStringList; const Limiter: char); static;
    class procedure GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean); static;
    class function ValidatePhoneString(const Value: string): string; static;
    class function IsStringIsPhone(const aString: string): boolean; static;
    class procedure AddApplicationToRunKey(const RunName, ApplicationName: string); static;
    class procedure DeleteApplicationFromRunKey(const RunName: string); static;
    class function IsApplicationInRunKey(const RunName: string): Boolean; static;
  end;

implementation

uses
  Windows,
  WinSock,
  mysql,
  SysUtils,
  Clipbrd,
  Registry;

class function Routines.GetLocalIP: string;
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

class function Routines.GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string;
begin
  if Condition then
    Result:=TrueString
  else
    Result:=FalseString;
end;

class procedure Routines.CopyStringToClipboard(const Value: string);
begin
  ClipBoard.Clear;
  ClipBoard.SetTextBuf(PWideChar(Value));
end;

class procedure Routines.CutStringByLimiterToStringList(const Source: string; var Destination: TStringList; const Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  s:=Source;
  if Assigned(Destination) then
    Destination.Clear
  else
    Destination:=TStringList.Create;

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

class procedure Routines.GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean);
begin
  aErrorMessage:=aMessage;
  aErrorFlag:=True;
end;

class function Routines.ValidatePhoneString(const Value: string): string;
var
  s: string;
begin
  s:=Value;
  // замена символов на пробел
  while Pos(#09, s)>0 do
    s:=StringReplace(s, #09, ' ', [rfReplaceAll]);
  while Pos(',', s)>0 do
    s:=StringReplace(s, ',', ' ', [rfReplaceAll]);
  while Pos('.', s)>0 do
    s:=StringReplace(s, '.', ' ', [rfReplaceAll]);
  // замена символа звёздочки на процент
  while Pos('*', s)>0 do
    s:=StringReplace(s, '*', '%', [rfReplaceAll]);
  // удаление двойных пробелов
  while Pos('  ', s)>0 do
    s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
  // удаление граничных пробелов
  s:=Trim(s);
  Result:=s;
end;

class function Routines.IsStringIsPhone(const aString: string): boolean;
var
  b: boolean;
  aSL: TStringList;
  i: integer;
  s: string;
begin
  b:=True;
  s:=Routines.ValidatePhoneString(aString);

  if s='' then // если строка пуста - возращаем "false"
    b:=False;
  // проверка строки на наличие "лишних" символов
  for i:=1 to Length(s)-1 do
    if not CharInSet(s[i], ['0'..'9', ' ', '%', '_']) then
      b:=False;
  aSL:=TStringList.Create;
  try
    aSL.Duplicates:=dupIgnore;
    aSL.Sorted:=True;
    Routines.CutStringByLimiterToStringList(s, aSL, ' ');
    for i:=0 to aSL.Count-1 do
      if (Length(aSL[i])<3)or(Length(aSL[i])>12) then
        b:=False;
  finally
    aSl.Free;
  end;

  Result:=b;
end;

class procedure Routines.AddApplicationToRunKey(const RunName, ApplicationName: string);
begin
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      try
        WriteString(RunName, ApplicationName);
      except
        on ERegistryException do;
      end;
    finally
      CloseKey;
      Free;
    end;
end;

class function Routines.IsApplicationInRunKey(const RunName: string): Boolean;
begin
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False);
      Result:=ValueExists(RunName);
    finally
      CloseKey;
      Free;
    end;
end;

class procedure Routines.DeleteApplicationFromRunKey(const RunName: string);
begin
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      if ValueExists(RunName) then
        try
          DeleteValue(RunName);
        except
          on ERegistryException do;
        end;
    finally
      CloseKey;
      Free;
    end;
end;

end.
