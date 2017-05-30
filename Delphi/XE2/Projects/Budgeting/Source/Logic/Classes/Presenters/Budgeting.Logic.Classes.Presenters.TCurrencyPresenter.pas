unit Budgeting.Logic.Classes.Presenters.TCurrencyPresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TCurrencyPresenter = class(TCustomEditPresenter)
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
  Budgeting.Logic.Interfaces.Models.ICurrencyModel;

function TCurrencyPresenter.CheckItem(): Boolean;
var
  tmpItem: ICurrencyModel;
begin
  Result := False;

  if Supports(FItem, ICurrencyModel, tmpItem) then
  begin
    Result := (tmpItem.Code > string.Empty);
  end;
end;

procedure TCurrencyPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: ICurrencyModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, ICurrencyModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_currencies_upd.Name;
    aQuery.ParamByName(TQuery.sp_currencies_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_currencies_upd.Param.Code).AsString := tmpItem.Code.Trim();
    aQuery.ParamByName(TQuery.sp_currencies_upd.Param.Description).AsString := tmpItem.Description.Trim();
    aQuery.ParamByName(TQuery.sp_currencies_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.

