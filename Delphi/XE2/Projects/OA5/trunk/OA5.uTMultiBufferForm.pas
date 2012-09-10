unit OA5.uTMultiBufferForm;

interface

uses
  CastersPackage.uTPositionedLogForm,
  System.SysUtils,
  System.Classes,
  Vcl.ComCtrls,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMultiBufferForm = class(TPositionedLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actPaste: TAction;
    actDelete: TAction;
    actClear: TAction;
    actClose: TAction;
    actHelp: TAction;
    lvBuffer: TListView;
    pnlButtons: TPanel;
    btnPaste: TButton;
    btnDelete: TButton;
    btnClear: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure lvBufferSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure actPasteUpdate(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actClearUpdate(Sender: TObject);
  strict private
    procedure _Help;
    procedure _Close;
    procedure _UpdateListViewScrollBarVisibility;
    { TODO : Переделать методы, перечисленные ниже }
    procedure _Paste;
    procedure _Delete;
    procedure _Clear;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Forms,
  Winapi.Windows,
  OA5.uMainForm,
  CastersPackage.uTLogForm,
  CastersPackage.uRoutines;

resourcestring
  RsMultiBufferForm = 'мультибуфера';
  RsTryingToPasteItemConfirmedByUser =
    'Попытка вставки данных элемента мультибуфера в поля ввода была подтверждена пользователем.';
  RsListItemDeleteProcedure = 'Процедура удаления элемента из списка';
  RsClearListProcedure = 'Процедура очистки списка элементов';

const
  ICON_MULTIBUFFER = 1;

procedure TMultiBufferForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{991A06F2-F6DE-4EA6-A329-857E77C0B01C}');
  _Help;
  ProcedureFooter;
end;

procedure TMultiBufferForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{ADE69D60-880D-463E-9776-5E197AD9212E}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TMultiBufferForm.actPasteExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actPaste.Caption]), '{0DC0CD76-2CF2-4502-A386-A5F6C1E8E7B3}');
  _Paste;
  ProcedureFooter;
end;

procedure TMultiBufferForm.actPasteUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := lvBuffer.Items.Count > 0;
  if actPaste.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actPaste.Caption]), '{A71F9C3A-194D-44D8-8E18-6DC8F76F9006}');
    actPaste.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actPaste));
    ProcedureFooter;
  end;
end;

procedure TMultiBufferForm.actDeleteUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Assigned(lvBuffer.Selected);
  if actDelete.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actDelete.Caption]),
      '{50D24F38-E7F9-4435-B34B-69300DA17CA0}');
    actDelete.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actDelete));
    ProcedureFooter;
  end;
end;

procedure TMultiBufferForm.actClearExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClear.Caption]), '{6276AF19-2B53-4A4F-90D5-40F1973EEED5}');
  _Clear;
  ProcedureFooter;
end;

procedure TMultiBufferForm.actClearUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := lvBuffer.Items.Count > 0;
  if actClear.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actClear.Caption]), '{3A6B4025-F962-486D-B670-55664B32CBBA}');
    actClear.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actClear));
    ProcedureFooter;
  end;
end;

procedure TMultiBufferForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{F1FBC2E1-336C-491D-BC0B-8B2E70108C6D}');
  _Close;
  ProcedureFooter;
end;

procedure TMultiBufferForm.actDeleteExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actDelete.Caption]), '{46DC8E0A-D03A-47AF-80E2-86B5FDF2A567}');
  _Delete;
  ProcedureFooter;
end;

procedure TMultiBufferForm._Close;
begin
  ProcedureHeader(Format(RsCloseModalWithCancelProcedure, [RsMultiBufferForm]), '{B3D47CF5-25C2-4448-8443-C5A77CAC41B3}');

  ModalResult := mrCancel;
  Log.SendInfo(Format(RsWindowClosedByUser, [RsMultiBufferForm]));

  ProcedureFooter;
end;

procedure TMultiBufferForm._Help;
begin
  ProcedureHeader(RsContextHelpProcedure, '{BD937891-4495-4529-8E8B-A630DCD93E12}');
  Log.SendInfo(RsTryingToOpenHelpFile);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    GenerateError(RsHelpFileNonFound);
  end;
  ProcedureFooter;
end;

procedure TMultiBufferForm._Paste;
begin
  ProcedureHeader(Format(RsCloseModalWithOkProcedure, [RsMultiBufferForm]), '{7A09C228-C2BB-4BAE-BB65-8AE111C6FD09}');

  ModalResult := mrOk;
  Log.SendInfo(RsTryingToPasteItemConfirmedByUser);
  Log.SendInfo(Format(RsWindowClosed, [RsMultiBufferForm]));

  ProcedureFooter;
end;

procedure TMultiBufferForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsMultiBufferForm]), '{356A4C31-9E29-476F-A4EC-4CCDEC00EED0}');

  ImageList.GetIcon(ICON_MULTIBUFFER, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;
  end;

  ProcedureFooter;
end;

procedure TMultiBufferForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsMultiBufferForm]), '{AB96A9E3-8B37-427E-8826-8E1873A44D98}');
  _UpdateListViewScrollBarVisibility;

  if lvBuffer.Items.Count > 0 then
  begin
    ActiveControl := lvBuffer;
  end
  else
  begin
    ActiveControl := btnClose;
  end;
  Log.SendInfo(Format(RsWindowShowed, [RsMultiBufferForm]));

  ProcedureFooter;
end;

procedure TMultiBufferForm.lvBufferSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  (* ProcedureHeader('Процедура-обработчик события выбора элемента списка', '{85E95E47-C35D-4FCA-8319-39B52C4047CB}');
    _UpdateActions;
    ProcedureFooter; *)
end;

procedure TMultiBufferForm._UpdateListViewScrollBarVisibility;
var
  h: HWND;
begin
  ProcedureHeader('Процедура изменения ширины колонки списка элементов в зависимости от наличия полосы прокрутки',
    '{01D76D7B-0DD5-4A6F-B6A7-7DC52A7DAE82}');

  h := lvBuffer.Handle;
  lvBuffer.Column[0].Width := 75;
  if (GetWindowLong(h, GWL_STYLE) and WS_VSCROLL) = WS_VSCROLL then
  begin
    lvBuffer.Column[1].Width := lvBuffer.Width - (lvBuffer.BevelWidth * 2) - 2 - GetSystemMetrics(SM_CXVSCROLL) -
      lvBuffer.Column[0].Width;
  end
  else
  begin
    lvBuffer.Column[1].Width := lvBuffer.Width - (lvBuffer.BevelWidth * 2) - 2 - lvBuffer.Column[0].Width;
  end;
  lvBuffer.FlatScrollBars := False; // принудительная перерисовка элемента управления
  lvBuffer.FlatScrollBars := True;

  ProcedureFooter;
end;

procedure TMultiBufferForm._Clear;
begin
  ProcedureHeader(RsClearListProcedure, '{2E8AC92F-B5AF-47CA-B6D7-2063421BCC77}');

  lvBuffer.Clear;
  MainForm.MultiBuffer.Clear;

  _UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

procedure TMultiBufferForm._Delete;
begin
  ProcedureHeader(RsListItemDeleteProcedure, '{2A3724F3-1297-4823-BC75-59127E72572B}');

  if Assigned(lvBuffer.Selected) then
  begin
    if StrToIntDef(lvBuffer.Selected.Caption, -1) > -1 then
    begin
      MainForm.MultiBuffer.Delete(lvBuffer.Selected.Index);
      lvBuffer.Selected.Delete;
    end;
  end;

  _UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

end.
