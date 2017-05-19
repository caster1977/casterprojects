unit ShateM.Utils.ContainerIoC;

interface

uses
  System.SysUtils,
  System.TypInfo,
  System.Rtti,
  System.Generics.Collections;

type
  TInjectionDelegate = reference to function: IInterface;

  TContainerIoC = class
  private
    class var
      FDefault: TContainerIoC;
      FLock: TObject;
    class constructor Create;
    class destructor Destroy;
    class function GetDefault: TContainerIoC; static;
  public
    class property Default: TContainerIoC read GetDefault;
  private
    type
      TIoCInternal = class
        Impl: TClass;
        Delegate: TInjectionDelegate;
      end;
      TValueArray = array of TValue;
    var
      FContainer: TDictionary<string, TIoCInternal>;
    function PrepareKey(aInterfaceInfo: PTypeInfo; const aName: string): string;
    function CreateImplementation<I: IInterface>(aImplementationStruct: TIoCInternal; const aName: string): I;
    function CreateImplementationFromType(aInterfaceInfo: PTypeInfo; aImplementation: TClass;
      const aName: string): IInterface;
    function CreateImplementationFromRttiType(aInterfaceInfo: PTypeInfo; aImplementationRttiType: TRttiType;
      const aName: string): IInterface;
    function CollectArgs(aRttiMethod: TRttiMethod; const aName: string): TValueArray;
    function CreateInstanceArgument(aInterfaceInfo: PTypeInfo; aImplementationStruct: TIoCInternal;
      const aName: string): TValue;
    procedure InternalRegisterType(aInterfaceInfo: PTypeInfo; aImplementationClass: TClass;
      aDelegate: TInjectionDelegate; const aName: string);
  public
    constructor Create;
    destructor Destroy; override;
    function RegisterType<I: IInterface; T: class>(const aName: string = ''): TContainerIoC; overload;
    function RegisterType<I: IInterface>(aDelegate: TInjectionDelegate; const aName: string = ''): TContainerIoC; overload;
    function Resolve<I: IInterface>(const aName: string = ''): I;
  end;

  EIoCResolveExistsException = class(Exception);
  EIoCArgsNotSupported = class(Exception);

implementation

{ TContainerIoC }

function TContainerIoC.CollectArgs(aRttiMethod: TRttiMethod; const aName: string): TValueArray;
var
  Params: TArray<TRttiParameter>;
  Param: TRttiParameter;
  k: Integer;
  Key: string;
  ImplementationStruct: TIoCInternal;
begin
  Params := aRttiMethod.GetParameters;
  SetLength(Result, Length(Params));
  for k := 0 to Length(Params) - 1 do
  begin
    Param := Params[k];
    if Param.ParamType.TypeKind = tkInterface then
    begin
      Key := PrepareKey(Param.ParamType.Handle, aName);
      ImplementationStruct := FContainer.Items[Key];
      Result[k] := CreateInstanceArgument(Param.ParamType.Handle, ImplementationStruct, aName);
    end
    else
      raise EIoCArgsNotSupported.CreateFmt('Для %s аргумент типа %s не поддерживается', [aRttiMethod.Parent.Name, Param.ParamType.Name])
  end;
end;

constructor TContainerIoC.Create;
begin
  FContainer := TDictionary<string, TIoCInternal>.Create();
end;

function TContainerIoC.CreateImplementation<I>(aImplementationStruct: TIoCInternal; const aName: string): I;
var
  InterfaceResolved: IInterface;
begin
  if Assigned(aImplementationStruct.Impl) then
    InterfaceResolved := CreateImplementationFromType(TypeInfo(I), aImplementationStruct.Impl, aName)
  else
    InterfaceResolved := aImplementationStruct.Delegate();
  InterfaceResolved.QueryInterface(PTypeInfo(TypeInfo(I))^.TypeData^.Guid, Result);
end;

function TContainerIoC.CreateImplementationFromRttiType(aInterfaceInfo: PTypeInfo;
  aImplementationRttiType: TRttiType; const aName: string): IInterface;
var
  Rm: TRttiMethod;
  Args: TValueArray;
begin
  for Rm in aImplementationRttiType.GetMethods() do
    if Rm.IsConstructor then
    begin
      Args := CollectArgs(Rm, aName);
      Result := Rm.Invoke(aImplementationRttiType.AsInstance.MetaclassType, Args).AsInterface;
      Break;
    end;
end;

function TContainerIoC.CreateImplementationFromType(aInterfaceInfo: PTypeInfo; aImplementation: TClass;
  const aName: string): IInterface;
var
  Rc: TRttiContext;
begin
  Rc := TRttiContext.Create();
  try
    Result := CreateImplementationFromRttiType(aInterfaceInfo, Rc.GetType(aImplementation), aName);
  finally
    Rc.Free();
  end;
end;

function TContainerIoC.CreateInstanceArgument(aInterfaceInfo: PTypeInfo; aImplementationStruct: TIoCInternal;
  const aName: string): TValue;
var
  ArgInterface: IInterface;
  ArgInterfaceCorrect: IInterface;
begin
  ArgInterface := CreateImplementationFromType(aInterfaceInfo, aImplementationStruct.Impl, aName);
  ArgInterface.QueryInterface(aInterfaceInfo^.TypeData^.Guid, ArgInterfaceCorrect);
  TValue.Make(NativeInt(ArgInterfaceCorrect), aInterfaceInfo, Result);
end;

class constructor TContainerIoC.Create;
begin
  FLock := TObject.Create();
end;

destructor TContainerIoC.Destroy;
var
  Pair: TPair<string, TIoCInternal>;
begin
  for Pair in FContainer do
    Pair.Value.Free();
  FreeAndNil(FContainer);
  inherited Destroy();
end;

class destructor TContainerIoC.Destroy;
begin
  TMonitor.Enter(FLock);
  try
    if Assigned(FDefault) then
      FreeAndNil(FDefault);
  finally
    TMonitor.Exit(FLock);
  end;
  FreeAndNil(FLock);
end;

class function TContainerIoC.GetDefault: TContainerIoC;
begin
  TMonitor.Enter(FLock);
  try
    if not Assigned(FDefault) then
      FDefault := TContainerIoC.Create();
    Result := FDefault;
  finally
    TMonitor.Exit(FLock);
  end;
end;

procedure TContainerIoC.InternalRegisterType(aInterfaceInfo: PTypeInfo; aImplementationClass: TClass;
  aDelegate: TInjectionDelegate; const aName: string);
var
  Key: string;
  IoCInternal: TIoCInternal;
begin
  Key := PrepareKey(aInterfaceInfo, aName);
  IoCInternal := TIoCInternal.Create();
  IoCInternal.Impl := aImplementationClass;
  IoCInternal.Delegate := aDelegate;
  TMonitor.Enter(FContainer);
  try
    if FContainer.ContainsKey(Key) then
      FContainer.Items[Key].Free();
    FContainer.AddOrSetValue(Key, IoCInternal);
  finally
    TMonitor.Exit(FContainer);
  end;
end;

function TContainerIoC.PrepareKey(aInterfaceInfo: PTypeInfo; const aName: string): string;
begin
  if aName.Equals('') then
    Result := string(aInterfaceInfo^.Name)
  else
    Result := string(aInterfaceInfo^.Name) + '_' + aName;
  Result := string.LowerCase(Result);
end;

function TContainerIoC.RegisterType<I, T>(const aName: string): TContainerIoC;
begin
  Result := Self;
  InternalRegisterType(TypeInfo(I), T, nil, aName);
end;

function TContainerIoC.RegisterType<I>(aDelegate: TInjectionDelegate; const aName: string): TContainerIoC;
begin
  Result := Self;
  InternalRegisterType(TypeInfo(I), nil, aDelegate, aName);
end;

function TContainerIoC.Resolve<I>(const aName: string): I;
var
  Key: string;
  ImplementationStruct: TIoCInternal;
  IntfInfo: PTypeInfo;
begin
  IntfInfo := TypeInfo(I);
  Key := PrepareKey(IntfInfo, aName);
  TMonitor.Enter(FContainer);
  try
    if FContainer.TryGetValue(Key, ImplementationStruct) then
      Result := CreateImplementation<I>(ImplementationStruct, aName)
    else
      raise EIoCResolveExistsException.CreateFmt('Класс реализатор не найден для %s', [IntfInfo^.Name]);
  finally
    TMonitor.Exit(FContainer);
  end;
end;

end.
