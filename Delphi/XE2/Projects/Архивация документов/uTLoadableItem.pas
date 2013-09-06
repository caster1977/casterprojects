unit uTLoadableItem;

interface

uses
  DB,
  uILoadableItem;

type
  TLoadableItem = class abstract(TInterfacedObject, ILoadableItem)
  protected
    constructor Create; reintroduce; virtual;
  public
    procedure Load(const ADataSet: TDataSet); virtual; abstract;
  end;

implementation

constructor TLoadableItem.Create;
begin
  inherited;
end;

end.
