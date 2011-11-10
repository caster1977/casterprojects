unit uCommon;

interface

const
  ICON_BUSY=0;
  ICON_READY=1;

  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;

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
    class function Do_LockMappedFile(var MutexHandle: THandle; const TimeOut: cardinal): Boolean; static;
    class function Do_UnlockMappedFile(const MutexHandle: THandle): boolean; static;
    class procedure GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean); static;
    class function GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string; static;
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
  if not ReleaseMutex(MutexHandle) then
    raise Exception.Create(TEXT_ERROR_RELEASE_MUTEX)
  else
    if CloseHandle(MutexHandle) then
      raise Exception.Create(TEXT_ERROR_CLOSE_MUTEX_HANDLE)
    else
      Result:=True;
end;

class procedure TCommonFunctions.GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean);
begin
  aErrorMessage:=aMessage;
  aErrorFlag:=True;
end;

class function TCommonFunctions.GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string;
begin
  if Condition then
    Result:=TrueString
  else
    Result:=FalseString;
end;

end.
