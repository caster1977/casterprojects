unit uTArchiveCompanyItem;

interface

uses
  uIArchiveCompanyItem,
  uTLoadableItem,
  DB,
  uILoadableItem;

type
  TArchiveCompanyItem = class {$IFNDEF VER150} sealed {$ENDIF}(TLoadableItem, IArchiveCompanyItem)
  protected
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetDeleteSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    function GetLoadSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
  private
    FName: string;
    function GetName: string;
  public
    property name: string read GetName;

  private
    FCode: string;
    function GetCode: string;
  public
    property Code: string read GetCode;

  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Assign(const AValue: ILoadableItem); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  SysUtils,
  uArchivingCommonRoutines;

function TArchiveCompanyItem.GetName: string;
begin
  Result := FName;
end;

procedure TArchiveCompanyItem.Assign(const AValue: ILoadableItem);
var
  a: IArchiveCompanyItem;
begin
  inherited;
  if Supports(AValue, IArchiveCompanyItem, a) then
  begin
    FName := a.Name;
    FCode := a.Code;
  end;
end;

constructor TArchiveCompanyItem.Create;
begin
  inherited;
  FName := EmptyStr;
  FCode := EmptyStr;
end;

function TArchiveCompanyItem.GetCode: string;
begin
  Result := FCode;
end;

function TArchiveCompanyItem.GetLoadSQL: string;
begin
  Result := Format('Archiving_sel_ArchiveCompany %d', [Id]);
end;

function TArchiveCompanyItem.GetDeleteSQL: string;
begin
  Result := EmptyStr;
end;

procedure TArchiveCompanyItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
    FCode := ADataSet.FieldByName('Code').AsString;
  end;
end;

function TArchiveCompanyItem.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

end.
