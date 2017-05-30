unit Budgeting.Logic.Classes.Presenters.TBudgetItemTypePresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TBudgetItemTypePresenter = class(TCustomEditPresenter)
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
  Budgeting.Logic.Consts,
  Budgeting.Logic.Types.TViewEnumAction,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel;

function TBudgetItemTypePresenter.CheckItem(): Boolean;
var
  tmpItem: IBudgetItemTypeModel;
begin
  Result := False;

  if Supports(FItem, IBudgetItemTypeModel, tmpItem) then
  begin
    Result := (tmpItem.Name > string.Empty);
  end;
end;

procedure TBudgetItemTypePresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IBudgetItemTypeModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IBudgetItemTypeModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_budget_item_types_upd.Name;
    aQuery.ParamByName(TQuery.sp_budget_item_types_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_budget_item_types_upd.Param.Name).AsString := tmpItem.Name.Trim();
    aQuery.ParamByName(TQuery.sp_budget_item_types_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.

