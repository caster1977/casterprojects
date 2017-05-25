unit Budgeting.Logic.Classes.Configuration.Section.TGeneral;

interface

uses
  ConfigPackage.Logic.TCustomSection,
  ConfigPackage.Logic.TDefaultValueAttribute,
  ConfigPackage.Logic.TSectionAttribute,
  Budgeting.Logic.Consts;

type

  /// <summary>
  /// Основные настройки
  /// </summary>
  [TSection(GENERAL_SECTION)]
  TGeneral = class(TCustomSection)
  public
    /// <summary>
    /// Расчётный год
    /// </summary>
    [TDefaultValue(0)]
    property Year: Integer index 0 read GetIntegerValue write SetIntegerValue;
  end;

implementation

end.
