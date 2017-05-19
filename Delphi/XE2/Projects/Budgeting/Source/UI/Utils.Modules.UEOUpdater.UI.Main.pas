unit Utils.Modules.UEOUpdater.UI.Main;

interface

uses
  Utils.Modules.UEOUpdater.Logic.TViewEnumEvent, ERP.Package.ClientInterface.IERPClientData, ERP.Package.CustomForm.TERPCustomForm,
  ERP.Package.CustomClasses.Consts, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.ImgList, dxBar, cxClasses, System.Actions, Vcl.ActnList, dxStatusBar,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IViewMain, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls, cxGroupBox,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxProgressBar, cxCheckBox, Vcl.ComCtrls, Utils.Modules.UEOUpdater.Logic.TViewEnumActionArray,
  Utils.Modules.UEOUpdater.Logic.TViewEnumAction, cxBarEditItem;

const
  MODULE_NAME = 'Модуль корректировки данных отчёта УЭО по ГТД';
  MODULE_GUID: TGUID = '{A48F568F-1BDF-5458-AB66-ED3746D204C7}';
  MODULE_TYPEDB = TYPE_DATABASE_FAKEUTILS;

type
  TfrmMain = class(TERPCustomForm, IViewMain)
    dxstsbrMain: TdxStatusBar;
    actlstMain: TActionList;
    actStart: TAction;
    dxbrmngrMain: TdxBarManager;
    cxmglstActions: TcxImageList;
    pnlDestinationFolderName: TPanel;
    lblDestinationFolderName: TcxLabel;
    gbSource: TcxGroupBox;
    pnlMaskFileName: TPanel;
    lblMaskFileName: TcxLabel;
    pnlSourceFileName: TPanel;
    lblSourceFileName: TcxLabel;
    actOpenOld: TAction;
    actOpenNew: TAction;
    dxBarManagerBar1: TdxBar;
    btn1: TdxBarLargeButton;
    actOpenResult: TAction;
    actChooseDestinationFolder: TAction;
    btn4: TdxBarLargeButton;
    cxbrdtmProgress: TcxBarEditItem;
    edtSourceFileName: TcxButtonEdit;
    edtMaskFileName: TcxButtonEdit;
    edtDestinationFolderName: TcxButtonEdit;
    procedure actStartExecute(Sender: TObject);
    procedure actStartUpdate(Sender: TObject);
    procedure actOpenOldExecute(Sender: TObject);
    procedure actOpenOldUpdate(Sender: TObject);
    procedure actOpenNewExecute(Sender: TObject);
    procedure actOpenNewUpdate(Sender: TObject);
    procedure actChooseDestinationFolderExecute(Sender: TObject);
    procedure actChooseDestinationFolderUpdate(Sender: TObject);
    procedure actOpenResultExecute(Sender: TObject);
    procedure actOpenResultUpdate(Sender: TObject);

  strict private
    FOnEventSimple: TProc<TViewEnumEvent>;
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    procedure SetDestinationFolderName(const aValue: string);
    procedure SetOldFileName(const aValue: string);
    procedure SetNewFileName(const aValue: string);
    procedure ShowProgress(const aTitle: string; const aMax: Integer);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress;
    function GetControl: TWinControl;
    procedure RefreshStates;
    procedure StorePresenter(const aPresenter: IInterface);

  public
    constructor Create(aERPClientData: IERPClientData); reintroduce;
  end;

implementation

{$R *.dfm}

uses
  System.IOUtils, ERP.Package.CustomGlobalFunctions.UserFunctions, ERP.Package.GlobalData.DataModule;

constructor TfrmMain.Create(aERPClientData: IERPClientData);
begin
  inherited Create(MODULE_NAME, aERPClientData);
end;

function TfrmMain.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

function TfrmMain.GetControl: TWinControl;
begin
  Result := Self;
end;

procedure TfrmMain.SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TfrmMain.SetDestinationFolderName(const aValue: string);
begin
  edtDestinationFolderName.Text := aValue;
end;

procedure TfrmMain.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  FOnEventSimple := aValue;
end;

procedure TfrmMain.SetNewFileName(const aValue: string);
begin
  edtMaskFileName.Text := aValue;
end;

procedure TfrmMain.ShowProgress(const aTitle: string; const aMax: Integer);
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aTitle.Trim();
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Max := aMax;
  cxbrdtmProgress.EditValue := 0;
  cxbrdtmProgress.Visible := ivAlways;
  Application.ProcessMessages();
end;

procedure TfrmMain.StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
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

procedure TfrmMain.StorePresenter(const aPresenter: IInterface);
begin
  FPresenter := aPresenter;
end;

procedure TfrmMain.HideProgress;
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := EmptyStr;
  cxbrdtmProgress.Visible := ivNever;
end;

procedure TfrmMain.RefreshStates;
var
  i: Integer;
begin
  for i := 0 to Pred(actlstMain.ActionCount) do
    actlstMain.Actions[i].Update();
end;

procedure TfrmMain.SetOldFileName(const aValue: string);
begin
  edtSourceFileName.Text := aValue;
end;

procedure TfrmMain.actOpenOldExecute(Sender: TObject);
begin
  FOnEventSimple(veOpenOldExecute);
end;

procedure TfrmMain.actOpenOldUpdate(Sender: TObject);
begin
  FOnEventSimple(veOpenOldUpdate);
  (Sender as TAction).Enabled := FActionStates[vaOpenOld];
end;

procedure TfrmMain.actOpenNewExecute(Sender: TObject);
begin
  FOnEventSimple(veOpenNewExecute);
end;

procedure TfrmMain.actOpenNewUpdate(Sender: TObject);
begin
  FOnEventSimple(veOpenNewUpdate);
  (Sender as TAction).Enabled := FActionStates[vaOpenNew];
end;

procedure TfrmMain.actChooseDestinationFolderExecute(Sender: TObject);
begin
  FOnEventSimple(veChooseDestinationFolderExecute);
end;

procedure TfrmMain.actOpenResultExecute(Sender: TObject);
begin
  FOnEventSimple(veOpenResultExecute);
end;

procedure TfrmMain.actOpenResultUpdate(Sender: TObject);
begin
  FOnEventSimple(veOpenResultUpdate);
  (Sender as TAction).Enabled := FActionStates[vaOpenResult];
end;

procedure TfrmMain.actChooseDestinationFolderUpdate(Sender: TObject);
begin
  FOnEventSimple(veChooseDestinationFolderUpdate);
  (Sender as TAction).Enabled := FActionStates[vaChooseDestinationFolder];
end;

procedure TfrmMain.actStartExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veStartExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TfrmMain.actStartUpdate(Sender: TObject);
begin
  FOnEventSimple(veStartUpdate);
  (Sender as TAction).Enabled := FActionStates[vaStart];
end;

end.
