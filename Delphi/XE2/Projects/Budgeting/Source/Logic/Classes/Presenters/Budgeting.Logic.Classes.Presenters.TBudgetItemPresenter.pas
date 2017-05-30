unit Budgeting.Logic.Classes.Presenters.TBudgetItemPresenter;

interface

uses
  FireDAC.Comp.Client,
  System.Classes,
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  TBudgetItemPresenter = class(TCustomEditPresenter)
  strict protected
    function CheckItem(): Boolean; override;
    procedure BeforeQueryOpen(const aQuery: TFDQuery); override;
    procedure Initialize(); override;
  strict private
    procedure LoadBudgetItemTypes(var aList: TStringList);
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
  Budgeting.Logic.Interfaces.Models.IBudgetItemModel,
  Budgeting.Logic.Interfaces.Views.IBudgetItemView;

  procedure TBudgetItemPresenter.LoadBudgetItemTypes(var aList: TStringList);
  var
    tmpQuery: TFDQuery;
    i: Integer;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_budget_item_types_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Activity).DataType := ftBoolean;
      if not FEditMode then
      begin
        tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Activity).AsBoolean := True;
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
            aList.AddObject(tmpQuery.FieldByName(TQuery.sp_budget_item_types_sel.Field.Name).AsString,
              TObject(tmpQuery.FieldByName(TQuery.sp_budget_item_types_sel.Field.Id).AsInteger));

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

function TBudgetItemPresenter.CheckItem(): Boolean;
var
  tmpItem: IBudgetItemModel;
begin
  Result := False;

  if Supports(FItem, IBudgetItemModel, tmpItem) then
  begin
    Result := (tmpItem.Id_BudgetItemType > -1) and (tmpItem.Code > string.Empty);
  end;
end;

procedure TBudgetItemPresenter.Initialize();
var
  tmpView: IBudgetItemView;
  tmpList: TStringList;
begin
  tmpList := TStringList.Create();
  try
    tmpList.Sorted := False;
    tmpList.Duplicates := dupAccept;
    LoadBudgetItemTypes(tmpList);
    if Supports(FView, IBudgetItemView, tmpView) then
    begin
      tmpView.BudgetItemTypes := tmpList;
      inherited;
    end;

//    tmpView := nil;
  finally
    tmpList.Free();
  end;
end;

procedure TBudgetItemPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: IBudgetItemModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, IBudgetItemModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_budget_items_upd.Name;
    aQuery.ParamByName(TQuery.sp_budget_items_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_budget_items_upd.Param.Id_BudgetItemType).AsInteger := tmpItem.Id_BudgetItemType;
    aQuery.ParamByName(TQuery.sp_budget_items_upd.Param.Code).AsString := tmpItem.Code.Trim();
    aQuery.ParamByName(TQuery.sp_budget_items_upd.Param.Description).AsString := tmpItem.Description.Trim();
    aQuery.ParamByName(TQuery.sp_budget_items_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.

