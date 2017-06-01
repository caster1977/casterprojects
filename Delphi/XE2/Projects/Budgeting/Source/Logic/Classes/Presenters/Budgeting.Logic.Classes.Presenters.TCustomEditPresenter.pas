unit Budgeting.Logic.Classes.Presenters.TCustomEditPresenter;

interface

uses
  FireDAC.Comp.Client,
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Classes.Presenters.TCustomPresenter,
  Budgeting.Logic.Types.TViewEnumEvent,
  Budgeting.Logic.Interfaces.Views.ICustomView,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter;

type
  TCustomEditPresenter = class(TCustomPresenter, ICustomPresenter)
  strict protected
    FItem: ICustomModel;
    FEditMode: Boolean;
    FTag: Integer;
    procedure Initialize(); override;
    procedure ItemChanged(); virtual; final;
    procedure CancelExecute; virtual; final;
    procedure CancelUpdate(); virtual; final;
    procedure SaveExecute(); virtual; final;
    procedure SaveUpdate(); virtual; final;
    function CheckItem(): Boolean; virtual; abstract;
    procedure BeforeQueryOpen(const aQuery: TFDQuery); virtual; abstract;
    procedure OnEventSimple(aValue: TViewEnumEvent); override;

  public
    constructor Create(const aView: ICustomView; const aItem: ICustomModel; const aTag: Integer = -1); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.Math,
  Budgeting.Logic.Consts,
  Budgeting.Logic.Classes.TQuery,
  Budgeting.Logic.Types.TViewEnumAction,
  Budgeting.Logic.Interfaces.Views.ICustomEditView;

constructor TCustomEditPresenter.Create(const aView: ICustomView; const aItem: ICustomModel; const aTag: Integer);
begin
  FEditMode := Assigned(aItem);
  FItem := aItem;
  FTag := aTag;
  inherited Create(aView);
  FView.SetCaption(Format('%s элемента', [IfThen(FEditMode, 'Редактирование', 'Добавление')]));
end;

procedure TCustomEditPresenter.Initialize();
var
  tmpView: ICustomEditView;
begin
  if Supports(FView, ICustomEditView, tmpView) then
  begin
    tmpView.Item := FItem;
  end;
end;

procedure TCustomEditPresenter.ItemChanged();
var
  tmpView: ICustomEditView;
begin
  if Supports(FView, ICustomEditView, tmpView) then
  begin
    Supports(tmpView.Item, ICustomModel, FItem);
  end;
end;

procedure TCustomEditPresenter.SaveUpdate();
var
  b: Boolean;
begin
  b := (not FProcessign) and Assigned(FItem);

  if b then
  begin
    b := CheckItem();
  end;

  FView.ActionStates[vaSave] := b;
end;

procedure TCustomEditPresenter.CancelExecute();
begin
end;

procedure TCustomEditPresenter.CancelUpdate();
begin
  FView.ActionStates[vaCancel] := not FProcessign;
end;

procedure TCustomEditPresenter.SaveExecute();
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
        tmpQuery.Connection := FConnection;
        BeforeQueryOpen(tmpQuery);
        tmpQuery.Open();
        try
          if tmpQuery.RecordCount <> 1 then
          begin
            Exit;
          end;

          tmpResult := tmpQuery.FieldByName(TQuery.sp_xxx_upd.Field.Result).AsInteger;
          tmpMessage := tmpQuery.FieldByName(TQuery.sp_xxx_upd.Field.Message).AsString;
        finally
          tmpQuery.Close();
        end;
      finally
        tmpQuery.Free();
      end;
    finally
      if tmpResult < 0 then
      begin
        FView.ShowMessage(tmpMessage, MESSAGE_TYPE_ERROR);
      end;
    end;
  finally
    FProcessign := False;
  end;
end;

procedure TCustomEditPresenter.OnEventSimple(aValue: TViewEnumEvent);
begin
  case aValue of
    veInitialization:
      Initialize();
    veSaveExecute:
      SaveExecute();
    veSaveUpdate:
      SaveUpdate();
    veCancelExecute:
      CancelExecute();
    veCancelUpdate:
      CancelUpdate();
    veItemChanged:
      ItemChanged();
  end;
end;

end.
