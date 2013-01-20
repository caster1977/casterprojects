program DBAutoTest;

uses
  Vcl.Forms,
  DBAutoTest.uTMainForm in 'SRC\UI\DBAutoTest.uTMainForm.pas' {MainForm},
  DBAutoTest.uTTaskForm in 'SRC\UI\DBAutoTest.uTTaskForm.pas' {TaskForm},
  DBAutoTest.uTConfigurationForm in 'SRC\UI\DBAutoTest.uTConfigurationForm.pas' {Form3},
  DBAutoTest.uTTask in 'SRC\Logic\Classes\DBAutoTest.uTTask.pas',
  DBAutoTest.uITask in 'SRC\Logic\Interfaces\DBAutoTest.uITask.pas',
  DBAutoTest.uTConfiguration in 'SRC\Logic\Classes\DBAutoTest.uTConfiguration.pas',
  DBAutoTest.uIConfiguration in 'SRC\Logic\Interfaces\DBAutoTest.uIConfiguration.pas',
  DBAutoTest.uITaskList in 'SRC\Logic\Interfaces\DBAutoTest.uITaskList.pas',
  DBAutoTest.uTTaskList in 'SRC\Logic\Classes\DBAutoTest.uTTaskList.pas',
  DBAutoTest.uTTaskThread in 'SRC\Logic\Classes\DBAutoTest.uTTaskThread.pas',
  DBAutoTest.uETaskThread in 'SRC\Logic\Classes\DBAutoTest.uETaskThread.pas',
  DBAutoTest.uTProfileForm in 'SRC\UI\DBAutoTest.uTProfileForm.pas' {Form4},
  DBAutoTest.uConsts in 'SRC\Logic\Other\DBAutoTest.uConsts.pas',
  DBAutoTest.uETaskList in 'SRC\Logic\Classes\DBAutoTest.uETaskList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
