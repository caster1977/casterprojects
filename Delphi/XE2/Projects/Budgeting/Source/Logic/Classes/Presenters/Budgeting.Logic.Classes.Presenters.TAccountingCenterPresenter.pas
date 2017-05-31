unit Budgeting.Logic.Classes.Presenters.TAccountingCenterPresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter;

type
  TAccountingCenterPresenter = class(TCustomEditPresenter)
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

  System.SysUtils,

  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IAccountingCenterModel;

function TAccountingCenterPresenter.CheckItem(): Boolean;
var
  tmpItem: IAccountingCenterModel;
begin
  Result := False;

  if Supports(FItem, IAccountingCenterModel, tmpItem) then
  begin
    Result := (tmpItem.Code > string.Empty) and (tmpItem.Name > string.Empty);
  end;
end;

procedure TAccountingCenterPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IAccountingCenterModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IAccountingCenterModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_accounting_centers_upd.Name;
    aQuery.ParamByName(TQuery.sp_accounting_centers_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_accounting_centers_upd.Param.Code).AsString := tmpItem.Code.Trim();
    aQuery.ParamByName(TQuery.sp_accounting_centers_upd.Param.Name).AsString := tmpItem.Name.Trim();
    aQuery.ParamByName(TQuery.sp_accounting_centers_upd.Param.Description).AsString := tmpItem.Description.Trim();
    aQuery.ParamByName(TQuery.sp_accounting_centers_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.
