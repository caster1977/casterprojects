unit Budgeting.Logic.Classes.Presenters.TActualBudgetPresenter;

interface

uses
  FireDAC.Comp.Client,
  System.Classes,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Presenters.IActualBudgetPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TActualBudgetPresenter = class(TCustomEditPresenter, IActualBudgetPresenter)
  strict protected
    function CheckItem(): Boolean; override;
    procedure BeforeQueryOpen(const aQuery: TFDQuery); override;
    procedure Initialize(); override;

  strict private
    procedure LoadBudgetItems(var aList: TStringList);
    procedure LoadAccountingCenters(var aList: TStringList);
    procedure LoadCosignatories(var aList: TStringList);
    procedure LoadProducts(var aList: TStringList);
    procedure LoadCurrencies(var aList: TStringList);
  end;

implementation

uses
  System.Math,
  Vcl.Forms,
  Winapi.Windows,
  Data.DB,
  Vcl.Controls,
  System.StrUtils,
  System.SysUtils,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Views.IActualBudgetView,
  Budgeting.Logic.Interfaces.Models.IActualBudgetModel;

function TActualBudgetPresenter.CheckItem(): Boolean;
var
  tmpItem: IActualBudgetModel;
begin
  Result := False;

  if Supports(FItem, IActualBudgetModel, tmpItem) then
  begin
    Result := (tmpItem.Id_BudgetItem > -1) and
    (tmpItem.Id_AccountingCenter > -1) and
    (tmpItem.Id_Cosignatory > -1) and
    (tmpItem.Id_Product > -1) and
    (tmpItem.Id_Currency > -1) and
    (tmpItem.DocumentDate > 0) and
    (tmpItem.Amount > 0);
  end;
end;

procedure TActualBudgetPresenter.Initialize();
var
  tmpView: IActualBudgetView;
  tmpList: TStringList;
begin
  if Supports(FView, IActualBudgetView, tmpView) then
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
      LoadCosignatories(tmpList);
      tmpView.Cosignatories := tmpList;

      tmpList.Clear();
      LoadProducts(tmpList);
      tmpView.Products := tmpList;

      tmpList.Clear();
      LoadCurrencies(tmpList);
      tmpView.Currencies := tmpList;
    finally
      tmpList.Free();
    end;
  end;
  inherited;
end;

procedure TActualBudgetPresenter.LoadAccountingCenters(var aList: TStringList);
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
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Info).AsString,
            TObject(tmpQuery.FieldByName(TQuery.sp_accounting_centers_sel.Field.Id).AsInteger));

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

procedure TActualBudgetPresenter.LoadBudgetItems(var aList: TStringList);
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
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Info).AsString,
            TObject(tmpQuery.FieldByName(TQuery.sp_budget_items_sel.Field.Id).AsInteger));

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

procedure TActualBudgetPresenter.LoadCosignatories(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_cosignatories_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Id).DataType := ftInteger;
    tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Activity).DataType := ftBoolean;
    if not FEditMode then
    begin
      tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Activity).AsBoolean := True;
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
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Info).AsString,
            TObject(tmpQuery.FieldByName(TQuery.sp_cosignatories_sel.Field.Id).AsInteger));

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

procedure TActualBudgetPresenter.LoadCurrencies(var aList: TStringList);
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
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Info).AsString,
            TObject(tmpQuery.FieldByName(TQuery.sp_currencies_sel.Field.Id).AsInteger));

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

procedure TActualBudgetPresenter.LoadProducts(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_products_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Id).DataType := ftInteger;
    tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Activity).DataType := ftBoolean;
    if not FEditMode then
    begin
      tmpQuery.ParamByName(TQuery.sp_products_sel.Param.Activity).AsBoolean := True;
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
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_products_sel.Field.Info).AsString,
            TObject(tmpQuery.FieldByName(TQuery.sp_products_sel.Field.Id).AsInteger));

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

procedure TActualBudgetPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IActualBudgetModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IActualBudgetModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_actual_budget_upd.Name;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Id_BudgetItem).AsInteger := tmpItem.Id_BudgetItem;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Id_AccountingCenter).AsInteger := tmpItem.Id_AccountingCenter;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Id_Cosignatory).AsInteger := tmpItem.Id_Cosignatory;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Id_Product).AsInteger := tmpItem.Id_Product;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Id_Currency).AsInteger := tmpItem.Id_Currency;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Document).AsString := tmpItem.Document.Trim();
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.DocumentDate).AsDate := tmpItem.DocumentDate;
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Description).AsString := tmpItem.Description.Trim();
    aQuery.ParamByName(TQuery.sp_actual_budget_upd.Param.Amount).AsCurrency := tmpItem.Amount;
  end;
end;

end.

