unit Budgeting.Logic.Classes.Presenters.TActualBudgetPresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TActualBudgetPresenter = class(TCustomEditPresenter)
  strict protected
    function CheckItem(): Boolean; override;
    procedure BeforeQueryOpen(const aQuery: TFDQuery); override;
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

