unit UE.Modules.FakeItemsManager.Logic.Interfaces.IViewMain;

interface

uses
  System.SysUtils,
  Vcl.Controls,
  Data.DB,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IView,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IFake;

type
  IViewMain = interface(IView)
    ['{F4C87C2B-8091-4C99-963D-318C02EE1D90}']
    procedure ShowProgress(const aTitle: string; const aMax: Integer = 100);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress();

    procedure SetFakes(const aValue: TDataSet);
    property Fakes: TDataSet write SetFakes;

    function GetCurrentFake(): IFake;
    property CurrentFake: IFake read GetCurrentFake;
  end;

implementation

end.
