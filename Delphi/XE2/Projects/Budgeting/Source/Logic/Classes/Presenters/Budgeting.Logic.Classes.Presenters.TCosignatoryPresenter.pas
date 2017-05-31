unit Budgeting.Logic.Classes.Presenters.TCosignatoryPresenter;

interface

uses
  FireDAC.Comp.Client,
  System.Classes,

  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter;

type
  TCosignatoryPresenter = class(TCustomEditPresenter)
  strict protected
    function CheckItem(): Boolean; override;
    procedure BeforeQueryOpen(const aQuery: TFDQuery); override;
    procedure Initialize(); override;

  strict private
    procedure LoadBanks(var aList: TStringList);
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
  Budgeting.Logic.Interfaces.Models.ICosignatoryModel,
  Budgeting.Logic.Interfaces.Views.ICosignatoryView;

function TCosignatoryPresenter.CheckItem(): Boolean;
var
  tmpItem: ICosignatoryModel;
begin
  Result := False;

  if Supports(FItem, ICosignatoryModel, tmpItem) then
  begin
    Result := (tmpItem.Id_Bank > -1) and (tmpItem.Name > string.Empty) and (tmpItem.UNP > string.Empty) and (tmpItem.Address > string.Empty) and (tmpItem.AgreementNumber > string.Empty) and (tmpItem.AgreementStart > 0) and
      (tmpItem.AgreementStop > 0) and (tmpItem.Account > string.Empty);
  end;
end;

procedure TCosignatoryPresenter.Initialize();
var
  tmpView: ICosignatoryView;
  tmpList: TStringList;
begin
  tmpList := TStringList.Create();
  try
    tmpList.Sorted := False;
    tmpList.Duplicates := dupAccept;
    LoadBanks(tmpList);
    if Supports(FView, ICosignatoryView, tmpView) then
    begin
      tmpView.Banks := tmpList;
      inherited;
    end;
  finally
    tmpList.Free();
  end;
end;

procedure TCosignatoryPresenter.LoadBanks(var aList: TStringList);
var
  tmpQuery: TFDQuery;
  i: Integer;
begin
  tmpQuery := TFDQuery.Create(nil);
  try
    tmpQuery.Connection := FConnection;
    tmpQuery.SQL.Text := TQuery.sp_banks_sel.Name;
    tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Id).DataType := ftInteger;
    tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Activity).DataType := ftBoolean;
    if not FEditMode then
    begin
      tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Activity).AsBoolean := True;
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
          aList.AddObject(tmpQuery.FieldByName(TQuery.sp_banks_sel.Field.Info).AsString, TObject(tmpQuery.FieldByName(TQuery.sp_banks_sel.Field.Id).AsInteger));

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

procedure TCosignatoryPresenter.BeforeQueryOpen(const aQuery: TFDQuery);
var
  tmpItem: ICosignatoryModel;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  if Supports(FItem, ICosignatoryModel, tmpItem) then
  begin
    aQuery.SQL.Text := TQuery.sp_cosignatories_upd.Name;
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.Id).AsInteger := tmpItem.Id;
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.Id_Bank).AsInteger := tmpItem.Id_Bank;
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.Name).AsString := tmpItem.Name.Trim();
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.UNP).AsString := tmpItem.UNP.Trim();
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.Address).AsString := tmpItem.Address.Trim();
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.AgreementNumber).AsString := tmpItem.AgreementNumber.Trim();
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.AgreementStart).AsDate := tmpItem.AgreementStart;
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.AgreementStop).AsDate := tmpItem.AgreementStop;
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.Account).AsString := tmpItem.Account.Trim();
    aQuery.ParamByName(TQuery.sp_cosignatories_upd.Param.Activity).AsBoolean := tmpItem.Activity;
  end;
end;

end.
