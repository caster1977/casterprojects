unit CastersPackage.getFVI;

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
  ModuleVersionInfo = record
    Major, Minor, Release, Build: word;
  end;

  TgsFileVersionInfo=class(TComponent)
  strict private
    FFilename: TFilename;
    FVersionInfoSize: cardinal;
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
    procedure SetFilename(const Value: TFilename);
    function GetModuleVersion: ModuleVersionInfo;
    procedure GetModuleVersionInfo(out Major, Minor, Release, Build: word);
  protected
    property VersionInfoSize: cardinal read FVersionInfoSize;
    procedure LoadFromFile;
    procedure ClearAll;
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
  dialogs,
  Forms;

procedure register;
begin
  RegisterComponents('CasterComponents', [TgsFileVersionInfo]);
end;

function TgsFileVersionInfo.GetModuleVersion: ModuleVersionInfo;
begin
  GetModuleVersionInfo(Result.Major, Result.Minor, Result.Release, Result.Build);
end;

procedure TgsFileVersionInfo.GetModuleVersionInfo(out Major, Minor, Release, Build: word);
type
  TV=array [0..3] of smallint;
var
  HR: HRSRC;
  H: THandle;
  C: ^TV;
begin
  HR:=FindResource(MainInstance, '#1', rt_Version);
  H:=LoadResource(MainInstance, HR);
  Integer(C):=Integer(LockResource(H))+48;
  Major:=word(C[1]);
  Minor:=word(C[0]);
  Release:=word(C[3]);
  Build:=word(C[2]);
  UnlockResource(H);
  FreeResource(H);
end;

procedure TgsFileVersionInfo.ClearAll;
begin
  FVersionInfoSize:=0;
  FCompanyName:='';
  FFileDescription:='';
  FFileVersion:='';
  FInternalName:='';
  FLegalCopyright:='';
  FOriginalFilename:='';
  FProductName:='';
  FProductVersion:='';
  FComments:='';
end;

constructor TgsFileVersionInfo.Create(AOwner: TComponent);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    FFilename:=Application.ExeName;
end;

function TgsFileVersionInfo.GetBuildOnly: string;
var
  p: integer;
  s: string;
begin
  s:=FileVersion;
  p:=LastDelimiter('.', s);
  Result:=copy(s, p+1, length(s)-p);
end;

procedure TgsFileVersionInfo.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
    LoadFromFile;
end;

procedure TgsFileVersionInfo.LoadFromFile;
var
  VISize: cardinal;
  VIBuff: pointer;
  trans: pointer;
  buffsize: cardinal;
  temp: integer;
  str: pchar;
  LangCharSet: string;

  function GetStringValue(const From: string): string;
  begin
    VerQueryValue(VIBuff, pchar('\StringFileInfo\'+LanguageInfo+'\'+From), pointer(str), buffsize);
    if buffsize>0 then
      Result:=str
    else
      Result:='n/a';
  end;

begin
  ClearAll;
  VIBuff:=nil;
  if not fileexists(Filename) then
    raise EFilerError.Create('File not found: '+Filename);
  VISize:=GetFileVersionInfoSize(pchar(Filename), buffsize);
  FVersionInfoSize:=VISize;
  if VISize<1 then
    raise EReadError.Create('Invalid version info record in file '+Filename);
  VIBuff:=AllocMem(VISize);
  GetFileVersionInfo(pchar(Filename), cardinal(0), VISize, VIBuff);

  VerQueryValue(VIBuff, '\VarFileInfo\Translation', Trans, buffsize);
  if buffsize>=4 then
    begin
      temp:=0;
      StrLCopy(@temp, pchar(Trans), 2 div SizeOf(char));
      LangCharSet:=IntToHex(temp, 4);
      StrLCopy(@temp, pchar(Trans)+2 div SizeOf(char), 2 div SizeOf(char));
      FLanguageInfo:=LangCharSet+IntToHex(temp, 4);
    end
  else
    raise EReadError.Create('Invalid language info in file '+Filename);

  FCompanyName:=GetStringValue('CompanyName');
  FFileDescription:=GetStringValue('FileDescription');
  FFileVersion:=GetStringValue('FileVersion');
  FInternalName:=GetStringValue('InternalName');
  FLegalCopyright:=GetStringValue('LegalCopyright');
  FOriginalFilename:=GetStringValue('OriginalFilename');
  FProductName:=GetStringValue('ProductName');
  FProductVersion:=GetStringValue('ProductVersion');
  FComments:=GetStringValue('Comments');

  FreeMem(VIBuff, VISize);
end;

procedure TgsFileVersionInfo.SetFilename(const Value: TFilename);
begin
  FFilename:=Value;
  LoadFromFile;
end;

end.
