unit OA5.uMultiBufferForm;

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
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  CastersPackage.uLogProvider,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TMultiBufferForm=class(TForm)
    Bevel2: TBevel;
    btnClose: TButton;
    btnHelp: TButton;
    ilMultiBufferFormSmallImages: TImageList;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    Action_Help: TAction;
    btnPaste: TButton;
    btnDelete: TButton;
    btnClear: TButton;
    lvBuffer: TListView;
    Action_Paste: TAction;
    Action_Delete: TAction;
    Action_Clear: TAction;
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure lvBufferSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_DeleteExecute(Sender: TObject);
    procedure Action_PasteExecute(Sender: TObject);
    procedure Action_ClearExecute(Sender: TObject);
  strict private
    procedure ProcedureHeader(const aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_UpdateActions;
    procedure Do_UpdateListViewScrollBarVisibility;
    { TODO : Переделать методы, перечисленные ниже }
    procedure Do_Paste;
    procedure Do_Delete;
    procedure Do_Clear;
  end;

implementation

{$R *.dfm}

uses
  OA5.uTypes,
  OA5.uMainForm,
  CastersPackage.uRoutines;

procedure TMultiBufferForm.ProcedureHeader(const aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TMultiBufferForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TMultiBufferForm.PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TMultiBufferForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{991A06F2-F6DE-4EA6-A329-857E77C0B01C}');
  Do_Help;
  ProcedureFooter;
end;

procedure TMultiBufferForm.Action_PasteExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Paste.Caption+'"', '{0DC0CD76-2CF2-4502-A386-A5F6C1E8E7B3}');
  Do_Paste;
  ProcedureFooter;
end;

procedure TMultiBufferForm.Action_ClearExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Clear.Caption+'"', '{6276AF19-2B53-4A4F-90D5-40F1973EEED5}');
  Do_Clear;
  ProcedureFooter;
end;

procedure TMultiBufferForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{F1FBC2E1-336C-491D-BC0B-8B2E70108C6D}');
  Do_Close;
  ProcedureFooter;
end;

procedure TMultiBufferForm.Action_DeleteExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Delete.Caption+'"', '{46DC8E0A-D03A-47AF-80E2-86B5FDF2A567}');
  Do_Delete;
  ProcedureFooter;
end;

procedure TMultiBufferForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{B3D47CF5-25C2-4448-8443-C5A77CAC41B3}');

  ModalResult:=mrClose;
  Log.SendInfo('Окно мультибуфера закрыто пользователем.');

  ProcedureFooter;
end;

procedure TMultiBufferForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{A18B0204-9CD7-4A82-B9B1-69B4231F21EA}');
  bError:=False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TMultiBufferForm.Do_Paste;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{7A09C228-C2BB-4BAE-BB65-8AE111C6FD09}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка вставки данных элемента мультибуфера в поля ввода была подтверждена пользователем.');
  Log.SendInfo('Окно мультибуфера закрыто.');

  ProcedureFooter;
end;

procedure TMultiBufferForm.Do_UpdateActions;
var
  b: boolean;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{75BE1246-C69A-4BB0-A6D9-1DB7FA775D81}');

  b:=lvBuffer.Items.Count>0;
  if Action_Paste.Enabled<>b then
    begin
      Action_Paste.Enabled:=b;
      Log.SendDebug('Действие "'+Action_Paste.Caption+'" '+Routines.GetConditionalString(Action_Paste.Enabled, 'в', 'от')+'ключено.');
    end;

  b:=lvBuffer.Selected<>nil;
  if Action_Delete.Enabled<>b then
    begin
      Action_Delete.Enabled:=b;
      Log.SendDebug('Действие "'+Action_Delete.Caption+'" '+Routines.GetConditionalString(Action_Delete.Enabled, 'в', 'от')+'ключено.');
    end;

  b:=lvBuffer.Items.Count>0;
  if Action_Clear.Enabled<>b then
    begin
      Action_Clear.Enabled:=b;
      Log.SendDebug('Действие "'+Action_Clear.Caption+'" '+Routines.GetConditionalString(Action_Clear.Enabled, 'в', 'от')+'ключено.');
    end;

  ProcedureFooter;
end;

procedure TMultiBufferForm.FormCreate(Sender: TObject);
const
  ICON_MULTIBUFFER=1;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{16B7A0D2-50B9-4893-8A4F-7C43CB483CA1}');

  ilMultiBufferFormSmallImages.GetIcon(ICON_MULTIBUFFER, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('Действие "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
      if MultibufferFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if MultibufferFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if MultibufferFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=LoginFormPosition.x;
          if MultibufferFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if MultibufferFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=LoginFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TMultiBufferForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{12A42A2F-3905-4F76-9BC6-734BD06F55DD}');
  Log.SendInfo('Отображено окно мультибуфера.');

  Do_UpdateListViewScrollBarVisibility;
  Do_UpdateActions;

  if lvBuffer.Items.Count>0 then
    ActiveControl:=lvBuffer
  else
    ActiveControl:=btnClose;

  ProcedureFooter;
end;

procedure TMultiBufferForm.lvBufferSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  ProcedureHeader('Процедура-обработчик события выбора элемента списка', '{85E95E47-C35D-4FCA-8319-39B52C4047CB}');
  Do_UpdateActions;
  ProcedureFooter;
end;

procedure TMultiBufferForm.Do_UpdateListViewScrollBarVisibility;
var
  h: HWND;
begin
  ProcedureHeader('Процедура изменения ширины колонки списка элементов в зависимости от наличия полосы прокрутки', '{01D76D7B-0DD5-4A6F-B6A7-7DC52A7DAE82}');

  h:=lvBuffer.Handle;
  lvBuffer.Column[0].Width:=75;
  if (GetWindowLong(h, GWL_STYLE)and WS_VSCROLL)=WS_VSCROLL then
    lvBuffer.Column[1].Width:=lvBuffer.Width-(lvBuffer.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)-lvBuffer.Column[0].Width
  else
    lvBuffer.Column[1].Width:=lvBuffer.Width-(lvBuffer.BevelWidth*2)-2-lvBuffer.Column[0].Width;
  lvBuffer.FlatScrollBars:=False; // принудительная перерисовка элемента управления
  lvBuffer.FlatScrollBars:=True;

  ProcedureFooter;
end;

procedure TMultiBufferForm.Do_Clear;
begin
  ProcedureHeader('Процедура очистки списка элементов', '{2E8AC92F-B5AF-47CA-B6D7-2063421BCC77}');

  lvBuffer.Clear;
  MainForm.MeasuresMultiBuffer.Clear;

  Do_UpdateActions;
  Do_UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

procedure TMultiBufferForm.Do_Delete;
begin
  ProcedureHeader('Процедура удаления элемента из списка', '{2A3724F3-1297-4823-BC75-59127E72572B}');

  if lvBuffer.Selected<>nil then
    begin
      if StrToIntDef(lvBuffer.Selected.Caption, -1)>-1 then
        begin
          MainForm.MeasuresMultiBuffer.Delete(lvBuffer.Selected.Index);
          lvBuffer.Selected.Delete;
        end;
    end;

  Do_UpdateActions;
  Do_UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

end.
