unit OA5.uAddEditPhoneForm;

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
  Vcl.StdCtrls,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  CastersPackage.uLogProvider,
  Vcl.ComCtrls;

type
  TAddEditPhoneForm=class(TForm)
    Log: TLogProvider;
    Bevel2: TBevel;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    Action_Help: TAction;
    btnClear: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    Action_Clear: TAction;
    btnApply: TButton;
    Action_Apply: TAction;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel5: TPanel;
    meComments: TMemo;
    ilAddEditPhoneFormSmallImages: TImageList;
    Panel6: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label13: TLabel;
    Label9: TLabel;
    edbxPhoneNumber: TEdit;
    cmbbxexedbxPhoneType: TComboBoxEx;
    Label10: TLabel;
    Label11: TLabel;
    dtpCheckDate: TDateTimePicker;
    Label12: TLabel;
    edbxPriority: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_ClearExecute(Sender: TObject);
    procedure edbxPriorityKeyPress(Sender: TObject; var Key: Char);
    procedure edbxPhoneNumberKeyPress(Sender: TObject; var Key: Char);
    procedure edbxPriorityChange(Sender: TObject);
    procedure edbxPriorityEnter(Sender: TObject);
    procedure edbxPriorityExit(Sender: TObject);
    procedure Do_OnChange(Sender: TObject);
  strict private
    procedure ProcedureHeader(const aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_Clear;
    procedure Do_Apply;
    procedure Do_UpdateActions;
  end;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  CastersPackage.uRoutines,
  OA5.uMainForm;

procedure TAddEditPhoneForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TAddEditPhoneForm.ProcedureHeader(const aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TAddEditPhoneForm.PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TAddEditPhoneForm.Do_Clear;
begin
  ProcedureHeader('Процедура очистки полей ввода окна добавления/исправления номера телефона', '{1006D689-7BEC-4229-AF29-9A9AB2A19DA2}');

  edbxPhoneNumber.Clear;
  cmbbxexedbxPhoneType.ItemIndex:=-1;
  dtpCheckDate.DateTime:=EncodeDate(1900, 01, 01); // Today;
  edbxPriority.Clear;
  meComments.Clear;
  Do_UpdateActions;
  ActiveControl:=edbxPhoneNumber;
  Log.SendInfo('Поля ввода очищены пользователем.');

  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{A439FD7A-FDB8-4CF5-B4D7-3FE18E1E4A4A}');
  bError:=False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Do_OnChange(Sender: TObject);
begin
  Do_UpdateActions;
end;

procedure TAddEditPhoneForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{EEEFBB6B-50BB-4EDD-9400-5784801D6950}');

  ModalResult:=mrClose;
  Log.SendInfo('Окно добавления/исправления номера телефона закрыто пользователем.');

  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Do_Apply;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{11F67191-F306-4C76-B8A8-CEC1AC239942}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка добавления/исправления номера телефона была подтверждена пользователем.');
  Log.SendInfo('Окно добавления/исправления номера телефона закрыто.');

  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Do_UpdateActions;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{769E9930-C791-4121-B171-85379120F47F}');

  ProcedureFooter;
end;

procedure TAddEditPhoneForm.edbxPhoneNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, ' ', '+', '-', '(', ')']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TAddEditPhoneForm.edbxPriorityChange(Sender: TObject);
begin
  if StrToIntDef(edbxPriority.Text, 0)<0 then
    edbxPriority.Text:='0';
  if StrToIntDef(edbxPriority.Text, 0)>254 then
    edbxPriority.Text:='254';
  Do_UpdateActions;
end;

procedure TAddEditPhoneForm.edbxPriorityEnter(Sender: TObject);
begin
  if StrToIntDef(edbxPriority.Text, -1)=-1 then
    edbxPriority.Text:='0';
end;

procedure TAddEditPhoneForm.edbxPriorityExit(Sender: TObject);
begin
  if StrToIntDef(edbxPriority.Text, -1)=-1 then
    edbxPriority.Text:='0';
end;

procedure TAddEditPhoneForm.edbxPriorityKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TAddEditPhoneForm.FormCreate(Sender: TObject);
const
  ICON_ADDEDITPHONE=1;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{7FD82BF2-AA3D-4AD0-848B-14E0000E9B31}');

  ilAddEditPhoneFormSmallImages.GetIcon(ICON_ADDEDITPHONE, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('Действие "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна в соответсвии со значениями конфигурации программы
      if AddEditPhoneFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if AddEditPhoneFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if AddEditPhoneFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=AddEditPhoneFormPosition.x;
          if AddEditPhoneFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if AddEditPhoneFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=AddEditPhoneFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TAddEditPhoneForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{F0AB3A4B-F7B1-444F-96D2-72BAA40CC988}');
  Do_UpdateActions;
  Log.SendInfo('Отображено окно добавления/исправления номера телефона.');
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Action_ApplyExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', '{3F6501C9-344A-46E6-9296-03C327D24EC1}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Action_ClearExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Clear.Caption+'"', '{E9B5319A-67B6-43AF-B5C3-C2970E5E66BC}');
  Do_Clear;
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{F5FC1E75-0564-4531-A1EC-242606AF6D3C}');
  Do_Close;
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{FC1F0DFA-B75D-455A-B245-37BE180520E1}');
  Do_Help;
  ProcedureFooter;
end;

end.
