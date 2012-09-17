unit Beeper.uTBeeper;

interface

uses
  Beeper.uIBeeper,
  Winapi.Windows;

type
  TBeeper = class(TInterfacedObject, IBeeper)
  strict private
    FMutexHandle: HWND;
    FError: string;
  public
    procedure ShowError;
    function StartSession: boolean;
    function StopSession: boolean;
    procedure SendActivationSignal;
  end;

function GetIBeeper: IBeeper;

implementation

uses
  Beeper.uConsts,
  Beeper.uResourceStrings,
  System.SysUtils,
  Vcl.Forms;

const
  MUTEX_SUFFIX = '_MUTEX';

resourcestring
  RsErrorCode = ' Код ошибки: %s';
  RsErrorMutexAlreadyExists = 'Работа данной копии программы будет завершена, т.к. одна копия программы уже запущена.';
  RsErrorCreateMutex = 'Не удалось создать объект мютекса';
  RsErrorWaitForMutex = 'Не удалось считать состояние объекта мьютекса';
  RsErrorReleaseMutex = 'Не удалось освободить объект мьютекса';
  RsErrorCloseMutex = 'Не удалось закрыть ссылку на мьютекс';

function GetIBeeper: IBeeper;
begin
  Result := TBeeper.Create;
end;

procedure TBeeper.SendActivationSignal;
var
  msg: cardinal;
begin
  msg := RegisterWindowMessage(PWideChar(APPLICATION_NAME));
  if msg > 0 then
  begin
    PostMessage(HWND_BROADCAST, msg, 0, 0);
  end;
end;

procedure TBeeper.ShowError;
begin
  MessageBox(Application.Handle, PWideChar(FError + sLineBreak + sLineBreak + Format(RsErrorCode, [IntToStr(GetLastError)])),
    PWideChar(Format(RsErrorMessageCaption, [Application.Title])), MESSAGE_TYPE_ERROR);
end;

function TBeeper.StartSession: boolean;
var
  last_error: cardinal;
begin
  Result := False;
  FMutexHandle := CreateMutex(nil, False, PWideChar(UpperCase(APPLICATION_NAME + MUTEX_SUFFIX)));
  last_error := GetLastError;
  if last_error = ERROR_ALREADY_EXISTS then
  begin
    FError := RsErrorMutexAlreadyExists
  end
  else
  begin
    Result := FMutexHandle <> 0;
    if not Result then
    begin
      FError := RsErrorCreateMutex
    end
    else
    begin
      Result := WaitForSingleObject(FMutexHandle, INFINITE) <> WAIT_FAILED;
      if not Result then
      begin
        FError := RsErrorWaitForMutex;
      end;
    end;
  end;
end;

function TBeeper.StopSession: boolean;
begin
  Result := ReleaseMutex(FMutexHandle);
  if not Result then
  begin
    FError := RsErrorReleaseMutex
  end
  else
  begin
    Result := CloseHandle(FMutexHandle);
    if not Result then
    begin
      FError := RsErrorCloseMutex;
    end;
  end;
end;

end.
