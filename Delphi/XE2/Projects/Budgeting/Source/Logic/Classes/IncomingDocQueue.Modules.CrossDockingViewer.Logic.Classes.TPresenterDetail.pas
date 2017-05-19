unit IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TPresenterDetail;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Classes,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IPresenter,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TPresenter,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IViewDetail,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IView,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumEvent;

type
  TPresenterDetail = class(TPresenter, IPresenter)
  strict private
    FDocumentId: Integer;
  strict protected
    procedure OnEventSimple(aValue: TViewEnumEvent); override;
    procedure Initialize(); override;
  public
    constructor Create(const aView: IView; const aConnection: TFDConnection; const aDocumentId: Integer); reintroduce; virtual;
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
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumAction,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TQuery,
  IncomingDocQueue.Modules.CrossDockingViewer.UI.Detail;

constructor TPresenterDetail.Create(const aView: IView;
  const aConnection: TFDConnection; const aDocumentId: Integer);
begin
  FDocumentId := aDocumentId;
  inherited Create(aView, aConnection);
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

  procedure LoadHistory();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FFDConnection;
      tmpQuery.SQL.Text := TQuery.SpCrossDockingViewerCrossDockingHistorySel.Name;
      tmpQuery.ParamByName(TQuery.SpCrossDockingViewerCrossDockingHistorySel.Param.AStatusMessageId).AsInteger := FDocumentId;
      tmpQuery.Open();
      try
        tmpView.List := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure CloseUpdate();
  begin
    tmpView.ActionStates[vaClose] := not FProcessign;
  end;

  procedure CloseExecute();
  begin
    tmpView.SetOnEventSimple(nil);
  end;

begin
  if not Supports(FView, IViewDetail, tmpView) then
  begin
    Exit;
  end;

  case aValue of
    veInitialize:
      LoadHistory();
    veCloseExecute:
      CloseExecute();
    veCloseUpdate:
      CloseUpdate();
  end;
end;

end.
