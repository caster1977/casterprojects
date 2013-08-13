unit TAPEstimator.uConsts;

interface

uses
  Winapi.Windows,
  TAPEstimator.uResourceStrings;

const
  APPLICATION_NAME = 'TAPEstimator';

  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;
  MESSAGE_TYPE_WARNING: Cardinal = MB_OK + MB_ICONWARNING + MB_DEFBUTTON1;
  MESSAGE_TYPE_CONFIRMATION_QUESTION: Cardinal = MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2;
  MESSAGE_TYPE_CONFIRMATION_WARNING_OK: Cardinal = MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1;
  MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL: Cardinal = MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2;

  CONFIGURATION_INTERFACE_SECTION = '���������';
  CONFIGURATION_OTHER_SECTION = '������';
  CONFIGURATION_MAINFORM_STATE_SECTION = '������� � ��������� ������� �����';

  CONFIGURATION_DEFAULT_ACTIVE_PAGE = 0;
  CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE = True;
  CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION = True;
  CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START = True;
  CONFIGURATION_DEFAULT_ENABLE_STATUSBAR = True;
  CONFIGURATION_DEFAULT_ENABLE_TOOLBAR = True;
  CONFIGURATION_DEFAULT_RECENTS_QUANTITY = 20;

  CONFIGURATION_DEFAULT_MAINFORM_STATE = 0;
  CONFIGURATION_DEFAULT_MAINFORM_LEFT = 0;
  CONFIGURATION_DEFAULT_MAINFORM_TOP = 0;
  CONFIGURATION_DEFAULT_MAINFORM_WIDTH = 800;
  CONFIGURATION_DEFAULT_MAINFORM_HEIGHT = 600;

  RECENTS_DEFAULT_COUNT = 0;

  RECENT_DEFAULT_FULL_NAME = '';

  PROFILE_DEFAULT_ACTIVE_PAGE = 0;
  PROFILE_DEFAULT_SERVER = '';
  PROFILE_DEFAULT_LOGIN = '';
  PROFILE_DEFAULT_PASSWORD = '';
  PROFILE_DEFAULT_DB = '';
  PROFILE_DEFAULT_WIN_NT_SECURITY = True;
  PROFILE_DEFAULT_STORE_PASSWORD = False;

  TAP_CODE_G00 = 'G00'; // �������� ��� (������� �� ������������ �������� � ��������� �������)
  TAP_CODE_G01 = 'G01'; // �������� �������� (������� ���)
  TAP_CODE_G02 = 'G02'; // �������� �������� �� ������� ������� (������� ���)
  TAP_CODE_G03 = 'G03'; // �������� �������� ������ ������� ������� (������� ���)
  TAP_CODE_G04 = 'G04';

  TAP_CODE_G53 = 'G53';
  TAP_CODE_G54 = 'G54';

  TAP_CODE_G90 = 'G90'; // ��������� ���������� ������� ���������
  TAP_CODE_G91 = 'G91'; // ��������� ������������� ������� ���������
  TAP_CODE_G92 = 'G92';

  TAP_CODE_T1 = 'T1'; // ����� ����������� ����� 1
  TAP_CODE_T2 = 'T2'; // ����� ����������� ����� 2
  TAP_CODE_T3 = 'T3'; // ����� ����������� ����� 3

  TAP_CODE_M3 = 'M3'; // ��������� �������� �������� �� ������� �������
  TAP_CODE_M4 = 'M4'; // ��������� �������� �������� ������ ������� �������
  TAP_CODE_M5 = 'M5'; // ���������� �������� ��������
  TAP_CODE_M6 = 'M6'; // ��������� ���������� ������ (��������)
  TAP_CODE_M7 = 'M7'; // ���������� ���������� ������ (��������)

  TAP_CODE_F = 'F'; // �������� ������� ������ � ������ (feed per minute (inch))

  TAP_CODE_W = 'W'; // ������� ����������� (����) ������ ��� (������ ������)

  TAP_CODE_L30 = 'L30'; // ��������� ������ ���� (knife on)
  TAP_CODE_L31 = 'L31'; // ���������� ������ ���� (knife off)
  TAP_CODE_L30_1 = 'L30.1'; // L30.1 A - liftup angle Z - ������ ������� P0... - ������ ��� ������

implementation

end.
