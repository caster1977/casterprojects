unit CastersPackage.uTIniFileSerilizator;

interface

uses
  CastersPackage.uISerilizator,
  CastersPackage.uIInitializable,
  CastersPackage.uTObjectMethod;

type
  TIniFileSerilizator = class(TInterfacedObject{, ISerilizator, IInitializable})
  {public
    procedure Load; final;
    procedure Save; final;

  strict private
    FLoading: TObjectMethod;
    function GetLoading: TObjectMethod;
    procedure SetLoading(const AValue: TObjectMethod);
  public
    property Loading: TObjectMethod read GetLoading write SetLoading nodefault;

  strict private
    FSaving: TObjectMethod;
    function GetSaving: TObjectMethod;
    procedure SetSaving(const AValue: TObjectMethod);
  public
    property Saving: TObjectMethod read GetSaving write SetSaving nodefault;

  strict private
    FBeforeSave: TObjectMethod;
    function GetBeforeSave: TObjectMethod;
    procedure SetBeforeSave(const AValue: TObjectMethod);
  public
    property BeforeSave: TObjectMethod read GetBeforeSave write SetBeforeSave nodefault;

  strict private
    FAfterLoad: TObjectMethod;
    function GetAfterLoad: TObjectMethod;
    procedure SetAfterLoad(const AValue: TObjectMethod);
  public
    property AfterLoad: TObjectMethod read GetAfterLoad write SetAfterLoad nodefault;

  strict private
    FFileName: string;
    function GetFileName: string;
    procedure SetFileName(const AValue: string);
  public
    property FileName: string read GetFileName write SetFileName nodefault;

  public
    constructor Create(const AFileName: string = ''); reintroduce; virtual;
    destructor Destroy; override;
  strict protected
    procedure Initialize; virtual; abstract;
    procedure Finalize; virtual;}
  end;

implementation

uses
  System.SysUtils;

{constructor TIniFileSerilizator.Create(const AFileName: string);
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
  FIniFile := nil;
  Initialize;
  Modified := False;
end;

destructor TIniFileSerilizator.Destroy;
begin

  inherited;
end;

procedure TIniFileSerilizator.Finalize;
begin
end;

function TIniFileSerilizator.GetAfterLoad: TObjectMethod;
begin

end;

function TIniFileSerilizator.GetBeforeSave: TObjectMethod;
begin

end;

function TIniFileSerilizator.GetFileName: string;
begin

end;

function TIniFileSerilizator.GetLoading: TObjectMethod;
begin

end;

function TIniFileSerilizator.GetSaving: TObjectMethod;
begin

end;

procedure TIniFileSerilizator.Load;
begin

end;

procedure TIniFileSerilizator.Save;
begin

end;

procedure TIniFileSerilizator.SetAfterLoad(const AValue: TObjectMethod);
begin

end;

procedure TIniFileSerilizator.SetBeforeSave(const AValue: TObjectMethod);
begin

end;

procedure TIniFileSerilizator.SetFileName(const AValue: string);
begin

end;

procedure TIniFileSerilizator.SetLoading(const AValue: TObjectMethod);
begin

end;

procedure TIniFileSerilizator.SetSaving(const AValue: TObjectMethod);
begin

end;}

end.
