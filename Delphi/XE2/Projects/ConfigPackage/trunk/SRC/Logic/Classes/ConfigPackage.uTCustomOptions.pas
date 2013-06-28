unit ConfigPackage.uTCustomOptions;

interface

uses
  ConfigPackage.uTDefaultValueAttribute,
  System.IniFiles,
  System.Rtti;

type
  TCustomOptions = class
  strict private
    FRttiContext: TRttiContext;
    FIniFile: TCustomIniFile;
    FSectionName: string;
  strict protected
    function GetDefaultAttribute(const ARttiProperty: TRttiProperty): TDefaultValueAttribute;

    function GetProperty(const AIndex: Integer): TRttiProperty;

    function GetGenericValue<T>(const AIndex: Integer): T;
    procedure SetGenericValue<T>(const AIndex: Integer; const AValue: T);

    function GetBooleanValue(const AIndex: Integer): Boolean; virtual;
    function GetIntegerValue(const AIndex: Integer): Integer; virtual;
    function GetStringValue(const AIndex: Integer): string; virtual;

    procedure SetBooleanValue(const AIndex: Integer; const AValue: Boolean); virtual;
    procedure SetIntegerValue(const AIndex: Integer; const AValue: Integer); virtual;
    procedure SetStringValue(const AIndex: Integer; const AValue: string); virtual;

  public
    constructor Create(const AIniFile: TCustomIniFile); reintroduce;
    destructor Destroy; override;
  end;

resourcestring
  RsUndefinedPropertyName = 'Undefined property name';

implementation

uses
  System.TypInfo,
  System.SysUtils,
  System.Classes,
  ConfigPackage.uTSectionAttribute;

resourcestring
  RsPropertyDoesNotExists = 'Property %d does not exists.';

constructor TCustomOptions.Create(const AIniFile: TCustomIniFile);
var
  ctx: TRttiContext;
  attr: TCustomAttribute;
  rtti_type: TRttiType;
begin
  inherited Create;
  FIniFile := AIniFile;

  FRttiContext := TRttiContext.Create;

  rtti_type := ctx.GetType(self.ClassType);
  for attr in rtti_type.GetAttributes do
  begin
    if attr is TSectionAttribute then
    begin
      FSectionName := (attr as TSectionAttribute).Name;
    end;
  end;
end;

destructor TCustomOptions.Destroy;
begin
  FRttiContext.Free;
  inherited;
end;

function TCustomOptions.GetProperty(const AIndex: Integer): TRttiProperty;
var
  rtti_type: TRttiType;
  props: TArray<TRttiProperty>;
begin
  rtti_type := FRttiContext.GetType(self.ClassType);
  props := rtti_type.GetProperties;
  if AIndex > Length(props) then
  begin
    raise EArgumentOutOfRangeException.Create(Format(RsPropertyDoesNotExists, [AIndex]));
  end;

  Result := props[AIndex];
end;

function TCustomOptions.GetDefaultAttribute(const ARttiProperty: TRttiProperty): TDefaultValueAttribute;
var
  attr: TCustomAttribute;
begin
  Result := nil;
  for attr in ARttiProperty.GetAttributes do
  begin
    if attr is TDefaultValueAttribute then
    begin
      Result := attr as TDefaultValueAttribute;
    end;
  end;
end;

function TCustomOptions.GetGenericValue<T>(const AIndex: Integer): T;
var
  prop: TRttiProperty;
  def: TDefaultValueAttribute;
  val: TValue;
begin
  prop := GetProperty(AIndex);
  if not Assigned(prop) then
  begin
    raise Exception.Create(RsUndefinedPropertyName);
  end;

  def := GetDefaultAttribute(prop);

  if FIniFile.ValueExists(FSectionName, prop.Name) then
  begin
    case prop.PropertyType.TypeKind of
      tkInteger:
        begin
          val := FIniFile.ReadInteger(FSectionName, prop.Name, def.Value.AsInteger);
        end;
      tkString, tkUString:
        begin
          val := FIniFile.ReadString(FSectionName, prop.Name, def.Value.asString);
        end;
      tkEnumeration:
        begin
          val := FIniFile.ReadInteger(FSectionName, prop.Name, ord(def.Value.AsBoolean)) <> 0;
        end;
    end;
    Result := val.AsType<T>;
  end
  else
  begin
    if Assigned(def) then
    begin
      Result := def.Value.AsType<T>;
    end
    else
    begin
      Result := System.Default(T);
    end;
  end;
end;

function TCustomOptions.GetIntegerValue(const AIndex: Integer): Integer;
begin
  Result := GetGenericValue<Integer>(AIndex);
end;

function TCustomOptions.GetBooleanValue(const AIndex: Integer): Boolean;
begin
  Result := GetGenericValue<Boolean>(AIndex);
end;

function TCustomOptions.GetStringValue(const AIndex: Integer): string;
begin
  Result := GetGenericValue<string>(AIndex);
end;

procedure TCustomOptions.SetGenericValue<T>(const AIndex: Integer; const AValue: T);
var
  prop: TRttiProperty;
  val: TValue;
  sl: TStringList;
begin
  prop := GetProperty(AIndex);
  if not Assigned(prop) then
  begin
    raise Exception.Create(RsUndefinedPropertyName);
  end;

  val := TValue.From<T>(AValue);

  sl := TStringList.Create;
  try
    case PTypeInfo(TypeInfo(T)).Kind of
      tkInteger:
        begin
          if GetDefaultAttribute(prop).Value.AsInteger <> val.AsInteger then
          begin
            FIniFile.WriteInteger(FSectionName, prop.Name, val.AsInteger);
          end
          else
          begin
            FIniFile.DeleteKey(FSectionName, prop.Name);
          end;
        end;
      tkString, tkUString:
        begin
          if GetDefaultAttribute(prop).Value.asString <> val.asString then
          begin
            FIniFile.WriteString(FSectionName, prop.Name, val.asString);
          end
          else
          begin
            FIniFile.DeleteKey(FSectionName, prop.Name);
          end;
        end;
      tkEnumeration:
        begin
          if GetDefaultAttribute(prop).Value.AsBoolean <> val.AsBoolean then
          begin
            FIniFile.WriteBool(FSectionName, prop.Name, val.AsBoolean);
          end
          else
          begin
            FIniFile.DeleteKey(FSectionName, prop.Name);
          end;
        end;
    end;
    FIniFile.ReadSectionValues(FSectionName, sl);
    if sl.Count = 0 then
    begin
      FIniFile.EraseSection(FSectionName);
    end;
  finally
    FreeAndNil(sl);
  end;
end;

procedure TCustomOptions.SetBooleanValue(const AIndex: Integer; const AValue: Boolean);
begin
  SetGenericValue<Boolean>(AIndex, AValue);
end;

procedure TCustomOptions.SetIntegerValue(const AIndex, AValue: Integer);
begin
  SetGenericValue<Integer>(AIndex, AValue);
end;

procedure TCustomOptions.SetStringValue(const AIndex: Integer; const AValue: string);
begin
  SetGenericValue<string>(AIndex, AValue);
end;

end.
