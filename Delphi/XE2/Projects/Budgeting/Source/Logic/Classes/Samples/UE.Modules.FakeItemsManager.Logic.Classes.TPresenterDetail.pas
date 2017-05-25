unit UE.Modules.FakeItemsManager.Logic.Classes.TPresenterDetail;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Classes,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IPresenter,
  UE.Modules.FakeItemsManager.Logic.Classes.TPresenter,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IViewDetail,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IView,
  UE.Modules.FakeItemsManager.Logic.TViewEnumEvent,
  UE.Modules.FakeItemsManager.Logic.Interfaces.IFake;

type
  TPresenterDetail = class(TPresenter, IPresenter)
  strict private
    FCurrentFake: IFake;
    FCustomers: TStringList;
    FDomains: TStringList;
    FItems: TStringList;
    FCurrentItems: TStringList;

  strict protected
    procedure OnEventSimple(aValue: TViewEnumEvent); override;
    procedure Initialize(); override;

  public
    constructor Create(const aView: IView; const aConnection: TFDConnection; const aCustomers, aDomains, aItems: TStringList; const aItem: IFake);
      reintroduce; virtual;
    procedure BeforeDestruction(); override;
  end;

implementation

uses
  System.Math,
  Vcl.Forms,
  Winapi.Windows,
  Data.DB,
  Vcl.Controls,
  System.StrUtils,
  ERP.Package.CustomGlobalFunctions.UserFunctions,
  UE.Modules.FakeItemsManager.Logic.TViewEnumAction,
  UE.Modules.FakeItemsManager.Logic.Classes.TQuery,
  UE.Modules.FakeItemsManager.UI.Detail;

procedure TPresenterDetail.BeforeDestruction();
begin
  try
    if Assigned(FCurrentItems) then
    begin
      FreeAndNil(FCurrentItems);
    end;
  finally
    inherited;
  end;
end;

constructor TPresenterDetail.Create(const aView: IView; const aConnection: TFDConnection; const aCustomers, aDomains, aItems: TStringList; const aItem: IFake);
var
  tmpView: IViewDetail;
begin
  FCustomers := aCustomers;
  FDomains := aDomains;
  FItems := aItems;
  FCurrentFake := aItem;
  inherited Create(aView, aConnection);
  FView.Caption := Format('%s элемента', [IfThen(Assigned(aItem), 'Редактирование', 'Добавление')]);
  if Supports(FView, IViewDetail, tmpView) then
  begin
    tmpView.Item := aItem;
  end;
end;

procedure TPresenterDetail.Initialize();
begin
  inherited;
  Assert(Supports(FView, IViewDetail));
  OnEventSimple(veInitialize);
end;

procedure TPresenterDetail.OnEventSimple(aValue: TViewEnumEvent);
var
  tmpView: IViewDetail;

  procedure LoadCustomers();
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.Customers := FCustomers;
    finally
      FProcessign := False;
    end;
  end;

  procedure LoadDomains();
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.Domains := FDomains;
    finally
      FProcessign := False;
    end;
  end;

  procedure LoadItems(const aDomainId: Integer = -1);
  var
    i: Integer;
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      if not Assigned(FCurrentItems) then
      begin
        FCurrentItems := TStringList.Create();
        FCurrentItems.Sorted := False;
        FCurrentItems.Duplicates := dupAccept;
      end;

      FCurrentItems.Clear();

      for i := 0 to Pred(FItems.Count) do
      begin
        if Integer(FItems.Objects[i]) = aDomainId then
        begin
          FCurrentItems.AddObject(FItems[i], FItems.Objects[i]);
        end;
      end;
      tmpView.Items := FCurrentItems;
    finally
      FProcessign := False;
    end;
  end;

  procedure CancelUpdate();
  begin
    FView.ActionStates[vaCancel] := not FProcessign;
  end;

  procedure SaveUpdate();
  var
    b: Boolean;
  begin
    b := (not FProcessign) and Assigned(FCurrentFake);

    if b then
    begin
      b := (FCurrentFake.CustomerId > -1) and (FCurrentFake.ItemDomainId > -1) and (FCurrentFake.ItemNo > EmptyStr) and (FCurrentFake.Quantity > 0);
    end;

    FView.ActionStates[vaSave] := b;
  end;

  procedure CancelExecute();
  begin
    FView.SetOnEventSimple(nil);
  end;

  procedure CustomerChanged();
  begin
    Supports(tmpView.Item, IFake, FCurrentFake);
  end;

  procedure DomainChanged();
  begin
    Supports(tmpView.Item, IFake, FCurrentFake);

    if Assigned(FCurrentFake) then
    begin
      LoadItems(FCurrentFake.ItemDomainId);
    end;
  end;

  procedure ItemChanged();
  begin
    Supports(tmpView.Item, IFake, FCurrentFake);
  end;

  procedure SaveExecute();
  var
    tmpQuery: TFDQuery;
    tmpResult: Integer;
    tmpMessage: string;
  begin
    FProcessign := True;
    FView.RefreshStates();
    tmpResult := 0;
    tmpMessage := EmptyStr;
    try
      try
        tmpQuery := TFDQuery.Create(nil);
        try
          tmpQuery.Connection := FFDConnection;
          tmpQuery.SQL.Text := TQuery.SpFIManagerMrgFakeItem.Name;
          tmpQuery.ParamByName(TQuery.SpFIManagerMrgFakeItem.Param.ACustomerId).AsInteger := FCurrentFake.CustomerId;
          tmpQuery.ParamByName(TQuery.SpFIManagerMrgFakeItem.Param.aDomainId).AsInteger := FCurrentFake.ItemDomainId;
          tmpQuery.ParamByName(TQuery.SpFIManagerMrgFakeItem.Param.AItemNo).AsString := FCurrentFake.ItemNo;
          tmpQuery.ParamByName(TQuery.SpFIManagerMrgFakeItem.Param.AQuantity).AsInteger := FCurrentFake.Quantity;
          tmpQuery.Open();
          try
            if tmpQuery.RecordCount <> 1 then
            begin
              Exit;
            end;

            tmpResult := tmpQuery.FieldByName(TQuery.SpFIManagerMrgFakeItem.Field.Result).AsInteger;
            tmpMessage := tmpQuery.FieldByName(TQuery.SpFIManagerMrgFakeItem.Field.Message).AsString;
          finally
            tmpQuery.Close();
          end;
        finally
          tmpQuery.Free();
        end;
      finally
        FView.ShowMessage(tmpMessage, IfThen(tmpResult >= 0, QUERY_RESULT_OK, QUERY_RESULT_ERROR));
        FProcessign := False;
      end;
    finally
      FProcessign := False;
    end;
  end;

begin
  if not Supports(FView, IViewDetail, tmpView) then
  begin
    Exit;
  end;

  case aValue of
    veInitialize:
      begin
        LoadCustomers();
        LoadDomains();
      end;
    veSaveExecute:
      SaveExecute();
    veSaveUpdate:
      SaveUpdate();
    veCancelExecute:
      CancelExecute();
    veCancelUpdate:
      CancelUpdate();
    veCustomerChanged:
      CustomerChanged();
    veDomainChanged:
      DomainChanged();
    veItemChanged:
      ItemChanged();
  end;
end;

end.
