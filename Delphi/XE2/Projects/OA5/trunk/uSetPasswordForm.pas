unit uSetPasswordForm;

interface

uses
  Vcl.ActnList,
  Vcl.ActnMan,
  System.Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.ImgList,
  Vcl.Mask,
  Vcl.StdCtrls,
  uLogProvider,
  Winapi.Windows,
  Vcl.PlatformDefaultStyleActnCtrls;

type
  TSetPasswordForm=class(TForm)
    lblPassword: TLabel;
    lblConfirmation: TLabel;
    meConfirmation: TMaskEdit;
    mePassword: TMaskEdit;
    Bevel2: TBevel;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Apply: TAction;
    Action_Close: TAction;
    chkbxShowPassword: TCheckBox;
    btnApply: TButton;
    btnHelp: TButton;
    Action_Help: TAction;
    btnClose: TButton;
    ilSetPasswordFormSmallImages: TImageList;
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
    procedure chkbxShowPasswordClick(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Apply;
    procedure Do_Close;
    procedure Do_UpdateActions;
    procedure Do_SwitchPasswordVisibility;
  end;

implementation

{$R *.dfm}

uses
  SysUtils,
  uMainForm,
  uRoutines;

procedure TSetPasswordForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TSetPasswordForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TSetPasswordForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TSetPasswordForm.Do_Apply;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{8C1D1934-43A0-4BD3-A063-95940EA9B73D}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка изменения пароля учётной записи была подтверждена пользователем.');
  Log.SendInfo('Окно изменения пароля учётной записи закрыто.');

  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{19DBBA6D-0E8E-4BBB-BF5B-D2C80E71A631}');

  ModalResult:=mrClose;
  Log.SendInfo('Попытка изменения пароля учётной записи была отменена пользователем.');
  Log.SendInfo('Окно изменения пароля учётной записи закрыто.');

  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{95536062-F76C-495C-B1F2-70E50F7A9FF0}');
  bError:=False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_UpdateActions;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{3ED4C156-FDB8-4F56-9E52-B3F393FE249D}');

  Action_Apply.Enabled:=mePassword.Text=meConfirmation.Text;
  Log.SendDebug('Действие "'+Action_Apply.Caption+'" '+Routines.GetConditionalString(Action_Apply.Enabled, 'в', 'от')+'ключено.');
  btnApply.Default:=Action_Apply.Enabled;
  btnClose.Default:=not Action_Apply.Enabled;

  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_SwitchPasswordVisibility;
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+chkbxShowPassword.Caption+'"', '{0219B9CF-B108-49C8-A390-22AF8B17C186}');

  if chkbxShowPassword.Checked then
    begin
      mePassword.PasswordChar:=#0;
      meConfirmation.PasswordChar:=#0;
    end
  else
    begin
      mePassword.PasswordChar:='*';
      meConfirmation.PasswordChar:='*';
    end;

  ProcedureFooter;
end;

procedure TSetPasswordForm.FormCreate(Sender: TObject);
const
  ICON_SETPASSWORD=1;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{43E2DB1C-46EC-46FB-BE5F-69082FF4BDB0}');

  ilSetPasswordFormSmallImages.GetIcon(ICON_SETPASSWORD, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('Действие "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
      if SetPasswordFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if SetPasswordFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if SetPasswordFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=SetPasswordFormPosition.x;
          if SetPasswordFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if SetPasswordFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=SetPasswordFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TSetPasswordForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{109E2C60-29E7-4230-956B-848F6063FD69}');
  Do_UpdateActions;
  Log.SendInfo('Отображено окно изменения пароля учётной записи.');
  ProcedureFooter;
end;

procedure TSetPasswordForm.FieldsChange(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', '{C2099A30-DAD0-476B-AAFF-031721A0641E}');
  Do_UpdateActions;
  ProcedureFooter;
end;

procedure TSetPasswordForm.Action_ApplyExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', '{D6F02F10-4334-4227-9C49-E2DB8B98CA70}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TSetPasswordForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{4569EB61-7A53-4A07-8D49-7D91C54D6FEF}');
  Do_Close;
  ProcedureFooter;
end;

procedure TSetPasswordForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{772E549E-6DD2-4921-B2F9-5C65F20976FE}');
  Do_Help;
  ProcedureFooter;
end;

procedure TSetPasswordForm.chkbxShowPasswordClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "'+chkbxShowPassword.Caption+'"', '{1CA50F76-73D7-4646-8365-189442365348}');
  Do_SwitchPasswordVisibility;
  ProcedureFooter;
end;

end.
