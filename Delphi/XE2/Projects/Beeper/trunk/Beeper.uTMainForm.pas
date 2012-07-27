unit Beeper.uTMainForm;

interface

uses
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.AppEvnts,
  Vcl.ActnMan,
  Vcl.ActnCtrls,
  Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.ToolWin,
  CastersPackage.Actions.Classes,
  Vcl.StdActns,
  Beeper.uIConfiguration;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    TrayIcon: TTrayIcon;
    ImageList: TImageList;
    ActionManager: TActionManager;
    MainMenu: TMainMenu;
    TrayPopupMenu: TPopupMenu;
    ActionToolBar1: TActionToolBar;
    QuitAction: TQuitAction;
    N1: TMenuItem;
    N2: TMenuItem;
    FileMenuGroupAction: TFileMenuGroupAction;
    ListView: TListView;
    HelpMenuGroupAction: THelpMenuGroupAction;
    HelpContentsAction: THelpContentsAction;
    N3: TMenuItem;
    N4: TMenuItem;
    EraseSignalAction: TAction;
    EditSignalAction: TAction;
    CreateSignalAction: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    ActionMenuGroupAction: TActionMenuGroupAction;
    ClearSignalsAction: TAction;
    N10: TMenuItem;
    procedure EraseSignalActionUpdate(Sender: TObject);
    procedure EditSignalActionUpdate(Sender: TObject);
    procedure EditSignalActionExecute(Sender: TObject);
    procedure EraseSignalActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateSignalActionExecute(Sender: TObject);
    procedure CreateSignalActionUpdate(Sender: TObject);
    procedure ListViewItemChecked(Sender: TObject; Item: TListItem);
    procedure ClearSignalsActionUpdate(Sender: TObject);
    procedure ClearSignalsActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  strict private
    FConfiguration: IConfiguration;
    FSignalingActive: Boolean;
    procedure DisplayHint(Sender: TObject);
    procedure ShowErrorMessageBox(const AMessage: string);
    procedure RegisterHotKeys;
    procedure UnregisterHotKeys;
    procedure RefreshSignals;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Winapi.Windows,
  Beeper.uISignal,
  Beeper.uTSignal,
  Beeper.uTPeriodType,
  Beeper.uTConfiguration,
  Beeper.uConsts,
  Beeper.uResourceStrings;

procedure TMainForm.DisplayHint(Sender: TObject);
begin
  StatusBar.SimpleText := GetLongHint(Application.Hint);
end;

procedure TMainForm.ShowErrorMessageBox(const AMessage: string);
begin
  MessageBox(Handle, PWideChar(AMessage), PWideChar(Format(RsErrorMessageCaption, [UpperCase(Application.Title)])), MESSAGE_TYPE_ERROR);
end;

procedure TMainForm.RegisterHotKeys;
begin
  if not RegisterHotkey(Handle, 1, FConfiguration.ModifierOn, FConfiguration.VirtualKeyOn) then
    ShowErrorMessageBox(RsErrorResisterStartHotKey);
  if not RegisterHotkey(Handle, 2, FConfiguration.ModifierOff, FConfiguration.VirtualKeyOff) then
    ShowErrorMessageBox(RsErrorResisterStopHotKey);
end;

procedure TMainForm.UnregisterHotKeys;
begin
  if not UnRegisterHotkey(Handle, 2) then
    ShowErrorMessageBox(RsErrorUnresisterStartHotKey);
  if not UnRegisterHotkey(Handle, 1) then
    ShowErrorMessageBox(RsErrorUnresisterStopHotKey);
end;

procedure TMainForm.CreateSignalActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := not FSignalingActive;
end;

procedure TMainForm.EditSignalActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(ListView.Selected) and (not FSignalingActive);
end;

procedure TMainForm.EraseSignalActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(ListView.Selected) and (not FSignalingActive);
end;

procedure TMainForm.ClearSignalsActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (ListView.Items.Count > 0) and (not FSignalingActive);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage), PWideChar(Format(RsExitConfirmationCaption, [UpperCase(Application.Title)])),
    MESSAGE_TYPE_CONFIRMATION) = IDOK;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FConfiguration := TConfiguration.Create;
  Application.OnHint := DisplayHint;
  FSignalingActive := False;
  if Assigned(FConfiguration) then
    FConfiguration.Load;
  RefreshSignals;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FConfiguration) then
    FConfiguration.Save;
end;

procedure TMainForm.ListViewItemChecked(Sender: TObject; Item: TListItem);
begin
  if ListView.Items.Count > 0 then
    if Assigned(Item) then
      if Assigned(Item.Data) then
        if Assigned(FConfiguration) then
          FConfiguration.SignalList.Items[FConfiguration.SignalList.IndexOf(ISignal(Item.Data))].Enabled := Item.Checked;
end;

procedure TMainForm.EraseSignalActionExecute(Sender: TObject);
begin
  if Assigned(ListView.Selected) then
    if Assigned(ListView.Selected.Data) then
      if Assigned(FConfiguration) then
        if Assigned(FConfiguration.SignalList) then
        begin
          FConfiguration.SignalList.Remove(ISignal(ListView.Selected.Data));
          RefreshSignals;
        end;
end;

procedure TMainForm.ClearSignalsActionExecute(Sender: TObject);
begin
  if Assigned(FConfiguration) then
    if ListView.Items.Count > 0 then
    begin
      FConfiguration.SignalList.Clear;
      RefreshSignals;
    end;
end;

procedure TMainForm.RefreshSignals;
var
  i: Integer;
  node: TListItem;
begin
  ListView.Items.BeginUpdate;
  try
    ListView.Items.Clear;
    if Assigned(FConfiguration) then
    begin
      for i := 0 to FConfiguration.SignalList.Count - 1 do
      begin
        node := ListView.Items.Add;
        node.Data := Pointer(FConfiguration.SignalList.Items[i]);
        node.Caption := FConfiguration.SignalList.Items[i].Title;
        node.SubItems.Add(IntToStr(FConfiguration.SignalList.Items[i].Period) + ' ' + PERIODS[FConfiguration.SignalList.Items[i].PeriodType]);
        node.Checked := FConfiguration.SignalList.Items[i].Enabled;
      end;
    end;
  finally
    ListView.Items.EndUpdate;
  end;
end;

procedure TMainForm.CreateSignalActionExecute(Sender: TObject);
var
  signal: ISignal;
begin
  signal := TSignal.Create;
  with signal do
  begin
    Title := 'Сигнал ' + IntToStr(ListView.Items.Count + 1);
    Period := 5;
    PeriodType := ptMinutes;
  end;
  //
  if Assigned(FConfiguration) then
    FConfiguration.SignalList.Add(signal);
  RefreshSignals;
end;

procedure TMainForm.EditSignalActionExecute(Sender: TObject);
begin
  //
  RefreshSignals;
end;

end.
