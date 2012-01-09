unit uCommon;

interface

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtDebug);
  TLogMessagesTypes=set of TLogMessagesType;

const
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;

  CONST_MINVALUE_SHAREDMEMSIZE=1024;
  CONST_MINVALUE_RETRANSLATORPAUSE=100;
  CONST_MINVALUE_WATCHPAUSE=100;

  CONST_DEFAULTVALUE_RETRANSLATORPAUSE=1000;
  CONST_DEFAULTVALUE_WATCHPAUSE=1000;

  WPARAM_SERVER_WANNA_HANDLE=1; // сервер хочет handle клиента (LPARAM = handle сервера)
  WPARAM_CLIENT_SENDS_HANDLE=2; // клиент отправляет свой handle (LPARAM = handle клиента)
  WPARAM_SERVER_ACCEPT_CLIENT=3; // сервер подтверждает соединение с данным клиентом
  WPARAM_CLIENT_WANNA_SEND_FILE=4; // клиент хочет послать очередной файл
  WPARAM_SERVER_SENDS_SHAREDMEM_SIZE=5; // сервер отправляет размер блока общей памяти (LPARAM = размер буфера в байтах)
  WPARAM_SERVER_WANNA_FILENAME=6; // сервер хочет имя файла
  WPARAM_CLIENT_SENDS_FILENAME=7; // клиент отправляет имя файла (LPARAM = размер имени файла в байтах)
  WPARAM_SERVER_WANNA_FILESIZE=8; // сервер хочет размер файла в байтах
  WPARAM_CLIENT_SENDS_FILESIZE=9; // клиент отправляет размер файла в байтах (LPARAM = размер символьного представления размера файла в байтах)
  WPARAM_SERVER_WANNA_DATA=10; // сервер хочет указанный блок данных (LPARAM = порядковый номер запрашиваемого блока данных)
  WPARAM_CLIENT_SENDS_DATA=11; // клиент отправляет указанный блок данных (LPARAM = размер переданных данных в байтах)
  WPARAM_SERVER_WANNA_CRC32=12; // сервер хочет контрольную сумму указанного блока данных (LPARAM = порядковый номер запрашиваемого блока данных)
  WPARAM_CLIENT_SENDS_CRC32=13; // клиент отправляет контрольную сумму указанного блока данных (LPARAM = СКС32)
  WPARAM_SERVER_TRANSFER_COMPLETE=14; // сервер сообщает что получил файл полностью
  WPARAM_SERVER_TRANSFER_ERROR=15; // сервер сообщает об ошибке при получении файла
  WPARAM_CLIENT_WANNA_CANCEL_SENDING=16; // клиент хочет прекратить передачу файла
  WPARAM_CLIENT_SHUTDOWN=17; // клиент сообщает о своём отключении от сервера
  WPARAM_SERVER_SHUTDOWN=18; // сервер сообщает клиенту о своём выключении
  WPARAM_SERVER_LOST=19; // окно сервера более не существует
  WPARAM_CLIENT_LOST=20; // окно клиента более не существует

resourcestring
  TEXT_WM_SM_SERVER='WM_SM_SERVER';
  TEXT_WM_SM_CLIENT='WM_SM_CLIENT';
  TEXT_ERRORCODE=' Код ошибки: ';
  TEXT_REGISTERWINDOWMESSAGEERROR='Не удалось выполнить операцию регистрации оконного сообщения!';
  TEXT_CONFIGURATIONFORM_SUFFIX='настроек программы';
  TEXT_ABOUTFORM_SUFFIX='"О программе..."';

  TEXT_CONFIGURATION_WINDOW_SHOWED='Отображено окно настроек программы.';

  TEXT_ACTION_SWITCHED='Действие "%s" %s.';
  TEXT_ACTION_ON='включено';
  TEXT_ACTION_OFF='выключено';

  TEXT_CHECKBOX_SWITCHED='Флажок "%s" %s.';
  TEXT_CHECKBOX_ON='включен';
  TEXT_CHECKBOX_OFF='выключен';

  TEXT_STATUSBAR_SWITCHED='Панель статуса %s.';
  TEXT_STATUSBAR_ON='включена';
  TEXT_STATUSBAR_OFF='отключена';

  TEXT_CONNECTION_SWITCHED='Индикатор соединения %s.';
  TEXT_CONNECTION_ON='включен';
  TEXT_CONNECTION_OFF='выключен';

  TEXT_SCROLLLOG_SWITCHED='Прокурутка к последнему сообщению протокола %s.';
  TEXT_SCROLLLOG_ON='включена';
  TEXT_SCROLLLOG_OFF='выключена';

  TEXT_HELP_FILE_OPENING='Производится попытка открытия справочного файла программы...';
  TEXT_HELP_FILE_NOT_FOUND='Извините, справочный файл к данной программе не найден.';
  TEXT_CONFIGURATION_VALUES_SETTED_TO_DEFAULTS='Настройки%s были сброшены пользователем в значения по умолчанию.';
  TEXT_CONFIGURATION_SUCCESSFULLY_APPLIED='Применение настроек программы прошло успешно.';
  TEXT_CONFIGURATION_TRYING_TO_READ='Производится попытка чтения настроек программы из файла...';
  TEXT_CONFIGURATION_SUCCESSFULLY_READED='Чтение настроек программы из файла конфигурации прошло успешно.';
  TEXT_CONFIGURATION_READ_ERROR='Произошла ошибка при попытке чтения настроек программы из файла!';
  TEXT_CONFIGURATION_SUCCESSFULLY_WRITTEN='Запись настроек программы в файл прошла успешно.';
  TEXT_CONFIGURATION_WINDOW_CLOSED='Окно изменения настроек программы закрыто.';
  TEXT_CONFIGURATION_SAVING_ABORTED_BY_USER='Попытка изменения настроек программы была отменена пользователем.';
  TEXT_CONFIGURATION_SAVING_CONFIRMED_BY_USER='Попытка изменения настроек программы была подтверждена пользователем.';

  TEXT_CONFIGURATION_PAGE_INTERFACE=' интерфейса';
  TEXT_CONFIGURATION_PAGE_LOCATION=' расположения файлов и папок';
  TEXT_CONFIGURATION_PAGE_LOG=' ведения протокола работы';
  TEXT_CONFIGURATION_PAGE_WINDOW_SIZES=' положения и размеров окон';
  TEXT_CONFIGURATION_PAGE_OTHER=' прочие';

  TEXT_WINDOW_SHOWED='Отображено окно "%s".';
  TEXT_WINDOW_CLOSED='Окно "%s" закрыто.';
  TEXT_APPLICATION_VERSION='Версия %d.%d Release %d Build %d';

  TEXT_ARE_YOU_SURE_YOU_WANNA_QUIT='Вы действительно хотите завершить работу программы?';
  TEXT_QIUT_CONFIRMATION='%s - Подтверждение выхода';
  TEXT_QIUT_CONFIRMED='Завершение работы приложения было подтверждено.';
  TEXT_QIUT_ABORTED_BY_USER='Завершение работы приложения было отменено пользователем.';

  TEXT_DATETIME_FORMAT = 'dd.mm.yyyy hh:nn:ss';
  TEXT_DO_YOU_WANNA_RETRY_CONFIGURATION_SAVING='Вы желаете повторить попытку записи настроек программы в файл?';
  TEXT_WARNING='%s - Предупреждение';
  TEXT_ERROR='%s - Ошибка!';

  TEXT_MESSAGE_REGISTRATION_COMPLETED_SUCCESSFULLY='Регистрация оконных сообщений выполнена успешно.';

  TEXT_WATCH_THREAD_STARTED='Поток наблюдения за наличием соединения между сервером и клиентом запущен.';
  TEXT_WATCH_THREAD_STOPPED='Поток наблюдения за наличием соединения между сервером и клиентом остановлен.';

  TEXT_SHARED_MEMORY_NAME_GETTING_SUCCESSFULLY='Получено имя объекта общей памяти: %s.';
  TEXT_SHARED_MEMORY_NAME_GETTING_ERROR='Не удалось получить имя объекта общей памяти!';
  TEXT_SHARED_MEMORY_NAME_USED_DEFAULT='Будет использовано имя общей памяти по умолчанию: %s.';

  TEXT_DEFAULT_SHARED_MEMORY_NAME='6579B61D-DA05-480A-A29B-B0998A354860';

  TEXT_CHUNK_OBJECT_CREATED='Создан объект порции данных.';
  TEXT_CHUNK_OBJECT_DESTROYED='Объект порции данных уничтожен.';
  TEXT_SHARED_MEMORY_OBJECT_CREATED='Создан объект доступа к общей памяти.';
  TEXT_SHARED_MEMORY_OBJECT_DESTROYED='Объект доступа к общей памяти уничтоден.';
  TEXT_CHUNKEDFILE_OBJECT_CREATED='Создан объект доступа к порционному файлу.';
  TEXT_CHUNKEDFILE_OBJECT_DESTROYED='Объект доступа к порционному файлу уничтоден.';
  TEXT_CHUNKEDFILE_OBJECT_CREATION_ERROR='Объект порционного файла уже был создан ранее!';

type
  CommonFunctions=class
  strict private
    class procedure GetCRC32(const Buff: pointer; const Len: integer; var CRC32: cardinal);
    class procedure UpdateCRC32(const Buff: pointer; const Len: integer; var CRC32: cardinal);
  public
    class procedure GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean); static;
    class function GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string; static;
    class function CRC32OfFile(const FileName: string): cardinal;
    class function CRC32OfByteArray(const ByteArray: TArray<byte>): cardinal;
    class function CRC32OfBuffer(const Buffer: pointer; const Len: integer): cardinal;
  end;

implementation

uses
  System.Classes,
  System.SysUtils,
  System.Win.ComObj,
  Winapi.Windows;

const
  CRC32INIT=$FFFFFFFF;
  MaxBuffer=64*1024;

var
  CRC32table: array [0..255] of cardinal;

class function CommonFunctions.CRC32OfBuffer(const Buffer: pointer; const Len: integer): cardinal;
begin
  Result:=CRC32INIT;
  UpdateCrc32(Buffer, Len, Result);
  Result:=not Result;
end;

class function CommonFunctions.CRC32OfByteArray(const ByteArray: TArray<byte>): cardinal;
begin
  Result:=CRC32INIT;
  UpdateCrc32(ByteArray, Length(ByteArray), Result);
  Result:=not Result;
end;

class function CommonFunctions.CRC32OfFile(const FileName: string): cardinal;
resourcestring
  TEXT_OUTOFMEMORY='Не удалось выделить блок динамической памяти для буфера чтения из файла!';
  TEXT_FILEERROR='При обработке файла [%s] возникла oшибка [%s]!';
var
  InFile: TFileStream;
  Readed: Integer;
  ByteArray: TArray<byte>;
begin
  Result:=CRC32INIT;
  try
    try
      SetLength(ByteArray, MaxBuffer);
      try
        InFile:=TFileStream.Create(FileName, fmOpenRead);
        InFile.Position:=0;
        Readed:=InFile.Read(ByteArray { [0] } , MaxBuffer);
        while Readed<>0 do
          begin
            UpdateCrc32(ByteArray, Readed, Result);
            Readed:=InFile.Read(ByteArray { [0] } , MaxBuffer);
          end;
      finally
        FreeAndNil(InFile);
      end;
    except
      on EOutOfMemory do
        raise Exception.Create(TEXT_OUTOFMEMORY);
      on E: Exception do
        raise Exception.Create(Format(TEXT_FILEERROR, [FileName, E.Message]));
    end;
  finally
    if Assigned(ByteArray) then
      SetLength(ByteArray, 0);
  end;
  Result:=not Result;
end;

class procedure CommonFunctions.GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean);
begin
  aErrorMessage:=aMessage;
  aErrorFlag:=True;
end;

class function CommonFunctions.GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string;
begin
  if Condition then
    Result:=TrueString
  else
    Result:=FalseString;
end;

class procedure CommonFunctions.GetCRC32(const Buff: pointer; const Len: integer; var CRC32: cardinal);
type
  Buffer=array [0..MaxBuffer-1] of byte;
var
  q: ^Buffer;
  i: integer;
begin
  q:=Buff;
  for i:=0 to Len-1 do
    CRC32:=(CRC32 shr 8)xor CRC32table[q^[i] xor(CRC32 and $000000FF)];
end;

class procedure CommonFunctions.UpdateCRC32(const Buff: pointer; const Len: integer; var CRC32: cardinal);
begin
  GetCRC32(Buff, Len, CRC32);
end;

procedure CRCInit;
var
  c: cardinal;
  i, j: integer;
begin
  for i:=0 to 255 do
    begin
      c:=i;
      for j:=1 to 8 do
        if odd(c) then
          c:=(c shr 1)xor $EDB88320
        else
          c:=(c shr 1);
      CRC32table[i]:=c;
    end;
end;

initialization

CRCinit;

end.
