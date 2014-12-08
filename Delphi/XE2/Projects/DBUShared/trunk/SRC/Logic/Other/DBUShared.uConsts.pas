unit DBUShared.uConsts;

interface

const
  DEFAULT_USER_LIST_SEPARATOR = '^^^';

  CONFIGURATION_DEFAULT_USER_BLOCKED = True;
  CONFIGURATION_DEFAULT_USER_ADMINISTRATOR = False;

  TCP_COMMAND_CONNECTION_TEST = 'TCP_CONNECTION_TEST';
  TCP_COMMAND_ADD_NEW_DATABASE_TYPE = 'TCP_ADD_NEW_DATABASE_TYPE';
  TCP_COMMAND_GET_DBU_DATABASE_TYPE_ITEMS = 'TCP_GET_DBU_DATABASE_TYPE_ITEMS';
  TCP_COMMAND_GET_DBU_STATES_ITEMS = 'TCP_GET_DBU_STATES_ITEMS';
  TCP_COMMAND_GET_DBU_SQL_ACTION_ITEMS = 'TCP_GET_DBU_SQL_ACTION_ITEMS';
  TCP_COMMAND_GET_DBU_SQL_SUBJ_ITEMS = 'TCP_GET_DBU_SQL_SUBJ_ITEMS';
  TCP_COMMAND_RESERVE_NEW_DBUPDATE_NUMBER = 'TCP_RESERVE_NEW_DBUPDATE_NUMBER';
  TCP_COMMAND_GET_DBU_NEW_NUMBER_LOG_GRID = 'TCP_GET_DBU_NEW_NUMBER_LOG_GRID';
  TCP_COMMAND_GET_DBU_NEW_NUMBER_LOG = 'TCP_GET_DBU_NEW_NUMBER_LOG';

  TCP_COMMAND_LOGIN = 'TCP_LOGIN';
  TCP_COMMAND_GET_USER_LIST = 'TCP_GET_USER_LIST';
  TCP_COMMAND_ADD_USER = 'TCP_ADD_USER';
  TCP_COMMAND_DELETE_USER = 'TCP_DELETE_USER';

  ERROR_UNKNOWN: Byte = 0;
  ERROR_CONFIGURATION_OBJECT_NOT_EXISTS: Byte = 1;
  ERROR_USERS_OBJECT_NOT_EXISTS: Byte = 2;
  ERROR_USER_ALREADY_EXISTS: Byte = 3;
  ERROR_CAN_NOT_CREATE_USER_OBJECT: Byte = 4;
  ERROR_CAN_NOT_ADD_USER_OBJECT_TO_USERS: Byte = 5;
  ERROR_USER_NOT_EXISTS: Byte = 6;
  ERROR_USER_NOT_DELETED: Byte = 7;
  SUCCESS_ADD_USER: Byte = 8;
  SUCCESS_DELETE_USER: Byte = 9;

implementation

end.
