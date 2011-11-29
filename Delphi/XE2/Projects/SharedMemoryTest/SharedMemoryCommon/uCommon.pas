unit uCommon;

interface

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtDebug);
  TLogMessagesTypes=set of TLogMessagesType;

const
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;

  TEXT_CONFIGURATIONFORM_SUFFIX = 'настроек программы';
  TEXT_ABOUTFORM_SUFFIX = '"О программе..."';

  CONST_DEFAULTVALUE_DATABLOCKSIZE=1024;
  CONST_DEFAULTVALUE_RETRANSLATORPAUSE=1000;
  CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM: boolean=False;
  CONST_DEFAULTVALUE_KEEPLOGTYPES: TLogMessagesTypes=[lmtError, lmtWarning, lmtInfo];
  CONST_DEFAULTVALUE_SHOWSTATUSBAR: boolean=True;

  WPARAM_SERVER_WANNA_HANDLE=1; // сервер хочет handle клиента (LPARAM = handle сервера)
  WPARAM_CLIENT_SENDS_HANDLE=2; // клиент отправляет свой handle (LPARAM = handle клиента)

  WPARAM_CLIENT_WANNA_SEND_FILE=3; // клиент хочет послать очередной файл
  WPARAM_SERVER_SENDS_BUFFER_SIZE=4; // сервер отправляет размер буфера общей памяти (LPARAM = размер буфера в байтах)

  WPARAM_SERVER_WANNA_FILENAME=5; // сервер хочет имя файла
  WPARAM_CLIENT_SENDS_FILENAME=6; // клиент отправляет имя файла (LPARAM = размер имени файла в байтах)
  WPARAM_SERVER_WANNA_BLOCKS_QUANTITY=7; // сервер хочет количество блоков в файле
  WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY=8; // клиент отправляет количество блоков в файле (LPARAM = количество блоков в файле)
  WPARAM_SERVER_WANNA_DATA=9; // сервер хочет указанный блок данных (LPARAM = порядковый номер запрашиваемого блока данных)
  WPARAM_CLIENT_SENDS_DATA=10; // клиент отправляет указанный блок данных (LPARAM = размер переданных данных в байтах)
  WPARAM_SERVER_WANNA_CRC32=11; // сервер хочет контрольную сумму указанного блока данных (LPARAM = порядковый номер запрашиваемого блока данных)
  WPARAM_CLIENT_SENDS_CRC32=12; // клиент отправляет контрольную сумму указанного блока данных (LPARAM = СКС32)

  WPARAM_CLIENT_SHUTDOWN=13; // клиент сообщает о своём отключении от сервера
  WPARAM_SERVER_SHUTDOWN=14; // сервер сообщает клиенту о своём выключении

  WPARAM_CLIENT_WANNA_CANCEL_SENDING=15; // клиент хочет прекратить передачу файла
  WPARAM_SERVER_TRANSFER_COMPLETE=16; // сервер сообщает что получил файл полностью

resourcestring
  TEXT_WM_SM_SERVER='WM_SM_SERVER';
  TEXT_WM_SM_CLIENT='WM_SM_CLIENT';

  TEXT_ERRORCODE=' Код ошибки: ';
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
  System.SysUtils;

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
        Readed:=InFile.Read(ByteArray{[0]}, MaxBuffer);
        while Readed<>0 do
          begin
            UpdateCrc32(ByteArray, Readed, Result);
            Readed:=InFile.Read(ByteArray{[0]}, MaxBuffer);
          end;
      finally
        FreeAndNil(InFile);
      end;
    except
      on EOutOfMemory do
        raise Exception.Create('Не удалось выделить блок динамической памяти для буфера чтения из файла!');
      on E: Exception do
        raise Exception.Create(Format('При обработке файла [%s] возникла oшибка [%s]!', [FileName, E.Message]));
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
