unit Configuration;

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
  ImgList,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan, ExtCtrls, Grids, ValEdit, ComCtrls,
  OA5Types;

type
  TConfigurationForm=class(TForm)
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_Defaults: TAction;
    Action_Close: TAction;
    Action_Apply: TAction;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    Action_ChooseLogClient: TAction;
    ImageList1: TImageList;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    Panel3: TPanel;
    gbHeader: TGroupBox;
    cbPage: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    Panel1: TPanel;
    gbPage: TGroupBox;
    PageControl1: TPageControl;
    ts1: TTabSheet;
    vleInterface: TValueListEditor;
    ts4: TTabSheet;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Bevel2: TBevel;
    chkbxKeepInfoLog: TCheckBox;
    chkbxKeepWarningLog: TCheckBox;
    chkbxKeepErrorLog: TCheckBox;
    chkbxKeepSQLLog: TCheckBox;
    chkbxFlushLogOnStringsQuantity: TCheckBox;
    chkbxFlushLogOnExit: TCheckBox;
    edbxFlushLogOnStringsQuantity: TEdit;
    chkbxFlushLogOnClearingLog: TCheckBox;
    chkbxFlushLogOnApply: TCheckBox;
    chkbxKeepDebugLog: TCheckBox;
    ts5: TTabSheet;
    Bevel3: TBevel;
    rbSaveIntoTheTempFolder: TRadioButton;
    rbSaveIntoTheSelectedFolder: TRadioButton;
    rbSaveIntoTheApplicationFolder: TRadioButton;
    chkbxAskForFileName: TCheckBox;
    edbxSelectedFolder: TEdit;
    btnSelectFolder: TButton;
    chkbxDontDemandOverwriteConfirmation: TCheckBox;
    ts2: TTabSheet;
    vleRNE4SERVER: TValueListEditor;
    ts3: TTabSheet;
    vleMESSAGESERVER: TValueListEditor;
    chkbxCustomLogClientFile: TCheckBox;
    edbxCustomLogClientFile: TEdit;
    btnChoiseCustomLogClientFile: TButton;
    Action_ChooseReportFolder: TAction;
    chkbxUseLog: TCheckBox;
    Bevel4: TBevel;
    Bevel5: TBevel;
    ts6: TTabSheet;
    sgAutoReplaceList: TStringGrid;
    btnLineUp: TButton;
    btnLineDown: TButton;
    Action_LineUp: TAction;
    Action_LineDown: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_DefaultsExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure Action_ChooseReportFolderExecute(Sender: TObject);
    procedure Action_ChooseLogClientExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  public
    slBoolean: TStringList;
  private
    procedure Do_Help;
    procedure Do_Defaults;
    procedure Do_Close;
    procedure Do_Apply;
    procedure Do_NextPage;
    procedure Do_PreviousPage;
    procedure Do_ChooseReportFolder;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

{$R *.dfm}

uses
  FileCtrl,
  Main,
  OA5Routines,
  OA5Consts;


procedure TConfigurationForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
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

procedure TConfigurationForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TConfigurationForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TConfigurationForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TConfigurationForm.Action_ApplyExecute(Sender: TObject);
const
  LogGroupGUID: string='{CA167013-A754-476D-B36F-6CE012D8C21E}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', LogGroupGUID);
  Do_Apply;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Apply;
const
  LogGroupGUID: string='{33DF7021-2314-4BD2-8FE5-745D3C92231F}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);

  ModalResult:=mrOk;
  LogThis('Попытка изменения настроек программы была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения настроек программы закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{E29B1B88-55F3-4F04-A4E7-99D189526C44}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Close;
const
  LogGroupGUID: string='{A114BAEA-0279-44A9-AECA-1D6D0A1C12BA}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('Попытка изменения настроек программы была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения настроек программы закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{C5006F00-F43A-40AE-A060-15853FF8290F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Help;
const
  LogGroupGUID: string='{A107CDA0-8C13-4A7D-A685-15948B680D49}';
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

procedure TConfigurationForm.Action_PreviousPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{DEEC08B4-451D-480B-A392-1E3127868934}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_PreviousPage.Caption+'"', LogGroupGUID);
  Do_PreviousPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_PreviousPage;
const
  LogGroupGUID: string='{5C70F626-6F88-4F8B-9F16-93DDCDA4A919}';
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения предыдущей страницы настроек программы', LogGroupGUID);

  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_NextPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{8AC3593F-EC49-4348-92E9-C34C15492737}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_NextPage.Caption+'"', LogGroupGUID);
  Do_NextPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_NextPage;
const
  LogGroupGUID: string='{207F2915-B5C9-4123-A435-AEA01A519A5A}';
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения следующей страницы настроек программы', LogGroupGUID);

  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_ChooseReportFolderExecute(Sender: TObject);
const
  LogGroupGUID: string='{07B749FB-3200-4928-97AB-6C9ECE22181C}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', LogGroupGUID);
  Do_ChooseReportFolder;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_ChooseReportFolder;
const
  LogGroupGUID: string='{10574594-BB2E-4D66-B2B0-45CFE6B0BD58}';
var
  s, sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора папки для сохранения отчётов', LogGroupGUID);
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
    end;

  s:=edbxSelectedFolder.Text;

  if SelectDirectory('Выберите папку', '', s, [sdNewFolder, sdNewUI], Self) then
    if (s<>'') then
      begin
        sPath:=s;
        if (sPath[Length(sPath)]<>'\') then
          sPath:=sPath+'\';
        if SysUtils.DirectoryExists(sPath) then
          begin
            edbxSelectedFolder.Text:=sPath;
            LogThis('В качестве папки для сохранения отчётов выбрана папка "'+sPath+'".', LogGroupGUID, lmtDebug);
          end
        else
          begin
            edbxSelectedFolder.Text:='';
            Routines_GenerateError('Возникла ошибка при выборе папки - указанная папка не существует!', sErrorMessage, bError);
          end;
      end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
      Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;


procedure TConfigurationForm.Action_ChooseLogClientExecute(Sender: TObject);
const
  LogGroupGUID: string='{2D27F8F7-46A5-4A52-A527-F80BCE16C56D}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', LogGroupGUID);
  Do_ChooseLogClient;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_DefaultsExecute(Sender: TObject);
const
  LogGroupGUID: string='{AB46AE80-4A60-4E43-8B6F-47A2D8E1049F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Defaults.Caption+'"', LogGroupGUID);
  Do_Defaults;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
const
  LogGroupGUID: string='{307097C9-68DB-47A5-A46D-1432E3A70A84}';
begin
  slBoolean.Free;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{E3A04C17-B2AB-461E-A4F5-2473EC4E9297}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
  LogThis('Отображено окно изменения настроек программы.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

  Action_Help.Enabled:=Application.HelpFile<>'';
  slBoolean:=TStringList.Create;
  with slBoolean do
    begin
      Add('Нет');
      Add('Да');
    end;

  ProcedureFooter(LogGroupGUID);
end;


end.
