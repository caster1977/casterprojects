unit Beeper.uTSignalForm;

interface

uses
  Beeper.uISignal,
  Beeper.uTPeriodTypes,
  CastersPackage.Actions.Classes,
  System.Classes,
  Vcl.Forms,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Actions;

type
  TSignalForm = class(TForm)
    ImageList: TImageList;
    ledTitle: TLabeledEdit;
    lblPeriod: TLabel;
    ledPeriod: TLabeledEdit;
    cmbxPeriodType: TComboBox;
    ActionList: TActionList;
    btnCancel: TButton;
    btnSave: TButton;
    cmbbxWaveFile: TComboBox;
    btnSelectWaveFile: TButton;
    chkbxWaveFileEnabled: TCheckBox;
    chkbxMessageEnabled: TCheckBox;
    actSave: TAction;
    actSelectWaveFile: TAction;
    actEnablePlayWaveFile: TAction;
    actPlayWaveFile: TAction;
    actEnableShowMessage: TAction;
    cmbbxMessage: TComboBox;
    btnPlayWaveFile: TButton;
    actCancel: TAction_Cancel;
    procedure ledPeriodKeyPress(Sender: TObject; var Key: Char);
    procedure actSaveExecute(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure actEnablePlayWaveFileUpdate(Sender: TObject);
    procedure actEnableShowMessageUpdate(Sender: TObject);
    procedure actEnableShowMessageExecute(Sender: TObject);
    procedure actEnablePlayWaveFileExecute(Sender: TObject);
    procedure actSelectWaveFileExecute(Sender: TObject);
    procedure actPlayWaveFileExecute(Sender: TObject);
    procedure actPlayWaveFileUpdate(Sender: TObject);
    procedure actSelectWaveFileUpdate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  strict private
    FEnabled: Boolean;
    FNowPlaying: Boolean;
    procedure AppendMessage;
  strict private
    function GetTitle: string;
    procedure SetTitle(const AValue: string);
    property Title: string read GetTitle write SetTitle nodefault;
    function GetPeriod: Int64;
    procedure SetPeriod(const AValue: Int64);
    property Period: Int64 read GetPeriod write SetPeriod nodefault;
    function GetPeriodType: TPeriodTypes;
    procedure SetPeriodType(const AValue: TPeriodTypes);
    property PeriodType: TPeriodTypes read GetPeriodType write SetPeriodType nodefault;
    function GetWaveFileEnabled: Boolean;
    procedure SetWaveFileEnabled(const AValue: Boolean);
    property WaveFileEnabled: Boolean read GetWaveFileEnabled write SetWaveFileEnabled nodefault;
    procedure SetWaveFile(const AValue: string);
    function GetWaveFile: string;
    property WaveFile: string read GetWaveFile write SetWaveFile nodefault;
    function GetMessageEnabled: Boolean;
    procedure SetMessageEnabled(const AValue: Boolean);
    property MessageEnabled: Boolean read GetMessageEnabled write SetMessageEnabled nodefault;
    function GetMessage: string;
    procedure SetMessage(const AValue: string);
    property message: string read GetMessage write SetMessage nodefault;
    function GetSignal: ISignal;
    function GetMessageHistory: TStringList;
    procedure SetMessageHistory(const AValue: TStringList);
    function GetWaveFileHistory: TStringList;
    procedure SetWaveFileHistory(const AValue: TStringList);
  public
    property Signal: ISignal read GetSignal nodefault;
    property MessageHistory: TStringList read GetMessageHistory write SetMessageHistory nodefault;
    property WaveFileHistory: TStringList read GetWaveFileHistory
      write SetWaveFileHistory nodefault;
    constructor Create(AOwner: TComponent; const ASignal: ISignal = nil); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Winapi.MMSystem,
  Vcl.Dialogs,
  Beeper.uConsts,
  Beeper.uResourceStrings,
  Beeper.uTSignal;

resourcestring
  RsAddSignalCaption = 'Добавление сигнала';
  RsEditSignalCaption = 'Редактирование сигнала';
  RsSelectWaveFile = 'Выберите звуковой файл...';

procedure TSignalForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSignalForm.actEnablePlayWaveFileUpdate(Sender: TObject);
begin
  cmbbxWaveFile.Enabled := actEnablePlayWaveFile.Checked;
end;

procedure TSignalForm.actPlayWaveFileUpdate(Sender: TObject);
begin
  actPlayWaveFile.Enabled := actEnablePlayWaveFile.Checked and FileExists(WaveFile) and
    (not FNowPlaying);
end;

procedure TSignalForm.actEnablePlayWaveFileExecute(Sender: TObject);
begin
  actEnablePlayWaveFile.Checked := not actEnablePlayWaveFile.Checked;
end;

procedure TSignalForm.actEnableShowMessageUpdate(Sender: TObject);
begin
  cmbbxMessage.Enabled := actEnableShowMessage.Checked;
end;

procedure TSignalForm.actEnableShowMessageExecute(Sender: TObject);
begin
  actEnableShowMessage.Checked := not actEnableShowMessage.Checked;
end;

function TSignalForm.GetSignal: ISignal;
begin
  Result := GetISignal;
  Result.Title := Title;
  Result.Period := Period;
  Result.PeriodType := PeriodType;
  Result.MessageEnabled := MessageEnabled;
  Result.Message := message;
  Result.WaveFileEnabled := WaveFileEnabled;
  Result.WaveFile := WaveFile;
  Result.Enabled := FEnabled;
end;

function TSignalForm.GetMessage: string;
begin
  if MessageEnabled then
  begin
    Result := Trim(cmbbxMessage.Text);
  end
  else
  begin
    Result := EmptyStr;
  end;
end;

function TSignalForm.GetMessageEnabled: Boolean;
begin
  Result := actEnableShowMessage.Checked;
end;

function TSignalForm.GetTitle: string;
begin
  Result := Trim(ledTitle.Text);
end;

function TSignalForm.GetMessageHistory: TStringList;
begin
  Result := TStringList.Create;
  Result.AddStrings(cmbbxMessage.Items);
end;

function TSignalForm.GetPeriod: Int64;
begin
  Result := StrToIntDef(ledPeriod.Text, 0);
end;

function TSignalForm.GetPeriodType: TPeriodTypes;
var
  pt: TPeriodTypes;
begin
  Result := ptSeconds;
  for pt := low(TPeriodTypes) to high(TPeriodTypes) do
  begin
    if cmbxPeriodType.Items[cmbxPeriodType.ItemIndex] = PERIODS[pt] then
    begin
      Result := pt;
      Break;
    end;
  end;
end;

function TSignalForm.GetWaveFile: string;
begin
  Result := EmptyStr;
  if WaveFileEnabled then
  begin
    if cmbbxWaveFile.ItemIndex > -1 then
    begin
      Result := Trim(cmbbxWaveFile.Items[cmbbxWaveFile.ItemIndex]);
    end;
  end;
end;

function TSignalForm.GetWaveFileEnabled: Boolean;
begin
  Result := actEnablePlayWaveFile.Checked;
end;

function TSignalForm.GetWaveFileHistory: TStringList;
begin
  Result := TStringList.Create;
  Result.AddStrings(cmbbxWaveFile.Items);
end;

procedure TSignalForm.ledPeriodKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8]) then
  begin
    Key := #0;
  end;
end;

procedure TSignalForm.SetTitle(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if ledTitle.Text <> s then
  begin
    ledTitle.Text := s;
  end;
end;

procedure TSignalForm.AppendMessage;
var
  i: Integer;
begin
  if message <> EmptyStr then
  begin
    i := cmbbxMessage.Items.IndexOf(message);
    if i = -1 then
    begin
      cmbbxMessage.ItemIndex := cmbbxMessage.Items.Add(message);
    end
    else
    begin
      cmbbxMessage.ItemIndex := i;
    end;
  end;
end;

procedure TSignalForm.actSaveUpdate(Sender: TObject);
begin
  actSave.Enabled := (cmbxPeriodType.ItemIndex > -1) and (Period > 0) and (Title <> EmptyStr) and
    ((not WaveFileEnabled) or (WaveFileEnabled and FileExists(WaveFile))) and
    ((not MessageEnabled) or (MessageEnabled and (message <> EmptyStr)));
  btnSave.Default := actSave.Enabled;
  btnCancel.Default := not actSave.Enabled;
end;

procedure TSignalForm.actSaveExecute(Sender: TObject);
begin
  AppendMessage;
  ModalResult := mrOk;
end;

constructor TSignalForm.Create(AOwner: TComponent; const ASignal: ISignal);
  procedure RefreshPeriodTypes;
  var
    pt: TPeriodTypes;
  begin
    cmbxPeriodType.Clear;
    for pt := low(TPeriodTypes) to high(TPeriodTypes) do
    begin
      cmbxPeriodType.Items.Add(PERIODS[pt]);
    end;
  end;

begin
  inherited Create(AOwner);
  FNowPlaying := False;
  FEnabled := False;
  RefreshPeriodTypes;
  if Assigned(ASignal) then
  begin
    Caption := RsEditSignalCaption;
    Title := ASignal.Title;
    Period := ASignal.Period;
    PeriodType := ASignal.PeriodType;
    MessageEnabled := ASignal.MessageEnabled;
    message := ASignal.Message;
    WaveFileEnabled := ASignal.WaveFileEnabled;
    WaveFile := ASignal.WaveFile;
    FEnabled := ASignal.Enabled;
  end
  else
  begin
    Caption := RsAddSignalCaption;
  end;
end;

procedure TSignalForm.actPlayWaveFileExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  FNowPlaying := True;
  try
    actPlayWaveFile.Update;
    Application.ProcessMessages;
    sndPlaySound(PWideChar(WaveFile), SND_FILENAME or SND_SYNC);
  finally
    FNowPlaying := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TSignalForm.actSelectWaveFileExecute(Sender: TObject);
var
  i: Integer;
begin
  with TOpenDialog.Create(Self) do
    try
      Filter := RsWaveFile + ' ' + UpperCase(WAVEFILE_EXTENTION) + ' (*.' + WAVEFILE_EXTENTION +
        ')|*.' + WAVEFILE_EXTENTION;
      DefaultExt := WAVEFILE_EXTENTION;
      Title := RsSelectWaveFile;
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
      begin
        i := cmbbxWaveFile.Items.IndexOf(FileName);
        if i = -1 then
        begin
          cmbbxWaveFile.ItemIndex := cmbbxWaveFile.Items.Add(FileName);
        end
        else
        begin
          cmbbxWaveFile.ItemIndex := i;
        end;
      end;
    finally
      Free;
    end;
end;

procedure TSignalForm.actSelectWaveFileUpdate(Sender: TObject);
begin
  actSelectWaveFile.Enabled := chkbxWaveFileEnabled.Checked;
end;

procedure TSignalForm.SetWaveFile(const AValue: string);
var
  i: Integer;
begin
  if WaveFileEnabled then
  begin
    i := cmbbxWaveFile.Items.IndexOf(AValue);
    if i = -1 then
    begin
      cmbbxWaveFile.ItemIndex := cmbbxWaveFile.Items.Add(AValue);
    end
    else
    begin
      cmbbxWaveFile.ItemIndex := i;
    end;
  end;
end;

procedure TSignalForm.SetWaveFileEnabled(const AValue: Boolean);
begin
  if chkbxWaveFileEnabled.Checked <> AValue then
  begin
    chkbxWaveFileEnabled.Checked := AValue;
  end;
end;

procedure TSignalForm.SetWaveFileHistory(const AValue: TStringList);
begin
  cmbbxWaveFile.Clear;
  cmbbxWaveFile.Items.AddStrings(AValue);
end;

procedure TSignalForm.SetMessage(const AValue: string);
var
  i: Integer;
begin
  if MessageEnabled then
  begin
    i := cmbbxMessage.Items.IndexOf(AValue);
    if i = -1 then
    begin
      cmbbxMessage.ItemIndex := cmbbxMessage.Items.Add(AValue);
    end
    else
    begin
      cmbbxMessage.ItemIndex := i;
    end;
  end;
end;

procedure TSignalForm.SetMessageEnabled(const AValue: Boolean);
begin
  if actEnableShowMessage.Checked <> AValue then
  begin
    actEnableShowMessage.Checked := AValue;
  end;
end;

procedure TSignalForm.SetMessageHistory(const AValue: TStringList);
begin
  cmbbxMessage.Clear;
  cmbbxMessage.Items.AddStrings(AValue);
end;

procedure TSignalForm.SetPeriod(const AValue: Int64);
var
  s: string;
begin
  s := IntToStr(AValue);
  if ledPeriod.Text <> s then
  begin
    ledPeriod.Text := s;
  end;
end;

procedure TSignalForm.SetPeriodType(const AValue: TPeriodTypes);
var
  i: Integer;
begin
  i := cmbxPeriodType.Items.IndexOf(PERIODS[AValue]);
  if cmbxPeriodType.ItemIndex <> i then
  begin
    cmbxPeriodType.ItemIndex := i;
  end;
end;

end.
