unit DBUServerService.uDBUServerUtils;

interface

function GetAppConfigFolder: string;
function GetAppLogFolder: string;
function GetFirstFreeDbUpdateNumber(const ADBType: string; const AReservUpdateCount: Integer = 1): Integer;
function GetDatabaseTypesFileName: string;
function GetLogFileName: string;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  System.IniFiles;

const
  CONST_COMMON = 'COMMON';
  CONST_LAST_DB_UPDATE_NUMBER = 'LastDbUpdateNumber';

function GetAppConfigFolder: string;
begin
  Result := Format('%sConfig\', [ExtractFilePath(Application.ExeName)]);
end;

function GetAppLogFolder: string;
begin
  Result := Format('%sLog\', [ExtractFilePath(Application.ExeName)]);
end;

function BuildDbIniFileName(const ADBType: string): string;
begin
  Result := Format('%s%s.ini', [GetAppConfigFolder, ADBType]);
end;

function GetDatabaseTypesFileName: string;
begin
  Result := Format('%sDatabaseTypes.lst', [GetAppConfigFolder]);
end;

function GetFirstFreeDbUpdateNumber(const ADBType: string; const AReservUpdateCount: Integer = 1): Integer;
var
  s: string;
  ini_file: TIniFile;
begin
  s := BuildDbIniFileName(ADBType);
  ini_file := TIniFile.Create(s);
  try
    if FileExists(s) then
    begin
      Result := ini_file.ReadInteger(CONST_COMMON, CONST_LAST_DB_UPDATE_NUMBER, 1000);
    end
    else
    begin
      Result := 1000;
      ForceDirectories(ExtractFilePath(s));
    end;
    ini_file.WriteInteger(CONST_COMMON, CONST_LAST_DB_UPDATE_NUMBER, Result + AReservUpdateCount);
  finally
    ini_file.Free;
  end;
end;

function GetLogFileName: string;
var
  s: string;
  y, m, d: Word;
begin
  DecodeDate(Now, y, m, d);
  s := Format('_%.2d_%.2d_%.2d', [y, m, d]);
  Result := GetAppLogFolder + ChangeFileExt(ExtractFileName(Application.ExeName), s + '.log');
end;

end.
