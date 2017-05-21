unit Budgeting.Logic.Classes.TPresenterMain;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  Budgeting.Logic.Interfaces.IPresenter,
  Budgeting.Logic.Interfaces.IViewMain,
  Budgeting.Logic.TViewEnumEvent,
  Budgeting.Logic.Classes.TPresenter;

type
  TPresenterMain = class(TPresenter, IPresenter)
//  strict private
//    FCurrentDocumentId: Integer;
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
  cxGrid,
  Vcl.Dialogs,
  Winapi.ShellApi,
  Vcl.Controls,
  cxGridExportLink,
  Budgeting.Logic.TViewEnumAction,
  Budgeting.Logic.Consts;
//  Budgeting.Logic.Classes.TPresenterDetail,
//  Budgeting.Logic.Classes.TQuery,
//  Budgeting.UI.Detail;

resourcestring
  RsResultDefaultExt = 'xlsx';
  RsResultFilters = 'Документ Excel (*.xlsx)|*.xlsx|Все файлы (*.*)|*.*';
  RsResultTitle = 'Введите имя файла для сохранения результатов...';

procedure TPresenterMain.Initialize();
var
  tmpView: IViewMain;
begin
  inherited;
//  FCurrentDocumentId := -1;
  if Supports(FView, IViewMain, tmpView) then
  begin
//    FCurrentDocumentId := tmpView.CurrentDocumentId;
  end;
end;

procedure TPresenterMain.OnEventSimple(aValue: TViewEnumEvent);
var
  tmpView: IViewMain;

  {procedure LoadQueueReciever();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FFDConnection;
      tmpQuery.SQL.Text := TQuery.SpStatusViewerStatusMessageSel.Name;
      tmpQuery.ParamByName(TQuery.SpStatusViewerStatusMessageSel.Param.AOrderCode).AsString := tmpView.OrderCode;
      tmpQuery.ParamByName(TQuery.SpStatusViewerStatusMessageSel.Param.ABeginDate).AsDateTime := tmpView.BeginDate;
      tmpQuery.ParamByName(TQuery.SpStatusViewerStatusMessageSel.Param.AEndDate).AsDateTime := tmpView.EndDate;
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
  end;}

  procedure RefreshExecute();
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.ShowProgress('Обновление списка...');
      try
//        LoadQueueReciever();
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
//    FCurrentDocumentId := tmpView.CurrentDocumentId;
  end;

  procedure QuitUpdate();
  begin
    tmpView.ActionStates[vaQuit] := not FProcessign;// and (FCurrentDocumentId > -1);
  end;

  procedure QuitExecute();
  var
    tmpView: IViewMain;
  begin
    if Supports(FView, IViewMain, tmpView) then
    begin
      tmpView.Close();
    end;
  end;

  procedure ConfigurationExecute();
  var
    tmpView: IViewMain;
  begin
    if Supports(FView, IViewMain, tmpView) then
    begin
(*var
  tmpForm: TForm;
begin
  tmpForm := TConfigurationForm.Create(Owner, nil, 0 { Configuration, Configuration.CurrentPage } );
  try
    { Result := } tmpForm.ShowModal { = mrOk };
  finally
    tmpForm.Free();
  end;
  { if not FLogic.ShowConfigurationForm() then
    begin
    Exit;
    end;
    ApplyConfiguration(); }
end;*)
      { TODO : дописать }
    end;
  end;

  procedure ConfigurationUpdate();
  begin
    tmpView.ActionStates[vaConfiguration] := not FProcessign;
  end;

  procedure ExportExcel(const aGrid: TcxGrid);
  var
    tmpExecInfo: TShellExecuteInfo;
    tmpForm: TSaveDialog;
    old_cursor: TCursor;
  begin
    tmpForm := TSaveDialog.Create(FView.Control);
    try
      tmpForm.DefaultExt := RsResultDefaultExt;
      tmpForm.Filter := RsResultFilters;
      tmpForm.Options := tmpForm.Options + [ofOverwritePrompt, ofPathMustExist, ofNoReadOnlyReturn];
      tmpForm.Title := RsResultTitle;
      tmpForm.FilterIndex := 1;

      if not tmpForm.Execute(FView.Control.Handle) then
      begin
        Exit;
      end;
      old_cursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        ExportGridToXLSX(tmpForm.FileName, aGrid);
        if FView.ShowMessage('Открыть сохранённый файл?', MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDYES then
        begin
          ZeroMemory(@tmpExecInfo, SizeOf(tmpExecInfo));
          tmpExecInfo.cbSize := SizeOf(TShellExecuteInfo);
          tmpExecInfo.lpVerb := 'open';
          tmpExecInfo.lpFile := PChar(tmpForm.FileName);
          tmpExecInfo.nShow := SW_SHOWNORMAL;
          ShellExecuteEx(@tmpExecInfo);
        end;
      finally
        Screen.Cursor := old_cursor;
      end;
    finally
      tmpForm.Free();
    end;
  end;

  procedure ExportToExcelExecute();
  var
    tmpView: IViewMain;
  begin
    if Supports(FView, IViewMain, tmpView) then
    begin
      { TODO : дописать }
      ExportExcel(tmpView.GetActiveGrid());
    end;
  end;

  procedure ExportToExcelUpdate();
  begin
    tmpView.ActionStates[vaExportToExcel] := not FProcessign;
    { TODO : дописать }
    //Result := FGridTableViewResult.DataController.RecordCount > 0;
  end;

  {procedure HistoryExecute();
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
  end;}

begin
  if not Supports(FView, IViewMain, tmpView) then
  begin
    Exit;
  end;

  case aValue of
    veQuitExecute:
      QuitExecute();
    veQuitUpdate:
      QuitUpdate();
    veConfigurationExecute:
      ConfigurationExecute();
    veConfigurationUpdate:
      ConfigurationUpdate();
    veRefreshExecute:
      RefreshExecute();
    veRefreshUpdate:
      RefreshUpdate();
    veExportToExcelExecute:
      ExportToExcelExecute();
    veExportToExcelUpdate:
      ExportToExcelUpdate();
//    veSelectedRecordChanged:
//      SelectedRecordChanged();
  end;
end;

end.
