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

  WPARAM_SERVER_WANNA_HANDLE=1; // ������ ����� handle ������� (LPARAM = handle �������)
  WPARAM_CLIENT_SENDS_HANDLE=2; // ������ ���������� ���� handle (LPARAM = handle �������)
  WPARAM_SERVER_ACCEPT_CLIENT=3; // ������ ������������ ���������� � ������ ��������
  WPARAM_CLIENT_WANNA_SEND_FILE=4; // ������ ����� ������� ��������� ����
  WPARAM_SERVER_SENDS_SHAREDMEM_SIZE=5; // ������ ���������� ������ ����� ����� ������ (LPARAM = ������ ������ � ������)
  WPARAM_SERVER_WANNA_FILENAME=6; // ������ ����� ��� �����
  WPARAM_CLIENT_SENDS_FILENAME=7; // ������ ���������� ��� ����� (LPARAM = ������ ����� ����� � ������)
  WPARAM_SERVER_WANNA_FILESIZE=8; // ������ ����� ������ ����� � ������
  WPARAM_CLIENT_SENDS_FILESIZE=9; // ������ ���������� ������ ����� � ������ (LPARAM = ������ ����� � ������)
  WPARAM_SERVER_WANNA_DATA=10; // ������ ����� ��������� ���� ������ (LPARAM = ���������� ����� �������������� ����� ������)
  WPARAM_CLIENT_SENDS_DATA=11; // ������ ���������� ��������� ���� ������ (LPARAM = ������ ���������� ������ � ������)
  WPARAM_SERVER_WANNA_CRC32=12; // ������ ����� ����������� ����� ���������� ����� ������ (LPARAM = ���������� ����� �������������� ����� ������)
  WPARAM_CLIENT_SENDS_CRC32=13; // ������ ���������� ����������� ����� ���������� ����� ������ (LPARAM = ���32)
  WPARAM_SERVER_TRANSFER_COMPLETE=14; // ������ �������� ��� ������� ���� ���������
  WPARAM_CLIENT_WANNA_CANCEL_SENDING=15; // ������ ����� ���������� �������� �����
  WPARAM_CLIENT_SHUTDOWN=16; // ������ �������� � ���� ���������� �� �������
  WPARAM_SERVER_SHUTDOWN=17; // ������ �������� ������� � ���� ����������
  WPARAM_SERVER_LOST=18; // ���� ������� ����� �� ����������
  WPARAM_CLIENT_LOST=19; // ���� ������� ����� �� ����������
  WPARAM_SERVER_TRANSFER_ERROR=20; // ������ �������� �� ������ ��� ��������� �����


resourcestring
  TEXT_WM_SM_SERVER='WM_SM_SERVER';
  TEXT_WM_SM_CLIENT='WM_SM_CLIENT';
  TEXT_ERRORCODE=' ��� ������: ';
  TEXT_REGISTERWINDOWMESSAGEERROR='�� ������� ��������� �������� ����������� �������� ���������!';
  TEXT_CONFIGURATIONFORM_SUFFIX = '�������� ���������';
  TEXT_ABOUTFORM_SUFFIX = '"� ���������..."';

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
resourcestring
  TEXT_OUTOFMEMORY ='�� ������� �������� ���� ������������ ������ ��� ������ ������ �� �����!';
  TEXT_FILEERROR='��� ��������� ����� [%s] �������� o����� [%s]!';
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
