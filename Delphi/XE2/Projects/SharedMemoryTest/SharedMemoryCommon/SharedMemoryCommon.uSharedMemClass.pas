/// <summary>
/// ������-������ ������ TSharedMemClass
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
  /// �����, �������������� ������ �� ��������, �������� � �����������
  /// ������� ����� ������.
  /// </summary>
  TSharedMemClass=class
  strict private

    /// <summary>
    /// ������������ ������� ����� ������.
    /// </summary>
    FName: WideString;

    /// <summary>
    /// ������ ������� ����� ������ � ������.
    /// </summary>
    FSize: cardinal;

    /// <summary>
    /// ����� �������� (� ������������) ��������� ������� � ��������,
    /// ��������������� ���������������� ������ (������/������) �
    /// ������������������� ����� ������.
    /// </summary>
    FTimeOut: cardinal;

    /// <summary>
    /// ����, ��������������� � ������� ��������� ������� ����� ������
    /// </summary>
    /// <value>
    /// �������� <b>True</b> ��������, ��� ������ ����� ������ ������
    /// � ����� � ��������, <b>False</b> - ������ ����� ������ ��� ��
    /// ������ ���� ��� ���������.
    /// </value>
    FOpened: boolean;

    /// <summary>
    /// ����, ��������������� � ������� ��������� �������� ������� ����� ������
    /// </summary>
    /// <value>
    /// �������� <b>True</b> ��������, ��� ������� ������� ����� ������ �������
    /// � ����� � ������/������, <b>False</b> - ������� �� ��������.
    /// </value>
    FMapped: boolean;

    /// <summary>
    /// Handle ������� ����� ������.
    /// </summary>
    FHandle: THandle;

    /// <summary>
    /// ��������� �� ������ ����� ����� ������.
    /// </summary>
    FMap: pointer;

    /// <summary>
    /// ��� ��������, ����������� �� ���������������� ������ � ����������� ������� ������.
    /// </summary>
    FMutexName: WideString;

    /// <summary>
    /// Handle ��������, ����������� �� ���������������� ������ � ����������� ������� ������.
    /// </summary>
    FMutexHandle: THandle;

    /// <summary>
    /// �����, ����������� �������� ������� ����� ������.
    /// </summary>
    function _Open: boolean;

    /// <summary>
    /// �����, ����������� ����������� ������� ����� ������.
    /// </summary>
    function _Close: boolean;

    /// <summary>
    /// �����, ������������ ������� � ������� ����� ������.
    /// </summary>
    function _Map: boolean;

    /// <summary>
    /// �����, ����������� ������� � ������� ����� ������.
    /// </summary>
    function _Unmap: boolean;

    /// <summary>
    /// �����, ����������� ������ � ������� ����� ������ ������ ������ ������.
    /// </summary>
    function _LockMap: boolean;

    /// <summary>
    /// �����, ����������� ������ � ������� ����� ������ ������ ������ ������.
    /// </summary>
    function _UnlockMap: boolean;

    /// <summary>
    /// �����, �������������� ��������� �������� �������� Mapped � ����������� �� ������� �������.
    /// </summary>
    procedure SetMapped(const Value: boolean);

    /// <summary>
    /// �����, �������������� ��������� �������� �������� Opened � ����������� �� ������� �������.
    /// </summary>
    procedure SetOpened(const Value: boolean);
  strict protected

    /// <summary>
    /// �������� �� �������� �������� � ����������� ������� ����� ������.
    /// </summary>
    /// <value>
    /// ��� ��������� �������� <b>True</b> ������������������� ����� �����
    /// ������, ��� <b>False</b> -�����������.
    /// </value>
    /// <remarks>
    /// ������������� ��������������� � <b>True</b> ��� �������� ����������
    /// ������.
    /// </remarks>
    property Opened: boolean read FOpened write SetOpened stored False;

    /// <summary>
    /// Handle ������������ ��� ������ ������� <b>CreateFileMapping</b>
    /// ������� ����� ������.
    /// </summary>
    /// <remarks>
    /// <b>������ ��� ������.</b>
    /// </remarks>
    property Handle: THandle read FHandle stored False;

    /// <summary>
    /// Handle ������������ ��� ������ ������� <b>CreateMutex</b> �������
    /// ���� �������, ���������������� ��� ����������� �����������������
    /// ������� (�����/������) � ������� ����� ������.
    /// </summary>
    /// <remarks>
    /// <b>������ ��� ������.</b>
    /// </remarks>
    property MutexHandle: THandle read FMutexHandle stored False;

    /// <summary>
    /// ��� ������������ ��� ������ ������� <b>CreateMutex</b> ������� ����
    /// �������, ���������������� ��� ����������� ����������������� �������
    /// (�����/������) � ������� ����� ������.
    /// </summary>
    /// <remarks>
    /// <b>������ ��� ������.</b>
    /// </remarks>
    property MutexName: WideString read FMutexName stored False;
  public

    /// <summary>
    /// ����������� ������.
    /// </summary>
    /// <param name="CustomName">
    /// <b>�������������� ��������.</b> ���������� ������� ����� ������. ��
    /// ��������� ���������� ��������� ����������� �����(GUID).
    /// </param>
    /// <param name="CustomSize">
    /// <b>�������������� ��������</b>. ������ ����� ����� ������ � ������.
    /// �� ��������� ����� 1024 (1Kb).
    /// <b>�������� ������ ���� ������ ����!</b>
    /// </param>
    /// <param name="TimeOut">
    /// <para>
    /// <b>�������������� ��������</b>. ����� �������� (� ������������)
    /// ��������� ������� � ��������, ��������������� ����������������
    /// ������ (������/������) � ������������������� ����� ������.
    /// </para>
    /// <para>
    /// �������� �� ��������� ����� 5000 (5 ������).
    /// </para>
    /// </param>
    /// <remarks>
    /// �������������� ���� ���������� ������� � ������ ������ ����� ������.
    /// ��� ���������� ������ � ����� ������� ���������� �������� �������
    /// ������� ��� ������ ��������� �������� �������� <b>Mapped</b>.
    /// </remarks>
    constructor Create(const CustomName: WideString=''; const CustomSize: cardinal=1024; const TimeOut: cardinal=5000);

    /// <summary>
    /// ���������� �������.
    /// </summary>
    /// <remarks>
    /// ��� ������������� ��������� ������� � ������������������� ������
    /// ����� ������.
    /// </remarks>
    destructor Destroy; override;

    /// <summary>
    /// �����, �������������� ������ ��������� ������ ������ �� ����� ������.
    /// </summary>
    /// <param name="Len">
    /// ������ ������ ����������� ������ � ������
    /// </param>
    /// <param name="Chunk">
    /// ������ ������ ������, � ������� ����� �������� ��������� �� �����
    /// ������ ������ ������
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ������������ ������ �������, <b>False</b> �
    /// ������ ������.
    /// </returns>
    function Read(const Len: cardinal; out Chunk: TChunkClass): boolean;

    /// <summary>
    /// �����, �������������������� ��������� ������ ������ � ����� ������.
    /// </summary>
    /// <param name="Chunk">
    /// ������ ������ ������, ������ �������� ������������� � ����� ������
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ���� �������� ������ �������, <b>False</b> �
    /// ������ ������.
    /// </returns>
    function Write(const Chunk: TChunkClass): boolean;

    /// <summary>
    /// ��������, ��������������� ������ � ����� ������� ����� ������.
    /// </summary>
    /// <remarks>
    /// <b>������ ��� ������.</b>
    /// </remarks>
    property name: WideString read FName stored False;

    /// <summary>
    /// ��������, ��������������� ������ �������� ������� ����� ������.
    /// </summary>
    /// <remarks>
    /// <b>������ ��� ������.</b>
    /// </remarks>
    property Size: cardinal read FSize stored False;

    /// <summary>
    /// �������� �� �������� ����������� ������������� ������� � �������
    /// ����� ������.
    /// </summary>
    /// <value>
    /// ��� ��������� �������� <b>True</b> ���������� ��������� ��������
    /// ����� ����� ������, ��� <b>False</b> -����������.
    /// </value>
    /// <remarks>
    /// ��� �������� ������� ������� �������� (<b>False</b>).
    /// </remarks>
    property Mapped: boolean read FMapped write SetMapped stored False;

    /// <summary>
    /// ��������� �� ������ ������� ������ ��� �������� ����� ����� �����
    /// ������.
    /// </summary>
    /// <remarks>
    /// <b>������ ��� ������.</b>
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
  TEXT_ERROR_CREATE_MUTEX='�� ������� ������� ���� ���������� ��������� ������/������!';
  TEXT_ERROR_WAITFOR_MUTEX='�� ������� ������� ��������� ����� ���������� ��������� ������/������!';
  TEXT_ERROR_RELEASE_MUTEX='�� ������� ������� ���� ���������� ��������� ������/������!';
  TEXT_ERROR_CLOSE_MUTEX_HANDLE='�� ������� ������� ������������� ����� ���������� ��������� ������/������!';
  TEXT_ERROR_CANT_MAP_CLOSED_FILE='��� ���������� �������� ������� ���������� ������� ���� ����� ������!';
  TEXT_MUTEX_NAMESUFFIX='_MUTEX';
  TEXT_ERROR_INVALID_MAP_POINTER='�������� ��������� �� ������� ����� ������!';
  TEXT_ERROR_MUST_MAPPED_FIRST='������� ���������� ��������� ������� ����� ������!';
  TEXT_ERROR_INVALID_CHUNK_SIZE='������ ������ ������� ������ ������ ��������� ������ ����� ������!';
  TEXT_WRONGSHAREDMEMORYSIZE='������ ����� ����� ������ �� ������ ���� ����� ������ �����!';
  TEXT_ERROR_CREATEFILEMAPPING='�� ������� ������� ���� ����� ������!';
  TEXT_ERROR_CLOSE_FILEMAPPING_HANDLE='�� ������� ������� ������������� ����� ����� ������!';
  TEXT_ERROR_MAPVIEWOFFILE='�� ������� ������������ � ����� ����� ������!';
  TEXT_ERROR_UNMAPVIEWOFFILE='�� ������� ����������� �� ����� ����� ������!';


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
