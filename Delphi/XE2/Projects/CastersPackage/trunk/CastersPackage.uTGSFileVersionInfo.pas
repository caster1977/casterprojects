unit CastersPackage.uTGSFileVersionInfo;

// **! ------------------------------------------------------------------
// **! This unit is a part of GSPackage project (Gregory Sitnin's Delphi
// **! Components Package).
// **! ------------------------------------------------------------------
// **! You may use or redistribute this unit for your purposes while
// **! unit's code and this copyright notice is unchanged and exists.
// **! ------------------------------------------------------------------
// **! (c) Gregory Sitnin, 2001-2002. All rights reserved.
// **! ------------------------------------------------------------------

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes;

type
  ModuleVersionInfo = packed record
    Major: Word;
    Minor: Word;
    Release: Word;
    Build: Word;
  end;

  TGSFileVersionInfo = class(TComponent)
  strict private
    FFilename: TFilename;
    FVersionInfoSize: Cardinal;
    FFileVersion: string;
    FFileDescription: string;
    FInternalName: string;
    FOriginalFilename: string;
    FCompanyName: string;
    FProductVersion: string;
    FProductName: string;
    FLegalCopyright: string;
    FLanguageInfo: string;
    FComments: string;
    procedure SetFilename(const AValue: TFilename);
    function GetModuleVersion: ModuleVersionInfo;
    procedure GetModuleVersionInfo(out AMajor, AMinor, ARelease, ABuild: Word);
    procedure ClearFields;
    procedure LoadFromFile;
  protected
    property VersionInfoSize: Cardinal read FVersionInfoSize;
    procedure Loaded; override;
    function GetBuildOnly: string;
  public
    constructor Create(AOwner: TComponent); override;
    property LanguageInfo: string read FLanguageInfo stored False;
    property CompanyName: string read FCompanyName stored False;
    property FileDescription: string read FFileDescription stored False;
    property FileVersion: string read FFileVersion stored False;
    property InternalName: string read FInternalName stored False;
    property LegalCopyright: string read FLegalCopyright stored False;
    property OriginalFilename: string read FOriginalFilename stored False;
    property ProductName: string read FProductName stored False;
    property ProductVersion: string read FProductVersion stored False;
    property Comments: string read FComments stored False;
    property ModuleVersion: ModuleVersionInfo read GetModuleVersion stored False;
  published
    property Filename: TFilename read FFilename write SetFilename;
  end;

procedure register;

implementation

uses
  Vcl.Dialogs,
  Vcl.Forms;

const
  QUERY_VALUE = '\VarFileInfo\Translation';
  STRING_FILE_INFO = '\StringFileInfo\%s\%s';
  COMPANY_NAME = 'CompanyName';
  FILE_DESCRIPTION = 'FileDescription';
  FILE_VERSION = 'FileVersion';
  INTERNAL_NAME = 'InternalName';
  LEGAL_COPYRIGHT = 'LegalCopyright';
  ORIGINAL_FILE_NAME = 'OriginalFilename';
  PRODUCT_NAME = 'ProductName';
  PRODUCT_VERSION = 'ProductVersion';
  Comments = 'Comments';
  DELIMITER = '.';
  COMPONENTS_PAGE = 'CasterComponents';

resourcestring
  RsFileNotFound = 'File not found: %s.';
  RsInvalidVersionInfo = 'Invalid version info record in file %s.';
  RsInvalidLanguageInfo = 'Invalid language info in file %s.';
  RsNotAvailable = 'n/a';

procedure register;
begin
  RegisterComponents(COMPONENTS_PAGE, [TGSFileVersionInfo]);
end;

function TGSFileVersionInfo.GetModuleVersion: ModuleVersionInfo;
begin
  GetModuleVersionInfo(Result.Major, Result.Minor, Result.Release, Result.Build);
end;

procedure TGSFileVersionInfo.GetModuleVersionInfo(out AMajor, AMinor, ARelease, ABuild: Word);
const
  Minor = 0;
  MAYOR = 1;
  Build = 2;
  Release = 3;
type
  TV = array [0 .. 3] of SmallInt;
var
  HR: HRSRC;
  H: THandle;
  C: ^TV;

begin
  HR := FindResource(MainInstance, '#1', rt_Version);
  H := LoadResource(MainInstance, HR);
  Integer(C) := Integer(LockResource(H)) + 48;
  AMajor := Word(C[MAYOR]);
  AMinor := Word(C[Minor]);
  ARelease := Word(C[Release]);
  ABuild := Word(C[Build]);
  UnlockResource(H);
  FreeResource(H);
end;

procedure TGSFileVersionInfo.ClearFields;
begin
  FVersionInfoSize := 0;
  FCompanyName := EmptyStr;
  FFileDescription := EmptyStr;
  FFileVersion := EmptyStr;
  FInternalName := EmptyStr;
  FLegalCopyright := EmptyStr;
  FOriginalFilename := EmptyStr;
  FProductName := EmptyStr;
  FProductVersion := EmptyStr;
  FComments := EmptyStr;
end;

constructor TGSFileVersionInfo.Create(AOwner: TComponent);
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    FFilename := Application.ExeName;
  end;
end;

function TGSFileVersionInfo.GetBuildOnly: string;
var
  p: Integer;
  s: string;
begin
  s := FileVersion;
  p := LastDelimiter(DELIMITER, s);
  Result := Copy(s, p + 1, length(s) - p);
end;

procedure TGSFileVersionInfo.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    LoadFromFile;
  end;
end;

procedure TGSFileVersionInfo.LoadFromFile;
var
  VISize: Cardinal;
  VIBuff: Pointer;
  trans: Pointer;
  buffsize: Cardinal;
  temp: Integer;
  str: PChar;
  LangCharSet: string;

  function GetStringValue(const AFrom: string): string;
  begin
    VerQueryValue(VIBuff, PChar(Format(STRING_FILE_INFO, [LanguageInfo, AFrom])), Pointer(str),
      buffsize);
    if buffsize = 0 then
    begin
      Result := RsNotAvailable;
    end
    else
    begin
      Result := str;
    end;
  end;

begin
  ClearFields;
  VIBuff := nil;
  if not FileExists(Filename) then
  begin
    raise EFilerError.Create(Format(RsFileNotFound, [Filename]));
  end;
  VISize := GetFileVersionInfoSize(PChar(Filename), buffsize);
  FVersionInfoSize := VISize;
  if VISize < 1 then
  begin
    raise EReadError.Create(Format(RsInvalidVersionInfo, [Filename]));
  end;
  VIBuff := AllocMem(VISize);
  GetFileVersionInfo(PChar(Filename), Cardinal(0), VISize, VIBuff);

  VerQueryValue(VIBuff, QUERY_VALUE, trans, buffsize);
  if buffsize >= 4 then
  begin
    temp := 0;
    StrLCopy(@temp, PChar(trans), 2 div SizeOf(char));
    LangCharSet := IntToHex(temp, 4);
    StrLCopy(@temp, PChar(trans) + 2 div SizeOf(char), 2 div SizeOf(char));
    FLanguageInfo := LangCharSet + IntToHex(temp, 4);
  end
  else
  begin
    raise EReadError.Create(Format(RsInvalidLanguageInfo, [Filename]));
  end;

  FCompanyName := GetStringValue(COMPANY_NAME);
  FFileDescription := GetStringValue(FILE_DESCRIPTION);
  FFileVersion := GetStringValue(FILE_VERSION);
  FInternalName := GetStringValue(INTERNAL_NAME);
  FLegalCopyright := GetStringValue(LEGAL_COPYRIGHT);
  FOriginalFilename := GetStringValue(ORIGINAL_FILE_NAME);
  FProductName := GetStringValue(PRODUCT_NAME);
  FProductVersion := GetStringValue(PRODUCT_VERSION);
  FComments := GetStringValue(Comments);

  FreeMem(VIBuff, VISize);
end;

procedure TGSFileVersionInfo.SetFilename(const AValue: TFilename);
var
  s: string;
begin
  s := Trim(AValue);
  if FFilename <> s then
  begin
    FFilename := s;
    LoadFromFile;
  end;
end;

end.
