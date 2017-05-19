unit UniversalExport.Service.Exporter.Logic.Classes.Configuration.Section.TGeneral;

interface

uses
  ConfigPackage.Logic.TCustomSection,
  ConfigPackage.Logic.TDefaultValueAttribute,
  ConfigPackage.Logic.TSectionAttribute;

type

  /// <summary>
  /// Общие настройки
  /// </summary>
  [TSection('General')]
  TGeneral = class(TCustomSection)
  public
    /// <summary>
    /// Уникальный идентификатор экземпляра службы
    /// </summary>
    [TDefaultValue(-1)]
    property ServiceId: Integer index 0 read GetIntegerValue write SetIntegerValue;

    /// <summary>
    /// Пауза в секундах между циклами проверки завершения выполнения задач
    /// </summary>
    [TDefaultValue(10)]
    property SleepInterval: Integer index 1 read GetIntegerValue write SetIntegerValue;

    /// <summary>
    /// Максимальное количество одновременно обрабатываемых задач
    /// </summary>
    [TDefaultValue(20)]
    property MaximumThreads: Integer index 2 read GetIntegerValue write SetIntegerValue;

    /// <summary>
    /// Идентификатор типа обрабатываемых файлов
    /// </summary>
    [TDefaultValue(-1)]
    property FileFormatId: Integer index 3 read GetIntegerValue write SetIntegerValue;

    /// <summary>
    /// Режим одноразового запуска
    /// </summary>
    [TDefaultValue(False)]
    property SingleRunMode: Boolean index 4 read GetBooleanValue write SetBooleanValue;

    /// <summary>
    /// Пауза в секундах между циклами проверки необходимости обработки очереди задач
    /// </summary>
    [TDefaultValue(300)]
    property RefreshInterval: Integer index 5 read GetIntegerValue write SetIntegerValue;

    /// <summary>
    /// Путь к сетевой папке в который сохраняются временные файлы импортов
    /// </summary>
    [TDefaultValue('')]
    property TemporaryPath: string index 6 read GetStringValue write SetStringValue;

    /// <summary>
    /// Для файла импорта будет использовн формат [<Сущность>.<Домен>.<GUID>.xml]
    /// </summary>
    [TDefaultValue(False)]
    property UseFullTempFileName: Boolean index 7 read GetBooleanValue write SetBooleanValue;

    /// <summary>
    /// Удалять временные файлы в случае ошибки создания задания для конвертера
    /// </summary>
    [TDefaultValue(True)]
    property DeleteTempFiles: Boolean index 8 read GetBooleanValue write SetBooleanValue;

    /// <summary>
    /// Путь к сетевому каталогу, в который помещаются готовые файлы прайсов
    /// </summary>
    [TDefaultValue('')]
    property ReadyPath: string index 9 read GetStringValue write SetStringValue;
  end;

implementation

end.
