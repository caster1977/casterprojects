{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
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
  ExtCtrls,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ComCtrls,
  Grids,
  ValEdit,
  OverseerTypes;

type
  TConfigurationForm=class(TForm)
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
    ActionManager1: TActionManager;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    Panel1: TPanel;
    gbPage: TGroupBox;
    PageControl1: TPageControl;
    ts1: TTabSheet;
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
    ts3: TTabSheet;
    ts7: TTabSheet;
    ts6: TTabSheet;
    vleDBSERVER: TValueListEditor;
    vleSTATSERVER: TValueListEditor;
    vleOVERSEERSERVER: TValueListEditor;
    ValueListEditor1: TValueListEditor;
    vleInterface: TValueListEditor;
    ts8: TTabSheet;
    vleRNE4SERVER: TValueListEditor;
    chkbxKeepDebugLog: TCheckBox;
    Action_Help: TAction;
    Action_Defaults: TAction;
    Action_Close: TAction;
    Action_Apply: TAction;
    Action_ChooseReportFolder: TAction;
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure cbPageSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
    procedure rbSaveIntoTheSelectedFolderClick(Sender: TObject);
    procedure chkbxUseExternalLogClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_DefaultsExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_ChooseReportFolderExecute(Sender: TObject);
  public
    slBoolean, slActions: TStringList;
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
  mysql,
  FileCtrl,
  Main,
  OverseerRoutines,
  OverseerConsts;

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
  LogGroupGUID: string='{5FE870D9-86BD-401D-9B70-03EA2021FE36}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', LogGroupGUID);
  Do_Apply;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_ChooseReportFolderExecute(Sender: TObject);
const
  LogGroupGUID: string='{43F7DFCB-2E62-4B0D-A92D-3AE0133F6D56}';
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

procedure TConfigurationForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{010E4FFC-5789-43A8-8362-50C9A9C23D22}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Apply; // завершена
const
  LogGroupGUID: string='{4F771D0D-5B18-44BA-8F38-DAA6CD09873C}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);

  ModalResult:=mrOk;
  LogThis('Попытка изменения настроек программы была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения настроек программы закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Close;
const
  LogGroupGUID: string='{4090ADB3-1842-4EF2-B9D7-B147355FB7D2}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('Попытка изменения настроек программы была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения настроек программы закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_DefaultsExecute(Sender: TObject);
const
  LogGroupGUID: string='{E5B0A060-5B94-4080-A3B5-5774EA65C6B3}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Defaults.Caption+'"', LogGroupGUID);
  Do_Defaults;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Defaults;
const
  LogGroupGUID: string='{EDC577E6-6D47-4DC2-973E-AD820C7AC588}';
begin
  ProcedureHeader('Процедура сброса настроек к значениям по умолчанию', LogGroupGUID);

  if PageControl1.ActivePage.Caption=' интерфейса' then
    begin
      vleInterface.Cells[1, 1]:='Нет';
      vleInterface.Cells[1, 2]:='Да';
      vleInterface.Cells[1, 3]:='Нет';
      vleInterface.Cells[1, 4]:='Нет';
      vleInterface.Cells[1, 5]:='Нет';
      vleInterface.Cells[1, 6]:='Нет';
      vleInterface.Cells[1, 7]:='';
      vleInterface.Cells[1, 8]:='Да';
      vleInterface.Cells[1, 9]:='Нет';
      vleInterface.Cells[1, 10]:='Нет';
      vleInterface.Cells[1, 11]:='Да';
      vleInterface.Cells[1, 12]:='Да';
    end;
  if PageControl1.ActivePage.Caption=' ведения протокола работы' then
    begin
      chkbxKeepErrorLog.Checked:=True;
      chkbxKeepWarningLog.Checked:=True;
      chkbxKeepInfoLog.Checked:=True;
      chkbxKeepSQLLog.Checked:=True;
      chkbxKeepDebugLog.Checked:=False;
      chkbxFlushLogOnExit.Checked:=True;
      chkbxFlushLogOnStringsQuantity.Checked:=False;
      edbxFlushLogOnStringsQuantity.Text:='';
      chkbxFlushLogOnClearingLog.Checked:=True;
      chkbxFlushLogOnApply.Checked:=False;
    end;
  if PageControl1.ActivePage.Caption=' формирования отчётов' then
    begin
      rbSaveIntoTheTempFolder.Checked:=True;
      edbxSelectedFolder.Text:='';
      chkbxDontDemandOverwriteConfirmation.Checked:=False;
      chkbxAskForFileName.Checked:=False;
    end;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу OVERSEERSERVER' then
    begin
      vleOVERSEERSERVER.Cells[1, 1]:='OVERSEERSERVER';
      vleOVERSEERSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
      vleOVERSEERSERVER.Cells[1, 3]:=IntToStr(30);
      vleOVERSEERSERVER.Cells[1, 4]:=vleOVERSEERSERVER.ItemProps[3].PickList.Strings[1];
      vleOVERSEERSERVER.Cells[1, 5]:='overseer';
    end;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу RNE4SERVER' then
    begin
      vleRNE4SERVER.Cells[1, 1]:='RNE4SERVER';
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(30);
      vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[1];
      vleRNE4SERVER.Cells[1, 5]:='rne4';
    end;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу DBSERVER' then
    begin
      vleDBSERVER.Cells[1, 1]:='DBSERVER';
      vleDBSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
      vleDBSERVER.Cells[1, 3]:=IntToStr(30);
      vleDBSERVER.Cells[1, 4]:=vleDBSERVER.ItemProps[3].PickList.Strings[1];
      vleDBSERVER.Cells[1, 5]:='statistika';
      vleDBSERVER.Cells[1, 6]:='statistika';
      vleDBSERVER.Cells[1, 7]:='test';
      vleDBSERVER.Cells[1, 8]:='test';
      vleDBSERVER.Cells[1, 9]:='MyStat';
    end;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу STATSERVER' then
    begin
      vleSTATSERVER.Cells[1, 1]:='STATSERVER';
      vleSTATSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
      vleSTATSERVER.Cells[1, 3]:=IntToStr(30);
      vleSTATSERVER.Cells[1, 4]:=vleSTATSERVER.ItemProps[3].PickList.Strings[1];
      vleSTATSERVER.Cells[1, 5]:='ird';
      vleSTATSERVER.Cells[1, 6]:='ord';
      vleSTATSERVER.Cells[1, 7]:='irda';
      vleSTATSERVER.Cells[1, 8]:='orda';
      vleSTATSERVER.Cells[1, 9]:='prijaves';
      vleSTATSERVER.Cells[1, 10]:='prijaves';
    end;
  LogThis('Настройки '+PageControl1.ActivePage.Caption+' были сброшены пользователем к значениям по умолчанию.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{7819A531-38CD-487B-836C-9F4E78F810BB}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_Help;
const
  LogGroupGUID: string='{5A7E5DF5-A7AC-4DE4-92F7-67011C1FFF7B}';
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

procedure TConfigurationForm.Action_NextPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{07323288-DA47-4420-8BAE-96DFF84FB9A2}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_NextPage.Caption+'"', LogGroupGUID);
  Do_NextPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_NextPage;
const
  LogGroupGUID: string='{5CFB341C-07A5-43D7-BBBC-BC7CF70B729E}';
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

procedure TConfigurationForm.Action_PreviousPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{1ED34383-81D8-4FB6-94E8-CB046847076B}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_PreviousPage.Caption+'"', LogGroupGUID);
  Do_PreviousPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.Do_PreviousPage;
const
  LogGroupGUID: string='{8709A13B-4208-4E65-A541-13A39A41CAE4}';
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

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to PageControl1.PageCount-1 do
    begin
      if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
        PageControl1.ActivePageIndex:=i;
    end;
  Action_Defaults.Enabled:=True;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу OVERSEERSERVER' then
    Action_Defaults.Enabled:=vleOVERSEERSERVER.Enabled;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу DBSERVER' then
    Action_Defaults.Enabled:=vleDBSERVER.Enabled;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу STATSERVER' then
    Action_Defaults.Enabled:=vleSTATSERVER.Enabled;
  if PageControl1.ActivePage.Caption=' подключения к MySQL-серверу RNE4SERVER' then
    Action_Defaults.Enabled:=vleRNE4SERVER.Enabled;
end;

procedure TConfigurationForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
begin
  with MainForm do
    begin
      edbxFlushLogOnStringsQuantity.Enabled:=chkbxFlushLogOnStringsQuantity.Checked;
      if edbxFlushLogOnStringsQuantity.Enabled then
        begin
          if Configuration.iFlushLogOnStringsQuantity>0 then
            edbxFlushLogOnStringsQuantity.Text:=IntToStr(Configuration.iFlushLogOnStringsQuantity)
          else
            edbxFlushLogOnStringsQuantity.Text:='10000';
        end
      else
        edbxFlushLogOnStringsQuantity.Text:='';
    end;
end;

procedure TConfigurationForm.edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TConfigurationForm.rbSaveIntoTheSelectedFolderClick(Sender: TObject);
begin
  edbxSelectedFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;
  Action_ChooseReportFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;
end;

procedure TConfigurationForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
  LogGroupGUID: string='{F16ADCF4-CDA8-4D4F-AE63-B1922F952BFC}';
begin
  slActions.Free;
  slBoolean.Free;
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
  slActions:=TStringList.Create;
  with slActions do
    begin
      Add('');
      AddStrings(MainForm.cbActionsList.Items);
    end;
  // интерфейс
  vleInterface.ItemProps[0].EditStyle:=esPickList;
  vleInterface.ItemProps[0].readonly:=True;
  vleInterface.ItemProps[0].PickList:=slBoolean;
  vleInterface.ItemProps[1].EditStyle:=esPickList;
  vleInterface.ItemProps[1].readonly:=True;
  vleInterface.ItemProps[1].PickList:=slBoolean;
  vleInterface.ItemProps[2].EditStyle:=esPickList;
  vleInterface.ItemProps[2].readonly:=True;
  vleInterface.ItemProps[2].PickList:=slBoolean;
  vleInterface.ItemProps[3].EditStyle:=esPickList;
  vleInterface.ItemProps[3].readonly:=True;
  vleInterface.ItemProps[3].PickList:=slBoolean;
  vleInterface.ItemProps[4].EditStyle:=esPickList;
  vleInterface.ItemProps[4].readonly:=True;
  vleInterface.ItemProps[4].PickList:=slBoolean;
  vleInterface.ItemProps[5].EditStyle:=esPickList;
  vleInterface.ItemProps[5].readonly:=True;
  vleInterface.ItemProps[5].PickList:=slBoolean;
  vleInterface.ItemProps[6].EditStyle:=esPickList;
  vleInterface.ItemProps[6].readonly:=True;
  vleInterface.ItemProps[6].PickList:=slActions;
  vleInterface.ItemProps[7].EditStyle:=esPickList;
  vleInterface.ItemProps[7].readonly:=True;
  vleInterface.ItemProps[7].PickList:=slBoolean;
  vleInterface.ItemProps[8].EditStyle:=esPickList;
  vleInterface.ItemProps[8].readonly:=True;
  vleInterface.ItemProps[8].PickList:=slBoolean;
  vleInterface.ItemProps[9].EditStyle:=esPickList;
  vleInterface.ItemProps[9].readonly:=True;
  vleInterface.ItemProps[9].PickList:=slBoolean;
  vleInterface.ItemProps[10].EditStyle:=esPickList;
  vleInterface.ItemProps[10].readonly:=True;
  vleInterface.ItemProps[10].PickList:=slBoolean;
  vleInterface.ItemProps[11].EditStyle:=esPickList;
  vleInterface.ItemProps[11].readonly:=True;
  vleInterface.ItemProps[11].PickList:=slBoolean;
  // overseer
  vleOVERSEERSERVER.ItemProps[1].EditMask:='99999;0; '; // номер порта
  vleOVERSEERSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
  vleOVERSEERSERVER.ItemProps[2].EditMask:='99999;0; '; // таймаут
  vleOVERSEERSERVER.Cells[1, 3]:=IntToStr(30);
  vleOVERSEERSERVER.ItemProps[3].EditStyle:=esPickList; // сжатие данных
  vleOVERSEERSERVER.ItemProps[3].readonly:=True;
  vleOVERSEERSERVER.ItemProps[3].PickList:=slBoolean;
  vleOVERSEERSERVER.Cells[1, 4]:=vleOVERSEERSERVER.ItemProps[3].PickList.Strings[0];
  // overseer
  vleRNE4SERVER.ItemProps[1].EditMask:='99999;0; '; // номер порта
  vleRNE4SERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
  vleRNE4SERVER.ItemProps[2].EditMask:='99999;0; '; // таймаут
  vleRNE4SERVER.Cells[1, 3]:=IntToStr(30);
  vleRNE4SERVER.ItemProps[3].EditStyle:=esPickList; // сжатие данных
  vleRNE4SERVER.ItemProps[3].readonly:=True;
  vleRNE4SERVER.ItemProps[3].PickList:=slBoolean;
  vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[0];
  // dbserver
  vleDBSERVER.ItemProps[1].EditMask:='99999;0; '; // номер порта
  vleDBSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
  vleDBSERVER.ItemProps[2].EditMask:='99999;0; '; // таймаут
  vleDBSERVER.Cells[1, 3]:=IntToStr(30);
  vleDBSERVER.ItemProps[3].EditStyle:=esPickList; // сжатие данных
  vleDBSERVER.ItemProps[3].readonly:=True;
  vleDBSERVER.ItemProps[3].PickList:=slBoolean;
  vleDBSERVER.Cells[1, 4]:=vleDBSERVER.ItemProps[3].PickList.Strings[0];
  // statserver
  vleSTATSERVER.ItemProps[1].EditMask:='99999;0; '; // номер порта
  vleSTATSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
  vleSTATSERVER.ItemProps[2].EditMask:='99999;0; '; // таймаут
  vleSTATSERVER.Cells[1, 3]:=IntToStr(30);
  vleSTATSERVER.ItemProps[3].EditStyle:=esPickList; // сжатие данных
  vleSTATSERVER.ItemProps[3].readonly:=True;
  vleSTATSERVER.ItemProps[3].PickList:=slBoolean;
  vleSTATSERVER.Cells[1, 4]:=vleSTATSERVER.ItemProps[3].PickList.Strings[0];

  cbPage.ItemIndex:=MainForm.Configuration.iConfigurationFormPage;
  if cbPage.ItemIndex<0 then
    cbPage.ItemIndex:=0;
  cbPageSelect(Sender);
  rbSaveIntoTheSelectedFolderClick(Sender);

  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{6C56F7CB-053A-4590-B73C-8523D70ED7B0}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
  LogThis('Отображено окно изменения настроек программы.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TConfigurationForm.chkbxUseExternalLogClick(Sender: TObject);
begin
  chkbxKeepInfoLog.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxKeepWarningLog.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxKeepErrorLog.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxKeepSQLLog.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxKeepDebugLog.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxFlushLogOnExit.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxFlushLogOnStringsQuantity.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  edbxFlushLogOnStringsQuantity.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxFlushLogOnClearingLog.Enabled:=not(vleInterface.Cells[1, 5]='Да');
  chkbxFlushLogOnApply.Enabled:=not(vleInterface.Cells[1, 5]='Да');
end;

end.
