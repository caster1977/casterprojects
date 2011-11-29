unit uCommon;

interface

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtDebug);
  TLogMessagesTypes=set of TLogMessagesType;

const
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;

  TEXT_CONFIGURATIONFORM_SUFFIX = '�������� ���������';
  TEXT_ABOUTFORM_SUFFIX = '"� ���������..."';

  CONST_DEFAULTVALUE_DATABLOCKSIZE=1024;
  CONST_DEFAULTVALUE_RETRANSLATORPAUSE=1000;
  CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM: boolean=False;
  CONST_DEFAULTVALUE_KEEPLOGTYPES: TLogMessagesTypes=[lmtError, lmtWarning, lmtInfo];
  CONST_DEFAULTVALUE_SHOWSTATUSBAR: boolean=True;

  WPARAM_SERVER_WANNA_HANDLE=1; // ������ ����� handle ������� (LPARAM = handle �������)
  WPARAM_CLIENT_SENDS_HANDLE=2; // ������ ���������� ���� handle (LPARAM = handle �������)

  WPARAM_CLIENT_WANNA_SEND_FILE=3; // ������ ����� ������� ��������� ����
  WPARAM_SERVER_SENDS_BUFFER_SIZE=4; // ������ ���������� ������ ������ ����� ������ (LPARAM = ������ ������ � ������)

  WPARAM_SERVER_WANNA_FILENAME=5; // ������ ����� ��� �����
  WPARAM_CLIENT_SENDS_FILENAME=6; // ������ ���������� ��� ����� (LPARAM = ������ ����� ����� � ������)
  WPARAM_SERVER_WANNA_BLOCKS_QUANTITY=7; // ������ ����� ���������� ������ � �����
  WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY=8; // ������ ���������� ���������� ������ � ����� (LPARAM = ���������� ������ � �����)
  WPARAM_SERVER_WANNA_DATA=9; // ������ ����� ��������� ���� ������ (LPARAM = ���������� ����� �������������� ����� ������)
  WPARAM_CLIENT_SENDS_DATA=10; // ������ ���������� ��������� ���� ������ (LPARAM = ������ ���������� ������ � ������)
  WPARAM_SERVER_WANNA_CRC32=11; // ������ ����� ����������� ����� ���������� ����� ������ (LPARAM = ���������� ����� �������������� ����� ������)
  WPARAM_CLIENT_SENDS_CRC32=12; // ������ ���������� ����������� ����� ���������� ����� ������ (LPARAM = ���32)

  WPARAM_CLIENT_SHUTDOWN=13; // ������ �������� � ���� ���������� �� �������
  WPARAM_SERVER_SHUTDOWN=14; // ������ �������� ������� � ���� ����������

  WPARAM_CLIENT_WANNA_CANCEL_SENDING=15; // ������ ����� ���������� �������� �����
  WPARAM_SERVER_TRANSFER_COMPLETE=16; // ������ �������� ��� ������� ���� ���������

resourcestring
  TEXT_WM_SM_SERVER='WM_SM_SERVER';
  TEXT_WM_SM_CLIENT='WM_SM_CLIENT';

  TEXT_ERRORCODE=' ��� ������: ';
  TEXT_REGISTERWINDOWMESSAGEERROR='�� ������� ��������� �������� ����������� �������� ���������!';
  TEXT_ERROR_CREATEFILEMAPPING='�� ������� ������� ���� ����� ������!';
  TEXT_ERROR_CREATEFILEMAPPING_ALREADYEXISTS='���� ����� ������ � ����� ������ ��� ����������!';
  TEXT_ERROR_MAPVIEWOFFILE='�� ������� ������������ � ����� ����� ������!';
  TEXT_ERROR_UNMAPVIEWOFFILE='�� ������� ����������� �� ����� ����� ������!';
  TEXT_ERROR_CLOSE_FILEMAPPING_HANDLE='�� ������� ������� ������������� ����� ����� ������!';
  TEXT_ERROR_CREATEFILE='�� ������� ������� ���� �� �����!';

  TEXT_WRONGBUFFERSIZE='������ ������ ��� �������� ������ �� ������ ���� ����� ������ �����!';
  TEXT_WRONGSHAREDMEMORYSIZE='������ ����� ����� ������ �� ������ ���� ����� ������ �����!';

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
        raise Exception.Create('�� ������� �������� ���� ������������ ������ ��� ������ ������ �� �����!');
      on E: Exception do
        raise Exception.Create(Format('��� ��������� ����� [%s] �������� o����� [%s]!', [FileName, E.Message]));
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
