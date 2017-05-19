unit IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TPresenterMain;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IPresenter,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IViewMain,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumEvent,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TPresenter,
  IncomingDocQueue.Modules.CrossDockingViewer.UI.Detail;

type
  TPresenterMain = class(TPresenter, IPresenter)
  strict private
    FCurrentDocumentId: Integer;
  strict protected
    procedure OnEventSimple(aValue: TViewEnumEvent); override;
    procedure Initialize(); override;
  end;

implementation

uses
  System.Math,
  Vcl.Forms,
  Winapi.Windows,
  Data.DB,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumAction,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TPresenterDetail,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TQuery;

procedure TPresenterMain.Initialize();
var
  tmpView: IViewMain;
begin
  inherited;
  FCurrentDocumentId := -1;
  if Supports(FView, IViewMain, tmpView) then
  begin
    FCurrentDocumentId := tmpView.CurrentDocumentId;
  end;
end;

procedure TPresenterMain.OnEventSimple(aValue: TViewEnumEvent);
var
  tmpView: IViewMain;

  procedure LoadQueueReciever();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FFDConnection;
      tmpQuery.SQL.Text := TQuery.SpCrossDockingViewerCrossDockingSel.Name;
      tmpQuery.ParamByName(TQuery.SpCrossDockingViewerCrossDockingSel.Param.AOrderCode).AsString := tmpView.OrderCode;
      tmpQuery.ParamByName(TQuery.SpCrossDockingViewerCrossDockingSel.Param.ABeginDate).AsDateTime := tmpView.BeginDate;
      tmpQuery.ParamByName(TQuery.SpCrossDockingViewerCrossDockingSel.Param.AEndDate).AsDateTime := tmpView.EndDate;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Queue := tmpQuery;
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
      tmpView.ShowProgress('Обновление списка...');
      try
        LoadQueueReciever();
      finally
        FProcessign := False;
      end;
    finally
      tmpView.HideProgress();
    end;
  end;

  procedure RefreshUpdate();
  begin
    tmpView.ActionStates[vaRefresh] := not FProcessign;
  end;

  procedure SelectedRecordChanged();
  begin
    FCurrentDocumentId := tmpView.CurrentDocumentId;
  end;

  procedure HistoryUpdate();
  begin
    tmpView.ActionStates[vaHistory] := (not FProcessign) and (FCurrentDocumentId > -1);
  end;

  procedure HistoryExecute();
  var
    tmpForm: TfrmDetail;
    tmpPresenter: IPresenter;
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.ShowProgress('Просмотр истории...');
      try
        tmpForm := TfrmDetail.Create(nil);
        try
          tmpPresenter := TPresenterDetail.Create(tmpForm, FFDConnection, tmpView.CurrentDocumentId);
          if not Assigned(tmpPresenter) then
          begin
            Exit;
          end;
          tmpForm.ShowModal();
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

begin
  if not Supports(FView, IViewMain, tmpView) then
  begin
    Exit;
  end;

  case aValue of
    veHistoryExecute:
      HistoryExecute();
    veHistoryUpdate:
      HistoryUpdate();
    veRefreshExecute:
      RefreshExecute();
    veRefreshUpdate:
      RefreshUpdate();
    veSelectedRecordChanged:
      SelectedRecordChanged();
  end;
end;

end.
