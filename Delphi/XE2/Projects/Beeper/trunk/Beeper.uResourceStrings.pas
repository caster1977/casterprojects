unit Beeper.uResourceStrings;

interface

uses
  Beeper.uTPeriodType;

resourcestring
  RsErrorMessageCaption = '%s - Ошибка!';
  RsErrorResisterStartHotKey = 'Не удалось назначить горячую клавишу для запуска сигналов.';
  RsErrorResisterStopHotKey = 'Не удалось назначить горячую клавишу для останова сигналов.';
  RsErrorUnresisterStartHotKey = 'Не удалось освободить горячую клавишу предназначеную для останова сигналов.';
  RsErrorUnresisterStopHotKey = 'Не удалось освободить горячую клавишу предназначеную для запуска сигналов.';

  RsHints = 'Подсказки';
  RsSounds = 'Звуки';
  RsHotKeys = 'Горячие клавиши';
  RsSignals = 'Сигналы';
  RsSignal = 'Сигнал %s';

  RsInTray = 'В трее';
  RsEnabled = 'Включены';
  RsModifierOn = 'Модификатор клавиши включения';
  RsVirtualKeyOn = 'Клавиша включения';
  RsModifierOff = 'Модификатор клавиши отключения';
  RsVirtualKeyOff = 'Клавиша отключения';
  RsQuantity = 'Количество';
  RsTitle = 'Наименование';
  RsPeriodType = 'Тип периода';
  RsPeriod = 'Период';
  RsMessageEnabled = 'Выводить сообщение';
  RsMessage = 'Сообщение';
  RsWaveFileEnabled = 'Проигрывать звуковой файл';
  RsWaveFile = 'Звуковой файл';

  RsIniFileSaveError = 'Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

  RsSeconds = 'сек.';
  RsMinutes = 'мин.';
  RsHours = 'ч.';
  RsDays = 'дн.';
  RsWeeks = 'нед.';
  RsMonths = 'мес.';
  RsYears = 'г.';

  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';

  RsAddSignalCaption = 'Добавление сигнала';
  RsEditSignalCaption = 'Редактирование сигнала';

  RsSelectWaveFile = 'Выберите звуковой файл...';

  RsErrorCreateMutex = 'Не удалось создать объект мютекса';
  RsErrorWaitForMutex = 'Не удалось считать состояние объекта мьютекса';
  RsErrorReleaseMutex = 'Не удалось освободить объект мьютекса';
  RsErrorCloseMutex = 'Не удалось закрыть ссылку на мьютекс';
  RsErrorMutexAlreadyExists = 'Работа данной копии программы будет завершена, т.к. одна копия программы уже запущена.';
  RsErrorCode = ' Код ошибки: %s';
  RsWarningCaption = '%s - Предупреждение';
  RsErrorRegisterWindowMessage = 'Не удалось выполнить операцию регистрации оконного сообщения!';

implementation

end.
