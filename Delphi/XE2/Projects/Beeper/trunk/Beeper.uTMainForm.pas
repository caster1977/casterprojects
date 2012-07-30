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
  Winapi.Messages,
  Winapi.Windows,
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
    actQuit: TQuitAction;
    N1: TMenuItem;
    N2: TMenuItem;
    actFileMenuGroup: TFileMenuGroupAction;
    ListView: TListView;
    actHelpMenuGroup: THelpMenuGroupAction;
    actHelpContents: THelpContentsAction;
    N3: TMenuItem;
    N4: TMenuItem;
    actEraseSignal: TAction;
    actEditSignal: TAction;
    actCreateSignal: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    actActionMenuGroup: TActionMenuGroupAction;
    actClearSignals: TAction;
    N10: TMenuItem;
    actAbout: TAction_About;
    N11: TMenuItem;
    N12: TMenuItem;
    actRestore: TAction_Restore;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    procedure actEraseSignalUpdate(Sender: TObject);
    procedure actEditSignalUpdate(Sender: TObject);
    procedure actEditSignalExecute(Sender: TObject);
    procedure actEraseSignalExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCreateSignalExecute(Sender: TObject);
    procedure actCreateSignalUpdate(Sender: TObject);
    procedure ListViewItemChecked(Sender: TObject; Item: TListItem);
    procedure actClearSignalsUpdate(Sender: TObject);
    procedure actClearSignalsExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure actRestoreExecute(Sender: TObject);
  strict private
    FConfiguration: IConfiguration;
    FSignalingActive: Boolean;
    FAboutWindowExists: Boolean;
    FAboutWindowHandle: HWND;
    FWaveFileHistory, FMessageHistory: TStringList;
    procedure DisplayHint(Sender: TObject);
    procedure Minimize(Sender: TObject); overload;
    procedure Minimize; overload;
    procedure Restore;
    procedure ShowErrorMessageBox(const AMessage: string);
    procedure RegisterHotKeys;
    procedure UnregisterHotKeys;
    procedure RefreshSignals;
    procedure FillHistory;
    procedure ShowAboutWindow(const AShowCloseButton: Boolean);
    procedure WMHotkey(var Msg: TWMHotkey); message WM_HOTKEY;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Beeper.uISignal,
  Beeper.uTSignal,
  Beeper.uTPeriodType,
  Beeper.uTConfiguration,
  Beeper.uConsts,
  Beeper.uResourceStrings,
  Beeper.uTSignalForm,
  Beeper.uTAboutForm;

procedure TMainForm.DisplayHint(Sender: TObject);
begin
  StatusBar.SimpleText := GetLongHint(Application.Hint);
end;

procedure TMainForm.ShowAboutWindow(const AShowCloseButton: Boolean);
begin
  with TAboutForm.Create(Self, AShowCloseButton) do
    try
      FAboutWindowHandle:=Handle;
      FAboutWindowExists := True;
      ShowModal;
    finally
      FAboutWindowExists := False;
      FAboutWindowHandle:=0;
      Free;
    end;
end;

procedure TMainForm.ShowErrorMessageBox(const AMessage: string);
begin
  MessageBox(Handle, PWideChar(AMessage), PWideChar(Format(RsErrorMessageCaption, [Application.Title])), MESSAGE_TYPE_ERROR);
end;

procedure TMainForm.TrayIconClick(Sender: TObject);
begin
  if Visible then
    SetForegroundWindow(Handle);
end;

procedure TMainForm.RegisterHotKeys;
begin
  if not RegisterHotkey(Handle, HOTKEY_ON, FConfiguration.ModifierOn, FConfiguration.VirtualKeyOn) then
    ShowErrorMessageBox(RsErrorResisterStartHotKey);
  if not RegisterHotkey(Handle, HOTKEY_OFF, FConfiguration.ModifierOff, FConfiguration.VirtualKeyOff) then
    ShowErrorMessageBox(RsErrorResisterStopHotKey);
end;

procedure TMainForm.UnregisterHotKeys;
begin
  if not UnRegisterHotkey(Handle, HOTKEY_OFF) then
    ShowErrorMessageBox(RsErrorUnresisterStartHotKey);
  if not UnRegisterHotkey(Handle, HOTKEY_ON) then
    ShowErrorMessageBox(RsErrorUnresisterStopHotKey);
end;

procedure TMainForm.actCreateSignalUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := not FSignalingActive;
end;

procedure TMainForm.actEditSignalUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(ListView.Selected) and (not FSignalingActive);
end;

procedure TMainForm.actEraseSignalUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(ListView.Selected) and (not FSignalingActive);
end;

procedure TMainForm.actClearSignalsUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (ListView.Items.Count > 0) and (not FSignalingActive);
end;

procedure TMainForm.FillHistory;
var
  i: Integer;
begin
  if not Assigned(FWaveFileHistory) then
  begin
    FWaveFileHistory := TStringList.Create;
    FWaveFileHistory.Sorted := True;
    FWaveFileHistory.Duplicates := dupIgnore;
  end;
  if not Assigned(FMessageHistory) then
  begin
    FMessageHistory := TStringList.Create;
    FMessageHistory.Sorted := True;
    FMessageHistory.Duplicates := dupIgnore;
  end;
  if Assigned(FConfiguration) then
    if Assigned(FConfiguration.SignalList) then
    begin
      for i := 0 to FConfiguration.SignalList.Count - 1 do
      begin
        if FConfiguration.SignalList.Items[i].WaveFile <> EmptyStr then
          FWaveFileHistory.Append(FConfiguration.SignalList.Items[i].WaveFile);
        if FConfiguration.SignalList.Items[i].Message <> EmptyStr then
          FMessageHistory.Append(FConfiguration.SignalList.Items[i].Message);
      end;
    end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage), PWideChar(Format(RsExitConfirmationCaption, [Application.Title])),
    MESSAGE_TYPE_CONFIRMATION) = IDOK;
end;

procedure TMainForm.ListViewItemChecked(Sender: TObject; Item: TListItem);
begin
  if ListView.Items.Count > 0 then
    if Assigned(Item) then
      if Assigned(Item.Data) then
        if Assigned(FConfiguration) then
          FConfiguration.SignalList.Items[FConfiguration.SignalList.IndexOf(ISignal(Item.Data))].Enabled := Item.Checked;
end;

procedure TMainForm.actEraseSignalExecute(Sender: TObject);
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

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  ShowAboutWindow(True);
end;

procedure TMainForm.actClearSignalsExecute(Sender: TObject);
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

procedure TMainForm.actCreateSignalExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FConfiguration) then
    with TSignalForm.Create(Self, True) do
      try
        MessageHistory := FMessageHistory;
        WaveFileHistory := FWaveFileHistory;
        ShowModal;
        if ModalResult = mrOk then
        begin
          i := FConfiguration.SignalList.Add(Signal);
          RefreshSignals;
          ListView.ItemIndex := i;
          FMessageHistory := MessageHistory;
          FWaveFileHistory := WaveFileHistory;
        end;
      finally
        Free;
      end;
end;

procedure TMainForm.actEditSignalExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FConfiguration) then
    if Assigned(ListView.Selected) then
      if Assigned(ListView.Selected.Data) then
        with TSignalForm.Create(Self, False) do
          try
            MessageHistory := FMessageHistory;
            WaveFileHistory := FWaveFileHistory;
            Signal := ISignal(ListView.Selected.Data);
            ShowModal;
            if ModalResult = mrOk then
            begin
              FConfiguration.SignalList.Items[FConfiguration.SignalList.IndexOf(ISignal(ListView.Selected.Data))] := Signal;
              i := ListView.ItemIndex;
              RefreshSignals;
              ListView.ItemIndex := i;
              FMessageHistory := MessageHistory;
              FWaveFileHistory := WaveFileHistory;
            end;
          finally
            Free;
          end;
end;

procedure TMainForm.Minimize;
begin
  TrayIcon.Visible := True;
  Visible := False;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  Restore;
end;

procedure TMainForm.actRestoreExecute(Sender: TObject);
begin
  Restore;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FConfiguration := TConfiguration.Create;
  FSignalingActive := False;
  FAboutWindowExists := False;
  FAboutWindowHandle:=0;
  if Assigned(FConfiguration) then
    FConfiguration.Load;
  Caption := Application.Title;
  Application.OnHint := DisplayHint;
  Application.OnMinimize := Minimize;
  RefreshSignals;
  FillHistory;
  RegisterHotKeys;
  ShowAboutWindow(False);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FSignalingActive := False;
  UnregisterHotKeys;
  if Assigned(FConfiguration) then
    FConfiguration.Save;
  FreeAndNil(FMessageHistory);
  FreeAndNil(FWaveFileHistory);
end;

procedure TMainForm.WMHotkey(var Msg: TWMHotkey);
begin
  case Msg.HotKey of
    HOTKEY_ON:
      { if not FSignalingActive then
        actStart.Execute };
    HOTKEY_OFF:
      { if FSignalingActive then
        actStop.Execute };
  end;
end;

procedure TMainForm.Minimize(Sender: TObject);
begin
  // Update_IconHint;
  Minimize;
end;

procedure TMainForm.Restore;
var
  fwi: FLASHWINFO;
begin
  if FAboutWindowExists then
  begin
    (* i.cbSize := sizeof(FLASHWINFO);
      fwi.hwnd := Application.Handle;
      fwi.dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
      fwi.uCount := 0;
      fwi.dwTimeout := 0;
      FlashWindowEx(fwi); *)
    SendMessage(FAboutWindowHandle, WM_SYSCOMMAND, SC_CLOSE, 0);
  end;
  Visible := True;
  TrayIcon.Visible := False;
  Application.Restore;
  SetForegroundWindow(Handle);
end;

end.
