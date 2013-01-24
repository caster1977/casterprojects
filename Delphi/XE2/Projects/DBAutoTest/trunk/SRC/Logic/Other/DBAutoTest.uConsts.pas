unit DBAutoTest.uConsts;

interface

uses
  Winapi.Windows;

const
  DEFAULT_TASK_ENABLED = True;
  DEFAULT_TASK_GROUP = '';
  DEFAULT_TASK_NAME = '';
  DEFAULT_TASK_SQL = nil;
  DEFAULT_FULL_NAME = '';
  DEFAULT_SERVER = '';
  DEFAULT_LOGIN = '';
  DEFAULT_PASSWORD = '';
  DEFAULT_DB = '';
  DEFAULT_WIN_NT_SECURITY = True;

  ADO_CONNECTION_STRING_PREFIX = 'Provider="SQLOLEDB.1";Data Source="%s"';
  ADO_CONNECTION_STRING_SUFFIX_INTEGRATED_SECURITY = ';Integrated Security="SSPI"';
  ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO = ';Persist Security Info="%s"';
  ADO_CONNECTION_STRING_SUFFIX_USER_ID = ';User ID="%s"';
  ADO_CONNECTION_STRING_SUFFIX_PASSWORD = ';Password="%s"';
  ADO_CONNECTION_STRING_SUFFIX_INITIAL_CATALOG = ';Initial Catalog="%s"';

  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;
  MESSAGE_TYPE_CONFIRMATION: Cardinal = MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2;
  MESSAGE_TYPE_CONFIRMATION_WARNING: Cardinal = MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2;
  MESSAGE_TYPE_WARNING: Cardinal = MB_OK + MB_ICONWARNING + MB_DEFBUTTON1;
  APPLICATION_NAME = 'DBAutoTest';

  CONFIGURATION_DEFAULT_ACTIVE_PAGE = 0;
  PROFILE_DEFAULT_ACTIVE_PAGE = 0;

implementation

end.
