unit uTArchiveDocumentTypeItem;

interface

uses
  DB,
  uIArchiveDocumentTypeItem,
  uTLoadableItem;

type
  TArchiveDocumentTypeItem = class(TLoadableItem, IArchiveDocumentTypeItem)
  protected
    function GetSaveSQL: string; override; final;
    function GetDeleteSQL: string; override; final;
  public
    function GetLoadSQL: string; override; final;

  private
    FName: string;
    function GetName: string;
  public
    property Name: string read GetName;

  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
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
  Result := Format('BSOArchiving_sel_ArchiveDocumentType %d', [Id]);
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
