unit Budgeting.Logic.Classes.Presenters.TPlannedBudgetPresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TPlannedBudgetPresenter = class(TCustomEditPresenter)
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
  Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel;

function TPlannedBudgetPresenter.CheckItem(): Boolean;
var
  tmpItem: IPlannedBudgetModel;
begin
  Result := False;

  if Supports(FItem, IPlannedBudgetModel, tmpItem) then
  begin
    Result := (tmpItem.Id_BudgetItem > -1) and
    (tmpItem.Id_AccountingCenter > -1) and
    (tmpItem.Id_Currency > -1) and
    (tmpItem.Year > 0) and
    (tmpItem.Month > 0) and
    (tmpItem.Amount > 0);
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

