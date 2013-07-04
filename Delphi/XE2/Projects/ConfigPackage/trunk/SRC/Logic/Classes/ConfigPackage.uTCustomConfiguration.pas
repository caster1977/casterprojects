unit ConfigPackage.uTCustomConfiguration;

interface

uses
  System.Generics.Collections,
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTCustomSectionClass,
  System.IniFiles;

type
  TCustomConfiguration = class(TInterfacedObject)
  strict private
    FSections: TObjectList<TCustomSection>;
    FFileName: string;
    function GetFileName: string;
  strict protected
    FIniFile: TCustomIniFile;
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create(const AMemoryFile: Boolean = True; const AFileName: string = ''); reintroduce;
    destructor Destroy; override;

    procedure RegisterSection(const AOptionsClass: TCustomSectionClass);
    function Section<T: TCustomSection>: T;

    property FileName: string read GetFileName nodefault;
  end;

resourcestring
  RsUnregisteredOption = 'Unregistered option group %s.';

implementation

uses
  System.TypInfo,
  System.Rtti,
  System.SysUtils;

constructor TCustomConfiguration.Create(const AMemoryFile: Boolean; const AFileName: string);
var
  s: string;
begin
  inherited Create;
  s := Trim(AFileName);
  if s = EmptyStr then
  begin
    FFileName := ChangeFileExt(ExpandFileName(ParamStr(0)), '.ini');
  end
  else
  begin
    FFileName := s;
  end;
  FSections := TObjectList<TCustomSection>.Create;
  if AMemoryFile then
  begin
    FIniFile := TMemIniFile.Create(FFileName);
  end
  else
  begin
    FIniFile := TIniFile.Create(FFileName);
  end;
  Initialize;
end;

destructor TCustomConfiguration.Destroy;
begin
  Finalize;
  if Assigned(FSections) then
  begin
    FreeAndNil(FSections);
  end;
  if Assigned(FIniFile) then
  begin
    if FIniFile is TMemIniFile then
    begin
      (FIniFile as TMemIniFile).UpdateFile;
    end;
    FreeAndNil(FIniFile);
  end;
  inherited;
end;

procedure TCustomConfiguration.Initialize;
begin
end;

procedure TCustomConfiguration.Finalize;
begin
end;

function TCustomConfiguration.GetFileName: string;
begin
  Result := FFileName;
end;

procedure TCustomConfiguration.RegisterSection(const AOptionsClass: TCustomSectionClass);
var
  opt: TCustomSection;
begin
  opt := AOptionsClass.Create(FIniFile);
  FSections.Add(opt);
end;

function TCustomConfiguration.Section<T>: T;
var
  opt: TCustomSection;
  ti: TRttiType;
  ctx: TRttiContext;
begin
  ti := ctx.GetType(TypeInfo(T));
  try
    for opt in FSections do
    begin
      if opt is ti.AsInstance.MetaclassType then
      begin
        Exit(T(opt));
      end;
    end;
  finally
    ctx.Free;
  end;

  raise Exception.Create(Format(RsUnregisteredOption, [PTypeInfo(typeInfo(T)).Name]));
end;

end.
