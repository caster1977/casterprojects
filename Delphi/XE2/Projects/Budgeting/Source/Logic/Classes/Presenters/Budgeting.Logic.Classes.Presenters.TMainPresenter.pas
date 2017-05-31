unit Budgeting.Logic.Classes.Presenters.TMainPresenter;

interface

uses
  System.SysUtils,
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
    FCurrentBudgetItemType: Integer;
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
  Budgeting.UI.CustomEdit,
  LoginPackage.Logic.TLoginWindow,
  Budgeting.Logic.Consts,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.UI.Configuration,
  Budgeting.Logic.Classes.TfrmCustomEditClass,
  Budgeting.Logic.Classes.TCustomEditPresenterClass,
  Budgeting.Logic.Interfaces.Views.ICustomView,
  Budgeting.Logic.Interfaces.Views.ICustomEditView,

  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Classes.Models.TAccountingCenterModel,
  Budgeting.Logic.Classes.Models.TActualBudgetModel,
  Budgeting.Logic.Classes.Models.TBankModel,
  Budgeting.Logic.Classes.Models.TBudgetItemModel,
  Budgeting.Logic.Classes.Models.TBudgetItemTypeModel,
  Budgeting.Logic.Classes.Models.TCosignatoryModel,
  Budgeting.Logic.Classes.Models.TCurrencyModel,
  Budgeting.Logic.Classes.Models.TPlannedBudgetModel,
  Budgeting.Logic.Classes.Models.TProductModel,
  Budgeting.Logic.Classes.Models.TProductTypeModel,

  Budgeting.Logic.Classes.Presenters.TAccountingCenterPresenter,
  Budgeting.Logic.Classes.Presenters.TActualBudgetPresenter,
  Budgeting.Logic.Classes.Presenters.TBankPresenter,
  Budgeting.Logic.Classes.Presenters.TBudgetItemPresenter,
  Budgeting.Logic.Classes.Presenters.TBudgetItemTypePresenter,
  Budgeting.Logic.Classes.Presenters.TCosignatoryPresenter,
  Budgeting.Logic.Classes.Presenters.TCurrencyPresenter,
  Budgeting.Logic.Classes.Presenters.TPlannedBudgetPresenter,
  Budgeting.Logic.Classes.Presenters.TProductPresenter,
  Budgeting.Logic.Classes.Presenters.TProductTypePresenter,

  Budgeting.UI.AccountingCenter,
  Budgeting.UI.ActualBudget,
  Budgeting.UI.Bank,
  Budgeting.UI.BudgetItem,
  Budgeting.UI.BudgetItemType,
  Budgeting.UI.Cosignatory,
  Budgeting.UI.Currency,
//  Budgeting.UI.PlannedBudget,
  Budgeting.UI.Product,
  Budgeting.UI.ProductType,

  FireDAC.Comp.Client;

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
  FCurrentBudgetItemType := -1;
  FGridId := TDictionary<TEntity, Integer>.Create();
  if Supports(FView, IMainView, tmpView) then
  begin
    if TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableSplashAtStart then
    begin
      AboutExecute(tmpView.Control, True);
    end;
  end;
  FView.Initialize();
end;

procedure TMainPresenter.AboutExecute(const aOwner: TWinControl; const aSplash: Boolean = False);
var
  tmpAbout: TAboutWindow;
begin
  tmpAbout := TAboutWindow.Create(aOwner);
  try
    tmpAbout.EMail := 'alenapranevich@gmail.com';
    tmpAbout.Show(aSplash);
  finally
    tmpAbout.Free();
  end;
end;

procedure TMainPresenter.OnEventSimple(aValue: TViewEnumEvent);
var
  tmpView: IMainView;
  tmpCurrentId: Integer;

  function LoadAccountingCenters(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_accounting_centers_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.AccountingCenters := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TAccountingCenterModel.Create(
            tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Code).AsString,
            tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Name).AsString,
            tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Description).AsString,
            tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Activity).AsBoolean
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadBanks(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    Result := nil;

    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_banks_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.Banks := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TBankModel.Create(tmpQuery.FieldByName(TQuery.sp_banks_sel.Field.Id).AsInteger, tmpQuery.FieldByName(TQuery.sp_banks_sel.Field.Name)
            .AsString, tmpQuery.FieldByName(TQuery.sp_banks_sel.Field.Code).AsString, tmpQuery.FieldByName(TQuery.sp_banks_sel.Field.Address).AsString,
            tmpQuery.FieldByName(TQuery.sp_banks_sel.Field.Activity).AsBoolean);

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadBudgetItems(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_budget_items_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.BudgetItems := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TBudgetItemModel.Create(
            tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Id_BudgetItemType).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Code).AsString,
            tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Description).AsString,
            tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Activity).AsBoolean
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadBudgetItemTypes(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_budget_item_types_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.BudgetItemTypes := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TBudgetItemTypeModel.Create(
            tmpQuery.FieldByName(TQuery.sp_budget_item_types_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_budget_item_types_sel.Field.Name).AsString,
            tmpQuery.FieldByName(TQuery.sp_budget_item_types_sel.Field.Activity).AsBoolean
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadCosignatories(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_cosignatories_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.Cosignatories := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TCosignatoryModel.Create(
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Id_Bank).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Name).AsString,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.UNP).AsString,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Address).AsString,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.AgreementNumber).AsString,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.AgreementStart).AsDateTime,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.AgreementStop).AsDateTime,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Account).AsString,
            tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Activity).AsBoolean
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadCurrencies(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_currencies_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.Currencies := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TCurrencyModel.Create(
            tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Code).AsString,
            tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Description).AsString,
            tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Activity).AsBoolean
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadProducts(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_products_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.Products := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TProductModel.Create(
            tmpQuery.FieldByName(TQuery.sp_products_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_products_sel.Field.Id_ProductType).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_products_sel.Field.Code).AsString,
            tmpQuery.FieldByName(TQuery.sp_products_sel.Field.Description).AsString,
            tmpQuery.FieldByName(TQuery.sp_products_sel.Field.Activity).AsBoolean
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadProductTypes(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_product_types_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.ProductTypes := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TProductTypeModel.Create(
            tmpQuery.FieldByName(TQuery.sp_product_types_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_product_types_sel.Field.Name).AsString,
            tmpQuery.FieldByName(TQuery.sp_product_types_sel.Field.Activity).AsBoolean
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadActualBudget(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_actual_budget_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_actual_budget_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_actual_budget_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_actual_budget_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.ParamByName(TQuery.sp_actual_budget_sel.Param.Id_BudgetItemType).DataType := ftInteger;
      if FCurrentBudgetItemType > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_actual_budget_sel.Param.Id_BudgetItemType).AsInteger := FCurrentBudgetItemType;
      end;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.ActualBudget := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TActualBudgetModel.Create(
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_BudgetItem).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_AccountingCenter).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_Cosignatory).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_Product).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_Currency).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Document).AsString,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.DocumentDate).AsDateTime,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Description).AsString,
            tmpQuery.FieldByName(TQuery.sp_actual_budget_sel.Field.Amount).AsCurrency
            );

          FView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  function LoadPlannedBudget(const aId: Integer = -1): ICustomModel;
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_planned_budget_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_planned_budget_sel.Param.Id).DataType := ftInteger;
      if aId > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_planned_budget_sel.Param.Id).AsInteger := aId;
      end;
      tmpQuery.ParamByName(TQuery.sp_planned_budget_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.ParamByName(TQuery.sp_planned_budget_sel.Param.Id_BudgetItemType).DataType := ftInteger;
      if FCurrentBudgetItemType > -1 then
      begin
        tmpQuery.ParamByName(TQuery.sp_planned_budget_sel.Param.Id_BudgetItemType).AsInteger := FCurrentBudgetItemType;
      end;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
        if aId = -1 then
        begin
          tmpView.PlannedBudget := tmpQuery;
        end
        else
        begin
          if tmpQuery.IsEmpty() then
          begin
            Exit;
          end;

          tmpQuery.First();

          Result := TPlannedBudgetModel.Create(
            tmpQuery.FieldByName(TQuery.sp_planned_budget_sel.Field.Id).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_planned_budget_sel.Field.Id_BudgetItem).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_planned_budget_sel.Field.Id_AccountingCenter).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_planned_budget_sel.Field.Id_Currency).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_planned_budget_sel.Field.Year).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_planned_budget_sel.Field.Month).AsInteger,
            tmpQuery.FieldByName(TQuery.sp_planned_budget_sel.Field.Amount).AsCurrency
            );

          FView.StepProgress();
        end;
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

  procedure BudgetItemTypeChanged();
  begin
    FCurrentBudgetItemType := tmpView.CurrentBudgetItemType;
  end;

  procedure EntityChanged();
  begin
    FCurrentEntity := tmpView.CurrentEntity;
    if FCurrentEntity in [etActualBudget, etPlannedBudget] then
    begin
      BudgetItemTypeChanged();
    end;
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
      b := tmpForm.ShowModal = mrOk;
    finally
      tmpForm.Free();
    end;
    if b then
    begin
      // ApplyConfiguration();
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
    // Result := FGridTableViewResult.DataController.RecordCount > 0;
  end;

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
          TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.Login :=
            IfThen(TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStoreLogin, tmpLoginWindow.Login);
          TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.Password :=
            IfThen(TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStorePassword, tmpLoginWindow.Password);
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

  procedure AddUpdate();
  begin
    tmpView.ActionStates[vaAdd] := not FProcessign;
  end;

  function GetCurrentModel(const aId: Integer): ICustomModel;
  begin
    Result := nil;

    if aId < 0 then
    begin
      Exit;
    end;

    case FCurrentEntity of
      etAccountingCenters:
        Result := LoadAccountingCenters(aId);
      etBanks:
        Result := LoadBanks(aId);
      etBudgetItems:
        Result := LoadBudgetItems(aId);
      etBudgetItemTypes:
        Result := LoadBudgetItemTypes(aId);
      etCosignatories:
        Result := LoadCosignatories(aId);
      etCurrencies:
        Result := LoadCurrencies(aId);
      etProducts:
        Result := LoadProducts(aId);
      etProductTypes:
        Result := LoadProductTypes(aId);
      etActualBudget:
        Result := LoadActualBudget(aId);
      etPlannedBudget:
        Result := LoadPlannedBudget(aId);
    else
      Exit;
    end;
  end;

  procedure AddEditExecute(const aId: Integer = -1);
  var
    tmpFormClass: TfrmCustomEditClass;
    tmpCustomEditView: ICustomEditView;
    tmpPresenter: ICustomPresenter;
    tmpPresenterClass: TCustomEditPresenterClass;
    tmpCurrentModel: ICustomModel;
  begin
    tmpFormClass := nil;

    case FCurrentEntity of
      etAccountingCenters:
        begin
          tmpFormClass := TfrmAccountingCenter;
          tmpPresenterClass := TAccountingCenterPresenter;
        end;
      etBanks:
        begin
          tmpFormClass := TfrmBank;
          tmpPresenterClass := TBankPresenter;
        end;
      etBudgetItems:
        begin
          tmpFormClass := TfrmBudgetItem;
          tmpPresenterClass := TBudgetItemPresenter;
        end;
      etBudgetItemTypes:
        begin
          tmpFormClass := TfrmBudgetItemType;
          tmpPresenterClass := TBudgetItemTypePresenter;
        end;
      etCosignatories:
        begin
          tmpFormClass := TfrmCosignatory;
          tmpPresenterClass := TCosignatoryPresenter;
        end;
      etCurrencies:
        begin
          tmpFormClass := TfrmCurrency;
          tmpPresenterClass := TCurrencyPresenter;
        end;
      etProducts:
        begin
          tmpFormClass := TfrmProduct;
          tmpPresenterClass := TProductPresenter;
        end;
      etProductTypes:
        begin
          tmpFormClass := TfrmProductType;
          tmpPresenterClass := TProductTypePresenter;
        end;
      etActualBudget:
        begin
          tmpFormClass := TfrmActualBudget;
          tmpPresenterClass := TActualBudgetPresenter;
        end;
      etPlannedBudget:
        begin
//          tmpFormClass := TfrmPlannedBudget;
          tmpPresenterClass := TPlannedBudgetPresenter;
        end;
    else
      Exit;
    end;

    FProcessign := True;

    tmpView.RefreshStates();
    try
      tmpCurrentModel := GetCurrentModel(aId);

      tmpView.ShowProgress(IfThen(Assigned(tmpCurrentModel), 'Редактирование элемента...', 'Добавление элемента...'));
      try
        tmpCustomEditView := tmpFormClass.Create(nil);
        try
          tmpPresenter := tmpPresenterClass.Create(tmpCustomEditView, tmpCurrentModel);
          try
            tmpCustomEditView.ShowModal();
          finally
            tmpPresenter := nil;
          end;
        finally
          tmpCustomEditView := nil;
        end;
      finally
        tmpView.HideProgress();
      end;
    finally
      FProcessign := False;
    end;
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

  tmpCurrentId := -1;
  if Assigned(FGridId) then
  begin
    FGridId.TryGetValue(FCurrentEntity, tmpCurrentId);
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
    veBudgetItemTypeChanged:
      BudgetItemTypeChanged();
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
      begin
        AddEditExecute();
        RefreshExecute();
      end;
    veAddUpdate:
      AddUpdate();
    veEditExecute:
      begin
        AddEditExecute(tmpCurrentId);
        RefreshExecute();
      end;
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
