unit Beeper.uConsts;

interface

uses
  Winapi.Windows,
  Beeper.uTPeriodType,
  Beeper.uResourceStrings;

const
  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;
  MESSAGE_TYPE_CONFIRMATION: Cardinal = MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2;

  DEFAULT_SHOW_BALOON_HINTS = True;
  DEFAULT_SOUND_ENABLED = True;
  DEFAULT_MODIFIER_ON = MOD_SHIFT + MOD_ALT;
  DEFAULT_VIRTUAL_KEY_ON = VK_F12;
  DEFAULT_MODIFIER_OFF = MOD_CONTROL + MOD_ALT + MOD_SHIFT;
  DEFAULT_VIRTUAL_KEY_OFF = VK_F12;
  DEFAULT_SIGNAL_COUNT = 0;
  DEFAULT_TITLE = '';
  DEFAULT_PERIOD = 0;
  DEFAULT_PERIOD_TYPE = ptSeconds;
  DEFAULT_MESSAGE_ENABLED = False;
  DEFAULT_MESSAGE = '';
  DEFAULT_WAVE_FILE_ENABLED = False;
  DEFAULT_WAVE_FILE = '';
  DEFAULT_ENABLED = True;

  PERIODS: array [Low(TPeriodType) .. High(TPeriodType)] of string = (RsSeconds, RsMinutes, RsHours, RsDays, RsWeeks, RsMonths, RsYears);

  WAVEFILE_EXTENTION = 'wav';

  HOTKEY_ON = 1;
  HOTKEY_OFF = 2;

implementation

end.
