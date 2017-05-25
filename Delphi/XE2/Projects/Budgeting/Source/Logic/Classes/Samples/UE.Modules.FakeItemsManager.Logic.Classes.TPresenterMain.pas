unit UE.Modules.FakeItemsManager.Logic.Classes.TPresenterMain;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Classes,
  System.Generics.Collections,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IPresenter,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IViewMain,
  UE.Modules.FakeItemsManager.Logic.TViewEnumEvent,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IFake,
  UE.Modules.FakeItemsManager.Logic.Classes.TPresenter;

type
  TPresenterMain = class(TPresenter, IPresenter)
  strict private
    FCurrentFake: IFake;
    FCustomers: TStringList;
    FDomains: TStringList;
    FItems: TStringList;

  strict protected
    procedure OnEventSimple(aValue: TViewEnumEvent); override;
    procedure Initialize(); override;

  public
    procedure BeforeDestruction(); override;
  end;

implementation

uses
  System.Math,
  Vcl.Forms,
  Winapi.Windows,
  Data.DB,
  Vcl.Controls,
  ERP.Package.CustomGlobalFunctions.UserFunctions,
  UE.Modules.FakeItemsManager.Logic.TViewEnumAction,
  UE.Modules.FakeItemsManager.Logic.Classes.TQuery,
  UE.Modules.FakeItemsManager.Logic.Classes.TPresenterDetail,
  UE.Modules.FakeItemsManager.UI.Detail;

procedure TPresenterMain.BeforeDestruction;
begin
  try
    if Assigned(FCustomers) then
    begin
      FreeAndNil(FCustomers);
    end;
  finally
    try
      if Assigned(FDomains) then
      begin
        FreeAndNil(FDomains);
      end;
    finally
      try
        if Assigned(FItems) then
        begin
          FreeAndNil(FItems);
        end;
      finally
        inherited;
      end;
    end;
  end;
end;

procedure TPresenterMain.Initialize();
begin
  inherited;
  OnEventSimple(veRefreshExecute);
end;

procedure TPresenterMain.OnEventSimple(aValue: TViewEnumEvent);
var
  tmpView: IViewMain;

  procedure LoadFakes();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FFDConnection;
      tmpQuery.SQL.Text := TQuery.SpFIManagerSelFakeItem.Name;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelFakeItem.Param.ACustomerId).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelFakeItem.Param.ADomainId).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelFakeItem.Param.AItemNo).DataType := ftString;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка фальшивок...', tmpQuery.RecordCount);
        tmpView.Fakes := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadCustomers();
  var
    tmpQuery: TFDQuery;
    i: Integer;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FFDConnection;
      tmpQuery.SQL.Text := TQuery.SpFIManagerSelCustomer.Name;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelCustomer.Param.ACustomerId).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelCustomer.Param.ADomainId).DataType := ftInteger;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка клиентоа...', tmpQuery.RecordCount);
        if not Assigned(FCustomers) then
        begin
          FCustomers := TStringList.Create();
          FCustomers.Sorted := False;
          FCustomers.Duplicates := dupAccept;
        end
        else
        begin
          FCustomers.Clear();
        end;
        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          FCustomers.AddObject(tmpQuery.FieldByName(TQuery.SpFIManagerSelCustomer.Field.CustomerNo).AsString,
            TObject(tmpQuery.FieldByName(TQuery.SpFIManagerSelCustomer.Field.CustomerId).AsInteger));

          tmpQuery.Next();
          tmpView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadDomains();
  var
    tmpQuery: TFDQuery;
    i: Integer;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FFDConnection;
      tmpQuery.SQL.Text := TQuery.SpFIManagerSelDomain.Name;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelDomain.Param.ADomainId).DataType := ftInteger;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка доменов...', tmpQuery.RecordCount);
        if not Assigned(FDomains) then
        begin
          FDomains := TStringList.Create();
          FDomains.Sorted := False;
          FDomains.Duplicates := dupAccept;
        end
        else
        begin
          FDomains.Clear();
        end;
        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          FDomains.AddObject(tmpQuery.FieldByName(TQuery.SpFIManagerSelDomain.Field.Name).AsString,
            TObject(tmpQuery.FieldByName(TQuery.SpFIManagerSelDomain.Field.DomainId).AsInteger));

          tmpQuery.Next();
          tmpView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadItems();
  var
    tmpQuery: TFDQuery;
    i: Integer;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FFDConnection;
      tmpQuery.SQL.Text := TQuery.SpFIManagerSelItem.Name;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelItem.Param.ADomainId).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.SpFIManagerSelItem.Param.AItemNo).DataType := ftString;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка товаров...', tmpQuery.RecordCount);
        if not Assigned(FItems) then
        begin
          FItems := TStringList.Create();
          FItems.Sorted := False;
          FItems.Duplicates := dupAccept;
        end
        else
        begin
          FItems.Clear();
        end;
        for i := 0 to Pred(tmpQuery.RecordCount) do
        begin
          FItems.AddObject(tmpQuery.FieldByName(TQuery.SpFIManagerSelItem.Field.ItemNo).AsString,
            TObject(tmpQuery.FieldByName(TQuery.SpFIManagerSelItem.Field.DomainId).AsInteger));

          tmpQuery.Next();
          tmpView.StepProgress();
        end;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure RefreshExecute();
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      try
        tmpView.ShowProgress('Обновление списка фальшивок...');
        LoadFakes();
        tmpView.ShowProgress('Обновление списка клиентов...');
        LoadCustomers();
        tmpView.ShowProgress('Обновление списка доменов...');
        LoadDomains();
        tmpView.ShowProgress('Обновление списка товаров...');
        LoadItems();
      finally
        tmpView.HideProgress();
      end;
    finally
      FProcessign := False;
    end;
  end;

  procedure AddExecute();
  var
    tmpForm: TfrmDetail;
    tmpPresenter: IPresenter;
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.ShowProgress('Добавление элемента...');
      try
        tmpForm := TfrmDetail.Create(nil);
        try
          tmpPresenter := TPresenterDetail.Create(tmpForm, FFDConnection, FCustomers, FDomains, FItems, nil);
          if not Assigned(tmpPresenter) then
          begin
            Exit;
          end;
          if tmpForm.ShowModal() = mrOk then
          begin
            LoadFakes();
          end;
        finally
          tmpForm.Free();
        end;
      finally
        FProcessign := False;
      end;
    finally
      tmpView.HideProgress();
    end;
  end;

  procedure EditExecute();
  var
    tmpForm: TfrmDetail;
    tmpPresenter: IPresenter;
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.ShowProgress('Редактирование элемента...');
      try
        tmpForm := TfrmDetail.Create(nil);
        try
          tmpPresenter := TPresenterDetail.Create(tmpForm, FFDConnection, FCustomers, FDomains, FItems, tmpView.CurrentFake);
          if not Assigned(tmpPresenter) then
          begin
            Exit;
          end;
          if tmpForm.ShowModal() = mrOk then
          begin
            LoadFakes();
          end;
        finally
          tmpForm.Free();
        end;
      finally
        FProcessign := False;
      end;
    finally
      tmpView.HideProgress();
    end;
  end;

  procedure DeleteExecute();
  var
    tmpQuery: TFDQuery;
    tmpResult: Integer;
    tmpMessage: string;
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    tmpResult := 0;
    tmpMessage := EmptyStr;
    try
      tmpView.ShowProgress('Удаление элемента...');
      try
        try
          tmpQuery := TFDQuery.Create(nil);
          try
            tmpQuery.Connection := FFDConnection;
            tmpQuery.SQL.Text := TQuery.SpFIManagerDelFakeItem.Name;
            tmpQuery.ParamByName(TQuery.SpFIManagerDelFakeItem.Param.ACustomerId).AsInteger := FCurrentFake.CustomerId;
            tmpQuery.ParamByName(TQuery.SpFIManagerDelFakeItem.Param.ADomainId).AsInteger := FCurrentFake.ItemDomainId;
            tmpQuery.ParamByName(TQuery.SpFIManagerDelFakeItem.Param.AItemNo).AsString := FCurrentFake.ItemNo;
            tmpQuery.Open();
            try
              if tmpQuery.RecordCount <> 1 then
              begin
                Exit;
              end;

              tmpResult := tmpQuery.FieldByName(TQuery.SpFIManagerDelFakeItem.Field.Result).AsInteger;
              tmpMessage := tmpQuery.FieldByName(TQuery.SpFIManagerDelFakeItem.Field.Message).AsString;
            finally
              tmpQuery.Close();
            end;
          finally
            tmpQuery.Free();
          end;
        finally
          tmpView.StepProgress();
          LoadFakes();
          tmpView.ShowMessage(tmpMessage, IfThen(tmpResult >= 0, QUERY_RESULT_OK, QUERY_RESULT_ERROR));
          FProcessign := False;
        end;
      finally
        FProcessign := False;
      end;
    finally
      tmpView.HideProgress();
    end;
  end;

  procedure SelectedRecordChanged();
  begin
    FCurrentFake := tmpView.CurrentFake;
  end;

  procedure AddUpdate();
  begin
    FView.ActionStates[vaAdd] := not FProcessign;
  end;

  procedure EditUpdate();
  begin
    FView.ActionStates[vaEdit] := (not FProcessign) and Assigned(FCurrentFake);
  end;

  procedure DeleteUpdate();
  begin
    FView.ActionStates[vaDelete] := (not FProcessign) and Assigned(FCurrentFake);
  end;

  procedure RefreshUpdate();
  begin
    FView.ActionStates[vaRefresh] := not FProcessign;
  end;

begin
  if not Supports(FView, IViewMain, tmpView) then
  begin
    Exit;
  end;

  case aValue of
    veAddExecute:
      AddExecute();
    veEditExecute:
      EditExecute();
    veDeleteExecute:
      DeleteExecute();
    veRefreshExecute:
      RefreshExecute();
    veAddUpdate:
      AddUpdate();
    veEditUpdate:
      EditUpdate();
    veDeleteUpdate:
      DeleteUpdate();
    veRefreshUpdate:
      RefreshUpdate();
    veSelectedRecordChanged:
      SelectedRecordChanged();
  end;
end;

end.
