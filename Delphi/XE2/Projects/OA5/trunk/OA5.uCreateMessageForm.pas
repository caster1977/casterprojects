unit OA5.uCreateMessageForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  CastersPackage.uLogProvider,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TCreateMessageForm=class(TForm)
    ilCreateMessageFormSmallImages: TImageList;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_Close: TAction;
    Bevel2: TBevel;
    btnClose: TButton;
    btnHelp: TButton;
    reMessage: TRichEdit;
    leTheme: TLabeledEdit;
    cmbbxTo: TComboBox;
    Label1: TLabel;
    btnSend: TButton;
    Action_Send: TAction;
    btnClear: TButton;
    Action_Clear: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_ClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Do_OnChange(Sender: TObject);
    procedure Action_SendExecute(Sender: TObject);
    procedure Do_OnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  strict private
    procedure ProcedureHeader(const aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_Clear;
    procedure Do_Send;
    procedure Do_UpdateActions;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uRoutines,
  OA5.uMainForm;

procedure TCreateMessageForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TCreateMessageForm.ProcedureHeader(const aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TCreateMessageForm.Do_OnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      Do_Close;
    VK_RETURN:
      if ssCtrl in Shift then
        Do_Send;
  end;
end;

procedure TCreateMessageForm.Do_Send;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{7BDDCBE9-E93E-4D51-A45E-6F8E532E8661}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка отправки созданного сообщения была подтверждена пользователем.');
  Log.SendInfo('Окно создания нового сообщения закрыто.');

  ProcedureFooter;
end;

procedure TCreateMessageForm.PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TCreateMessageForm.Action_ClearExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Clear.Caption+'"', '{F78DE6D4-0164-4F4E-9DCA-0BD6FA5EB2CF}');
  Do_Clear;
  ProcedureFooter;
end;

procedure TCreateMessageForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{F1FBC2E1-336C-491D-BC0B-8B2E70108C6D}');
  Do_Close;
  ProcedureFooter;
end;

procedure TCreateMessageForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{800109C0-82AB-4EAC-80E9-9341BC00A650}');
  Do_Help;
  ProcedureFooter;
end;

procedure TCreateMessageForm.Action_SendExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Send.Caption+'"', '{09170DB8-FCE2-4EF4-BD59-4E149C5F8280}');
  Do_Send;
  ProcedureFooter;
end;

procedure TCreateMessageForm.Do_OnChange(Sender: TObject);
begin
  Do_UpdateActions;
end;

procedure TCreateMessageForm.Do_Clear;
begin
  ProcedureHeader('Процедура очистки полей ввода окна создания сообщения', '{CC3CBEB8-842A-44C8-A6A0-92FE911F5A4D}');

  cmbbxTo.ItemIndex:=-1;
  leTheme.Clear;
  reMessage.Clear;
  ActiveControl:=cmbbxTo;
  Log.SendInfo('Поля ввода очищены пользователем.');

  ProcedureFooter;
end;

procedure TCreateMessageForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{FB15D7B1-D988-4AB8-952A-A407B768E1C6}');

  ModalResult:=mrClose;
  Log.SendInfo('Окно создания нового сообщения закрыто пользователем.');

  ProcedureFooter;
end;

procedure TCreateMessageForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{D123D1F6-0D45-45B0-9361-110CAC9C6735}');
  bError:=False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TCreateMessageForm.Do_UpdateActions;
var
  b: boolean;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{3F56424B-5AAE-4F72-AC97-57075F825F88}');

  b:=(cmbbxTo.ItemIndex>-1)or(leTheme.Text<>'')or(reMessage.Text<>'');
  if Action_Clear.Enabled<>b then
    begin
      Action_Clear.Enabled:=b;
      Log.SendDebug('Действие "'+Action_Clear.Caption+'" '+Routines.GetConditionalString(Action_Clear.Enabled, 'в', 'от')+'ключено.');
    end;

  b:=(cmbbxTo.ItemIndex>-1)and(leTheme.Text<>'')and(reMessage.Text<>'');
  if Action_Send.Enabled<>b then
    begin
      Action_Send.Enabled:=b;
      Log.SendDebug('Действие "'+Action_Send.Caption+'" '+Routines.GetConditionalString(Action_Send.Enabled, 'в', 'от')+'ключено.');
      btnSend.Default:=b;
      btnClose.Default:=not b;
    end;

  ProcedureFooter;
end;

procedure TCreateMessageForm.FormCreate(Sender: TObject);
const
  ICON_CREATEMESSAGE=1;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{7FD82BF2-AA3D-4AD0-848B-14E0000E9B31}');

  ilCreateMessageFormSmallImages.GetIcon(ICON_CREATEMESSAGE, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('Действие "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна в соответсвии со значениями конфигурации программы
      if CreateMessageFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if CreateMessageFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if CreateMessageFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=CreateMessageFormPosition.x;
          if CreateMessageFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if CreateMessageFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=CreateMessageFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TCreateMessageForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{C74EFD70-4CE5-4DF6-AFCD-D946EF325B07}');
  Do_UpdateActions;
  Log.SendInfo('Отображено окно создания нового сообщения.');
  ProcedureFooter;
end;

end.
