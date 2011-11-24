unit uSharedFileClass;

interface

type
  /// <summary>
  /// Класс-обёртка для обеспечения работ по созданию, маппингу и уничтожению
  /// объекта общей памяти.
  /// </summary>
  TSharedFileClass=class
  strict private
    FName: WideString;
    FSize: cardinal;
    FTimeOut: cardinal;
    FOpened: boolean;
    FMapped: boolean;
    FHandle: THandle;
    FMap: pointer;
    FMutexName: WideString;
    FMutexHandle: THandle;
    function _Open: boolean;
    function _Close: boolean;
    function _Map: boolean;
    function _Unmap: boolean;
    function _LockMap: boolean;
    function _UnlockMap: boolean;
    procedure SetMapped(const Value: boolean);
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
  uCommon;

resourcestring
  TEXT_ERROR_CREATE_MUTEX='Не удалось создать флаг управления процессом чтения/записи!';
  TEXT_ERROR_WAITFOR_MUTEX='Не удалось считать состояние флага управления процессом чтения/записи!';
  TEXT_ERROR_RELEASE_MUTEX='Не удалось удалить флаг управления процессом чтения/записи!';
  TEXT_ERROR_CLOSE_MUTEX_HANDLE='Не удалось закрыть идентификатор флага управления процессом чтения/записи!';
  TEXT_ERROR_CANT_MAP_CLOSED_FILE='Для выполнения маппинга вначале необходимо создать блок общей памяти!';
  TEXT_MUTEX_NAMESUFFIX='_MUTEX';

constructor TSharedFileClass.Create(const CustomName: WideString=''; const CustomSize: cardinal=1024; const TimeOut: cardinal=5000);
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

  Opened:=True;
end;

destructor TSharedFileClass.Destroy;
begin
  Mapped:=False;
  Opened:=False;
  inherited;
end;

procedure TSharedFileClass.SetMapped(const Value: boolean);
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

procedure TSharedFileClass.SetOpened(const Value: boolean);
begin
  if FOpened<>Value then
    begin
      if Value then
        begin
          if _Open then
            FOpened:=Value;
        end
      else
        if _Close then
          FOpened:=Value;
    end;
end;

function TSharedFileClass._Open: boolean;
begin
  FHandle:=CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, FSize, PWideChar(FName));
  Result:=FHandle<>NULL;
  if not Result then
    raise Exception.Create(TEXT_ERROR_CREATEFILEMAPPING+TEXT_ERRORCODE+IntToStr(GetLastError))
  else
    Result:=GetLastError<>ERROR_ALREADY_EXISTS;
  if not Result then
    raise Exception.Create(TEXT_ERROR_CREATEFILEMAPPING_ALREADYEXISTS+TEXT_ERRORCODE+IntToStr(GetLastError))
end;

function TSharedFileClass._Close: boolean;
begin
  Result:=CloseHandle(FHandle);
  if not Result then
    raise Exception.Create(TEXT_ERROR_CLOSE_FILEMAPPING_HANDLE+TEXT_ERRORCODE+IntToStr(GetLastError))
end;

function TSharedFileClass._Map: boolean;
begin
  FMap:=MapViewOfFile(FHandle, FILE_MAP_WRITE, 0, 0, 0);
  Result:=Assigned(FMap);
  if not Result then
    raise Exception.Create(TEXT_ERROR_MAPVIEWOFFILE+TEXT_ERRORCODE+IntToStr(GetLastError));
end;

function TSharedFileClass._Unmap: boolean;
begin
  Result:=UnmapViewOfFile(FMap);
  if not Result then
    raise Exception.Create(TEXT_ERROR_UNMAPVIEWOFFILE+TEXT_ERRORCODE+IntToStr(GetLastError));
end;

function TSharedFileClass._LockMap: boolean;
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

function TSharedFileClass._UnlockMap: boolean;
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

end.
