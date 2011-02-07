unit FindGIUD;

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
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  OverseerTypes;

type
  TFindGUIDForm=class(TForm)
    edbxGUID: TEdit;
    lblGUID: TLabel;
    lblSearchDirecton: TLabel;
    rbSearchUpward: TRadioButton;
    rbSearchDownward: TRadioButton;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    Action_Find: TAction;
    cbFromCursor: TCheckBox;
    Bevel2: TBevel;
    btnClose: TButton;
    btnFind: TButton;
    btnHelp: TButton;
    Action_Help: TAction;
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_FindExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
  private
    procedure Do_Close;
    procedure Do_Find;
    procedure Do_Help;
    procedure Do_UpdateActions;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
  end;

var
  FindGUIDForm: TFindGUIDForm;

implementation

{$R *.dfm}

uses
  Main,
  OverseerRoutines,
  OverseerConsts;

procedure TFindGUIDForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
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

procedure TFindGUIDForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TFindGUIDForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TFindGUIDForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TFindGUIDForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{D35C2850-B4DE-4ABD-8572-B1B72A706E97}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

  with Action_Help do
    begin
      Enabled:=Application.HelpFile<>'';
      Visible:=Enabled;
    end;
  LogThis('Действие "'+Action_Help.Caption+'" '+Routines_GetConditionalMessage(Action_Help.Visible, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{5C9D84F0-39E0-4E90-AC67-FDDC51795B06}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
  LogThis('Отображено окно поиска GUID.', LogGroupGUID, lmtInfo);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.FieldsChange(Sender: TObject);
const
  LogGroupGUID: string='{B1A568EF-939F-40B9-9D6F-A50C9F7FBAC6}';
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', LogGroupGUID);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.Do_UpdateActions;
const
  LogGroupGUID: string='{200C3FDA-D9BC-4ED3-95BD-F75B049E3684}';
begin
  ProcedureHeader('Процедура обновления состояния действий', LogGroupGUID);

  Action_Find.Enabled:=Length(edbxGUID.Text)=38;
  LogThis('Действие "'+Action_Find.Caption+'" '+Routines_GetConditionalMessage(Action_Find.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  btnFind.Default:=Action_Find.Enabled;
  btnClose.Default:=not Action_Find.Enabled;

  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{E9C4E9C1-6BB1-4D39-BD53-16A57D038E4D}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.Action_FindExecute(Sender: TObject);
const
  LogGroupGUID: string='{39D2290D-B989-4C66-858B-A62487792865}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Find.Caption+'"', LogGroupGUID);
  Do_Find;
  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{39D2290D-B989-4C66-858B-A62487792865}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.Do_Help;
const
  LogGroupGUID: string='{D3E49892-C9DA-4A3F-8AA4-B386BD32EE5C}';
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

procedure TFindGUIDForm.Do_Find;
const
  LogGroupGUID: string='{87711D6D-D680-4178-8C90-7B0758526C48}';
var
  s: string;
  i, j, k: integer;
  b: boolean;
begin
  ProcedureHeader('Процедура перехода к строке протокола с указанным GUID', LogGroupGUID);
  b:=False;
  j:=-1;
  s:=Trim(edbxGUID.Text);

  if MainForm.lvLog.Items.Count>0 then
    begin
      LogThis('Выбран режим поиска '+Routines_GetConditionalMessage(rbSearchUpward.Checked, 'снизу вверх', 'сверху вниз')+' по списку протокола.', LogGroupGUID, lmtInfo);
      LogThis('Выбран режим поиска '+Routines_GetConditionalMessage(cbFromCursor.Checked, 'от курсора', 'по всему списку')+'.', LogGroupGUID, lmtInfo);
      if cbFromCursor.Checked then
        LogThis('Выделенный элемент списка'+Routines_GetConditionalMessage(MainForm.lvLog.Selected<>nil, '', ' не')+' был найден.', LogGroupGUID, lmtInfo);

      if rbSearchUpward.Checked then
        begin
          if cbFromCursor.Checked then
            begin
              if MainForm.lvLog.Selected<>nil then
                k:=MainForm.lvLog.Selected.index-1
              else
                k:=MainForm.lvLog.Items.Count-1;
            end
          else
            k:=MainForm.lvLog.Items.Count-1;
          with MainForm.lvLog do
            for i:=k downto 0 do
              if not b then
                if Items[i]<>nil then
                  if Items[i].SubItems.Count>=1 then
                    if Items[i].SubItems[0]=s then
                      begin
                        b:=True;
                        j:=i;
                      end;
        end;

      if rbSearchDownward.Checked then
        begin
          if cbFromCursor.Checked then
            begin
              if MainForm.lvLog.Selected<>nil then
                k:=MainForm.lvLog.Selected.index+1
              else
                k:=0;
            end
          else
            k:=0;
          with MainForm.lvLog do
            for i:=k to MainForm.lvLog.Items.Count-1 do
              if not b then
                if Items[i]<>nil then
                  if Items[i].SubItems.Count>=1 then
                    if Items[i].SubItems[0]=s then
                      begin
                        b:=True;
                        j:=i;
                      end;
        end;
      if b and(j>-1) then
        begin
          MainForm.lvLog.Items[j].Selected:=True;
          MainForm.lvLog.Items[j].Focused:=True;
          MainForm.lvLog.Selected.MakeVisible(False);
          LogThis(PWideChar('Переход к строке списка протокола с GUID '+s+' успешно выполнен.'), LogGroupGUID, lmtInfo);
        end
      else
        LogThis(PWideChar('Строк с GUID '+s+' в списке протокола не найдено!'), LogGroupGUID, lmtWarning);
    end
  else
    LogThis(PWideChar('Переход не выполнен, так как список протокола пуст!'), LogGroupGUID, lmtError);

  ProcedureFooter(LogGroupGUID);
end;

procedure TFindGUIDForm.Do_Close;
const
  LogGroupGUID: string='{FF3A7593-9C79-45E4-A2DB-86FFE81533BC}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrCancel', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('Окно поиска GUID закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

end.
