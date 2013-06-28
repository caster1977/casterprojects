unit CastersPackage.uISerilizator;

interface

uses
  CastersPackage.uTObjectMethod;

type

  ISerilizator = interface
    ['{56D530BA-6BE7-4C51-9069-25379A3B6513}']
    procedure Load;
    procedure Save;

    function GetLoading: TObjectMethod;
    procedure SetLoading(const AValue: TObjectMethod);
    property Loading: TObjectMethod read GetLoading write SetLoading;

    function GetSaving: TObjectMethod;
    procedure SetSaving(const AValue: TObjectMethod);
    property Saving: TObjectMethod read GetSaving write SetSaving;

    function GetBeforeSave: TObjectMethod;
    procedure SetBeforeSave(const AValue: TObjectMethod);
    property BeforeSave: TObjectMethod read GetBeforeSave write SetBeforeSave;

    function GetAfterLoad: TObjectMethod;
    procedure SetAfterLoad(const AValue: TObjectMethod);
    property AfterLoad: TObjectMethod read GetAfterLoad write SetAfterLoad;
  end;

implementation

end.
