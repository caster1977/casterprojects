unit Budgeting.Logic.Classes.Configuration.TGeneralSection;

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
  TGeneralSection = class(TCustomSection)
  public
    /// <summary>
    /// Время начала периода расчётов
    /// </summary>
    [TDefaultValue('')]
    property StartDate: string index 0 read GetStringValue write SetStringValue;

    /// <summary>
    /// Время окончания периода расчётов
    /// </summary>
    [TDefaultValue('')]
    property StopDate: string index 1 read GetStringValue write SetStringValue;
  end;

implementation

end.
