unit uPermissionsForm;

interface

uses
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ActnList,
  Vcl.ActnMan,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ImgList,
  Vcl.CheckLst,
  uLogProvider;

type
  TPermissionsForm=class(TForm)
    ActionManager1: TActionManager;
    Log: TLogProvider;
    ilPermissionsFormSmallImages: TImageList;
    chklbxPermissions: TCheckListBox;
    Bevel2: TBevel;
    btnHelp: TButton;
    btnApply: TButton;
    btnClose: TButton;
    btnSelectNone: TButton;
    btnSelectAll: TButton;
    Action_Apply: TAction;
    Action_Close: TAction;
    Action_Help: TAction;
    Action_SelectAll: TAction;
    Action_SelectNone: TAction;
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_SelectNoneExecute(Sender: TObject);
    procedure Action_SelectAllExecute(Sender: TObject);
    procedure chklbxPermissionsClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Apply;
    procedure Do_Close;
    procedure Do_SelectAll;
    procedure Do_SelectNone;
    procedure Do_UpdateActions;
  end;

implementation

{$R *.dfm}

uses
  uMainForm,
  uRoutines;

procedure TPermissionsForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TPermissionsForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TPermissionsForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TPermissionsForm.Action_ApplyExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', '{5C75FA77-50A0-471B-B6DA-472A571E78A5}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TPermissionsForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{0CD08097-3CBD-497C-A6E9-C334C2613D87}');
  Do_Close;
  ProcedureFooter;
end;

procedure TPermissionsForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{E39211E9-EC4D-452A-B3BF-267D5E516A22}');
  Do_Help;
  ProcedureFooter;
end;

procedure TPermissionsForm.Action_SelectAllExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_SelectAll.Caption+'"', '{14A91B39-D3D7-49C4-9F19-D253DE7AB611}');
  Do_SelectAll;
  ProcedureFooter;
end;

procedure TPermissionsForm.Action_SelectNoneExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_SelectNone.Caption+'"', '{2E28DFC0-7D3C-4E6E-B105-CFEC8B796E11}');
  Do_SelectNone;
  ProcedureFooter;
end;

procedure TPermissionsForm.chklbxPermissionsClickCheck(Sender: TObject);
begin
  ProcedureHeader('Процедура реакции на пеметку/снятие пометки чекбокса в списке прав доступа', '{FC7CC002-2ADC-4615-95D0-2F86AEC2E17B}');
  Do_UpdateActions;
  ProcedureFooter;
end;

procedure TPermissionsForm.Do_Apply;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{8C1D1934-43A0-4BD3-A063-95940EA9B73D}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка изменения пароля учётной записи была подтверждена пользователем.');
  Log.SendInfo('Окно изменения пароля учётной записи закрыто.');

  ProcedureFooter;
end;

procedure TPermissionsForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{19DBBA6D-0E8E-4BBB-BF5B-D2C80E71A631}');

  ModalResult:=mrClose;
  Log.SendInfo('Попытка изменения пароля учётной записи была отменена пользователем.');
  Log.SendInfo('Окно изменения пароля учётной записи закрыто.');

  ProcedureFooter;
end;

procedure TPermissionsForm.Do_Help;
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

procedure TPermissionsForm.Do_SelectAll;
var
  i: integer;
begin
  ProcedureHeader('Процедура выделения всех элементов списка прав доступа', '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i:=0 to chklbxPermissions.Count-1 do
    chklbxPermissions.Checked[i]:=True;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TPermissionsForm.Do_SelectNone;
var
  i: integer;
begin
  ProcedureHeader('Процедура снятия выделения со всех элементов списка прав доступа', '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i:=0 to chklbxPermissions.Count-1 do
    chklbxPermissions.Checked[i]:=False;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TPermissionsForm.Do_UpdateActions;
var
  b: boolean;
  i: integer;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{3ED4C156-FDB8-4F56-9E52-B3F393FE249D}');

  b:=False;
  for i:=0 to chklbxPermissions.Items.Count-1 do
    if not chklbxPermissions.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_SelectAll.Enabled:=(chklbxPermissions.Items.Count>0)and b;
  Log.SendDebug('Действие "'+Action_SelectAll.Caption+'" '+Routines.GetConditionalString(Action_SelectAll.Enabled, 'в', 'от')+'ключено.');
  btnSelectAll.Enabled:=Action_SelectAll.Enabled;

  b:=False;
  for i:=0 to chklbxPermissions.Items.Count-1 do
    if chklbxPermissions.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_SelectNone.Enabled:=(chklbxPermissions.Items.Count>0)and b;
  Log.SendDebug('Действие "'+Action_SelectNone.Caption+'" '+Routines.GetConditionalString(Action_SelectNone.Enabled, 'в', 'от')+'ключено.');
  btnSelectNone.Enabled:=Action_SelectNone.Enabled;

  ProcedureFooter;
end;

procedure TPermissionsForm.FormCreate(Sender: TObject);
const
  ICON_PERMISSIONS=3;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{43E2DB1C-46EC-46FB-BE5F-69082FF4BDB0}');

  ilPermissionsFormSmallImages.GetIcon(ICON_PERMISSIONS, Icon);
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
          if PermissionsFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if PermissionsFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=PermissionsFormPosition.x;
          if PermissionsFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if PermissionsFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=PermissionsFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TPermissionsForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{109E2C60-29E7-4230-956B-848F6063FD69}');
  Do_UpdateActions;
  Log.SendInfo('Отображено окно управления правами доступа пользователя.');
  ProcedureFooter;
end;

end.
