program Beeper;

{$R 'Beeper.Waves.res' 'Beeper.Waves.rc'}

uses
  Vcl.Forms,
  Beeper.uTMainForm in 'Beeper.uTMainForm.pas' {MainForm} ,
  Beeper.uTConfiguration in 'Beeper.uTConfiguration.pas',
  Beeper.uResourceStrings in 'Beeper.uResourceStrings.pas',
  Beeper.uConsts in 'Beeper.uConsts.pas',
  Beeper.uTSignal in 'Beeper.uTSignal.pas',
  Beeper.uTPeriodType in 'Beeper.uTPeriodType.pas',
  Beeper.uISignal in 'Beeper.uISignal.pas',
  Beeper.uISignalList in 'Beeper.uISignalList.pas',
  Beeper.uTSignalList in 'Beeper.uTSignalList.pas',
  Beeper.uIConfiguration in 'Beeper.uIConfiguration.pas',
  Beeper.uTSignalForm in 'Beeper.uTSignalForm.pas' {SignalForm} ,
  Beeper.uTAboutForm in 'Beeper.uTAboutForm.pas' {AboutForm} ,
  Winapi.Windows,
  System.SysUtils;

{$R *.res}

var
  MutexHandle: HWND;
  MutexName: string;
  Error: string;

procedure ShowErrorMessageBox(const AMessage: string);
begin
  MessageBox(Application.Handle, PWideChar(AMessage + sLineBreak + sLineBreak + Format(RsErrorCode, [IntToStr(GetLastError)])),
    PWideChar(Format(RsErrorMessageCaption, [Application.Title])), MESSAGE_TYPE_ERROR);
end;

function StartSession: Boolean;
var
  last_error: cardinal;
begin
  Result := False;
  MutexName := UpperCase(APPLICATION_NAME + MUTEX_SUFFIX);
  MutexHandle := CreateMutex(nil, False, PWideChar(MutexName));
  last_error := GetLastError;
  if last_error = ERROR_ALREADY_EXISTS then
    Error := RsErrorMutexAlreadyExists
  else
  begin
    Result := MutexHandle <> 0;
    if not Result then
      Error := RsErrorCreateMutex
    else
    begin
      Result := WaitForSingleObject(MutexHandle, INFINITE) <> WAIT_FAILED;
      if not Result then
        Error := RsErrorWaitForMutex;
    end;
  end;
end;

function StopSession: Boolean;
begin
  Result := ReleaseMutex(MutexHandle);
  if not Result then
    Error := RsErrorReleaseMutex
  else
  begin
    Result := CloseHandle(MutexHandle);
    if not Result then
      Error := RsErrorCloseMutex;
  end;
end;

procedure SendActivationSignal;
var
  msg: cardinal;
begin
  msg := RegisterWindowMessage(PWideChar(APPLICATION_NAME));
  if msg > 0 then
    PostMessage(HWND_BROADCAST, msg, 0, 0);
end;

begin
  Application.Initialize;
  Application.Title := APPLICATION_NAME;
  if not StartSession then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      SendActivationSignal;
      Application.Terminate;
    end
    else
    begin
      ShowErrorMessageBox(Error);
      Application.Terminate;
    end;
  end
  else
  begin
    //Application.HelpFile := '';
    Application.ShowMainForm := True;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TMainForm, MainForm);
    Application.Run;
    if not StopSession then
      ShowErrorMessageBox(Error);
  end;

end.
