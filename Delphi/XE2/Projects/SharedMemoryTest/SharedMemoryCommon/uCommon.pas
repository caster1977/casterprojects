unit uCommon;

interface

resourcestring
  TEXT_READDATA='WM_READDATA';
  TEXT_WRITEDATA='WM_WRITEDATA';
  TEXT_DONE='WM_DONE';

  TEXT_MUTEX_NAME='SharedMemoryMutex';
  TEXT_ERROR_CREATE_MUTEX='Не удалось создать флаг управления процессом чтения/записи!';
  TEXT_ERROR_WAITFOR_MUTEX='Не удалось дождаться корректного состояния флага управления процессом чтения/записи!';
  TEXT_ERROR_RELEASE_MUTEX='Не удалось удалить флаг управления процессом чтения/записи!';
  TEXT_ERROR_CLOSE_MUTEX_HANDLE='Не удалось закрыть идентификатор флага управления процессом чтения/записи!';

type
  TCommonFunctions=class
  public
    class function Do_LockMappedFile(var MutexHandle: THandle; const TimeOut: cardinal): Boolean;
    class function Do_UnlockMappedFile(const MutexHandle: THandle): boolean;
  end;

implementation

uses
  WinAPI.Windows,
  System.SysUtils;

{ CommonFunctions }

class function TCommonFunctions.Do_LockMappedFile(var MutexHandle: THandle; const TimeOut: cardinal): Boolean;
begin
  Result:=False;
  MutexHandle:=CreateMutex(nil, False, PWideChar(TEXT_MUTEX_NAME));
  if MutexHandle=0 then
    raise Exception.Create(TEXT_ERROR_CREATE_MUTEX)
  else
    if WaitForSingleObject(MutexHandle, TimeOut)=WAIT_FAILED then
      raise Exception.Create(TEXT_ERROR_WAITFOR_MUTEX)
    else
      Result:=True;
end;

class function TCommonFunctions.Do_UnlockMappedFile(const MutexHandle: THandle): boolean;
begin
  Result:=False;
  if ReleaseMutex(MutexHandle)=0 then
    raise Exception.Create(TEXT_ERROR_RELEASE_MUTEX)
  else
    if CloseHandle(MutexHandle) then
      raise Exception.Create(TEXT_ERROR_CLOSE_MUTEX_HANDLE)
    else
      Result:=True;
end;

end.
