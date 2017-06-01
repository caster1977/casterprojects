unit Budgeting.Logic.Classes.Presenters.TPlannedBudgetPresenter;

interface

uses
  FireDAC.Comp.Client,
  System.Classes,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Presenters.IPlannedBudgetPresenter;

type
  TPlannedBudgetPresenter = class(TCustomEditPresenter, IPlannedBudgetPresenter)
  strict protected
    function CheckItem(): Boolean; override;
    procedure BeforeQueryOpen(const aQuery: TFDQuery); override;
    procedure Initialize(); override;

  strict private
    procedure LoadBudgetItems(var aList: TStringList);
    procedure LoadAccountingCenters(var aList: TStringList);
    procedure LoadCurrencies(var aList: TStringList);
    procedure LoadYears(var aList: TStringList);
    procedure LoadMonths(var aList: TStringList);
  end;

implementation

uses
  System.Math,
  Vcl.Forms,
  Winapi.Windows,
  Data.DB,
  Vcl.Controls,
  System.SysUtils,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  Budgeting.Logic.Classes.Configuration.Sections.TGeneralSection,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Views.IPlannedBudgetView,
  Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel;

function TPlannedBudgetPresenter.CheckItem(): Boolean;
var
  tmpItem: IPlannedBudgetModel;
begin
  Result := False;

  if Supports(FItem, IPlannedBudgetModel, tmpItem) then
  begin
    Result := (tmpItem.Id_BudgetItem > -1) and (tmpItem.Id_AccountingCenter > -1) and (tmpItem.Id_Currency > -1) and (tmpItem.Year > 0) and (tmpItem.Month > 0) and (tmpItem.Amount > 0);
  end;
end;

procedure TPlannedBudgetPresenter.Initialize();
var
  tmpView: IPlannedBudgetView;
  tmpList: TStringList;
begin
  if Supports(FView, IPlannedBudgetView, tmpView) then
  begin
    tmpList := TStringList.Create();
    try
      tmpList.Sorted := False;
      tmpList.Duplicates := dupAccept;

      LoadBudgetItems(tmpList);
      tmpView.BudgetItems := tmpList;

      tmpList.Clear();
      LoadAccountingCenters(tmpList);
      tmpView.AccountingCenters := tmpList;

      tmpList.Clear();
      LoadCurrencies(tmpList);
      tmpView.Currencies := tmpList;

      tmpList.Clear();
      LoadYears(tmpList);
      tmpView.Years := tmpList;

      tmpList.Clear();
      LoadMonths(tmpList);
      tmpView.Months := tmpList;

    finally
      tmpList.Free();
    end;
  end;
  inherited;
end;

procedure TPlannedBudgetPresenter.LoadAccountingCenters(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_accounting_centers_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Id).DataType := ftInteger;
    tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Activity).DataType := ftBoolean;
    if not FEditMode then
    begin
      tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Activity).AsBoolean := True;
    end;
    tmpQuery.Open();
    try
      FView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
      try
        if tmpQuery.IsEmpty() then
        begin
          Exit;
        end;

        tmpQuery.First();

        aList.Clear();

        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Info).AsString, TObject(tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Id).AsInteger));

          tmpQuery.Next();

          FView.StepProgress();
        end;
      finally
        FView.HideProgress();
      end;
    finally
      tmpQuery.Close();
    end;
  finally
    tmpQuery.Free();
  end;
end;

procedure TPlannedBudgetPresenter.LoadBudgetItems(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_budget_items_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Id).DataType := ftInteger;
    tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Activity).DataType := ftBoolean;
    if not FEditMode then
    begin
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Activity).AsBoolean := True;
    end;
    tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Id_BudgetItemType).DataType := ftInteger;
    if FTag > -1 then
    begin
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Id_BudgetItemType).AsInteger := FTag;
    end;
    tmpQuery.Open();
    try
      FView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
      try
        if tmpQuery.IsEmpty() then
        begin
          Exit;
        end;

        tmpQuery.First();

        aList.Clear();

        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Info).AsString, TObject(tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Id).AsInteger));

          tmpQuery.Next();

          FView.StepProgress();
        end;
      finally
        FView.HideProgress();
      end;
    finally
      tmpQuery.Close();
    end;
  finally
    tmpQuery.Free();
  end;
end;

procedure TPlannedBudgetPresenter.LoadCurrencies(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_currencies_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Id).DataType := ftInteger;
    tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Activity).DataType := ftBoolean;
    if not FEditMode then
    begin
      tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Activity).AsBoolean := True;
    end;
    tmpQuery.Open();
    try
      FView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
      try
        if tmpQuery.IsEmpty() then
        begin
          Exit;
        end;

        tmpQuery.First();

        aList.Clear();

        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Info).AsString, TObject(tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Id).AsInteger));

          tmpQuery.Next();

          FView.StepProgress();
        end;
      finally
        FView.HideProgress();
      end;
    finally
      tmpQuery.Close();
    end;
  finally
    tmpQuery.Free();
  end;
end;

procedure TPlannedBudgetPresenter.LoadMonths(var aList: TStringList);
begin
  FView.ShowProgress('Создание списка месяцев...', 1);
  try
    aList.Clear();

    aList.AddObject('Январь', TObject(1));
    aList.AddObject('Февраль', TObject(2));
    aList.AddObject('Март', TObject(3));
    aList.AddObject('Апрель', TObject(4));
    aList.AddObject('Май', TObject(5));
    aList.AddObject('Июнь', TObject(6));
    aList.AddObject('Июль', TObject(7));
    aList.AddObject('Август', TObject(8));
    aList.AddObject('Сентябрь', TObject(9));
    aList.AddObject('Октябрь', TObject(10));
    aList.AddObject('Ноябрь', TObject(11));
    aList.AddObject('Декабрь', TObject(12));

    FView.StepProgress();
  finally
    FView.HideProgress();
  end;
end;

procedure TPlannedBudgetPresenter.LoadYears(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_planned_budget_years_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_planned_budget_years_sel.Param.Year).DataType := ftInteger;
    if TConfiguration.Get(TConfiguration).Section<TGeneralSection>.Year <> 0 then
    begin
      tmpQuery.ParamByName(TQuery.sp_planned_budget_years_sel.Param.Year).AsInteger := TConfiguration.Get(TConfiguration).Section<TGeneralSection>.Year;
    end;
    tmpQuery.Open();
    try
      FView.ShowProgress('Загрузка данных из базы...', tmpQuery.RecordCount);
      try
        if tmpQuery.IsEmpty() then
        begin
          Exit;
        end;

        tmpQuery.First();

        aList.Clear();

        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_planned_budget_years_sel.Field.Year).AsString, TObject(tmpQuery.FieldByName(TQuery.sp_planned_budget_years_sel.Field.Year).AsInteger));

          tmpQuery.Next();

          FView.StepProgress();
        end;
      finally
        FView.HideProgress();
      end;
    finally
      tmpQuery.Close();
    end;
  finally
    tmpQuery.Free();
  end;
end;

procedure TPlannedBudgetPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IPlannedBudgetModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IPlannedBudgetModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_planned_budget_upd.Name;
    aQuery.ParamByName(TQuery.sp_planned_budget_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_planned_budget_upd.Param.Id_BudgetItem).AsInteger := tmpItem.Id_BudgetItem;
    aQuery.ParamByName(TQuery.sp_planned_budget_upd.Param.Id_AccountingCenter).AsInteger := tmpItem.Id_AccountingCenter;
    aQuery.ParamByName(TQuery.sp_planned_budget_upd.Param.Id_Currency).AsInteger := tmpItem.Id_Currency;
    aQuery.ParamByName(TQuery.sp_planned_budget_upd.Param.Year).AsInteger := tmpItem.Year;
    aQuery.ParamByName(TQuery.sp_planned_budget_upd.Param.Month).AsInteger := tmpItem.Month;
    aQuery.ParamByName(TQuery.sp_planned_budget_upd.Param.Amount).AsCurrency := tmpItem.Amount;
  end;
end;

end.
