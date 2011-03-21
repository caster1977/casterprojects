unit getFVI;

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
  TgsFileVersionInfo=class(TComponent)
  private
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
  protected
    property VersionInfoSize: cardinal read FVersionInfoSize;
    procedure LoadFromFile;
    procedure ClearAll;
  public
    function GetBuildOnly: string;
    constructor Create(AOwner: TComponent); override;
  published
    property Filename: TFilename read FFilename write SetFilename;
    property LanguageInfo: string read FLanguageInfo;
    property CompanyName: string read FCompanyName;
    property FileDescription: string read FFileDescription;
    property FileVersion: string read FFileVersion;
    property InternalName: string read FInternalName;
    property LegalCopyright: string read FLegalCopyright;
    property OriginalFilename: string read FOriginalFilename;
    property ProductName: string read FProductName;
    property ProductVersion: string read FProductVersion;
    property Comments: string read FComments;
  end;

procedure register;

implementation

uses
  dialogs,
  Forms;

procedure register;
begin
  RegisterComponents('MyComponents', [TgsFileVersionInfo]);
end;

{ TgsFileVersionInfo }

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
    Filename:=Application.ExeName;
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
