unit ES4FScan.Logic.Classes.TMainFormBusinessLogic;

interface

uses
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  Data.DB,
  cxDBData,
  cxContainer,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxLabel,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  Vcl.Forms,
  ES4FScan.Logic.Classes.TCustomBusinessLogic,
  ES4FScan.Logic.Interfaces.IMainFormBusinessLogic,
  ES4FScan.Logic.Classes.Configuration.TConfiguration,
  Data.Win.ADODB;

type
  TMainFormBusinessLogic = class(TCustomBusinessLogic<TConfiguration>, IMainFormBusinessLogic)
  strict private
    FGridTableViewFiles: TcxGridTableView;
    FGridTableViewResult: TcxGridTableView;

    procedure ResizeColumns(const aGridTableView: TcxGridTableView);

  strict private
    FConnection: TADOConnection;
    function GetConnection(): TADOConnection;

  strict protected
    property Connection: TADOConnection read GetConnection nodefault;

  strict protected
    function GetConfiguration(): TConfiguration; override;

  public
    constructor Create(const aOwner: TCustomForm; const aGridTableViewFiles, aGridTableViewResult: TcxGridTableView); reintroduce; virtual;

    function LoadList(): Boolean;
    function Process(): Boolean;
    procedure HelpContext();
    function CloseQuery(): Boolean;

    function CanExportExcel(): Boolean;
    procedure ExportExcel(const aGrid: TcxGrid);
    function CanProcess(): Boolean;

    procedure SetEnableStatusbar(const aValue: Boolean);
    procedure SetEnableToolbar(const aValue: Boolean);
    function GetEnableStatusbar(): Boolean;
    function GetEnableToolbar(): Boolean;
    function GetEnableSplashAtStart(): Boolean;
    function ShowConfigurationForm(): Boolean;
  end;

resourcestring
  RsWarningCaption = '%s - Предупреждение';
  RsErrorCaption = '%s - Ошибка';
  RsInfoCaption = '%s - Информация';

implementation

uses
  MSExcel,
  System.Win.ComObj,
  System.Win.ComServ,
  System.IOUtils,
  System.Zip,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Winapi.Windows,
  ShateM.Utils.Windows,
  Vcl.Dialogs,
  Winapi.ShellApi,
  cxGridExportLink,
  Vcl.Controls,
  RoutinesPackage.Logic,
  ES4FScan.Logic.Classes.Configuration.TInterfaceSection,
  ES4FScan.Logic.Classes.Configuration.TDatabaseConnectionSection,
  ES4FScan.Logic.Classes.Configuration.TGeneralSection,
  ES4FScan.Logic.Consts,
  ES4FScan.UI.Configuration;

const
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;

  wdFindStop = 0;
  wdFindContinue = 1;
  wdFindAsk = 2;

  wdStory = 6;
  wdMove = 0;
  wdExtend = 1;

resourcestring
  RsResultDefaultExt = 'xlsx';
  RsResultFilters = 'Документ Excel (*.xlsx)|*.xlsx|Все файлы (*.*)|*.*';
  RsResultTitle = 'Введите имя файла для сохранения результатов...';
  RsDocumentDefaultExt = 'docx';
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsHelpNotFound = 'Файл справки к программе [%s] не найден.';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';

function TMainFormBusinessLogic.CanProcess(): Boolean;
begin
  Result := FGridTableViewFiles.DataController.RecordCount > 0;
end;

function TMainFormBusinessLogic.CanExportExcel(): Boolean;
begin
  Result := FGridTableViewResult.DataController.RecordCount > 0;
end;

function TMainFormBusinessLogic.CloseQuery(): Boolean;
begin
  Result := True;

  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if Configuration.Section<TInterfaceSection>.EnableQuitConfirmation then
  begin
    Result := MessageBox(Owner.Handle, PWideChar(RsExitConfirmationMessage), PWideChar(Format(RsExitConfirmationCaption, [Owner.Caption])),
      MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDYES;
  end;
end;

constructor TMainFormBusinessLogic.Create(const aOwner: TCustomForm; const aGridTableViewFiles, aGridTableViewResult: TcxGridTableView);
begin
  Assert(Assigned(aGridTableViewFiles));

  inherited Create(aOwner);
  FGridTableViewFiles := aGridTableViewFiles;
  FGridTableViewResult := aGridTableViewResult;
end;

function TMainFormBusinessLogic.GetConfiguration(): TConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := TConfiguration.Create(IncludeTrailingPathDelimiter(TPath.GetHomePath()) + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini'));
  end;
  Result := FConfiguration;
end;

function TMainFormBusinessLogic.GetConnection(): TADOConnection;
var
  tmpADOConnection: TADOConnection;
begin
  try
    if not Assigned(FConnection) then
    begin
      tmpADOConnection := TADOConnection.Create(nil);
      if Assigned(tmpADOConnection) then
      begin
        tmpADOConnection.LoginPrompt := False;
        tmpADOConnection.ConnectionString :=
          Format('Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=True;Data Source=%s;Initial Catalog=%s;User ID=%s;',
          [GetConfiguration().Section<TDatabaseConnectionSection>.Host.Trim(), GetConfiguration().Section<TDatabaseConnectionSection>.Database.Trim(),
          TWindows.GetUserName().Trim()]);
        tmpADOConnection.ConnectionTimeout := GetConfiguration().Section<TDatabaseConnectionSection>.ConnectionTimeout;
        tmpADOConnection.CommandTimeout := GetConfiguration().Section<TDatabaseConnectionSection>.CommandTimeout;
        FConnection := tmpADOConnection;
      end;
    end;
    Result := FConnection;
  except
    on e: Exception do
    begin
      ShowMessage(e.ToString());
      raise;
    end;
  end;
end;

function TMainFormBusinessLogic.GetEnableSplashAtStart(): Boolean;
begin
  Result := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;

  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  Result := Configuration.Section<TInterfaceSection>.EnableSplashAtStart;
end;

function TMainFormBusinessLogic.GetEnableStatusbar(): Boolean;
begin
  Result := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;

  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  Result := Configuration.Section<TInterfaceSection>.EnableStatusbar;
end;

function TMainFormBusinessLogic.GetEnableToolbar(): Boolean;
begin
  Result := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;

  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  Result := Configuration.Section<TInterfaceSection>.EnableToolbar;
end;

procedure TMainFormBusinessLogic.HelpContext();
begin
  if not FileExists(Application.HelpFile) then
  begin
    MessageBox(Owner.Handle, PWideChar(Format(RsHelpNotFound, [Application.HelpFile])), PWideChar(Format(RsErrorCaption, [Owner.Caption])), MESSAGE_TYPE_ERROR);
    Exit;
  end;

  Application.HelpShowTableOfContents();
end;

function TMainFormBusinessLogic.LoadList(): Boolean;
var
  i: Integer;
  tmpDataController: TcxDataController;
  tmpQuery: TADOQuery;
begin
  Result := False;
  tmpDataController := FGridTableViewFiles.DataController;
  if not Assigned(tmpDataController) then
  begin
    Exit;
  end;

  tmpDataController.BeginFullUpdate();
  try
    tmpQuery := GetADOQuery(GetConnection());
    try
      SetADOQuery(tmpQuery, SP_ES4F_SCAN_FILES_SEL, [Configuration.Section<TGeneralSection>.StartDate, Configuration.Section<TGeneralSection>.StopDate]);
      try
        tmpDataController.RecordCount := tmpQuery.RecordCount;
        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          tmpDataController.Values[i, COLUMN_ID] := tmpQuery.FieldByName(FLD_ID).AsInteger;
          tmpDataController.Values[i, COLUMN_SERIES] := tmpQuery.FieldByName(FLD_SERIES).AsString;
          tmpDataController.Values[i, COLUMN_NUMBER] := tmpQuery.FieldByName(FLD_NUMBER).AsString;
          tmpDataController.Values[i, COLUMN_FILE_NAME] := tmpQuery.FieldByName(FLD_FILE_NAME).AsString;
          tmpDataController.Values[i, COLUMN_TYPE] := tmpQuery.FieldByName(FLD_TYPE).AsString;
          tmpDataController.Values[i, COLUMN_STATUS] := 0;
          tmpQuery.Next();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  finally
    tmpDataController.EndFullUpdate();
    ResizeColumns(FGridTableViewFiles);
  end;
  Result := True;
end;

procedure TMainFormBusinessLogic.ExportExcel(const aGrid: TcxGrid);
var
  tmpExecInfo: TShellExecuteInfo;
  tmpForm: TSaveDialog;
  old_cursor: TCursor;
begin
  tmpForm := TSaveDialog.Create(Owner);
  try
    tmpForm.DefaultExt := RsResultDefaultExt;
    tmpForm.Filter := RsResultFilters;
    tmpForm.Options := tmpForm.Options + [ofOverwritePrompt, ofPathMustExist, ofNoReadOnlyReturn];
    tmpForm.Title := RsResultTitle;
    tmpForm.FilterIndex := 1;

    if not tmpForm.Execute(Owner.Handle) then
    begin
      Exit;
    end;
    old_cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      ExportGridToXLSX(tmpForm.FileName, aGrid);
      if MessageBox(Owner.Handle, 'Открыть сохранённый файл?', 'Подтверждение', MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDYES then
      begin
        ZeroMemory(@tmpExecInfo, SizeOf(tmpExecInfo));
        tmpExecInfo.cbSize := SizeOf(TShellExecuteInfo);
        tmpExecInfo.lpVerb := 'open';
        tmpExecInfo.lpFile := PChar(tmpForm.FileName);
        tmpExecInfo.nShow := SW_SHOWNORMAL;
        ShellExecuteEx(@tmpExecInfo);
      end;
    finally
      Screen.Cursor := old_cursor;
    end;
  finally
    tmpForm.Free();
  end;
end;

procedure TMainFormBusinessLogic.ResizeColumns(const aGridTableView: TcxGridTableView);
var
  dt: TcxCustomDataController;
  old_cursor: TCursor;
  column_width: Integer;
  i: Integer;
  j: Integer;
  current_width: Integer;
  tmpColumn: TcxGridColumn;
begin
  old_cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    dt := aGridTableView.DataController;
    dt.BeginFullUpdate();
    try
      if dt.RecordCount = 0 then
      begin
        for i := 0 to Pred(aGridTableView.ColumnCount) do
        begin
          tmpColumn := aGridTableView.Columns[i];

          tmpColumn.Options.HorzSizing := True;
          tmpColumn.BestFitMaxWidth := 0;
          tmpColumn.Width := 0;
        end;
        aGridTableView.OptionsView.ColumnAutoWidth := True;
      end
      else
      begin
        aGridTableView.OptionsView.ColumnAutoWidth := False;

        for i := 0 to Pred(aGridTableView.ColumnCount) do
        begin
          tmpColumn := aGridTableView.Columns[i];

          column_width := Owner.Canvas.TextWidth(tmpColumn.Caption) + 16;
          for j := 0 to Pred(dt.RecordCount) do
          begin
            if VarIsNull(dt.Values[j, i]) then
            begin
              Continue;
            end;

            current_width := Owner.Canvas.TextWidth(dt.Values[j, i]) + 8;
            if column_width < current_width then
            begin
              column_width := current_width;
            end;
          end;

          tmpColumn.Options.HorzSizing := False;
          tmpColumn.BestFitMaxWidth := column_width;
          tmpColumn.Width := column_width;
          tmpColumn.Options.HorzSizing := True;
        end;
      end;
    finally
      dt.EndFullUpdate();
    end;
  finally
    Screen.Cursor := old_cursor;
  end;
end;

procedure TMainFormBusinessLogic.SetEnableStatusbar(const aValue: Boolean);
begin
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if Configuration.Section<TInterfaceSection>.EnableStatusbar <> aValue then
  begin
    Configuration.Section<TInterfaceSection>.EnableStatusbar := aValue;
  end;
end;

procedure TMainFormBusinessLogic.SetEnableToolbar(const aValue: Boolean);
begin
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if Configuration.Section<TInterfaceSection>.EnableToolbar <> aValue then
  begin
    Configuration.Section<TInterfaceSection>.EnableToolbar := aValue;
  end;
end;

function TMainFormBusinessLogic.ShowConfigurationForm(): Boolean;
var
  tmpForm: TForm;
begin
  tmpForm := TConfigurationForm.Create(Owner, Configuration, Configuration.CurrentPage);
  try
    Result := tmpForm.ShowModal = mrOk;
  finally
    tmpForm.Free();
  end;
end;

function TMainFormBusinessLogic.Process(): Boolean;
var
  old_cursor: TCursor;
  i: Integer;
  s: string;
  j: Integer;
  tmpDataController: TcxDataController;
  tmpResultDataController: TcxDataController;
  tmpId: Integer;
  tmpQuery: TADOQuery;
  tmpZipFile: TZipFile;
  tmpSummaryRowNumberFounded: Boolean;
  tmpSummaryRowNumber: Integer;
  tmpCell: Variant;

  tmpType: string;
  tmpSeries: string;
  tmpNumber: string;
  tmpUNP: string;
  tmpConsignorAddress: string;
  tmpConsigneeAddress: string;
  tmpLoadingPoint: string;
  tmpUnloadingPoint: string;
  tmpSum: string;
  tmpVAT: string;
  tmpSumWithVat: string;
  tmpDate: string;
  tmpStatus: Boolean;
  tmpTemporaryFileName: string;
  tmpBreak: Boolean;
begin
  Result := False;

  tmpBreak := False;

  tmpDataController := FGridTableViewFiles.DataController;
  if not Assigned(tmpDataController) then
  begin
    Exit;
  end;

  tmpResultDataController := FGridTableViewResult.DataController;
  if not Assigned(tmpResultDataController) then
  begin
    Exit;
  end;

  tmpQuery := GetADOQuery(GetConnection());
  try
    try
      CallExcel(False);
    except
      Sleep(1000);
      try
        CallExcel(False);
      except
        Exit;
      end;
    end;
    tmpDataController.BeginUpdate();
    try
      tmpResultDataController.RecordCount := 0;
      for i := 0 to Pred(tmpDataController.RecordCount) do
      begin
        if tmpBreak then
        begin
          Break;
        end;

        old_cursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        try
          try
            tmpStatus := tmpDataController.Values[i, COLUMN_STATUS];
            if tmpStatus then
            begin
              Continue;
            end;

            {$REGION 'Сохранение на диск'}
            tmpId := tmpDataController.Values[i, COLUMN_ID];
            tmpTemporaryFileName := ChangeFilePath(ChangeFileExt(TPath.GetGUIDFileName(), ExtractFileExt(tmpDataController.Values[i, COLUMN_FILE_NAME])),
              TPath.GetTempPath());

            SetADOQuery(tmpQuery, SP_ES4F_SCAN_FILEDATA_SEL, [tmpId]);
            try
              if not tmpQuery.Eof then
              begin
                (tmpQuery.FieldByName(FLD_DATA) as TBlobField).SaveToFile(tmpTemporaryFileName);
              end;
            finally
              tmpQuery.Close();
            end;
            {$ENDREGION}
            try
              tmpZipFile := TZipFile.Create();
              try
                tmpZipFile.Open(tmpTemporaryFileName, zmRead);
                s := ChangeFilePath(tmpZipFile.FileName[0], TPath.GetTempPath());
                tmpZipFile.Extract(0, TPath.GetTempPath(), False);
                tmpZipFile.Close();
              finally
                tmpZipFile.Free();
              end;
              System.SysUtils.DeleteFile(tmpTemporaryFileName);
              tmpTemporaryFileName := s;
            except
            end;

            try
              OpenWorkBook(tmpTemporaryFileName);
            except
              try
                s := ChangeFileExt(tmpTemporaryFileName, '.xlsm');
                System.SysUtils.RenameFile(tmpTemporaryFileName, s);
                tmpTemporaryFileName := s;
                OpenWorkBook(tmpTemporaryFileName);
              except
                try
                  s := ChangeFileExt(tmpTemporaryFileName, '.xlsx');
                  System.SysUtils.RenameFile(tmpTemporaryFileName, s);
                  tmpTemporaryFileName := s;
                  OpenWorkBook(tmpTemporaryFileName);
                except
                  try
                    s := ChangeFileExt(tmpTemporaryFileName, '.xls');
                    System.SysUtils.RenameFile(tmpTemporaryFileName, s);
                    tmpTemporaryFileName := s;
                    OpenWorkBook(tmpTemporaryFileName);
                  except
                    Sleep(1000);
                    System.SysUtils.DeleteFile(tmpTemporaryFileName);
                    Continue;
                  end;
                end;
              end;
            end;
            try
              {$REGION 'Активация книги'}
              try
                ActivateWorkBook(tmpTemporaryFileName);
              except
                Sleep(1000);
                try
                  ActivateWorkBook(tmpTemporaryFileName);
                except
                  Continue;
                end;
              end;
              {$ENDREGION}
              tmpType := tmpDataController.Values[i, COLUMN_TYPE];
              tmpSeries := tmpDataController.Values[i, COLUMN_SERIES];
              tmpNumber := tmpDataController.Values[i, COLUMN_NUMBER];

              if not((tmpType = 'ТТН') or (tmpType = 'ТН')) then
              begin
                Continue;
              end;

              if tmpType = 'ТТН' then
              begin
                tmpUNP := MSExcel.ReadCellValue('стр1', 2, 90);
                tmpConsignorAddress := MSExcel.ReadCellValue('стр1', 18, 25);
                tmpConsigneeAddress := MSExcel.ReadCellValue('стр1', 20, 22);
                tmpLoadingPoint := MSExcel.ReadCellValue('стр1', 24, 20);
                tmpUnloadingPoint := MSExcel.ReadCellValue('стр1', 24, 111);
                tmpDate := MSExcel.ReadCellValue('стр1', 13, 1);

                tmpSummaryRowNumberFounded := False;
                for tmpSummaryRowNumber := 0 to 1000 do
                begin
                  tmpCell := MSExcel.ReadCellValue('стр1', tmpSummaryRowNumber, 4);
                  case VarType(tmpCell) of
                    varString, varUString, varOleStr:
                      begin
                        s := tmpCell;
                        if s = 'Итого' then
                        begin
                          tmpSummaryRowNumberFounded := True;
                          Break;
                        end;
                      end;
                  else
                    Continue;
                  end;
                end;

                if not tmpSummaryRowNumberFounded then
                begin
                  Continue;
                end;

                tmpSum := MSExcel.ReadCellValue('стр1', tmpSummaryRowNumber, 75);
                tmpVAT := MSExcel.ReadCellValue('стр1', tmpSummaryRowNumber, 105);
                tmpSumWithVat := MSExcel.ReadCellValue('стр1', tmpSummaryRowNumber, 116);
              end
              else
              begin
                tmpUNP := MSExcel.ReadCellValue('Лист1', 1, 6);
                tmpConsignorAddress := MSExcel.ReadCellValue('Лист1', 21, 2);
                tmpConsigneeAddress := MSExcel.ReadCellValue('Лист1', 24, 2);
                tmpLoadingPoint := '-';
                tmpUnloadingPoint := '-';
                tmpDate := MSExcel.ReadCellValue('Лист1', 18, 2);

                tmpSummaryRowNumberFounded := False;
                for tmpSummaryRowNumber := 0 to 1000 do
                begin
                  tmpCell := MSExcel.ReadCellValue('Лист1', tmpSummaryRowNumber, 2);
                  case VarType(tmpCell) of
                    varString, varUString, varOleStr:
                      begin
                        s := tmpCell;
                        if s = 'Итого:' then
                        begin
                          tmpSummaryRowNumberFounded := True;
                          Break;
                        end;
                      end;
                  else
                    Continue;
                  end;
                end;

                if not tmpSummaryRowNumberFounded then
                begin
                  Continue;
                end;

                tmpSum := MSExcel.ReadCellValue('Лист1', tmpSummaryRowNumber, 6);
                tmpVAT := MSExcel.ReadCellValue('Лист1', tmpSummaryRowNumber, 8);
                tmpSumWithVat := MSExcel.ReadCellValue('Лист1', tmpSummaryRowNumber, 9);
              end;

              SetADOQuery(tmpQuery, SP_ES4F_SCAN_STATUS_UPD, [tmpId, 1], False);
              if tmpQuery.RowsAffected < 1 then
              begin
                Continue;
              end;

              tmpResultDataController.BeginUpdate();
              try
                j := tmpResultDataController.AppendRecord();
                tmpResultDataController.Values[j, COLUMN_TYPE2] := tmpType;
                tmpResultDataController.Values[j, COLUMN_SERIES2] := tmpSeries;
                tmpResultDataController.Values[j, COLUMN_NUMBER2] := tmpNumber;
                tmpResultDataController.Values[j, COLUMN_UNP] := tmpUNP;
                tmpResultDataController.Values[j, COLUMN_CONSIGNOR_ADDRESS] := tmpConsignorAddress;
                tmpResultDataController.Values[j, COLUMN_CONSIGNEE_ADDRESS] := tmpConsigneeAddress;
                tmpResultDataController.Values[j, COLUMN_LOADING_POINT] := tmpLoadingPoint;
                tmpResultDataController.Values[j, COLUMN_UNLOADING_POINT] := tmpUnloadingPoint;
                if tmpSummaryRowNumberFounded then
                begin
                  tmpResultDataController.Values[j, COLUMN_SUM] := tmpSum;
                  tmpResultDataController.Values[j, COLUMN_VAT] := tmpVAT;
                  tmpResultDataController.Values[j, COLUMN_SUM_WITH_VAT] := tmpSumWithVat;
                end;
                tmpResultDataController.Values[j, COLUMN_DATE] := tmpDate;
                tmpDataController.Values[i, COLUMN_STATUS] := 1;
              finally
                tmpResultDataController.EndUpdate();
              end;
            finally
              CloseWorkBook(tmpTemporaryFileName);
              try
                System.SysUtils.DeleteFile(tmpTemporaryFileName);
              except
                Sleep(1000);
                try
                  System.SysUtils.DeleteFile(tmpTemporaryFileName);
                except
                end;
              end;
            end;
          except
          end;
        finally
          Screen.Cursor := old_cursor;
        end;
      end;
    finally
      tmpDataController.EndUpdate();
    end;
    ResizeColumns(FGridTableViewFiles);
    ResizeColumns(FGridTableViewResult);
  finally
    tmpQuery.Free();
  end;
  Result := True;
end;

end.
