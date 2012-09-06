unit OA5.uLoginForm;

interface

uses
  CastersPackage.uTLogForm,
  Winapi.Windows,
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
    actOk: TAction;
    actClose: TAction;
    pnlButtons: TPanel;
    btnHelp: TButton;
    btnOk: TButton;
    btnClose: TButton;
    lblLogin: TLabel;
    edbxLogin: TEdit;
    lblPassword: TLabel;
    mePassword: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actOkUpdate(Sender: TObject);
  strict private
    procedure _Ok;
    procedure _Help;
    procedure _Close;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  OA5.uMainForm,
  CastersPackage.uRoutines;

procedure TLoginForm._Ok;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{38630A3A-99DB-4D54-A9A4-42BBA7F6DC42}');

  ModalResult := mrOk;
  Log.SendInfo('Попытка авторизации была подтверждена пользователем.');
  Log.SendInfo('Окно авторизации закрыто.');

  ProcedureFooter;
end;

procedure TLoginForm.actOkExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actOk.Caption + '"', '{28FD25CC-0ED7-4CDC-8238-38B08A51AE9B}');
  _Ok;
  ProcedureFooter;
end;

procedure TLoginForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actHelp.Caption + '"', '{394B4218-5393-4162-95FE-9740CEB2F2C9}');
  _Help;
  ProcedureFooter;
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
    Application.HelpContext(HelpContext)
  else
    GenerateError('Извините, справочный файл к данной программе не найден.');
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
const
  ICON_LOGIN = 1;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{B7B2C87E-2141-43CA-A41B-23FE0E874839}');

  ImageList.GetIcon(ICON_LOGIN, Icon);
  actHelp.Enabled := Application.HelpFile <> '';
  Log.SendDebug('Действие "' + actHelp.Caption + '" ' + Routines.GetConditionalString(actHelp.Enabled, 'в', 'от') +
    'ключено.');

  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;

    // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
    if LoginFormPosition.bCenter then
      Position := poScreenCenter
    else
    begin
      Position := poDesigned;
      if LoginFormPosition.x < Screen.WorkAreaLeft then
        Left := Screen.WorkAreaLeft
      else
        if LoginFormPosition.x > Screen.WorkAreaLeft + Screen.WorkAreaWidth then
          Left := Screen.WorkAreaLeft + Screen.WorkAreaWidth - Width
        else
          Left := LoginFormPosition.x;
      if LoginFormPosition.y < Screen.WorkAreaTop then
        Top := Screen.WorkAreaTop
      else
        if LoginFormPosition.y > Screen.WorkAreaTop + Screen.WorkAreaHeight then
          Top := Screen.WorkAreaTop + Screen.WorkAreaHeight - Height
        else
          Top := LoginFormPosition.y;
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

procedure TLoginForm.actOkUpdate(Sender: TObject);
var
  b: boolean;
begin
  inherited;
  Screen.Cursor := crHourGlass;
  try
    b := edbxLogin.Text <> EmptyStr;
    if actOk.Enabled <> b then
    begin
      actOk.Enabled := b;
      Log.SendDebug('Действие "' + actOk.Caption + '" ' + Routines.GetConditionalString(actOk.Enabled, 'в', 'от') +
        'ключено.');
      if btnOk.Default <> b then
      begin
        btnOk.Default := b;
      end;
      if btnClose.Default <> (not b) then
      begin
        btnClose.Default := not b;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
