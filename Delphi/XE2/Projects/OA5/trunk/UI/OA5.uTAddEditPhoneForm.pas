unit OA5.uTAddEditPhoneForm;

interface

uses
  OA5.uTOA5PositionedLogForm,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TAddEditPhoneForm = class(TOA5PositionedLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actClear: TAction;
    actApply: TAction;
    actClose: TAction;
    actHelp: TAction;

    pnlButtons: TPanel;
    btnClear: TButton;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;

    Panel1: TPanel;
    pnlCreatedBy: TPanel;
    lblCreatedBy: TLabel;
    lblCreateByValue: TLabel;
    pnlMain: TPanel;
    meComments: TMemo;
    lblComments: TLabel;
    lblNumber: TLabel;
    edbxNumber: TEdit;
    cmbexType: TComboBoxEx;
    lblType: TLabel;
    lblCheckDate: TLabel;
    dtpCheckDate: TDateTimePicker;
    lblPriority: TLabel;
    edbxPriority: TEdit;
    pnlCommentsCreated: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure edbxPriorityKeyPress(Sender: TObject; var Key: Char);
    procedure edbxNumberKeyPress(Sender: TObject; var Key: Char);
    procedure edbxPriorityChange(Sender: TObject);
    procedure edbxPriorityEnter(Sender: TObject);
    procedure edbxPriorityExit(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure actClearUpdate(Sender: TObject);
  strict private
    procedure _Clear;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Forms,
  System.SysUtils,
  System.DateUtils,
  CastersPackage.uResourceStrings,
  CastersPackage.uRoutines,
  OA5.uTMainForm;

const
  ICON_ADDEDITPHONE = 1;

resourcestring
  RsAddEditPhoneForm = 'добавлени€/исправлени€ номера телефона';

procedure TAddEditPhoneForm._Clear;
begin
  ProcedureHeader('ѕроцедура очистки полей ввода окна добавлени€/исправлени€ номера телефона',
    '{1006D689-7BEC-4229-AF29-9A9AB2A19DA2}');

  edbxNumber.Clear;
  cmbexType.ItemIndex := -1;
  dtpCheckDate.DateTime := EncodeDate(1900, 01, 01); // Today;
  edbxPriority.Clear;
  meComments.Clear;
  ActiveControl := edbxNumber;
  Log.SendInfo('ѕол€ ввода очищены пользователем.');

  ProcedureFooter;
end;

procedure TAddEditPhoneForm.edbxNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8, ' ', '+', '-', '(', ')']) then
    Key := #0; // "погасить" все остальные клавиши
end;

procedure TAddEditPhoneForm.edbxPriorityChange(Sender: TObject);
begin
  if StrToIntDef(edbxPriority.Text, 0) < 0 then
    edbxPriority.Text := '0';
  if StrToIntDef(edbxPriority.Text, 0) > 254 then
    edbxPriority.Text := '254';
end;

procedure TAddEditPhoneForm.edbxPriorityEnter(Sender: TObject);
begin
  if StrToIntDef(edbxPriority.Text, -1) = -1 then
  begin
    edbxPriority.Text := '0';
  end;
end;

procedure TAddEditPhoneForm.edbxPriorityExit(Sender: TObject);
begin
  if StrToIntDef(edbxPriority.Text, -1) = -1 then
  begin
    edbxPriority.Text := '0';
  end;
end;

procedure TAddEditPhoneForm.edbxPriorityKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8]) then
  begin
    Key := #0; // "погасить" все остальные клавиши
  end;
end;

procedure TAddEditPhoneForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsAddEditPhoneForm]), '{7FD82BF2-AA3D-4AD0-848B-14E0000E9B31}');

  ImageList.GetIcon(ICON_ADDEDITPHONE, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколировани€ в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;
  end;

  ProcedureFooter;
end;

procedure TAddEditPhoneForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsAddEditPhoneForm]), '{56B99E60-8AE1-4B33-B005-32AFBC21114F}');
  Log.SendInfo(Format(RsWindowShowed, [RsAddEditPhoneForm]));
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.actApplyExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actApply.Caption]), '{3F6501C9-344A-46E6-9296-03C327D24EC1}');
  Log.SendInfo('ѕопытка добавлени€/исправлени€ номера телефона была подтверждена пользователем.');
  CloseModalWindowWithOkResult(RsAddEditPhoneForm, '{5EDFF0E8-891D-4F4E-90D9-B3195669939E}');
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.actClearExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClear.Caption]), '{E9B5319A-67B6-43AF-B5C3-C2970E5E66BC}');
  _Clear;
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{F5FC1E75-0564-4531-A1EC-242606AF6D3C}');
  CloseModalWindowWithCancelResult(RsAddEditPhoneForm, '{82C266AC-84F6-4B06-8B0E-0FACDB889CD1}');
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{FC1F0DFA-B75D-455A-B245-37BE180520E1}');
  Help(HelpContext, '{1A7EF6C2-56E0-476A-86B6-14A49DFCB413}');
  ProcedureFooter;
end;

procedure TAddEditPhoneForm.actHelpUpdate(Sender: TObject);
var
  b: boolean;
begin
  inherited;
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{CEE5E3DF-C04C-4125-AFDE-D6FE85947558}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TAddEditPhoneForm.actClearUpdate(Sender: TObject);
var
  b: boolean;
begin
  inherited;
  b := (edbxNumber.Text <> EmptyStr) or (cmbexType.ItemIndex > -1) or (dtpCheckDate.DateTime <> EncodeDate(1900, 01, 01)) or
    (edbxPriority.Text <> EmptyStr) or (meComments.Text <> EmptyStr);
  if actClear.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actClear.Caption]), '{F81F6D8B-EAFB-4A9D-AB50-E79FD75F2401}');
    actClear.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actClear));
    ProcedureFooter;
  end;
end;

end.
