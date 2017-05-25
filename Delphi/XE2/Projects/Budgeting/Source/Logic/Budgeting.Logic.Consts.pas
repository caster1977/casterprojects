unit Budgeting.Logic.Consts;

interface

uses
  Winapi.Windows;

const
  STATUSBAR_PROGRESS_PANEL_WIDTH = 100;

  GENERAL_SECTION = '��������';
  DATABASE_SECTION = '����������� � ��';
  INTERFACE_SECTION = '���������';
  OTHER_SECTION = '������';

  MESSAGE_TYPE_OK = MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON1;
  MESSAGE_TYPE_ERROR = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;
  MESSAGE_TYPE_WARNING = MB_OK + MB_ICONWARNING + MB_DEFBUTTON1;
  MESSAGE_TYPE_CONFIRMATION_QUESTION = MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2;
  MESSAGE_TYPE_CONFIRMATION_WARNING_OK = MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON1;
  MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL = MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2;

  CONFIGURATION_DEFAULT_ACTIVE_PAGE = 0;
  CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION = True;
  CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START = True;
  CONFIGURATION_DEFAULT_ENABLE_STATUSBAR = True;
  CONFIGURATION_DEFAULT_ENABLE_TOOLBAR = True;
  CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION = False;
  CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE = False;
  CONFIGURATION_DEFAULT_ENABLE_AUTO_LOGON = False;
  CONFIGURATION_DEFAULT_ENABLE_STORE_LOGIN = False;
  CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD = False;

implementation

end.
