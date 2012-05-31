unit OA5.uINormalized;

interface

type
  INormalized = interface(IUnknown)
  ['{AD602BB0-347C-4223-B729-4CE1CC8A1E0F}']
    function GetAutoNormalizeData: boolean;
    procedure SetAutoNormalizeData(const Value: boolean);
    /// <summary>
    /// Функция валидации данных класса (только проверка значений)
    /// </summary>
    /// <returns>
    /// <para>
    /// Если нормализация данных <i>
    /// <b>не требуется</b>
    /// </i> - будет возвращено <b>True</b>.
    /// </para>
    /// <para>
    /// Если нормализация данных <i>
    /// <b>требуется</b>
    /// </i>, будет возвращено <b>False</b>.
    /// </para>
    /// </returns>
    /// <remarks>
    /// См. также процедуру <b>Normalize</b>
    /// </remarks>
    function Normalized: boolean;
    /// <summary>
    /// Процедура нормализации значений данных класса
    /// </summary>
    /// <remarks>
    /// См. также функцию <b>Normalized</b>
    /// </remarks>
    procedure Normalize;
    /// <summary>
    /// Требуется ли при записи данных в поля автоматически проводить их
    /// нормализацию?
    /// </summary>
    /// <remarks>
    /// Так же исходное значение можно передать при создании объекта через
    /// конструктор <b>Create(<i>значение</i>);</b>
    /// </remarks>
    property _AutoNormalizeData: boolean read GetAutoNormalizeData write SetAutoNormalizeData;
  end;

implementation

end.
