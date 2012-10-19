unit Beeper.uTMainForm;

interface

uses
  Beeper.uIConfiguration,
  CastersPackage.Actions.Classes,
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.StdActns,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  Vcl.ActnCtrls;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    TrayIcon: TTrayIcon;
    ImageList: TImageList;
    ActionManager: TActionManager;
    actEraseSignal: TAction;
    actEditSignal: TAction;
    actCreateSignal: TAction;
    actActionMenuGroup: TActionMenuGroupAction;
    actClearSignals: TAction;
    actAbout: TAction_About;
    actShow: TAction;
    actHide: TAction;
    actConfiguration: TAction_Configuration;
    actFileMenuGroup: TFileMenuGroupAction;
    actHelpMenuGroup: THelpMenuGroupAction;
    actHelpContents: THelpContentsAction;
    actQuit: TQuitAction;
    ActionToolBar: TActionToolBar;
    ListView: TListView;
    TrayPopupMenu: TPopupMenu;
    MainMenu: TMainMenu;
    miShow: TMenuItem;
    miHide: TMenuItem;
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
    N11: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N13: TMenuItem;
    N19: TMenuItem;
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
    procedure actQuitExecute(Sender: TObject);
    procedure actShowExecute(Sender: TObject);
    procedure actHideExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  strict private
    FConfiguration: IConfiguration;
    FSignalingActive: Boolean;
    FAboutWindowExists: Boolean;
    FAboutWindowHandle: HWND;
    FWaveFileHistory, FMessageHistory: TStringList;
    FWindowMessage: Cardinal;
    FFirstRun: Boolean;
    procedure DisplayHint(ASender: TObject);
    procedure ShowErrorMessageBox(const AMessage: string);
    procedure RegisterHotKeys;
    procedure UnregisterHotKeys;
    procedure RegisterWindowMessages;
    procedure RefreshSignals;
    procedure FillHistory;
    procedure ShowAboutWindow(const AShowCloseButton: Boolean);
    procedure HideAboutWindow;
    procedure WMHotkey(var AMsg: TWMHotkey); message WM_HOTKEY;
    procedure Flash;
    procedure UpdateVisibilityActions;
  strict protected
    procedure WMGetSysCommand(var AMessage: TMessage); message WM_SYSCOMMAND;
    procedure WndProc(var AMessage: TMessage); override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Beeper.uISignal,
  Beeper.uTPeriodType,
  Beeper.uTConfiguration,
  Beeper.uConsts,
  Beeper.uResourceStrings,
  Beeper.uTSignalForm,
  Beeper.uTAboutForm;

resourcestring
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';
  RsErrorRegisterWindowMessage = 'Не удалось выполнить операцию регистрации оконного сообщения!';
  RsErrorResigterStartHotKey = 'Не удалось назначить горячую клавишу для запуска сигналов.';
  RsErrorResigterStopHotKey = 'Не удалось назначить горячую клавишу для останова сигналов.';
  RsErrorUnregisterStartHotKey = 'Не удалось освободить горячую клавишу предназначеную для останова сигналов.';
  RsErrorUnregisterStopHotKey = 'Не удалось освободить горячую клавишу предназначеную для запуска сигналов.';

procedure TMainForm.DisplayHint(ASender: TObject);
begin
  StatusBar.SimpleText := GetLongHint(Application.Hint);
end;

procedure TMainForm.ShowAboutWindow(const AShowCloseButton: Boolean);
begin
  if not FAboutWindowExists then
  begin
    with TAboutForm.Create(Self, AShowCloseButton) do
      try
        FAboutWindowHandle := Handle;
        FAboutWindowExists := True;
        ShowModal;
      finally
        FAboutWindowExists := False;
        FAboutWindowHandle := 0;
        Free;
      end;
  end
  else
  begin
    SetForegroundWindow(FAboutWindowHandle);
  end;
end;

procedure TMainForm.HideAboutWindow;
begin
  if FAboutWindowExists then
  begin
    SendMessage(FAboutWindowHandle, WM_SYSCOMMAND, SC_CLOSE, 0);
  end;
end;

procedure TMainForm.ShowErrorMessageBox(const AMessage: string);
begin
  MessageBox(Handle, PWideChar(AMessage), PWideChar(Format(RsErrorMessageCaption, [Application.Title])), MESSAGE_TYPE_ERROR);
end;

procedure TMainForm.RegisterHotKeys;
begin
  if Assigned(FConfiguration) then
  begin
    if not RegisterHotkey(Handle, HOTKEY_ON, FConfiguration.ModifierOn, FConfiguration.VirtualKeyOn) then
    begin
      ShowErrorMessageBox(RsErrorResigterStartHotKey);
    end;
    if not RegisterHotkey(Handle, HOTKEY_OFF, FConfiguration.ModifierOff, FConfiguration.VirtualKeyOff) then
    begin
      ShowErrorMessageBox(RsErrorResigterStopHotKey);
    end;
  end;
end;

procedure TMainForm.UnregisterHotKeys;
begin
  if not UnRegisterHotkey(Handle, HOTKEY_OFF) then
  begin
    ShowErrorMessageBox(RsErrorUnregisterStartHotKey);
  end;
  if not UnRegisterHotkey(Handle, HOTKEY_ON) then
  begin
    ShowErrorMessageBox(RsErrorUnregisterStopHotKey);
  end;
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

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  Close;
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
  begin
    if Assigned(FConfiguration.SignalList) then
    begin
      for i := 0 to FConfiguration.SignalList.Count - 1 do
      begin
        if FConfiguration.SignalList.Items[i].WaveFile <> EmptyStr then
        begin
          FWaveFileHistory.Append(FConfiguration.SignalList.Items[i].WaveFile);
        end;
        if FConfiguration.SignalList.Items[i].Message <> EmptyStr then
        begin
          FMessageHistory.Append(FConfiguration.SignalList.Items[i].Message);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage), PWideChar(Format(RsExitConfirmationCaption, [Application.Title])), MESSAGE_TYPE_CONFIRMATION) = IDOK;
end;

procedure TMainForm.ListViewItemChecked(Sender: TObject; Item: TListItem);
begin
  if ListView.Items.Count > 0 then
  begin
    if Assigned(Item) then
    begin
      if Assigned(Item.Data) then
      begin
        if Assigned(FConfiguration) then
        begin
          FConfiguration.SignalList.Items[FConfiguration.SignalList.IndexOf(ISignal(Item.Data))].Enabled := Item.Checked;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.actEraseSignalExecute(Sender: TObject);
begin
  if Assigned(ListView.Selected) then
  begin
    if Assigned(ListView.Selected.Data) then
    begin
      if Assigned(FConfiguration) then
      begin
        if Assigned(FConfiguration.SignalList) then
        begin
          FConfiguration.SignalList.Remove(ISignal(ListView.Selected.Data));
          RefreshSignals;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  ShowAboutWindow(True);
end;

procedure TMainForm.actClearSignalsExecute(Sender: TObject);
begin
  if Assigned(FConfiguration) then
  begin
    if ListView.Items.Count > 0 then
    begin
      FConfiguration.SignalList.Clear;
      RefreshSignals;
    end;
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
      if Assigned(FConfiguration.SignalList) then
      begin
        for i := 0 to FConfiguration.SignalList.Count - 1 do
        begin
          if Assigned(FConfiguration.SignalList.Items[i]) then
          begin
            node := ListView.Items.Add;
            node.Data := Pointer(FConfiguration.SignalList.Items[i]);
            node.Caption := FConfiguration.SignalList.Items[i].Title;
            node.SubItems.Add(IntToStr(FConfiguration.SignalList.Items[i].Period) + ' ' + PERIODS[FConfiguration.SignalList.Items[i].PeriodType]);
            node.Checked := FConfiguration.SignalList.Items[i].Enabled;
          end;
        end;
      end;
    end;
  finally
    ListView.Items.EndUpdate;
  end;
end;

procedure TMainForm.actCreateSignalExecute(Sender: TObject);
var
  i: Integer;
  sig: ISignal;
begin
  if Assigned(FConfiguration) then
  begin
    with TSignalForm.Create(Self, True) do
      try
        MessageHistory := FMessageHistory;
        WaveFileHistory := FWaveFileHistory;
        ShowModal;
        if ModalResult = mrOk then
        begin
          sig:=GetISignal;
          sig.Assign(Signal);
          i := FConfiguration.SignalList.Add(sig);
          RefreshSignals;
          ListView.ItemIndex := i;
          FMessageHistory := MessageHistory;
          FWaveFileHistory := WaveFileHistory;
        end;
      finally
        Free;
      end;
  end;
end;

procedure TMainForm.actEditSignalExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FConfiguration) then
  begin
    if Assigned(ListView.Selected) then
    begin
      if Assigned(ListView.Selected.Data) then
      begin
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
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FConfiguration := GetIConfiguration;
  FSignalingActive := False;
  FAboutWindowExists := False;
  FAboutWindowHandle := 0;
  FFirstRun := True;
  if Assigned(FConfiguration) then
  begin
    FConfiguration.Load;
  end;
  Caption := Application.Title;
  Application.OnHint := DisplayHint;
  RefreshSignals;
  FillHistory;
  RegisterWindowMessages;
  RegisterHotKeys;
  UpdateVisibilityActions;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FSignalingActive := False;
  UnregisterHotKeys;
  if Assigned(FConfiguration) then
  begin
    FConfiguration.Save;
  end;
  FreeAndNil(FMessageHistory);
  FreeAndNil(FWaveFileHistory);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if FFirstRun then
  begin
    FFirstRun := False;
    ShowAboutWindow(False);
  end;
end;

procedure TMainForm.WMHotkey(var AMsg: TWMHotkey);
begin
  case AMsg.HotKey of
    HOTKEY_ON:
      { if not FSignalingActive then
        actStart.Execute };
    HOTKEY_OFF:
      { if FSignalingActive then
        actStop.Execute };
  end;
end;

procedure TMainForm.RegisterWindowMessages;
begin
  FWindowMessage := RegisterWindowMessage(PWideChar(APPLICATION_NAME));
  if FWindowMessage = 0 then
  begin
    ShowErrorMessageBox(RsErrorRegisterWindowMessage);
  end;
end;

procedure TMainForm.Flash;
var
  fwi: FLASHWINFO;
begin
  fwi.cbSize := SizeOf(FLASHWINFO);
  fwi.HWND := Handle;
  fwi.dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
  fwi.uCount := 0;
  fwi.dwTimeout := 0;
  FlashWindowEx(fwi);
end;

procedure TMainForm.TrayIconClick(Sender: TObject);
begin
  if Visible then
  begin
    actHide.Execute;
  end
  else
  begin
    actShow.Execute;
  end;
end;

procedure TMainForm.UpdateVisibilityActions;
begin
  actShow.Visible := not Visible;
  actHide.Visible := Visible;
  miShow.Default := actShow.Visible;
  miHide.Default := actHide.Visible;
end;

procedure TMainForm.WndProc(var AMessage: TMessage);
begin
  inherited;
  if AMessage.Msg = FWindowMessage then
  begin
    actShow.Execute;
    Flash;
  end;
end;

procedure TMainForm.actHideExecute(Sender: TObject);
begin
  HideAboutWindow;
  Visible := False;
  UpdateVisibilityActions;
end;

procedure TMainForm.actShowExecute(Sender: TObject);
begin
  HideAboutWindow;
  Visible := True;
  UpdateVisibilityActions;
  SetForegroundWindow(Handle);
end;

procedure TMainForm.WMGetSysCommand(var AMessage: TMessage);
begin
  if (AMessage.WParam = SC_MINIMIZE) then
  begin
    actHide.Execute;
  end
  else
  begin
    inherited;
  end;
end;

end.
