unit uTLoadableItem;

interface

uses
  DB,
  uILoadableItem;

type
  TLoadableItem = class(TInterfacedObject, ILoadableItem)
  public
    constructor Create; virtual;
    procedure Load(const ADataSet: TDataSet); virtual; abstract;
  end;

implementation

constructor TLoadableItem.Create;
begin
  inherited;
end;

end.
