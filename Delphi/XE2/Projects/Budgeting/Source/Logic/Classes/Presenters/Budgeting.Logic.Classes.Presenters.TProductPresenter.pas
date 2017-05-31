unit Budgeting.Logic.Classes.Presenters.TProductPresenter;

interface

uses
  FireDAC.Comp.Client,
  System.Classes,
  Budgeting.Logic.Interfaces.Presenters.IProductPresenter,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter;

type
  TProductPresenter = class(TCustomEditPresenter, IProductPresenter)
  strict protected
    function CheckItem(): Boolean; override;
    procedure BeforeQueryOpen(const aQuery: TFDQuery); override;
    procedure Initialize(); override;

  strict private
    procedure LoadProductTypes(var aList: TStringList);
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
  Budgeting.Logic.Interfaces.Models.IProductModel,
  Budgeting.Logic.Interfaces.Views.IProductView;

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

procedure TProductPresenter.Initialize();
var
  tmpView: IProductView;
  tmpList: TStringList;
begin
  tmpList := TStringList.Create();
  try
    tmpList.Sorted := False;
    tmpList.Duplicates := dupAccept;
    LoadProductTypes(tmpList);
    if Supports(FView, IProductView, tmpView) then
    begin
      tmpView.ProductTypes := tmpList;
      inherited;
    end;
  finally
    tmpList.Free();
  end;
end;

procedure TProductPresenter.LoadProductTypes(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_product_types_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Id).DataType := ftInteger;
    tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Activity).DataType := ftBoolean;
    if not FEditMode then
    begin
      tmpQuery.ParamByName(TQuery.sp_product_types_sel.Param.Activity).AsBoolean := True;
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
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_product_types_sel.Field.Name).AsString, TObject(tmpQuery.FieldByName(TQuery.sp_product_types_sel.Field.Id).AsInteger));

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
