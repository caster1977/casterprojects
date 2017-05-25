unit Budgeting.Logic.Classes.Presenters.TMainPresenter;

interface

uses
  System.SysUtils,
  // FireDAC.Comp.Client,
  Vcl.Controls,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter,
  Budgeting.Logic.Interfaces.Views.IMainView,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Classes.Presenters.TCustomPresenter,
  System.Generics.Collections,
  Budgeting.Logic.Types.TEntity;

type
  TMainPresenter = class(TCustomPresenter, ICustomPresenter)
  strict private
    FCurrentEntity: TEntity;
    FGridId: TDictionary<TEntity, Integer>;
    procedure AboutExecute(const aOwner: TWinControl; const aSplash: Boolean = False);

  strict protected
    procedure OnEventSimple(aValue: TViewEnumEvent); override;
    procedure Initialize(); override;

  public
    destructor Destroy(); override;
  end;

implementation

uses
  System.Math,
  System.StrUtils,
  Vcl.Forms,
  Winapi.Windows,
  Data.DB,
  cxGrid,
  Vcl.Dialogs,
  Winapi.ShellApi,
  cxGridExportLink,
  Budgeting.Logic.Types.TViewEnumAction,
  AboutPackage.Logic.TAboutWindow,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  Budgeting.Logic.Classes.Configuration.Sections.TInterfaceSection,
  // Budgeting.Logic.Classes.Configuration.Sections.TDatabaseSection,
  LoginPackage.Logic.TLoginWindow,
  Budgeting.Logic.Consts,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.UI.Configuration,
  FireDAC.Comp.Client;
// Budgeting.Logic.Classes.TPresenterDetail,
// Budgeting.Logic.Classes.TQuery,
// Budgeting.UI.Detail;

resourcestring
  RsResultDefaultExt = 'xlsx';
  RsResultFilters = 'Документ Excel (*.xlsx)|*.xlsx|Все файлы (*.*)|*.*';
  RsResultTitle = 'Введите имя файла для сохранения результатов...';
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';
  RsHelpNotFound = 'Файл справки к программе [%s] не найден.';

destructor TMainPresenter.Destroy;
begin
  try
    FreeAndNil(FGridId);
  finally
    inherited;
  end;
end;

procedure TMainPresenter.Initialize();
var
  tmpView: IMainView;
begin
  inherited;
  FCurrentEntity := etUnknown;
  FGridId := TDictionary<TEntity, Integer>.Create();
  if Supports(FView, IMainView, tmpView) then
  begin
    if TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableSplashAtStart then
    begin
      AboutExecute(tmpView.Control, True);
    end;

    tmpView.Initialize();
  end;
end;

procedure TMainPresenter.AboutExecute(const aOwner: TWinControl; const aSplash: Boolean = False);
var
  tmpAbout: TAboutWindow;
begin
  tmpAbout := TAboutWindow.Create(aOwner);
  try
    tmpAbout.EMail := 'caster1977@yandex.ru';
    tmpAbout.Show(aSplash);
  finally
    tmpAbout.Free();
  end;
end;

procedure TMainPresenter.OnEventSimple(aValue: TViewEnumEvent);
var
  tmpView: IMainView;

  procedure LoadAccountingCenters();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_accounting_centers_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.AccountingCenters := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadBanks();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_banks_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Banks := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadBudgetItems();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_budget_items_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.BudgetItems := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadBudgetItemTypes();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_budget_item_types_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.BudgetItemTypes := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadCosignatories();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_cosignatories_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Cosignatories := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadCurrencies();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_currencies_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Currencies := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadProducts();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_products_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Products := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadProductTypes();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_product_types_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.ProductTypes := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadActualBudget();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_actual_budget_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_actual_budget_sel.Param.Id).DataType := ftInteger;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.ActualBudget := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadPlannedBudget();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_planned_budget_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_planned_budget_sel.Param.Id).DataType := ftInteger;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.PlannedBudget := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure RefreshExecute();
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.ShowProgress('Обновление списка...');
      try
        case tmpView.CurrentEntity of
          etAccountingCenters:
            LoadAccountingCenters();
          etBanks:
            LoadBanks();
          etBudgetItems:
            LoadBudgetItems();
          etBudgetItemTypes:
            LoadBudgetItemTypes();
          etCosignatories:
            LoadCosignatories();
          etCurrencies:
            LoadCurrencies();
          etProducts:
            LoadProducts();
          etProductTypes:
            LoadProductTypes();
          etActualBudget:
            LoadActualBudget();
          etPlannedBudget:
            LoadPlannedBudget();
        end;
      finally
        FProcessign := False;
      end;
    finally
      tmpView.HideProgress();
    end;
  end;

  procedure RefreshUpdate();
  begin
    tmpView.ActionStates[vaRefresh] := not FProcessign;
  end;

  procedure SelectedRecordChanged();
  begin
    if FCurrentEntity <> etUnknown then
    begin
      FGridId.AddOrSetValue(FCurrentEntity, tmpView.GetCurrentId(FCurrentEntity));
    end;
  end;

  procedure EntityChanged();
  begin
    FCurrentEntity := tmpView.CurrentEntity;
  end;

  procedure QuitUpdate();
  begin
    tmpView.ActionStates[vaCloseQuery] := not FProcessign;
  end;

  procedure CloseQuery();
  begin
    if TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableQuitConfirmation then
    begin
      tmpView.ActionStates[vaCloseQuery] := MessageBox(tmpView.Control.Handle, PWideChar(RsExitConfirmationMessage),
        PWideChar(Format(RsExitConfirmationCaption, [Application.MainForm.Caption])), MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDYES;
    end;
  end;

  procedure ConfigurationExecute();
  var
    tmpForm: TForm;
    b: Boolean;
  begin
    tmpForm := TConfigurationForm.Create(tmpView.Control, (TConfiguration.Get(TConfiguration) as TConfiguration).CurrentPage);
    try
      b := tmpForm.ShowModal = mrOk ;
    finally
      tmpForm.Free();
    end;
    if b then
    begin
      //ApplyConfiguration();
      { TODO : дописать }
    end;
  end;

  procedure ConfigurationUpdate();
  begin
    tmpView.ActionStates[vaConfiguration] := not FProcessign;
  end;

  procedure ExportExcel(const aGrid: TcxGrid);
  var
    tmpExecInfo: TShellExecuteInfo;
    tmpForm: TSaveDialog;
    old_cursor: TCursor;
  begin
    tmpForm := TSaveDialog.Create(FView.Control);
    try
      tmpForm.DefaultExt := RsResultDefaultExt;
      tmpForm.Filter := RsResultFilters;
      tmpForm.Options := tmpForm.Options + [ofOverwritePrompt, ofPathMustExist, ofNoReadOnlyReturn];
      tmpForm.Title := RsResultTitle;
      tmpForm.FilterIndex := 1;

      if not tmpForm.Execute(FView.Control.Handle) then
      begin
        Exit;
      end;
      old_cursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        ExportGridToXLSX(tmpForm.FileName, aGrid);
        if FView.ShowMessage('Открыть сохранённый файл?', MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDYES then
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

  procedure ExportToExcelExecute();
  begin
    ExportExcel(tmpView.GetActiveGrid());
  end;

  procedure ExportToExcelUpdate();
  begin
    tmpView.ActionStates[vaExportToExcel] := not FProcessign;
    { TODO : дописать }
    // and (FCurrentDocumentId > -1);;
    // Result := FGridTableViewResult.DataController.RecordCount > 0;
  end;

{ procedure HistoryExecute();
  var
  tmpForm: TfrmDetail;
  tmpPresenter: IPresenter;
  begin
  FProcessign := True;
  tmpView.RefreshStates();
  try
  tmpView.ShowProgress('Просмотр истории...');
  try
  tmpForm := TfrmDetail.Create(nil);
  try
  tmpPresenter := TPresenterDetail.Create(tmpForm, FFDConnection, tmpView.CurrentDocumentId);
  if not Assigned(tmpPresenter) then
  begin
  Exit;
  end;
  tmpForm.ShowModal();
  finally
  tmpForm.Free();
  end;
  finally
  FProcessign := False;
  end;
  finally
  tmpView.HideProgress();
  end;
  end; }

  procedure HelpContextExecute();
  begin
    if not FileExists(Application.HelpFile) then
    begin
      tmpView.ShowMessage(Format(RsHelpNotFound, [Application.HelpFile]), MESSAGE_TYPE_ERROR);
      Exit;
    end;

    Application.HelpShowTableOfContents();
  end;

  procedure HelpContextUpdate();
  begin
    tmpView.ActionStates[vaHelpContext] := not FProcessign;
  end;

  procedure AboutUpdate();
  begin
    tmpView.ActionStates[vaAbout] := not FProcessign;
  end;

  procedure StatusBarExecute();
  var
    b: Boolean;
  begin
    b := not TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStatusbar;
    TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStatusbar := b;
    tmpView.EnableStatusbar := b;
  end;

  procedure ToolBarExecute();
  var
    b: Boolean;
  begin
    b := not TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableToolbar;
    TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableToolbar := b;
    tmpView.EnableToolbar := b;
  end;

  procedure ConnectExecute();
  var
    tmpLoginWindow: TLoginWindow;
  begin
    tmpLoginWindow := TLoginWindow.Create(tmpView.Control);
    try
      tmpLoginWindow.Login := TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.Login;
      tmpLoginWindow.Password := TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.Password;
      if not TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableAutoLogon then
      begin
        if tmpLoginWindow.Execute() then
        begin
          TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.Login := IfThen(TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStoreLogin,
            tmpLoginWindow.Login);
          TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.Password := IfThen(TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStorePassword,
            tmpLoginWindow.Password);
        end;
      end
      else
      begin
        Exit;
      end;
    finally
      tmpLoginWindow.Free();
    end;
  end;

  procedure ConnectUpdate();
  begin
    tmpView.ActionStates[vaConnect] := not FProcessign; // и не соединено
    { TODO : дописать }
  end;

  procedure AddExecute();
  begin
  end;

  procedure AddUpdate();
  begin
    tmpView.ActionStates[vaAdd] := not FProcessign;
  end;

  procedure EditExecute();
  begin
  end;

  procedure EditUpdate();
  var
    i: Integer;
  begin
    if not FGridId.TryGetValue(FCurrentEntity, i) then
    begin
      i := -1;
    end;

    tmpView.ActionStates[vaEdit] := (not FProcessign) and (i > -1);
  end;

  procedure DeleteExecute();
  var
    tmpQuery: TFDQuery;
    i: Integer;
    tmpSPName: string;
    tmpCurrentId: Integer;
  begin
    case FCurrentEntity of
      etAccountingCenters:
        tmpSPName := 'accounting_centers_del';
      etBanks:
        tmpSPName := 'banks_del';
      etBudgetItems:
        tmpSPName := 'budget_items_del';
      etBudgetItemTypes:
        tmpSPName := 'budget_item_types_del';
      etCosignatories:
        tmpSPName := 'cosignatories_del';
      etCurrencies:
        tmpSPName := 'currencies_del';
      etProducts:
        tmpSPName := 'products_del';
      etProductTypes:
        tmpSPName := 'product_types_del';
      etActualBudget:
        tmpSPName := 'actual_budget_del';
      etPlannedBudget:
        tmpSPName := 'planned_budget_del';
    else
      Exit;
    end;

    if not FGridId.TryGetValue(FCurrentEntity, tmpCurrentId) then
    begin
      Exit;
    end;

    if tmpCurrentId < 0 then
    begin
      Exit;
    end;

    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.ShowProgress('Удаление элемента...', 1);
      try
        tmpQuery := TFDQuery.Create(nil);
        try
          tmpQuery.Connection := FConnection;
          tmpQuery.SQL.Text := Format(TQuery.sp_xxx_del.Name, [tmpSPName]);
          tmpQuery.ParamByName(TQuery.sp_xxx_del.Param.Id).DataType := ftInteger;
          tmpQuery.ParamByName(TQuery.sp_xxx_del.Param.Id).AsInteger := tmpCurrentId;
          tmpQuery.Open();
          try
            tmpView.ShowProgress('Удаление элемента...', 1);

            if tmpQuery.IsEmpty() then
            begin
              Exit;
            end;

            tmpQuery.First();

            i := tmpQuery.FieldByName(TQuery.sp_xxx_del.Field.Result).AsInteger;

            tmpView.StepProgress();

            if i < 0 then
            begin
              tmpView.ShowMessage(tmpQuery.FieldByName(TQuery.sp_xxx_del.Field.Message).AsString, MESSAGE_TYPE_ERROR);
            end;
          finally
            tmpQuery.Close();
          end;
        finally
          tmpQuery.Free();
        end;
      finally
        FProcessign := False;
      end;
    finally
      tmpView.HideProgress();
    end;
  end;

  procedure DeleteUpdate();
  var
    i: Integer;
  begin
    if not FGridId.TryGetValue(FCurrentEntity, i) then
    begin
      i := -1;
    end;

    tmpView.ActionStates[vaDelete] := (not FProcessign) and (i > -1);
  end;

  procedure DisconnectExecute();
  begin
  end;

  procedure DisconnectUpdate();
  begin
    tmpView.ActionStates[vaDisconnect] := not FProcessign;
  end;

begin
  if not Supports(FView, IMainView, tmpView) then
  begin
    Exit;
  end;

  case aValue of
    veInitialization:
      LoadBudgetItemTypes();
    veCloseQuery:
      CloseQuery();
    veQuitUpdate:
      QuitUpdate();
    veConfigurationExecute:
      ConfigurationExecute();
    veConfigurationUpdate:
      ConfigurationUpdate();
    veRefreshExecute:
      RefreshExecute();
    veRefreshUpdate:
      RefreshUpdate();
    veExportToExcelExecute:
      ExportToExcelExecute();
    veExportToExcelUpdate:
      ExportToExcelUpdate();
    veHelpContextExecute:
      HelpContextExecute();
    veHelpContextUpdate:
      HelpContextUpdate();
    veEntityChanged:
      EntityChanged();
    veSelectedRecordChanged:
      SelectedRecordChanged();
    veAboutExecute:
      AboutExecute(tmpView.Control);
    veAboutUpdate:
      AboutUpdate();
    veStatusBarExecute:
      StatusBarExecute();
    veToolBarExecute:
      ToolBarExecute();
    veConnectExecute:
      ConnectExecute();
    veConnectUpdate:
      ConnectUpdate();
    veDisconnectExecute:
      DisconnectExecute();
    veDisconnectUpdate:
      DisconnectUpdate();
    veAddExecute:
      AddExecute();
    veAddUpdate:
      AddUpdate();
    veEditExecute:
      EditExecute();
    veEditUpdate:
      EditUpdate();
    veDeleteExecute:
      begin
        DeleteExecute();
        RefreshExecute();
      end;
    veDeleteUpdate:
      DeleteUpdate();
  end;
end;

{
  var
  b: Boolean;
  i: Integer;
  tmpStartTime: TDateTime;
  tmpStopTime: TDateTime;
  dt: TDateTime;
  d, h, n, s, ms: word;
  sh: word;

  try
  FProcessing := True;
  for i := 0 to Pred(actlstMain.ActionCount) do
  begin
  actlstMain.Actions[i].Update();
  Application.ProcessMessages();
  StatusBar.SimplePanelStyle.Text := 'Пожалуйста, подождите...';
  end;

  tmpStartTime := Now();

  try
  b := FLogic.Process();
  finally
  FProcessing := False;
  end;
  if b then
  begin
  tmpStopTime := Now();
  StatusBar.SimplePanelStyle.Text := EmptyStr;

  dt := tmpStopTime - tmpStartTime;
  d := DaysBetween(dt, 0);
  DecodeTime(dt, h, n, s, ms);
  sh := d * 24 + h;
  MessageBox(Handle, PWideChar(Format('Действие выполнено успешно. Затраченное время: %s',
  [Format('%d:%2d:%2d', [sh, n, s]).Replace(' ', '0', [rfReplaceAll])])), PWideChar(Format(RsInfoCaption, [Caption])), MESSAGE_TYPE_OK);
  end;
  except
  on e: Exception do
  begin
  MessageBox(Handle, PWideChar(e.ToString()), PWideChar(Format(RsErrorCaption, [Caption])), MESSAGE_TYPE_ERROR);
  end;
  end; }

// procedure TMainForm.actLoadListExecute(Sender: TObject);
// var
// b: Boolean;
// i: Integer;
// tmpStartTime: TDateTime;
// tmpStopTime: TDateTime;
// dt: TDateTime;
// d, h, n, s, ms: word;
// sh: word;
// begin
{ if not Assigned(FLogic) then
  begin
  Exit();
  end;

  try
  FProcessing := True;
  for i := 0 to Pred(actlstMain.ActionCount) do
  begin
  actlstMain.Actions[i].Update();
  Application.ProcessMessages();
  StatusBar.SimplePanelStyle.Text := 'Пожалуйста, подождите...';
  end;

  tmpStartTime := Now();

  try
  b := FLogic.LoadList();
  finally
  FProcessing := False;
  end;
  if b then
  begin
  tmpStopTime := Now();
  StatusBar.SimplePanelStyle.Text := EmptyStr;

  dt := tmpStopTime - tmpStartTime;
  d := DaysBetween(dt, 0);
  DecodeTime(dt, h, n, s, ms);
  sh := d * 24 + h;
  MessageBox(Handle, PWideChar(Format('Действие выполнено успешно. Затраченное время: %s',
  [Format('%d:%2d:%2d', [sh, n, s]).Replace(' ', '0', [rfReplaceAll])])), PWideChar(Format(RsInfoCaption, [Caption])), MESSAGE_TYPE_OK);
  end;
  except
  on e: Exception do
  begin
  MessageBox(Handle, PWideChar(e.ToString()), PWideChar(Format(RsErrorCaption, [Caption])), MESSAGE_TYPE_ERROR);
  end;
  end; }

end.
