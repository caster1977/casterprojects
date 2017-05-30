unit Budgeting.Logic.Classes.Presenters.TProductPresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TProductPresenter = class(TCustomEditPresenter)
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
  Budgeting.Logic.Interfaces.Models.IProductModel;

function TProductPresenter.CheckItem(): Boolean;
var
  tmpItem: IProductModel;
begin
  Result := False;

  if Supports(FItem, IProductModel, tmpItem) then
  begin
    Result := (tmpItem.Id_ProductType > -1) and (tmpItem.Code > string.Empty);
  end;
end;

procedure TProductPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IProductModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IProductModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_products_upd.Name;
    aQuery.ParamByName(TQuery.sp_products_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_products_upd.Param.Id_ProductType).AsInteger := tmpItem.Id_ProductType;
    aQuery.ParamByName(TQuery.sp_products_upd.Param.Code).AsString := tmpItem.Code.Trim();
    aQuery.ParamByName(TQuery.sp_products_upd.Param.Description).AsString := tmpItem.Description.Trim();
    aQuery.ParamByName(TQuery.sp_products_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.

