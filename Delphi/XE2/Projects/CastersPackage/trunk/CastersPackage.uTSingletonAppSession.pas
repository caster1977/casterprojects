unit CastersPackage.uTSingletonAppSession;

interface

uses
  CastersPackage.uISingletonAppSession,
  Winapi.Windows;

type
  TSingletonAppSession = class(TInterfacedObject, ISingletonAppSession)
  strict private
    FMutexHandle: HWND;
    FError: string;
  public
    procedure ShowError;
    function Start: Boolean;
    function Stop: Boolean;
    procedure Activate;
    constructor Create;
  end;

function GetISingletonAppSession: ISingletonAppSession;

implementation

uses
  System.SysUtils,
  Vcl.Forms;

const
  MUTEX_SUFFIX = '_MUTEX';
  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;

resourcestring
  RsErrorMessageCaption = '%s - Ошибка!';
  RsErrorCode = ' Код ошибки: %s';
  RsErrorMutexAlreadyExists = 'Работа данной копии программы будет завершена, т.к. одна копия программы уже запущена.';
  RsErrorCreateMutex = 'Не удалось создать объект мютекса';
  RsErrorWaitForMutex = 'Не удалось считать состояние объекта мьютекса';
  RsErrorReleaseMutex = 'Не удалось освободить объект мьютекса';
  RsErrorCloseMutex = 'Не удалось закрыть ссылку на мьютекс';
  RsErrorEmptyAppName = 'Наименование приложения не должно быть пустым';

function GetISingletonAppSession: ISingletonAppSession;
begin
  Result := TSingletonAppSession.Create;
end;

procedure TSingletonAppSession.Activate;
var
  msg: Cardinal;
begin
  msg := RegisterWindowMessage(PWideChar(Application.Title));
  if msg > 0 then
  begin
    PostMessage(HWND_BROADCAST, msg, 0, 0);
  end;
end;

constructor TSingletonAppSession.Create;
begin
  Assert(Length(Trim(Application.Title)) > 0, RsErrorEmptyAppName);
  inherited;
end;

procedure TSingletonAppSession.ShowError;
begin
  MessageBox(Application.Handle, PWideChar(FError + sLineBreak + sLineBreak + Format(RsErrorCode,
    [IntToStr(GetLastError)])), PWideChar(Format(RsErrorMessageCaption, [Application.Title])), MESSAGE_TYPE_ERROR);
end;

function TSingletonAppSession.Start: Boolean;
var
  last_error: Cardinal;
begin
  Result := False;
  FMutexHandle := CreateMutex(nil, False, PWideChar(UpperCase(Application.Title + MUTEX_SUFFIX)));

  last_error := GetLastError;
  if last_error = ERROR_ALREADY_EXISTS then
  begin
    FError := RsErrorMutexAlreadyExists;
    Exit;
  end;

  Result := FMutexHandle <> 0;
  if not Result then
  begin
    FError := RsErrorCreateMutex;
    Exit;
  end;

  Result := WaitForSingleObject(FMutexHandle, INFINITE) <> WAIT_FAILED;
  if not Result then
  begin
    FError := RsErrorWaitForMutex;
  end;
end;

function TSingletonAppSession.Stop: Boolean;
begin
  Result := ReleaseMutex(FMutexHandle);
  if not Result then
  begin
    FError := RsErrorReleaseMutex;
    Exit;
  end;

  Result := CloseHandle(FMutexHandle);
  if not Result then
  begin
    FError := RsErrorCloseMutex;
  end;
end;

end.
