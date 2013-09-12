unit uIDamagedBSOItem;

interface

uses
  uICustomBSOItem;

type
  /// <summary>
  /// Интерфейс доступа к объектам типа "Испорченный БСО"
  /// </summary>
  IDamagedBSOItem = interface(ICustomBSOItem)
    ['{F6F22AC2-556E-4EEE-B637-129D520489E8}']
    function GetCauseOfDamageId: Integer;
    procedure SetCauseOfDamageId(const AValue: Integer);

    /// <summary>
    /// Идентификатор причины "порчи" БСО
    /// </summary>
    property CauseOfDamageId: Integer read GetCauseOfDamageId write SetCauseOfDamageId;

    function GetCauseOfDamageName: string;
    procedure SetCauseOfDamageName(const AValue: string);

    /// <summary>
    /// Наименование причины "порчи" БСО
    /// </summary>
    property CauseOfDamageName: string read GetCauseOfDamageName write SetCauseOfDamageName;
  end;

implementation

end.
