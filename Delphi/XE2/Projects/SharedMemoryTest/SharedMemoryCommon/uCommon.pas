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

  WPARAM_SERVER_WANNA_HANDLE = 1; // ������ ����� handle ������� (LPARAM = handle �������)
  WPARAM_CLIENT_SENDS_HANDLE = 2; // ������ ���������� ���� handle (LPARAM = handle �������)

  WPARAM_CLIENT_WANNA_SEND_FILE = 3; // ������ ����� ������� ��������� ����
  WPARAM_SERVER_SENDS_BUFFER_SIZE = 4; // ������ ���������� ������ ������ ����� ������ (LPARAM = ������ ������ � ������)

  WPARAM_SERVER_WANNA_FILENAME = 5; // ������ ����� ��� �����
  WPARAM_CLIENT_SENDS_FILENAME = 6; // ������ ���������� ��� ����� (LPARAM = ������ ����� ����� � ������)
  WPARAM_SERVER_WANNA_BLOCKS_QUANTITY = 7; // ������ ����� ���������� ������ � �����
  WPARAM_CLIENT_SENDS_BLOCKS_QUANTITY = 8; // ������ ���������� ���������� ������ � ����� (LPARAM = ���������� ������ � �����)
  WPARAM_SERVER_WANNA_DATA = 9; // ������ ����� ��������� ���� ������ (LPARAM = ���������� ����� �������������� ����� ������)
  WPARAM_CLIENT_SENDS_DATA = 10; // ������ ���������� ��������� ���� ������ (LPARAM = ������ ���������� ������ � ������)
  WPARAM_SERVER_WANNA_CRC32 = 11; // ������ ����� ����������� ����� ���������� ����� ������ (LPARAM = ���������� ����� �������������� ����� ������)
  WPARAM_CLIENT_SENDS_CRC32 = 12; // ������ ���������� ����������� ����� ���������� ����� ������ (LPARAM = ������ ������ ���32 � ������)

  WPARAM_CLIENT_SHUTDOWN = 13; // ������ �������� � ���� ���������� �� �������
  WPARAM_SERVER_SHUTDOWN = 14; // ������ �������� ������� � ���� ����������

  WPARAM_CLIENT_WANNA_CANCEL_SENDING = 15; // ������ ����� ���������� �������� �����
  WPARAM_SERVER_TRANSFER_COMPLETE = 16; // ������ �������� ��� ������� ���� ���������


resourcestring
  TEXT_WM_SM_SERVER = 'WM_SM_SERVER';
  TEXT_WM_SM_CLIENT = 'WM_SM_CLIENT';

  TEXT_ERRORCODE = ' ��� ������: ';
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
