unit Budgeting.UI.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  Data.DB,
  cxDBData,
  cxContainer,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxLabel,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  Vcl.ExtCtrls,
  cxSplitter,
  Vcl.ImgList,
  dxBar,
  dxStatusBar,
  System.Actions,
  Vcl.ActnList,
  AboutPackage.Logic.TAboutWindow,
  AboutPackage.Logic.TGSFileVersionInfo,
  Vcl.Menus,
  cxHyperLinkEdit,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  Vcl.OleCtnrs,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup,
  dxSkinsCore,
  dxSkinBlack,
  dxSkinBlue,
  dxSkinBlueprint,
  dxSkinCaramel,
  dxSkinCoffee,
  dxSkinDarkRoom,
  dxSkinDarkSide,
  dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  dxSkinFoggy,
  dxSkinGlassOceans,
  dxSkinHighContrast,
  dxSkiniMaginary,
  dxSkinLilian,
  dxSkinLiquidSky,
  dxSkinLondonLiquidSky,
  dxSkinMcSkin,
  dxSkinMetropolis,
  dxSkinMetropolisDark,
  dxSkinMoneyTwins,
  dxSkinOffice2007Black,
  dxSkinOffice2007Blue,
  dxSkinOffice2007Green,
  dxSkinOffice2007Pink,
  dxSkinOffice2007Silver,
  dxSkinOffice2010Black,
  dxSkinOffice2010Blue,
  dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray,
  dxSkinOffice2013White,
  dxSkinPumpkin,
  dxSkinSeven,
  dxSkinSevenClassic,
  dxSkinSharp,
  dxSkinSharpPlus,
  dxSkinSilver,
  dxSkinSpringTime,
  dxSkinStardust,
  dxSkinSummer2008,
  dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters,
  dxSkinValentine,
  dxSkinVS2010,
  dxSkinWhiteprint,
  dxSkinXmas2008Blue,
  dxSkinsdxStatusBarPainter,
  dxSkinscxPCPainter,
  dxSkinsdxBarPainter,
  cxImageComboBox,
  cxCurrencyEdit,
  cxCalendar,
  cxCalc, dxBarBuiltInMenu, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxPC,
  LoginPackage.Logic.TLoginWindow,
  Budgeting.Logic.Interfaces.IView,
  Budgeting.Logic.Interfaces.IViewMain,
  Budgeting.Logic.TViewEnumActionArray,
  Budgeting.Logic.TViewEnumAction,
  Budgeting.Logic.TViewEnumEvent,
  cxProgressBar, cxBarEditItem;

type
  TMainForm = class(TForm, IView, IViewMain)
    actQuit: TAction;
    actFile: TAction;
    actHelp: TAction;
    actHelpContext: TAction;
    actAbout: TAction;
    actStatusBar: TAction;
    actToolBar: TAction;
    actView: TAction;
    actAction: TAction;
    StatusBar: TdxStatusBar;
    dxbrmngrMain: TdxBarManager;
    cxmglstActions: TcxImageList;
    actlstMain: TActionList;
    actConfiguration: TAction;
    AboutWindow: TAboutWindow;
    gsflvrsnfMain: TGSFileVersionInfo;
    mmMain: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    dxbrToolBar: TdxBar;
    btnQuit: TdxBarButton;
    btnHelpContext: TdxBarButton;
    btnAbout: TdxBarButton;
    cxgrdFiles: TcxGrid;
    cxgrdtblvwFiles: TcxGridTableView;
    colFileName: TcxGridColumn;
    cxgrdlvl2: TcxGridLevel;
    pctnbrMain: TPopupActionBar;
    N21: TMenuItem;
    N15: TMenuItem;
    N22: TMenuItem;
    N18: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    btnConfiguration: TdxBarButton;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    colId: TcxGridColumn;
    colSeries: TcxGridColumn;
    colNumber: TcxGridColumn;
    colType: TcxGridColumn;
    colStatus: TcxGridColumn;
    actExportToExcel: TAction;
    btnExcel: TdxBarButton;
    N19: TMenuItem;
    btnConnect: TdxBarButton;
    actConnect: TAction;
    actDisconnect: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefresh: TAction;
    cxpgcntrlMain: TcxPageControl;
    cxtbshtExports: TcxTabSheet;
    cxtbshtReferences: TcxTabSheet;
    cbbReferences: TcxComboBox;
    cxgrdReferences: TcxGrid;
    shtReports: TcxTabSheet;
    btn1: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    LoginWindow: TLoginWindow;
    cxbrdtmProgress: TcxBarEditItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N20: TMenuItem;
    N31: TMenuItem;
    tblvAccountingCenters: TcxGridTableView;
    tblvBanks: TcxGridTableView;
    tblvBudgetItems: TcxGridTableView;
    tblvBudgetItemTypes: TcxGridTableView;
    tblvCosignatories: TcxGridTableView;
    tblvCurrencies: TcxGridTableView;
    tblvGoods: TcxGridTableView;
    tblvGoodsTypes: TcxGridTableView;
    tblvUsers: TcxGridTableView;
    lvl1: TcxGridLevel;
    procedure actQuitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actAboutExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actStatusBarExecute(Sender: TObject);
    procedure actToolBarExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actActionExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actHelpContextExecute(Sender: TObject);
    procedure actAddUpdate(Sender: TObject);
    procedure actQuitUpdate(Sender: TObject);
    procedure actAboutUpdate(Sender: TObject);
    procedure actHelpContextUpdate(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure actLoadListExecute(Sender: TObject);
    procedure actExportToExcelUpdate(Sender: TObject);
    procedure actExportToExcelExecute(Sender: TObject);
    procedure actLoadListUpdate(Sender: TObject);
    procedure actConfigurationUpdate(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actFileExecute(Sender: TObject);

  strict private
    FProcessing: Boolean;
    FOnEventSimple: TProc<TViewEnumEvent>;
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;

    procedure ApplyConfiguration();
    function ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;
    function GetControl: TWinControl;
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    procedure ShowProgress(const aTitle: string; const aMax: Integer);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress();
    procedure RefreshStates();
    procedure StorePresenter(const aPresenter: IInterface);
    function GetConnection(const aConnectionString: string): TCustomConnection;
    function GetActiveGrid(): TcxGrid;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  CodesiteLogging,
  FireDAC.Comp.Client,
  FireDAC.Stan.ASync,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  System.DateUtils,
  Budgeting.Logic.Consts,
  Budgeting.UI.Configuration;

procedure TMainForm.actAboutUpdate(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actActionExecute(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actHelpExecute(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actLoadListExecute(Sender: TObject);
var
  b: Boolean;
  i: Integer;
  tmpStartTime: TDateTime;
  tmpStopTime: TDateTime;
  dt: TDateTime;
  d, h, n, s, ms: word;
  sh: word;
begin
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
end;

procedure TMainForm.actLoadListUpdate(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actHelpContextExecute(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actHelpContextUpdate(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutWindow.Show();
end;

procedure TMainForm.actQuitExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veQuitExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actQuitUpdate(Sender: TObject);
begin
  FOnEventSimple(veQuitUpdate);
  (Sender as TAction).Enabled := FActionStates[vaQuit];
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veConfigurationExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actConfigurationUpdate(Sender: TObject);
begin
  FOnEventSimple(veConfigurationUpdate);
  (Sender as TAction).Enabled := FActionStates[vaConfiguration];
end;

procedure TMainForm.actConnectExecute(Sender: TObject);
begin
  LoginWindow.Login := ''; // Configuration.Section<TConnection>.Login;
  LoginWindow.Password := ''; // Configuration.Section<TConnection>.Password;

  // if not Configuration.Section<TConnection>.EnableAutoLogon then
  begin
    if LoginWindow.Execute then
    begin
      // Configuration.Section<TConnection>.Login := IfThen(Configuration.Section<TConnection>.EnableStoreLogin, LoginWindow.Login);
      // Configuration.Section<TConnection>.Password := IfThen(Configuration.Section<TConnection>.EnableStorePassword, LoginWindow.Password);
    end
    else
    begin
      Exit;
    end;
  end;
end;

procedure TMainForm.actExportToExcelExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veExportToExcelExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actExportToExcelUpdate(Sender: TObject);
begin
  FOnEventSimple(veExportToExcelUpdate);
  (Sender as TAction).Enabled := FActionStates[vaExportToExcel];
end;

procedure TMainForm.actFileExecute(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actAddExecute(Sender: TObject);
var
  b: Boolean;
  i: Integer;
  tmpStartTime: TDateTime;
  tmpStopTime: TDateTime;
  dt: TDateTime;
  d, h, n, s, ms: word;
  sh: word;
begin
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
end;

procedure TMainForm.actAddUpdate(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.actStatusBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actStatusBar.Checked;

  if StatusBar.Visible <> b then
  begin
    StatusBar.Visible := b;
  end;

  { if not Assigned(FLogic) then
    begin
    Exit;
    end;

    FLogic.EnableStatusbar := b; }
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actToolBar.Checked;

  if dxbrToolBar.Visible <> b then
  begin
    dxbrToolBar.Visible := b;
  end;

  { if not Assigned(FLogic) then
    begin
    Exit;
    end;

    FLogic.EnableToolbar := b; }
end;

procedure TMainForm.actViewExecute(Sender: TObject);
begin
  // заглушка
end;

procedure TMainForm.ApplyConfiguration();
var
  b: Boolean;
begin
  { if not Assigned(FLogic) then
    begin
    Exit;
    end;

    b := FLogic.EnableStatusbar;
    actStatusBar.Checked := b;
    StatusBar.Visible := b;

    b := FLogic.EnableToolbar;
    actToolBar.Checked := b;
    dxbrToolBar.Visible := b; }
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;

  { if not Assigned(FLogic) then
    begin
    Exit;
    end;

    CanClose := FLogic.CloseQuery(); }
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // FLogic := TMainFormBusinessLogic.Create(Self, cxgrdtblvwFiles, cxgrdtblvwResult);
  FProcessing := False;

  gsflvrsnfMain.Filename := Application.ExeName;
  Caption := gsflvrsnfMain.InternalName;
  Application.HelpFile := ChangeFileExt(Application.ExeName, '.hlp');

  ApplyConfiguration();

  { if not Assigned(FLogic) then
    begin
    Exit;
    end;

    if FLogic.EnableSplashAtStart then
    begin }
  AboutWindow.Show(True);
  // end;
end;

function TMainForm.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

function TMainForm.GetActiveGrid(): TcxGrid;
begin
  Result := cxgrdReferences;
  { TODO : дописать }
end;

function TMainForm.GetConnection(
  const aConnectionString: string): TCustomConnection;
var
  tmpConnection: TFDConnection;
begin
  {$IFDEF DEBUG}
  Result := nil;
  CodeSite.EnterMethod(Self, 'GetConnection()');
  try
    {$ENDIF}
    try
      {$REGION 'Создание подлюкчения к БД'}
      tmpConnection := TFDConnection.Create(nil);
      if Assigned(tmpConnection) then
      begin
        tmpConnection.LoginPrompt := False;
        tmpConnection.FetchOptions.AutoClose := False;
        tmpConnection.FetchOptions.Mode := fmAll;
        tmpConnection.ResourceOptions.SilentMode := True;
        tmpConnection.ResourceOptions.DirectExecute := True;
        tmpConnection.ResourceOptions.MacroCreate := False;
        tmpConnection.ResourceOptions.MacroExpand := False;
        tmpConnection.ConnectionString := aConnectionString;
        {$IFDEF DEBUG}
        CodeSite.Send('ConnectionString', tmpConnection.ConnectionString);
        {$ENDIF}
      end;
      Result := tmpConnection;
      {$ENDREGION}
    except
      on e: Exception do
      begin
        CodeSite.SendException(e);
        raise;
      end;
    end;
    {$IFDEF DEBUG}
  finally
    CodeSite.ExitMethod(Self, 'GetConnection()');
  end;
  {$ENDIF}
end;

function TMainForm.GetControl(): TWinControl;
begin
  Result := Self;
end;

procedure TMainForm.HideProgress();
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := EmptyStr;
  cxbrdtmProgress.Visible := ivNever;
end;

procedure TMainForm.RefreshStates();
var
  i: Integer;
begin
  for i := 0 to Pred(actlstMain.ActionCount) do
    actlstMain.Actions[i].Update();
end;

procedure TMainForm.SetActionStates(const aKey: TViewEnumAction;
  const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TMainForm.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  FOnEventSimple := aValue;
end;

function TMainForm.ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;
var
  sCaption: string;
begin
  case aStatus of
    MESSAGE_TYPE_OK: sCaption := Format('%s - Информация', [Application.Title]);
    MESSAGE_TYPE_ERROR: sCaption := Format('%s - Ошибка', [Application.Title]);
    MESSAGE_TYPE_WARNING, MESSAGE_TYPE_CONFIRMATION_WARNING_OK, MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL: sCaption := Format('%s - Внимание', [Application.Title]);
    MESSAGE_TYPE_CONFIRMATION_QUESTION: sCaption := Format('%s - Подтверждение', [Application.Title]);
  end;
  Result := MessageBox(Handle, PWideChar(aMessage), PWideChar(sCaption), aStatus);
end;

procedure TMainForm.ShowProgress(const aTitle: string; const aMax: Integer);
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aTitle.Trim();
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Max := aMax;
  cxbrdtmProgress.EditValue := 0;
  cxbrdtmProgress.Visible := ivAlways;
  Application.ProcessMessages();
end;

procedure TMainForm.StepProgress(const aNewTitle: string;
  const aToPosition: Integer);
var
  i: Integer;
begin
  if aNewTitle <> EmptyStr then
  begin
    (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aNewTitle.Trim();
  end;
  if aToPosition > -1 then
  begin
    cxbrdtmProgress.EditValue := aToPosition;
  end
  else
  begin
    i := cxbrdtmProgress.EditValue;
    cxbrdtmProgress.EditValue := Succ(i);
  end;
end;

procedure TMainForm.StorePresenter(const aPresenter: IInterface);
begin
  FPresenter := aPresenter;
end;

end.
