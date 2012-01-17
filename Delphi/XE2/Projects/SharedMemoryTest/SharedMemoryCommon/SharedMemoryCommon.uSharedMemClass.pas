/// <summary>
/// Модуль-обёртка класса TSharedMemClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit SharedMemoryCommon.uSharedMemClass;

interface

uses
  SharedMemoryCommon.uChunkClass;

type

  /// <summary>
  /// Класс, обеспечивающий работы по созданию, маппингу и уничтожению
  /// объекта общей памяти.
  /// </summary>
  TSharedMemClass=class
  strict private

    /// <summary>
    /// Наименование объекта общей памяти.
    /// </summary>
    FName: WideString;

    /// <summary>
    /// Размер объекта общей памяти в байтах.
    /// </summary>
    FSize: cardinal;

    /// <summary>
    /// Время ожидания (в милисекундах) получения доступа к мьютексу,
    /// обеспечивающему последовательный доступ (чтение/запись) к
    /// одноименному  объекту общей памяти.
    /// </summary>
    FTimeOut: cardinal;

    /// <summary>
    /// Флаг, сигнализирующий о текущем состоянии объекта общей памяти
    /// </summary>
    /// <value>
    /// Значение <b>True</b> означает, что объект общей памяти создан
    /// и готов к маппингу, <b>False</b> - объект общей памяти ещё не
    /// создан либо уже уничтожен.
    /// </value>
    FOpened: boolean;

    /// <summary>
    /// Флаг, сигнализирующий о текущем состоянии маппинга объекта общей памяти
    /// </summary>
    /// <value>
    /// Значение <b>True</b> означает, что маппинг объекта общей памяти включён
    /// и готов к чтению/записи, <b>False</b> - маппинг не выполнен.
    /// </value>
    FMapped: boolean;

    /// <summary>
    /// Handle объекта общей памяти.
    /// </summary>
    FHandle: THandle;

    /// <summary>
    /// Указатель на начало блока общей памяти.
    /// </summary>
    FMap: pointer;

    /// <summary>
    /// Имя мьютекса, отвечающего за последовательный доступ к одноимённому объекту памяти.
    /// </summary>
    FMutexName: WideString;

    /// <summary>
    /// Handle мьютекса, отвечающего за последовательный доступ к одноимённому объекту памяти.
    /// </summary>
    FMutexHandle: THandle;

    /// <summary>
    /// Метод, выполняющий создание объекта общей памяти.
    /// </summary>
    function _Open: boolean;

    /// <summary>
    /// Метод, выполняющий уничтожение объекта общей памяти.
    /// </summary>
    function _Close: boolean;

    /// <summary>
    /// Метод, подключающий маппинг к объекту общей памяти.
    /// </summary>
    function _Map: boolean;

    /// <summary>
    /// Метод, отключающий маппинг к объекту общей памяти.
    /// </summary>
    function _Unmap: boolean;

    /// <summary>
    /// Метод, блокирующий доступ к объекту общей памяти прочим копиям класса.
    /// </summary>
    function _LockMap: boolean;

    /// <summary>
    /// Метод, разрешающий доступ к объекту общей памяти прочим копиям класса.
    /// </summary>
    function _UnlockMap: boolean;

    /// <summary>
    /// Метод, контролирующий устанавку значения свойства Mapped в зависимости от текущих условий.
    /// </summary>
    procedure SetMapped(const Value: boolean);

    /// <summary>
    /// Метод, контролирующий устанавку значения свойства Opened в зависимости от текущих условий.
    /// </summary>
    procedure SetOpened(const Value: boolean);
  strict protected

    /// <summary>
    /// Отвечает за механизм создания и уничтожения объекта общей памяти.
    /// </summary>
    /// <value>
    /// При установке значения <b>True</b> проводится создание блока общей
    /// памяти, при <b>False</b> -уничтожение.
    /// </value>
    /// <remarks>
    /// Автоматически устанавливается в <b>True</b> при создании экземпляра
    /// класса.
    /// </remarks>
    property Opened: boolean read FOpened write SetOpened stored False;

    /// <summary>
    /// Handle создаваемого при помощи функции <b>CreateFileMapping</b>
    /// объекта общей памяти.
    /// </summary>
    /// <remarks>
    /// <b>Только для чтения.</b>
    /// </remarks>
    property Handle: THandle read FHandle stored False;

    /// <summary>
    /// Handle создаваемого при помощи функции <b>CreateMutex</b> объекта
    /// типа мьютекс, предназначенного для организации последовательного
    /// доступа (чтени/запись) к объекту общей записи.
    /// </summary>
    /// <remarks>
    /// <b>Только для чтения.</b>
    /// </remarks>
    property MutexHandle: THandle read FMutexHandle stored False;

    /// <summary>
    /// Имя создаваемого при помощи функции <b>CreateMutex</b> объекта типа
    /// мьютекс, предназначенного для организации последовательного доступа
    /// (чтени/запись) к объекту общей записи.
    /// </summary>
    /// <remarks>
    /// <b>Только для чтения.</b>
    /// </remarks>
    property MutexName: WideString read FMutexName stored False;
  public

    /// <summary>
    /// Конструктор класса.
    /// </summary>
    /// <param name="CustomName">
    /// <b>Необязательный параметр.</b> Нменование объекта общей памяти. По
    /// умолчанию происходит генерация уникального имени(GUID).
    /// </param>
    /// <param name="CustomSize">
    /// <b>Необязательный параметр</b>. Размер блока общей памяти в байтах.
    /// По умолчанию равен 1024 (1Kb).
    /// <b>Значение должно быть больше нуля!</b>
    /// </param>
    /// <param name="TimeOut">
    /// <para>
    /// <b>Необязательный параметр</b>. Время ожидания (в милисекундах)
    /// получения доступа к мьютексу, обеспечивающему последовательный
    /// доступ (чтение/запись) к одноименному  объекту общей памяти.
    /// </para>
    /// <para>
    /// Значение по умолчанию равно 5000 (5 секунд).
    /// </para>
    /// </param>
    /// <remarks>
    /// Инициализирует поля экземпляра объекта и создаёт объект общей памяти.
    /// Для дальнейшей работы с общей памятью необходимо включить маппинг
    /// объекта при помощи изменения значения свойства <b>Mapped</b>.
    /// </remarks>
    constructor Create(const CustomName: WideString=''; const CustomSize: cardinal=1024; const TimeOut: cardinal=5000);

    /// <summary>
    /// Деструктор объекта.
    /// </summary>
    /// <remarks>
    /// При необходимости выключает маппинг и уничтожает имеющийся объект
    /// общей памяти.
    /// </remarks>
    destructor Destroy; override;

    /// <summary>
    /// Метод, обеспечивающий чтение очередной порции данных из общей памяти.
    /// </summary>
    /// <param name="Len">
    /// Размер порции считываемых данных в байтах
    /// </param>
    /// <param name="Chunk">
    /// Объект порции данных, в который будет помещена считанная из общей
    /// памяти порция данных
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если операция прошла успешно, <b>False</b> в
    /// случае ошибки.
    /// </returns>
    function Read(const Len: cardinal; out Chunk: TChunkClass): boolean;

    /// <summary>
    /// Метод, обеспечивающий запись очередной порции данных в общую память.
    /// </summary>
    /// <param name="Chunk">
    /// Объект порции данных, данные которого будут записаны в общую память
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если операция прошла успешно, <b>False</b> в
    /// случае ошибки.
    /// </returns>
    function Write(const Chunk: TChunkClass): boolean;

    /// <summary>
    /// Свойство, предоставляющее доступ к имени объекта общей памяти.
    /// </summary>
    /// <remarks>
    /// <b>Только для чтения.</b>
    /// </remarks>
    property name: WideString read FName stored False;

    /// <summary>
    /// Свойство, предоставляющее доступ к размеру объекта общей памяти.
    /// </summary>
    /// <remarks>
    /// <b>Только для чтения.</b>
    /// </remarks>
    property Size: cardinal read FSize stored False;

    /// <summary>
    /// Отвечает за механизм обеспечения эксключивного доступа к объекту
    /// общей памяти.
    /// </summary>
    /// <value>
    /// При установке значения <b>True</b> проводится включение маппинга
    /// блока общей памяти, при <b>False</b> -отключение.
    /// </value>
    /// <remarks>
    /// При создании объекта маппинг выключен (<b>False</b>).
    /// </remarks>
    property Mapped: boolean read FMapped write SetMapped stored False;

    /// <summary>
    /// Указатель на начало области памяти при маппинге части блока общей
    /// памяти.
    /// </summary>
    /// <remarks>
    /// <b>Только для чтения.</b>
    /// </remarks>
    property Map: pointer read FMap stored False;
  end;

implementation

uses
  System.Variants,
  System.IOUtils,
  System.SysUtils,
  Winapi.Windows,
  SharedMemoryCommon.uCommon;

resourcestring
  TEXT_ERROR_CREATE_MUTEX='Не удалось создать флаг управления процессом чтения/записи!';
  TEXT_ERROR_WAITFOR_MUTEX='Не удалось считать состояние флага управления процессом чтения/записи!';
  TEXT_ERROR_RELEASE_MUTEX='Не удалось удалить флаг управления процессом чтения/записи!';
  TEXT_ERROR_CLOSE_MUTEX_HANDLE='Не удалось закрыть идентификатор флага управления процессом чтения/записи!';
  TEXT_ERROR_CANT_MAP_CLOSED_FILE='Для выполнения маппинга вначале необходимо создать блок общей памяти!';
  TEXT_MUTEX_NAMESUFFIX='_MUTEX';
  TEXT_ERROR_INVALID_MAP_POINTER='Неверный указатель на область общей памяти!';
  TEXT_ERROR_MUST_MAPPED_FIRST='Сначала необходимо выполнить маппинг общей памяти!';
  TEXT_ERROR_INVALID_CHUNK_SIZE='Размер данных объекта порции памяти превышает размер общей памяти!';
  TEXT_WRONGSHAREDMEMORYSIZE='Размер блока общей памяти не должен быть менее одного байта!';
  TEXT_ERROR_CREATEFILEMAPPING='Не удалось создать блок общей памяти!';
  TEXT_ERROR_CLOSE_FILEMAPPING_HANDLE='Не удалось закрыть идентификатор блока общей памяти!';
  TEXT_ERROR_MAPVIEWOFFILE='Не удалось подключиться к блоку общей памяти!';
  TEXT_ERROR_UNMAPVIEWOFFILE='Не удалось отключиться от блока общей памяти!';


constructor TSharedMemClass.Create(const CustomName: WideString=''; const CustomSize: cardinal=1024; const TimeOut: cardinal=5000);
begin
  if Trim(CustomName)='' then
    FName:=TPath.GetGUIDFileName(True)
  else
    FName:=Trim(CustomName);
  FMutexName:=FName+WideString(TEXT_MUTEX_NAMESUFFIX);

  if CustomSize>0 then
    FSize:=CustomSize
  else
    raise Exception.Create(TEXT_WRONGSHAREDMEMORYSIZE);

  FTimeOut:=TimeOut;
  FMap:=nil;

  Opened:=True;
end;

destructor TSharedMemClass.Destroy;
begin
  Mapped:=False;
  Opened:=False;
  inherited;
end;

procedure TSharedMemClass.SetMapped(const Value: boolean);
begin
  if FMapped<>Value then
    if not Opened then
      raise Exception.Create(TEXT_ERROR_CANT_MAP_CLOSED_FILE)
    else
      if Value then
        begin
          if _LockMap then
            if _Map then
              FMapped:=Value;
        end
      else
        if _UnlockMap then
          if _Unmap then
            FMapped:=Value;
end;

procedure TSharedMemClass.SetOpened(const Value: boolean);
begin
  if FOpened<>Value then
    if Value then
      begin
        if _Open then
          FOpened:=Value;
      end
    else
      if _Close then
        FOpened:=Value;
end;

function TSharedMemClass._Open: boolean;
begin
  FHandle:=CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, FSize, PWideChar(FName));
  Result:=FHandle<>NULL;
  if not Result then
    raise Exception.Create(TEXT_ERROR_CREATEFILEMAPPING+TEXT_ERRORCODE+IntToStr(GetLastError));
end;

function TSharedMemClass._Close: boolean;
begin
  Result:=CloseHandle(FHandle);
  if not Result then
    raise Exception.Create(TEXT_ERROR_CLOSE_FILEMAPPING_HANDLE+TEXT_ERRORCODE+IntToStr(GetLastError))
end;

function TSharedMemClass._Map: boolean;
begin
  FMap:=MapViewOfFile(FHandle, FILE_MAP_WRITE, 0, 0, 0);
  Result:=Assigned(FMap);
  if not Result then
    raise Exception.Create(TEXT_ERROR_MAPVIEWOFFILE+TEXT_ERRORCODE+IntToStr(GetLastError));
end;

function TSharedMemClass._Unmap: boolean;
begin
  Result:=UnmapViewOfFile(FMap);
  FMap:=nil;
  if not Result then
    raise Exception.Create(TEXT_ERROR_UNMAPVIEWOFFILE+TEXT_ERRORCODE+IntToStr(GetLastError));
end;

function TSharedMemClass._LockMap: boolean;
begin
  FMutexHandle:=CreateMutex(nil, False, PWideChar(FMutexName));
  Result:=FMutexHandle<>0;
  if not Result then
    raise Exception.Create(TEXT_ERROR_CREATE_MUTEX)
  else
    begin
      Result:=WaitForSingleObject(FMutexHandle, FTimeOut)<>WAIT_FAILED;
      if not Result then
        raise Exception.Create(TEXT_ERROR_WAITFOR_MUTEX+TEXT_ERRORCODE+IntToStr(GetLastError));
    end;
end;

function TSharedMemClass._UnlockMap: boolean;
begin
  Result:=ReleaseMutex(FMutexHandle);
  if not Result then
    raise Exception.Create(TEXT_ERROR_RELEASE_MUTEX)
  else
    begin
      Result:=CloseHandle(FMutexHandle);
      if not Result then
        raise Exception.Create(TEXT_ERROR_CLOSE_MUTEX_HANDLE+TEXT_ERRORCODE+IntToStr(GetLastError));
    end;
end;

function TSharedMemClass.Read(const Len: cardinal; out Chunk: TChunkClass): boolean;
begin
  if not Assigned(Chunk) then
    Chunk:=TChunkClass.Create;
  if Mapped then
    if Assigned(FMap) then
      if Chunk.Size<=Size then
        begin
          Chunk.Size:=Len;
          CopyMemory(Chunk.Data, Map, Chunk.Size);
          Result:=Chunk.CRC32=CommonFunctions.CRC32OfBuffer(Map, Chunk.Size);
        end
      else
        raise Exception.Create(TEXT_ERROR_INVALID_CHUNK_SIZE)
    else
      raise Exception.Create(TEXT_ERROR_INVALID_MAP_POINTER)
  else
    raise Exception.Create(TEXT_ERROR_MUST_MAPPED_FIRST);
end;

function TSharedMemClass.Write(const Chunk: TChunkClass): boolean;
begin
  if not Assigned(Chunk) then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_OBJECT);
  if Mapped then
    if Assigned(FMap) then
      if Chunk.Size<=Size then
        begin
          CopyMemory(Map, Chunk.Data, Chunk.Size);
          Result:=Chunk.CRC32=CommonFunctions.CRC32OfBuffer(Map, Chunk.Size);
        end
      else
        raise Exception.Create(TEXT_ERROR_INVALID_CHUNK_SIZE)
    else
      raise Exception.Create(TEXT_ERROR_INVALID_MAP_POINTER)
  else
    raise Exception.Create(TEXT_ERROR_MUST_MAPPED_FIRST);
end;

end.
