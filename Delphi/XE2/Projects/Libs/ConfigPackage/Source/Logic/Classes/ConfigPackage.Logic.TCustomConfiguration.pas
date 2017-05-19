unit ConfigPackage.Logic.TCustomConfiguration;

interface

uses
  System.Generics.Collections,
  System.IniFiles,
  ConfigPackage.Logic.TCustomSection,
  ConfigPackage.Logic.TCustomSectionClass;

type
  TCustomConfiguration = class;

  TCustomConfigurationClass = class of TCustomConfiguration;

  TCustomConfiguration = class abstract(TInterfacedObject)
  strict private
    FSections: TObjectList<TCustomSection>;
    function GetFileName(): string;

  strict private
    FUpdateFile: Boolean;

  strict protected
    FIniFile: TCustomIniFile;
    procedure Initialize(); virtual; abstract;
    procedure Finalize; virtual;

  public
    constructor Create(); reintroduce; overload; virtual;
    constructor Create(const aFileName: string; const aMemoryFile: Boolean = True; const aUpdateFile: Boolean = True); reintroduce; overload; virtual;
    destructor Destroy(); override;
    procedure RegisterSection(const aOptionsClass: TCustomSectionClass);
    function Section<T: TCustomSection>(): T;
    property FileName: string read GetFileName nodefault;
  public
    class function Get(const aClass: TCustomConfigurationClass; const aMemoryFile: Boolean = False): TCustomConfiguration; virtual;
  end;

resourcestring
  RsUnregisteredOption = 'Unregistered option group %s.';

var
  FConfiguration: TCustomConfiguration;

implementation

uses
  System.TypInfo,
  System.StrUtils,
  System.Rtti,
  System.SysUtils;

constructor TCustomConfiguration.Create(const aFileName: string; const aMemoryFile, aUpdateFile: Boolean);
var
  s: string;
begin
  inherited Create();
  s := aFileName.Trim();
  s := IfThen(
    // Если имя файла не было задано,
    s.IsEmpty(),
    // меняем расширение файла на .ini
    ChangeFileExt(ExpandFileName(IfThen(
    // взяв за основу
    ModuleIsLib,
    // имя файла библиотеки
    GetModuleName(HInstance),
    // или имя файла приложения.
    ParamStr(0))), '.ini'), IfThen(
    // Если имя файла было задано без путей,
    ExtractFilePath(s).IsEmpty(),
    // берём за основу путь
    IncludeTrailingPathDelimiter(ExtractFilePath(ExpandFileName(IfThen(ModuleIsLib,
    // библиотеки
    GetModuleName(HInstance),
    // или приложения
    ParamStr(0))))) +
    // и добавляем имя файла
    ExtractFileName(s),
    // если имя файла было задано с путями, оставляем его
    ExpandFileName(s)));

  FSections := TObjectList<TCustomSection>.Create();
  FUpdateFile := aUpdateFile;

  case aMemoryFile of
    True:
      begin
        FIniFile := TMemIniFile.Create(s);
      end;
    False:
      begin
        FIniFile := TIniFile.Create(s);
      end;
  end;
  Initialize();
end;

class function TCustomConfiguration.Get(const aClass: TCustomConfigurationClass; const aMemoryFile: Boolean): TCustomConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := aClass.Create(EmptyStr, aMemoryFile);
  end;
  Result := FConfiguration;
end;


function TCustomConfiguration.GetFileName(): string;
begin
  Result := EmptyStr;
  if Assigned(FIniFile) then
  begin
    Result := FIniFile.FileName;
  end;
end;

constructor TCustomConfiguration.Create();
begin
  Create(EmptyStr);
end;

destructor TCustomConfiguration.Destroy();
begin
  try
    try
      Finalize();
    finally
      try
        if FUpdateFile then
        begin
          if Assigned(FIniFile) then
          begin
            FIniFile.UpdateFile();
          end;
        end;
      finally
        try
          if Assigned(FSections) then
          begin
            FreeAndNil(FSections);
          end;
        finally
          if Assigned(FIniFile) then
          begin
            FreeAndNil(FIniFile);
          end;
        end;
      end;
    end;
  finally
    inherited;
  end;
end;

procedure TCustomConfiguration.Finalize();
begin
end;

procedure TCustomConfiguration.RegisterSection(const aOptionsClass: TCustomSectionClass);
var
  Opt: TCustomSection;
begin
  Opt := aOptionsClass.Create(FIniFile);
  FSections.Add(Opt);
end;

function TCustomConfiguration.Section<T>(): T;
var
  Opt: TCustomSection;
  RT: TRttiType;
  Ctx: TRttiContext;
begin
  RT := Ctx.GetType(TypeInfo(T));
  try
    for Opt in FSections do
    begin
      if Opt is RT.AsInstance.MetaclassType then
      begin
        Exit(T(Opt));
      end;
    end;
  finally
    Ctx.Free();
  end;

  raise Exception.Create(Format(RsUnregisteredOption, [PTypeInfo(TypeInfo(T)).Name]));
end;

initialization

finalization

if Assigned(FConfiguration) then
begin
  FreeAndNil(FConfiguration);
end;

end.
