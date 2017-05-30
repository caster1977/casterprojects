unit Budgeting.Logic.Interfaces.ICosignatoryPresenter;

interface

uses
  System.Classes,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter;

type
  ICosignatoryPresenter = interface(ICustomPresenter)
    ['{BA39D249-81E4-409B-82E0-FACFF3D0DE05}']
    procedure LoadBanks(var aList: TStringList);
  end;

implementation

end.
