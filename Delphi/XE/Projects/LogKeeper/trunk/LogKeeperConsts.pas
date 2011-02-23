unit LogKeeperConsts;

interface

const
  WMCD_THREADLOG: integer=222; // идентификатор типа строки содержайщей данные лога, принимаемой через сообщение WM_COPYDATA из дочернего потока

  STATUSBAR_STATE_PANEL_NUMBER: integer=0; // номер панели состояния в панели статуса
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1; // номер панели прогресса в панели статуса
  STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER: integer=2; // номер панели количества строк сообщений в панели статуса
  STATUSBAR_LOG_COUNT_PANEL_NUMBER: integer=3; // номер панели количества строк протокола в панели статуса
  STATUSBAR_HINT_PANEL_NUMBER: integer=4; // номер панели контекстной подсказки в панели статуса
  ICON_ERROR=15; // номера иконок в списке ImageList1                         // номера иконок в списке иконок
  ICON_WARNING=13;
  ICON_INFO=6;
  ICON_SQL=14;
  ICON_DEBUG=30;
  ICON_BUSY=0;
  ICON_READY=1;
  ICON_CONFIGURATION=11;
  ICON_FINDGUID=28;
  EXIT_COUNTER_MAX=60; // счётчик итераций цикла, которые должны пройти перед завершением работы программы

implementation

end.
