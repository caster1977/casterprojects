unit Permissions;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  CheckLst,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ImgList,
  Menus,
  OverseerTypes;

type
  TPermissionsForm=class(TForm)
    clbActions: TCheckListBox;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    ImageList1: TImageList;
    Action_Close: TAction;
    PopupMenu1: TPopupMenu;
    Action_Apply: TAction;
    btnSelectAllPermissions: TButton;
    btnUnselectAllPermissions: TButton;
    Action_SelectAllPermissions: TAction;
    Action_UnselectAllPermissions: TAction;
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_SelectAllPermissionsExecute(Sender: TObject);
    procedure Action_UnselectAllPermissionsExecute(Sender: TObject);
    procedure clbActionsClickCheck(Sender: TObject);
  private
    procedure Do_Close;
    procedure Do_Help;
    procedure Do_Apply;
    procedure Update_Actions;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
  end;

var
  PermissionsForm: TPermissionsForm;

implementation

{$R *.dfm}

uses
  Main,
  OverseerRoutines,
  OverseerConsts;

procedure TPermissionsForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
var
  s: string;
  aCopyData: TCopyDataStruct;
begin
  case aMessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
    lmtDebug:
      s:='DEBUG';
  end;
  s:=IntToStr(WMCD_MODALLOG)+';'+s+';'+aMessage+';'+aLogGroupGUID;
  with aCopyData do
    begin
      dwData:=0;
      cbData:=Length(s)+1;
      lpData:=PAnsiChar(AnsiString(s));
    end;
  SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;

procedure TPermissionsForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TPermissionsForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TPermissionsForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TPermissionsForm.Action_ApplyExecute(Sender: TObject);
const
  LogGroupGUID: string='{D2961D79-CDD3-424C-A4B8-5EFD6C11E622}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', LogGroupGUID);
  Do_Apply;
  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{8A936681-B799-4EFD-8A48-C9E3D9BE441F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{AFDA0293-6E4E-402C-80DD-4FDCC8579C1B}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Do_Close;
const
  LogGroupGUID: string='{D1935C65-438B-4FE0-B4C0-A1EF293B0562}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('Попытка изменения прав доступа была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения прав доступа закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Do_Help;
const
  LogGroupGUID: string='{12A06CB9-F9B5-4903-8756-DF8A57FFBD45}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{261C94B6-8015-40D5-9FA7-1D2C8C3B5E2C}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

  with Action_Help do
    begin
      Enabled:=Application.HelpFile<>'';
      Visible:=Enabled;
    end;
  LogThis('Действие "'+Action_Help.Caption+'" '+Routines_GetConditionalMessage(Action_Help.Visible, 'в', 'от')+'ключено.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{C3F14D57-A01D-4B92-9D9D-478466B60959}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);

  LogThis('Отображено окно изменения прав доступа.', LogGroupGUID, lmtInfo);
  clbActions.Enabled:=clbActions.Items.Count>0;
  Update_Actions;

  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Do_Apply;
const
  LogGroupGUID: string='{58F1FDA8-6958-4475-9093-B74AA613A5E6}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);

  ModalResult:=mrOk;
  LogThis('Попытка изменения прав доступа была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения прав доступа закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Action_SelectAllPermissionsExecute(Sender: TObject);
const
  LogGroupGUID: string='{AA86DD78-8380-4C41-9B9F-67A9CB4FF9C5}';
var
  i: integer;
begin
  ProcedureHeader('Процедура выделения всех элементов списка прав доступа', LogGroupGUID);

  with clbActions do
    begin
      OnClickCheck:=nil;
      Items.BeginUpdate;
      for i:=0 to Count-1 do
        Checked[i]:=True;
      Items.EndUpdate;
      OnClickCheck:=clbActionsClickCheck;
    end;
  Update_Actions;

  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Action_UnselectAllPermissionsExecute(Sender: TObject);
const
  LogGroupGUID: string='{9B428694-2E4B-4659-8697-14E61F340D39}';
var
  i: integer;
begin
  ProcedureHeader('Процедура снятия выделения со всех элементов списка прав доступа', LogGroupGUID);

  with clbActions do
    begin
      OnClickCheck:=nil;
      Items.BeginUpdate;
      for i:=0 to Count-1 do
        Checked[i]:=False;
      Items.EndUpdate;
      OnClickCheck:=clbActionsClickCheck;
    end;
  Update_Actions;

  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.clbActionsClickCheck(Sender: TObject);
const
  LogGroupGUID: string='{4F38B2E5-B9BC-4CAB-8EEA-39A1E49CB6A7}';
begin
  ProcedureHeader('Процедура реакции на пеметку/снятие пометки чекбокса в списке прав доступа', LogGroupGUID);

  Update_Actions;

  ProcedureFooter(LogGroupGUID);
end;

procedure TPermissionsForm.Update_Actions;
const
  LogGroupGUID: string='{7912CFE0-E383-46F2-A9D6-AA4F143D4701}';
var
  b: boolean;
  i: integer;
begin
  ProcedureHeader('Процедура обновления состояния кнопок дополнительных параметров действия', LogGroupGUID);

  b:=False;
  for i:=0 to clbActions.Items.Count-1 do
    if not clbActions.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_SelectAllPermissions.Enabled:=(clbActions.Items.Count>0)and b;
  btnSelectAllPermissions.Enabled:=Action_SelectAllPermissions.Enabled;

  b:=False;
  for i:=0 to clbActions.Items.Count-1 do
    if clbActions.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_UnselectAllPermissions.Enabled:=(clbActions.Items.Count>0)and b;
  btnUnselectAllPermissions.Enabled:=Action_UnselectAllPermissions.Enabled;

  ProcedureFooter(LogGroupGUID);
end;

end.
