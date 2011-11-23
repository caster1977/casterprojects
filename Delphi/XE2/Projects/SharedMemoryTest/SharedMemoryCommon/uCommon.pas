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

  WPARAM_SERVER_WANNA_HANDLE = 1; // сервер хочет handle клиента (LPARAM = handle сервера)
  WPARAM_CLIENT_SENDS_HANDLE = 2; // клиент отправляет свой handle (LPARAM = handle клиента)

  WPARAM_CLIENT_WANNA_SEND_FILE = 3; // клиент хочет послать очередной файл
  WPARAM_SERVER_SENDS_BUFFER_SIZE = 4; // сервер отправляет размер буфера общей памяти (LPARAM = размер буфера в байтах)

  WPARAM_SERVER_WANNA_FILENAME = 5; // сервер хочет имя файла
  WPARAM_CLIENT_SENDS_FILENAME = 6; // клиент отправляет имя файла (LPARAM = размер имени файла в байтах)
  WPARAM_SERVER_WANNA_BLOCKS_QUANTITY = 7; // сервер хочет количество блоков в файле
  WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY = 8; // клиент отправляет количество блоков в файле (LPARAM = количество блоков в файле)
  WPARAM_SERVER_WANNA_DATA = 9; // сервер хочет указанный блок данных (LPARAM = порядковый номер запрашиваемого блока данных)
  WPARAM_CLIENT_SENDS_DATA = 10; // клиент отправляет указанный блок данных (LPARAM = размер переданных данных в байтах)
  WPARAM_SERVER_WANNA_CRC32 = 11; // сервер хочет контрольную сумму указанного блока данных (LPARAM = порядковый номер запрашиваемого блока данных)
  WPARAM_CLIENT_SENDS_CRC32 = 12; // клиент отправляет контрольную сумму указанного блока данных (LPARAM = размер строки СКС32 в байтах)

  WPARAM_CLIENT_SHUTDOWN = 13; // клиент сообщает о своём отключении от сервера
  WPARAM_SERVER_SHUTDOWN = 14; // сервер сообщает клиенту о своём выключении

  WPARAM_CLIENT_WANNA_CANCEL_SENDING = 15; // клиент хочет прекратить передачу файла
  WPARAM_SERVER_TRANSFER_COMPLETE = 16; // сервер сообщает что получил файл полностью


resourcestring
  TEXT_WM_SM_SERVER = 'WM_SM_SERVER';
  TEXT_WM_SM_CLIENT = 'WM_SM_CLIENT';

  TEXT_ERRORCODE = ' Код ошибки: ';
  TEXT_REGISTERWINDOWMESSAGEERROR='Не удалось выполнить операцию регистрации оконного сообщения!';
  TEXT_ERROR_CREATEFILEMAPPING='Не удалось создать блок общей памяти!';
  TEXT_ERROR_CREATEFILEMAPPING_ALREADYEXISTS='Блок общей памяти с таким именем уже существует!';
  TEXT_ERROR_MAPVIEWOFFILE='Не удалось подключиться к блоку общей памяти!';
  TEXT_ERROR_UNMAPVIEWOFFILE='Не удалось отключиться от блока общей памяти!';
  TEXT_ERROR_CLOSE_FILEMAPPING_HANDLE='Не удалось закрыть идентификатор блока общей памяти!';
  TEXT_ERROR_CREATEFILE='Не удалось создать файл на диске!';

  TEXT_WRONGBUFFERSIZE='Размер буфера для передачи данных не должен быть менее одного байта!';
  TEXT_WRONGSHAREDMEMORYSIZE='Размер блока общей памяти не должен быть менее одного байта!';

type
  TCommonFunctions=class
  public
    class procedure GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean); static;
    class function GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string; static;
  end;

implementation

uses
  WinAPI.Windows,
  System.SysUtils;

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
