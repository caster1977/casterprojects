unit Budgeting.Logic.Classes.Presenters.TBankPresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TBankPresenter = class(TCustomEditPresenter)
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
  Budgeting.Logic.Interfaces.Views.IBankView,
  Budgeting.Logic.Types.TViewEnumAction,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IBankModel;

function TBankPresenter.CheckItem(): Boolean;
var
  tmpItem: IBankModel;
begin
  Result := False;

  if Supports(FItem, IBankModel, tmpItem) then
  begin
    Result := (tmpItem.Name > string.Empty) and (tmpItem.Code > string.Empty);
  end;
end;

procedure TBankPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IBankModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IBankModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_banks_upd.Name;
    aQuery.ParamByName(TQuery.sp_banks_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_banks_upd.Param.Name).AsString := tmpItem.Name.Trim();
    aQuery.ParamByName(TQuery.sp_banks_upd.Param.Code).AsString := tmpItem.Code.Trim();
    aQuery.ParamByName(TQuery.sp_banks_upd.Param.Address).AsString := tmpItem.Address.Trim();
    aQuery.ParamByName(TQuery.sp_banks_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.

