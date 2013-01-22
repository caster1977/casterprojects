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
  DEFAULT_DB = '';
  DEFAULT_ADO_CONNECTION_STRING = 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=%s;Initial Catalog=%s;Data Source=%s';

  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;
  MESSAGE_TYPE_CONFIRMATION: Cardinal = MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2;
  MESSAGE_TYPE_CONFIRMATION_WARNING: Cardinal = MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2;
  MESSAGE_TYPE_WARNING: Cardinal = MB_OK + MB_ICONWARNING + MB_DEFBUTTON1;
  APPLICATION_NAME = 'DBAutoTest';

implementation

end.
