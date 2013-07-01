unit ConfigPackage.uTIniFileSerilizator;

interface

uses
  System.Generics.Collections,
  ConfigPackage.uTCustomOptions,
  ConfigPackage.uTCustomOptionsClass,
  System.IniFiles;

type
  TIniFileSerilizator = class(TInterfacedObject)
  strict private
    FOptions: TObjectList<TCustomOptions>;
    FFileName: string;
    function GetFileName: string;
  strict protected
    FIniFile: TCustomIniFile;
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create(const AMemoryFile: Boolean = True; const AFileName: string = ''); reintroduce;
    destructor Destroy; override;

    procedure RegisterOptions(const AOptionsClass: TCustomOptionsClass);
    function Section<T: TCustomOptions>: T;

    property FileName: string read GetFileName nodefault;
  end;

resourcestring
  RsUnregisteredOption = 'Unregistered option group %s.';

implementation

uses
  System.TypInfo,
  System.Rtti,
  System.SysUtils;

constructor TIniFileSerilizator.Create(const AMemoryFile: Boolean; const AFileName: string);
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
  FOptions := TObjectList<TCustomOptions>.Create;
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

destructor TIniFileSerilizator.Destroy;
begin
  Finalize;
  if Assigned(FOptions) then
  begin
    FreeAndNil(FOptions);
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

procedure TIniFileSerilizator.Initialize;
begin
end;

procedure TIniFileSerilizator.Finalize;
begin
end;

function TIniFileSerilizator.GetFileName: string;
begin
  Result := FFileName;
end;

procedure TIniFileSerilizator.RegisterOptions(const AOptionsClass: TCustomOptionsClass);
var
  opt: TCustomOptions;
begin
  opt := AOptionsClass.Create(FIniFile);
  FOptions.Add(opt);
end;

function TIniFileSerilizator.Section<T>: T;
var
  opt: TCustomOptions;
  ti: TRttiType;
  ctx: TRttiContext;
begin
  ti := ctx.GetType(typeInfo(T));
  try
    for opt in FOptions do
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
