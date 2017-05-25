unit UE.Modules.FakeItemsManager.Logic.Classes.TPresenter;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IPresenter,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IView,
  UE.Modules.FakeItemsManager.Logic.TViewEnumEvent;

type
  TPresenter = class(TInterfacedObject, IPresenter)
  strict protected
    FView: IView;
    FProcessign: Boolean;
    FFDConnection: TFDConnection;
    procedure OnEventSimple(aValue: TViewEnumEvent); virtual; abstract;
    procedure Initialize(); virtual;

  public
    constructor Create(const aView: IView; const aConnection: TFDConnection); reintroduce; virtual;
  end;

implementation

constructor TPresenter.Create(const aView: IView; const aConnection: TFDConnection);
begin
  Assert(Assigned(aView));
  inherited Create();
  FProcessign := False;
  FView := aView;
  FFDConnection := aConnection;
  FView.SetOnEventSimple(OnEventSimple);
  FView.StorePresenter(Self);
  Initialize();
end;

procedure TPresenter.Initialize();
begin
end;

end.
