unit Budgeting.Logic.Classes.TPresenterMain;

interface

uses
  System.SysUtils,
  // FireDAC.Comp.Client,
  Vcl.Controls,
  Budgeting.Logic.Interfaces.IPresenter,
  Budgeting.Logic.Interfaces.IViewMain,
  Budgeting.Logic.TViewEnumEvent,
  Budgeting.Logic.Classes.TPresenter;

type
  TPresenterMain = class(TPresenter, IPresenter)
  strict private
    FCurrentDocumentId: Integer;
    procedure AboutExecute(const aOwner: TWinControl; const aSplash: Boolean = False);

  strict protected
    procedure OnEventSimple(aValue: TViewEnumEvent); override;
    procedure Initialize(); override;
  end;

implementation

uses
  System.Math,
  System.StrUtils,
  Vcl.Forms,
  Winapi.Windows,
  Data.DB,
  cxGrid,
  Vcl.Dialogs,
  Winapi.ShellApi,
  cxGridExportLink,
  Budgeting.Logic.TViewEnumAction,
  AboutPackage.Logic.TAboutWindow,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  Budgeting.Logic.Classes.Configuration.Section.TInterface,
  // Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection,
  LoginPackage.Logic.TLoginWindow,
  Budgeting.Logic.Consts,
  Budgeting.Logic.Classes.TQuery,
  FireDAC.Comp.Client;
// Budgeting.Logic.Classes.TPresenterDetail,
// Budgeting.Logic.Classes.TQuery,
// Budgeting.UI.Detail;

resourcestring
  RsResultDefaultExt = 'xlsx';
  RsResultFilters = 'Документ Excel (*.xlsx)|*.xlsx|Все файлы (*.*)|*.*';
  RsResultTitle = 'Введите имя файла для сохранения результатов...';
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';
  RsHelpNotFound = 'Файл справки к программе [%s] не найден.';

procedure TPresenterMain.Initialize();
var
  tmpView: IViewMain;
begin
  inherited;
  FCurrentDocumentId := -1;
  if Supports(FView, IViewMain, tmpView) then
  begin
    FCurrentDocumentId := tmpView.CurrentDocumentId;

    if TConfiguration.Get(TConfiguration).Section<TInterface>.EnableSplashAtStart then
    begin
      AboutExecute(tmpView.Control, True);
    end;
  end;
end;

procedure TPresenterMain.AboutExecute(const aOwner: TWinControl; const aSplash: Boolean = False);
var
  tmpAbout: TAboutWindow;
begin
  tmpAbout := TAboutWindow.Create(aOwner);
  try
    tmpAbout.EMail := 'caster1977@yandex.ru';
    tmpAbout.Show(aSplash);
  finally
    tmpAbout.Free();
  end;
end;

procedure TPresenterMain.OnEventSimple(aValue: TViewEnumEvent);
var
  tmpView: IViewMain;

  procedure LoadAccountingCenters();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_accounting_centers_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_accounting_centers_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.AccountingCenters := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadBanks();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_banks_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_banks_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Banks := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadBudgetItems();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_budget_items_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_budget_items_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.BudgetItems := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadBudgetItemTypes();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_budget_item_types_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_budget_item_types_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.BudgetItemTypes := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadCosignatories();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_cosignatories_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_cosignatories_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Cosignatories := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadCurrencies();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_currencies_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_currencies_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Currencies := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadGoods();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_goods_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_goods_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_goods_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.Goods := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;

  procedure LoadGoodsTypes();
  var
    tmpQuery: TFDQuery;
  begin
    tmpQuery := TFDQuery.Create(nil);
    try
      tmpQuery.Connection := FConnection;
      tmpQuery.SQL.Text := TQuery.sp_goods_types_sel.Name;
      tmpQuery.ParamByName(TQuery.sp_goods_types_sel.Param.Id).DataType := ftInteger;
      tmpQuery.ParamByName(TQuery.sp_goods_types_sel.Param.Activity).DataType := ftBoolean;
      tmpQuery.Open();
      try
        tmpView.ShowProgress('Загрузка списка...', tmpQuery.RecordCount);
        tmpView.GoodsTypes := tmpQuery;
      finally
        tmpQuery.Close();
      end;
    finally
      tmpQuery.Free();
    end;
  end;


  procedure RefreshExecute(aValue: TViewEnumEvent);
  begin
    FProcessign := True;
    tmpView.RefreshStates();
    try
      tmpView.ShowProgress('Обновление списка...');
      try
        case aValue of
          veRefreshAccountingCentersExecute:
            LoadAccountingCenters();
          veRefreshBanksExecute:
            LoadBanks();
          veRefreshBudgetItemsExecute:
            LoadBudgetItems();
          veRefreshBudgetItemTypesExecute:
            LoadBudgetItemTypes();
          veRefreshCosignatoriesExecute:
            LoadCosignatories();
          veRefreshCurrenciesExecute:
            LoadCurrencies();
          veRefreshGoodsExecute:
            LoadGoods();
          veRefreshGoodsTypesExecute:
            LoadGoodsTypes();
        end;

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

  procedure QuitUpdate();
  begin
    tmpView.ActionStates[vaCloseQuery] := not FProcessign;
  end;

  procedure CloseQuery();
  begin
    if TConfiguration.Get(TConfiguration).Section<TInterface>.EnableQuitConfirmation then
    begin
      tmpView.ActionStates[vaCloseQuery] := MessageBox(tmpView.Control.Handle, PWideChar(RsExitConfirmationMessage),
        PWideChar(Format(RsExitConfirmationCaption, [Application.MainForm.Caption])), MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDYES;
    end;
  end;

  procedure ConfigurationExecute();
  begin
    (* var
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
      end; *)
    { TODO : дописать }
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
  begin
    ExportExcel(tmpView.GetActiveGrid());
  end;

  procedure ExportToExcelUpdate();
  begin
    tmpView.ActionStates[vaExportToExcel] := not FProcessign;
    { TODO : дописать }
    // and (FCurrentDocumentId > -1);;
    // Result := FGridTableViewResult.DataController.RecordCount > 0;
  end;

{ procedure HistoryExecute();
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
  end; }

  procedure HelpContextExecute();
  begin
    if not FileExists(Application.HelpFile) then
    begin
      tmpView.ShowMessage(Format(RsHelpNotFound, [Application.HelpFile]), MESSAGE_TYPE_ERROR);
      Exit;
    end;

    Application.HelpShowTableOfContents();
  end;

  procedure HelpContextUpdate();
  begin
    tmpView.ActionStates[vaHelpContext] := not FProcessign;
  end;

  procedure AboutUpdate();
  begin
    tmpView.ActionStates[vaAbout] := not FProcessign;
  end;

  procedure StatusBarExecute();
  var
    b: Boolean;
  begin
    b := not TConfiguration.Get(TConfiguration).Section<TInterface>.EnableStatusbar;
    TConfiguration.Get(TConfiguration).Section<TInterface>.EnableStatusbar := b;
    tmpView.EnableStatusbar := b;
  end;

  procedure ToolBarExecute();
  var
    b: Boolean;
  begin
    b := not TConfiguration.Get(TConfiguration).Section<TInterface>.EnableToolbar;
    TConfiguration.Get(TConfiguration).Section<TInterface>.EnableToolbar := b;
    tmpView.EnableToolbar := b;
  end;

  procedure ConnectExecute();
  var
    tmpLoginWindow: TLoginWindow;
  begin
    tmpLoginWindow := TLoginWindow.Create(tmpView.Control);
    try
      tmpLoginWindow.Login := TConfiguration.Get(TConfiguration).Section<TInterface>.Login;
      tmpLoginWindow.Password := TConfiguration.Get(TConfiguration).Section<TInterface>.Password;
      if not TConfiguration.Get(TConfiguration).Section<TInterface>.EnableAutoLogon then
      begin
        if tmpLoginWindow.Execute() then
        begin
          TConfiguration.Get(TConfiguration).Section<TInterface>.Login := IfThen(TConfiguration.Get(TConfiguration).Section<TInterface>.EnableStoreLogin,
            tmpLoginWindow.Login);
          TConfiguration.Get(TConfiguration).Section<TInterface>.Password := IfThen(TConfiguration.Get(TConfiguration).Section<TInterface>.EnableStorePassword,
            tmpLoginWindow.Password);
        end;
      end
      else
      begin
        Exit;
      end;
    finally
      tmpLoginWindow.Free();
    end;
  end;

  procedure ConnectUpdate();
  begin
    tmpView.ActionStates[vaConnect] := not FProcessign; // и не соединено
    { TODO : дописать }
  end;

  procedure AddExecute();
  begin
  end;

  procedure AddUpdate();
  begin
    tmpView.ActionStates[vaAdd] := not FProcessign;
  end;

  procedure EditExecute();
  begin
  end;

  procedure EditUpdate();
  begin
    tmpView.ActionStates[vaEdit] := not FProcessign;
  end;

  procedure DeleteExecute();
  begin
  end;

  procedure DeleteUpdate();
  begin
    tmpView.ActionStates[vaDelete] := not FProcessign;
  end;

  procedure DisconnectExecute();
  begin
  end;

  procedure DisconnectUpdate();
  begin
    tmpView.ActionStates[vaDisconnect] := not FProcessign;
  end;

begin
  if not Supports(FView, IViewMain, tmpView) then
  begin
    Exit;
  end;

  case aValue of
    veCloseQuery:
      CloseQuery();
    veQuitUpdate:
      QuitUpdate();
    veConfigurationExecute:
      ConfigurationExecute();
    veConfigurationUpdate:
      ConfigurationUpdate();
    veRefreshAccountingCentersExecute, veRefreshBanksExecute, veRefreshBudgetItemsExecute, veRefreshBudgetItemTypesExecute, veRefreshCosignatoriesExecute,
      veRefreshCurrenciesExecute, veRefreshGoodsExecute, veRefreshGoodsTypesExecute:
      RefreshExecute(aValue);
    veRefreshUpdate:
      RefreshUpdate();
    veExportToExcelExecute:
      ExportToExcelExecute();
    veExportToExcelUpdate:
      ExportToExcelUpdate();
    veHelpContextExecute:
      HelpContextExecute();
    veHelpContextUpdate:
      HelpContextUpdate();
    veSelectedRecordChanged:
      SelectedRecordChanged();
    veAboutExecute:
      AboutExecute(tmpView.Control);
    veAboutUpdate:
      AboutUpdate();
    veStatusBarExecute:
      StatusBarExecute();
    veToolBarExecute:
      ToolBarExecute();
    veConnectExecute:
      ConnectExecute();
    veConnectUpdate:
      ConnectUpdate();
    veDisconnectExecute:
      DisconnectExecute();
    veDisconnectUpdate:
      DisconnectUpdate();
    veAddExecute:
      AddExecute();
    veAddUpdate:
      AddUpdate();
    veEditExecute:
      EditExecute();
    veEditUpdate:
      EditUpdate();
    veDeleteExecute:
      DeleteExecute();
    veDeleteUpdate:
      DeleteUpdate();
  end;
end;

{
  var
  b: Boolean;
  i: Integer;
  tmpStartTime: TDateTime;
  tmpStopTime: TDateTime;
  dt: TDateTime;
  d, h, n, s, ms: word;
  sh: word;

  try
  FProcessing := True;
  for i := 0 to Pred(actlstMain.ActionCount) do
  begin
  actlstMain.Actions[i].Update();
  Application.ProcessMessages();
  StatusBar.SimplePanelStyle.Text := 'Пожалуйста, подождите...';
  end;

  tmpStartTime := Now();

  try
  b := FLogic.Process();
  finally
  FProcessing := False;
  end;
  if b then
  begin
  tmpStopTime := Now();
  StatusBar.SimplePanelStyle.Text := EmptyStr;

  dt := tmpStopTime - tmpStartTime;
  d := DaysBetween(dt, 0);
  DecodeTime(dt, h, n, s, ms);
  sh := d * 24 + h;
  MessageBox(Handle, PWideChar(Format('Действие выполнено успешно. Затраченное время: %s',
  [Format('%d:%2d:%2d', [sh, n, s]).Replace(' ', '0', [rfReplaceAll])])), PWideChar(Format(RsInfoCaption, [Caption])), MESSAGE_TYPE_OK);
  end;
  except
  on e: Exception do
  begin
  MessageBox(Handle, PWideChar(e.ToString()), PWideChar(Format(RsErrorCaption, [Caption])), MESSAGE_TYPE_ERROR);
  end;
  end; }

// procedure TMainForm.actLoadListExecute(Sender: TObject);
// var
// b: Boolean;
// i: Integer;
// tmpStartTime: TDateTime;
// tmpStopTime: TDateTime;
// dt: TDateTime;
// d, h, n, s, ms: word;
// sh: word;
// begin
{ if not Assigned(FLogic) then
  begin
  Exit();
  end;

  try
  FProcessing := True;
  for i := 0 to Pred(actlstMain.ActionCount) do
  begin
  actlstMain.Actions[i].Update();
  Application.ProcessMessages();
  StatusBar.SimplePanelStyle.Text := 'Пожалуйста, подождите...';
  end;

  tmpStartTime := Now();

  try
  b := FLogic.LoadList();
  finally
  FProcessing := False;
  end;
  if b then
  begin
  tmpStopTime := Now();
  StatusBar.SimplePanelStyle.Text := EmptyStr;

  dt := tmpStopTime - tmpStartTime;
  d := DaysBetween(dt, 0);
  DecodeTime(dt, h, n, s, ms);
  sh := d * 24 + h;
  MessageBox(Handle, PWideChar(Format('Действие выполнено успешно. Затраченное время: %s',
  [Format('%d:%2d:%2d', [sh, n, s]).Replace(' ', '0', [rfReplaceAll])])), PWideChar(Format(RsInfoCaption, [Caption])), MESSAGE_TYPE_OK);
  end;
  except
  on e: Exception do
  begin
  MessageBox(Handle, PWideChar(e.ToString()), PWideChar(Format(RsErrorCaption, [Caption])), MESSAGE_TYPE_ERROR);
  end;
  end; }

end.
