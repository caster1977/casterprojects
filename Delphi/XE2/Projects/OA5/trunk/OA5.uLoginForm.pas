unit OA5.uLoginForm;

interface

uses
  Windows,
  Forms,
  Mask,
  StdCtrls,
  ActnList,
  ActnMan,
  ExtCtrls,
  PlatformDefaultStyleActnCtrls,
  Controls,
  Graphics,
  Classes,
  ImgList,
  CastersPackage.uLogProvider;

type
  TLoginForm=class(TForm)
    Bevel2: TBevel;
    ActionManager1: TActionManager;
    Action_Ok: TAction;
    Action_Close: TAction;
    btnOk: TButton;
    btnClose: TButton;
    lblLogin: TLabel;
    lblPassword: TLabel;
    edbxLogin: TEdit;
    mePassword: TMaskEdit;
    Log: TLogProvider;
    ilLoginFormSmallImages: TImageList;
    Action_Help: TAction;
    btnHelp: TButton;
    procedure FormShow(Sender: TObject);
    procedure Action_OkExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_UpdateActions;
    procedure Do_Ok;
    procedure Do_Help;
    procedure Do_Close;
  end;

implementation

{$R *.dfm}

uses
  SysUtils,
  OA5.uMainForm,
  CastersPackage.uRoutines;

procedure TLoginForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TLoginForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TLoginForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TLoginForm.Do_UpdateActions;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{348CBBCC-9845-40ED-9C35-39F5D58F4EAA}');
  Action_Ok.Enabled:=edbxLogin.Text<>'';
  Log.SendDebug('Действие "'+Action_Ok.Caption+'" '+Routines.GetConditionalString(Action_Ok.Enabled, 'в', 'от')+'ключено.');
  btnOk.Default:=Action_Ok.Enabled;
  btnClose.Default:=not Action_Ok.Enabled;
  ProcedureFooter;
end;

procedure TLoginForm.Do_Ok;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{38630A3A-99DB-4D54-A9A4-42BBA7F6DC42}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка авторизации была подтверждена пользователем.');
  Log.SendInfo('Окно авторизации закрыто.');

  ProcedureFooter;
end;

procedure TLoginForm.Action_OkExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Ok.Caption+'"', '{28FD25CC-0ED7-4CDC-8238-38B08A51AE9B}');
  Do_Ok;
  ProcedureFooter;
end;

procedure TLoginForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{394B4218-5393-4162-95FE-9740CEB2F2C9}');
  Do_Help;
  ProcedureFooter;
end;

procedure TLoginForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{1DFD76E1-46A7-4ADA-A2F3-AAF70AC8060C}');
  Do_Close;
  ProcedureFooter;
end;

procedure TLoginForm.Do_Help;
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

procedure TLoginForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{AFC63B2A-379B-4A09-98F3-549C5570B3D2}');

  ModalResult:=mrClose;
  Log.SendInfo('Попытка авторизации была отменена пользователем.');
  Log.SendInfo('Окно авторизации закрыто.');

  ProcedureFooter;
end;

procedure TLoginForm.FieldsChange(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', '{93B9E5F4-4353-4053-A07E-DED31D7011F0}');
  Do_UpdateActions;
  ProcedureFooter;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
const
  ICON_LOGIN=1;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{B7B2C87E-2141-43CA-A41B-23FE0E874839}');

  ilLoginFormSmallImages.GetIcon(ICON_LOGIN, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('Действие "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
      if LoginFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if LoginFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if LoginFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=LoginFormPosition.x;
          if LoginFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if LoginFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=LoginFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{96321487-1DC9-4591-AD46-BD64CDC4B64D}');
  Log.SendInfo('Отображено окно авторизации.');
  Do_UpdateActions;
  ProcedureFooter;
end;

end.
