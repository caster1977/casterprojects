unit Utils.Modules.UEOUpdater.Logic.Classes.TModelItem;

interface

uses
  System.Classes, Utils.Modules.UEOUpdater.Logic.Interfaces.IModelItem;

type
  TModelItem = class(TInterfacedObject, IModelItem)
  strict private
    FA: string;
    FB: string;
    FC: string;
    FD: string;
    FE: string;
    FF: string;
    FG: string;
    FH: string;
    FI: string;
    FJ: string;
    FK: string;
    FL: string;
    FM: string;
    FN: string;
    function GetA(): string;
    function GetB(): string;
    function GetC(): string;
    function GetD(): string;
    function GetE(): string;
    function GetF(): string;
    function GetG(): string;
    function GetH(): string;
    function GetI(): string;
    function GetJ(): string;
    function GetK(): string;
    function GetL(): string;
    function GetM(): string;
    function GetN(): string;

    procedure SetG(const aValue: string);
    procedure SetH(const aValue: string);
    procedure SetI(const aValue: string);
    procedure SetJ(const aValue: string);
    procedure SetK(const aValue: string);
    procedure SetL(const aValue: string);
    procedure SetM(const aValue: string);
    procedure SetN(const aValue: string);

    function AsArray(): TArray<string>;

  public
    constructor Create(const aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ: string); reintroduce; overload;
    constructor Create(const aValue: TArray<string>); reintroduce; overload;
  end;

implementation

uses
  System.SysUtils;

constructor TModelItem.Create(const aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ: string);
begin
  inherited Create();
  FA := aA.Trim();
  FB := aB.Trim();
  FC := aC.Trim();
  FD := aD.Trim();
  FE := aE.Trim();
  FF := aF.Trim();
  FG := aG.Trim();
  FH := aH.Trim();
  FI := aI.Trim();
  FJ := aJ.Trim();
  FK := aG.Trim();
  FL := aH.Trim();
  FM := aI.Trim();
  FN := aJ.Trim();
end;

function TModelItem.AsArray: TArray<string>;
begin
  SetLength(Result, 14);
  Result[0] := GetA;
  Result[1] := GetB;
  Result[2] := GetC;
  Result[3] := GetD;
  Result[4] := GetE;
  Result[5] := GetF;
  Result[6] := GetG;
  Result[7] := GetH;
  Result[8] := GetI;
  Result[9] := GetJ;
  Result[10] := GetK;
  Result[11] := GetL;
  Result[12] := GetM;
  Result[13] := GetN;
end;

constructor TModelItem.Create(const aValue: TArray<string>);
begin
  Create(aValue[0], aValue[1], aValue[2], aValue[3], aValue[4], aValue[5], aValue[6], aValue[7], aValue[8], aValue[9]);
end;

function TModelItem.GetA: string;
begin
  Result := FA;
end;

function TModelItem.GetB: string;
begin
  Result := FB;
end;

function TModelItem.GetC: string;
begin
  Result := FC;
end;

function TModelItem.GetD: string;
begin
  Result := FD;
end;

function TModelItem.GetE: string;
begin
  Result := FE;
end;

function TModelItem.GetF: string;
begin
  Result := FF;
end;

function TModelItem.GetG: string;
begin
  Result := FG;
end;

function TModelItem.GetH: string;
begin
  Result := FH;
end;

function TModelItem.GetI: string;
begin
  Result := FI;
end;

function TModelItem.GetJ: string;
begin
  Result := FJ;
end;

function TModelItem.GetK: string;
begin
  Result := FK;
end;

function TModelItem.GetL: string;
begin
  Result := FL;
end;

function TModelItem.GetM: string;
begin
  Result := FM;
end;

function TModelItem.GetN: string;
begin
  Result := FN;
end;

procedure TModelItem.SetG(const aValue: string);
begin
  FG := aValue;
end;

procedure TModelItem.SetH(const aValue: string);
begin
  FH := aValue;
end;

procedure TModelItem.SetI(const aValue: string);
begin
  FI := aValue;
end;

procedure TModelItem.SetJ(const aValue: string);
begin
  FJ := aValue;
end;

procedure TModelItem.SetK(const aValue: string);
begin
  FK := aValue;
end;

procedure TModelItem.SetL(const aValue: string);
begin
  FL := aValue;
end;

procedure TModelItem.SetM(const aValue: string);
begin
  FM := aValue;
end;

procedure TModelItem.SetN(const aValue: string);
begin
  FN := aValue;
end;

end.
