unit Budgeting.Logic.Classes.Presenters.TProductTypePresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter;

type
  TProductTypePresenter = class(TCustomEditPresenter)
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
  Budgeting.Logic.Interfaces.Models.IProductTypeModel;

function TProductTypePresenter.CheckItem(): Boolean;
var
  tmpItem: IProductTypeModel;
begin
  Result := False;

  if Supports(FItem, IProductTypeModel, tmpItem) then
  begin
    Result := (tmpItem.Name > string.Empty);
  end;
end;

procedure TProductTypePresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IProductTypeModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IProductTypeModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_product_types_upd.Name;
    aQuery.ParamByName(TQuery.sp_product_types_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_product_types_upd.Param.Name).AsString := tmpItem.Name.Trim();
    aQuery.ParamByName(TQuery.sp_product_types_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.
