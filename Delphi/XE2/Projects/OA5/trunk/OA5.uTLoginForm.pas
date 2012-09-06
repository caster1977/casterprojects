unit OA5.uTLoginForm;

interface

uses
  CastersPackage.uTLogForm,
  System.Classes,
  Vcl.Forms,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.Mask,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TLoginForm = class(TLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actHelp: TAction;
    actEnter: TAction;
    actClose: TAction;
    pnlButtons: TPanel;
    btnHelp: TButton;
    btnEnter: TButton;
    btnClose: TButton;
    lblLogin: TLabel;
    edbxLogin: TEdit;
    lblPassword: TLabel;
    mePassword: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure actEnterExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actEnterUpdate(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
  strict private
    procedure _Enter;
    procedure _Help;
    procedure _Close;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  OA5.uMainForm,
  CastersPackage.uRoutines;

const
  ICON_LOGIN = 1;

procedure TLoginForm._Enter;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{38630A3A-99DB-4D54-A9A4-42BBA7F6DC42}');

  ModalResult := mrOk;
  Log.SendInfo('Попытка авторизации была подтверждена пользователем.');
  Log.SendInfo('Окно авторизации закрыто.');

  ProcedureFooter;
end;

procedure TLoginForm.actEnterExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actEnter.Caption + '"', '{28FD25CC-0ED7-4CDC-8238-38B08A51AE9B}');
  _Enter;
  ProcedureFooter;
end;

procedure TLoginForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actHelp.Caption + '"', '{394B4218-5393-4162-95FE-9740CEB2F2C9}');
  _Help;
  ProcedureFooter;
end;

procedure TLoginForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader('Процедура-обработчик обновления действия "' + actHelp.Caption + '"',
      '{B92D0FEB-6E73-42D9-A684-68918F5F11A6}');
    actHelp.Enabled := b;
    Log.SendDebug('Действие "' + actHelp.Caption + '" ' + Routines.GetConditionalString(b, 'в', 'от') + 'ключено.');
    ProcedureFooter;
  end;
end;

procedure TLoginForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actClose.Caption + '"', '{1DFD76E1-46A7-4ADA-A2F3-AAF70AC8060C}');
  _Close;
  ProcedureFooter;
end;

procedure TLoginForm._Help;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{95536062-F76C-495C-B1F2-70E50F7A9FF0}');
  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    GenerateError('Извините, справочный файл к данной программе не найден.');
  end;
  ProcedureFooter;
end;

procedure TLoginForm._Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{AFC63B2A-379B-4A09-98F3-549C5570B3D2}');

  ModalResult := mrClose;
  Log.SendInfo('Попытка авторизации была отменена пользователем.');
  Log.SendInfo('Окно авторизации закрыто.');

  ProcedureFooter;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{B7B2C87E-2141-43CA-A41B-23FE0E874839}');

  ImageList.GetIcon(ICON_LOGIN, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;

    // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
    if LoginFormPosition.bCenter then
    begin
      Position := poScreenCenter;
    end
    else
    begin
      Position := poDesigned;
      if LoginFormPosition.x < Screen.WorkAreaLeft then
      begin
        Left := Screen.WorkAreaLeft;
      end
      else
      begin
        if LoginFormPosition.x > Screen.WorkAreaLeft + Screen.WorkAreaWidth then
        begin
          Left := Screen.WorkAreaLeft + Screen.WorkAreaWidth - Width;
        end
        else
        begin
          Left := LoginFormPosition.x;
        end;
      end;
      if LoginFormPosition.y < Screen.WorkAreaTop then
      begin
        Top := Screen.WorkAreaTop;
      end
      else
      begin
        if LoginFormPosition.y > Screen.WorkAreaTop + Screen.WorkAreaHeight then
        begin
          Top := Screen.WorkAreaTop + Screen.WorkAreaHeight - Height;
        end
        else
        begin
          Top := LoginFormPosition.y;
        end;
      end;
    end;
  end;

  ProcedureFooter;
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{96321487-1DC9-4591-AD46-BD64CDC4B64D}');
  Log.SendInfo('Отображено окно авторизации.');
  ProcedureFooter;
end;

procedure TLoginForm.actEnterUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := edbxLogin.Text <> EmptyStr;
  if actEnter.Enabled <> b then
  begin
    ProcedureHeader('Процедура-обработчик обновления действия "' + actEnter.Caption + '"',
      '{53E5D5D6-2AA3-4537-8268-7DD101CB6FBB}');
    actEnter.Enabled := b;
    Log.SendDebug('Действие "' + actEnter.Caption + '" ' + Routines.GetConditionalString(actEnter.Enabled, 'в', 'от') +
      'ключено.');
    ProcedureFooter;
  end;
  if btnEnter.Default <> b then
  begin
    btnEnter.Default := b;
  end;
  if btnClose.Default <> (not b) then
  begin
    btnClose.Default := not b;
  end;
end;

end.
