unit uTArchiveDocumentTypeItem;

interface

uses
  DB,
  uIArchiveDocumentTypeItem,
  uTLoadableItem;

type
  TArchiveDocumentTypeItem = class(TLoadableItem, IArchiveDocumentTypeItem)
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

  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  SysUtils;

function TArchiveDocumentTypeItem.GetName: string;
begin
  Result := FName;
end;

constructor TArchiveDocumentTypeItem.Create;
begin
  inherited;
  FName := EmptyStr;
end;

function TArchiveDocumentTypeItem.GetLoadSQL: string;
begin
  Result := Format('Archiving_sel_ArchiveDocumentType %d', [Id]);
end;

procedure TArchiveDocumentTypeItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
  end;
end;

function TArchiveDocumentTypeItem.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

function TArchiveDocumentTypeItem.GetDeleteSQL: string;
begin
  Result := EmptyStr;
end;

end.
