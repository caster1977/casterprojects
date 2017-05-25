unit ES4FScan.Logic.Classes.TCustomBusinessLogic;

interface

uses
  Vcl.Forms,
  ConfigPackage.Logic.TCustomConfiguration,
  ES4FScan.Logic.Interfaces.ICustomBusinessLogic;

type
  TCustomBusinessLogic<T: TCustomConfiguration, constructor> = class abstract(TInterfacedObject, ICustomBusinessLogic<T>)
  private
    FOwner: TCustomForm;
    function GetOwner(): TCustomForm;

  public
    property Owner: TCustomForm read GetOwner nodefault;

  strict protected
    FConfiguration: T;
    function GetConfiguration(): T; virtual;

  public
    property Configuration: T read GetConfiguration nodefault;

  strict protected
    function GetClassName(): string; reintroduce; virtual;

  public
    constructor Create(const aOwner: TCustomForm); reintroduce; virtual;
    destructor Destroy(); override;
    {$IFDEF DEBUG}
    function ToString(): string; reintroduce; virtual;
    {$ENDIF}
  end;

implementation

uses
  ES4FScan.Logic.Consts,
  System.SysUtils,
  System.Math;

constructor TCustomBusinessLogic<T>.Create(const aOwner: TCustomForm);
begin
  inherited Create();
  FOwner := aOwner;
end;

function TCustomBusinessLogic<T>.GetClassName(): string;
begin
  Result := inherited ClassName();
end;

function TCustomBusinessLogic<T>.GetConfiguration(): T;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := T.Create();
  end;
  Result := FConfiguration;
end;

destructor TCustomBusinessLogic<T>.Destroy();
begin
  try
    if Assigned(FConfiguration) then
    begin
      FreeAndNil(FConfiguration);
    end;
  finally
    inherited;
  end;
end;

{$IFDEF DEBUG}

function TCustomBusinessLogic<T>.ToString(): string;
var
  tmpOwner: string;
  tmpConnection: string;
begin
  if Assigned(FOwner) then
  begin
    tmpOwner := FOwner.ToString();
  end
  else
  begin
    tmpOwner := 'nil';
  end;

  Result := Format('ClassName: [%s]%sInherited from [TCustomBusinessLogic]:%s  Owner: [%s]%s  Connection: [%s]',
    [ClassName, sLineBreak + sLineBreak, sLineBreak, tmpOwner, sLineBreak, tmpConnection]);
end;
{$ENDIF}

function TCustomBusinessLogic<T>.GetOwner(): TCustomForm;
begin
  Result := FOwner;
end;

end.
