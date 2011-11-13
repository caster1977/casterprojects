unit uCommon;

interface

const
  ICON_BUSY=0;
  ICON_READY=1;

  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;

  CONST_DEFAULTVALUE_DATABLOCKSIZE = 1024;
  CONST_DEFAULTVALUE_RETRANSLATORPAUSE = 1000;

  WPARAM_SERVER_READY = 1; // сигнал клиентам о том, что сервер готов к установке соединения, в LPARAM находится размер буфера для передачи данных в байтах
  WPARAM_SERVER_READING = 2; // сигнал клиенту о том, что сервер начинает считывать данные в блок памяти и клиенту нужно ждать, пока не прийдёт сообщение о запросе очередного блока данных
  WPARAM_SERVER_WAITING_FOR_DATA = 3; // сигнал клиенту о том, что сервер ждёт данные блока для чтения и в LPARAM находится номер блока, который ждёт сервер

  WPARAM_CLIENT_SENDS_HANDLE = 1; // сигнал серверу о том, что в LPARAM находится handle клиента
  WPARAM_CLIENT_SENDS_FILENAME = 2; // сигнал серверу о том, что в LPARAM находится указатель на имя передаваемого файла
  WPARAM_CLIENT_SENDS_DATA = 3; // сигнал серверу о том, что клиент начинает записывать данные в блок памяти и в LPARAM находится номер передаваемой части
  WPARAM_CLIENT_SENDS_SIZE = 4; // сигнал серверу о том, что клиент окончил записывать данные затребованного чанка в блок памяти и данные готовы для чтения и в LPARAM находится размер записанного в память блока данных в байтах
  WPARAM_CLIENT_SENDS_CRC32 = 5; // сигнал серверу о том, что в LPARAM находится контрольная сумма записанной части
  WPARAM_CLIENT_SENDS_EOF = 6; // сигнал серверу о том, что был достигнут конец файла и можно "закрыть" файл

resourcestring
  TEXT_WM_SM_SERVER = 'WM_SM_SERVER';
  TEXT_WM_SM_CLIENT = 'WM_SM_CLIENT';

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
