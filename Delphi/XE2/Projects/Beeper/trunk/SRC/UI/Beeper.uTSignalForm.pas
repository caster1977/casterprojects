unit Beeper.uTSignalForm;

interface

uses
  Beeper.uISignal,
  CastersPackage.Actions.Classes,
  System.Classes,
  Vcl.Forms,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

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
    chkbxPlayWaveFile: TCheckBox;
    chkbxShowMessage: TCheckBox;
    actSave: TAction;
    actSelectWaveFile: TAction;
    actEnablePlayWaveFile: TAction;
    actPlayWaveFile: TAction;
    actEnableShowMessage: TAction;
    cmbbxMessage: TComboBox;
    btnPlayWaveFile: TButton;
    actCancel: TAction_Cancel;
    procedure ledPeriodKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
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
    function GetWaveFileName: string;
    procedure AppendMessage;
    function GetSignal: ISignal;
    procedure SetSignal(const AValue: ISignal);
    function GetMessageHistory: TStringList;
    procedure SetMessageHistory(const AValue: TStringList);
    function GetWaveFileHistory: TStringList;
    procedure SetWaveFileHistory(const AValue: TStringList);
  public
    constructor Create(AOwner: TComponent; const ANew: Boolean); reintroduce; virtual;
    property Signal: ISignal read GetSignal write SetSignal nodefault;
    property MessageHistory: TStringList read GetMessageHistory write SetMessageHistory nodefault;
    property WaveFileHistory: TStringList read GetWaveFileHistory write SetWaveFileHistory nodefault;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Winapi.MMSystem,
  Vcl.Dialogs,
  Beeper.uConsts,
  Beeper.uResourceStrings,
  Beeper.uTPeriodType,
  Beeper.uTSignal;

resourcestring
  RsAddSignalCaption = 'Добавление сигнала';
  RsEditSignalCaption = 'Редактирование сигнала';
  RsSelectWaveFile = 'Выберите звуковой файл...';

procedure TSignalForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSignalForm.actEnablePlayWaveFileExecute(Sender: TObject);
begin
  TAction(Sender).Checked := not TAction(Sender).Checked;
end;

procedure TSignalForm.actEnablePlayWaveFileUpdate(Sender: TObject);
begin
  cmbbxWaveFile.Enabled := TAction(Sender).Checked;
end;

procedure TSignalForm.actEnableShowMessageExecute(Sender: TObject);
begin
  TAction(Sender).Checked := not TAction(Sender).Checked;
end;

procedure TSignalForm.actEnableShowMessageUpdate(Sender: TObject);
begin
  cmbbxMessage.Enabled := TAction(Sender).Checked;
end;

procedure TSignalForm.actPlayWaveFileUpdate(Sender: TObject);
begin
  actPlayWaveFile.Enabled := actEnablePlayWaveFile.Checked and FileExists(GetWaveFileName) and (not FNowPlaying);
end;

procedure TSignalForm.FormCreate(Sender: TObject);
var
  pt: TPeriodType;
begin
  FNowPlaying := False;
  FEnabled := False;
  cmbxPeriodType.Clear;
  for pt := low(TPeriodType) to high(TPeriodType) do
  begin
    cmbxPeriodType.Items.Add(PERIODS[pt]);
  end;
end;

function TSignalForm.GetSignal: ISignal;
var
  pt: TPeriodType;
begin
  Result := GetISignal;
  Result.Title := Trim(ledTitle.Text);
  Result.Period := StrToIntDef(ledPeriod.Text, 0);
  for pt := low(TPeriodType) to high(TPeriodType) do
  begin
    if cmbxPeriodType.Items[cmbxPeriodType.ItemIndex] = PERIODS[pt] then
    begin
      Result.PeriodType := pt;
      Break;
    end;
  end;
  Result.MessageEnabled := actEnableShowMessage.Checked;
  if Result.MessageEnabled then
  begin
    Result.Message := Trim(cmbbxMessage.Text);
  end;
  Result.WaveFileEnabled := actEnablePlayWaveFile.Checked;
  if Result.WaveFileEnabled then
  begin
    Result.WaveFile := GetWaveFileName;
  end;
  Result.Enabled := FEnabled;
end;

function TSignalForm.GetMessageHistory: TStringList;
begin
  Result := TStringList.Create;
  Result.AddStrings(cmbbxMessage.Items);
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

procedure TSignalForm.SetSignal(const AValue: ISignal);
begin
  if Assigned(AValue) then
  begin
    ledTitle.Text := AValue.Title;
    ledPeriod.Text := IntToStr(AValue.Period);
    cmbxPeriodType.ItemIndex := cmbxPeriodType.Items.IndexOf(PERIODS[AValue.PeriodType]);

    actEnableShowMessage.Checked := AValue.MessageEnabled;
    if AValue.MessageEnabled then
    begin
      if cmbbxMessage.Items.IndexOf(AValue.Message) = -1 then
      begin
        cmbbxMessage.ItemIndex := cmbbxMessage.Items.Add(AValue.Message);
      end
      else
      begin
        cmbbxMessage.ItemIndex := cmbbxMessage.Items.IndexOf(AValue.Message);
      end;
    end;

    actEnablePlayWaveFile.Checked := AValue.WaveFileEnabled;
    if AValue.WaveFileEnabled then
    begin
      if cmbbxWaveFile.Items.IndexOf(AValue.WaveFile) = -1 then
      begin
        cmbbxWaveFile.ItemIndex := cmbbxWaveFile.Items.Add(AValue.WaveFile);
      end
      else
      begin
        cmbbxWaveFile.ItemIndex := cmbbxWaveFile.Items.IndexOf(AValue.WaveFile);
      end;
    end;
    FEnabled := AValue.Enabled;
  end;
end;

procedure TSignalForm.AppendMessage;
var
  s: string;
begin
  s := Trim(cmbbxMessage.Text);
  if s <> EmptyStr then
  begin
    if cmbbxMessage.Items.IndexOf(s) = -1 then
    begin
      cmbbxMessage.ItemIndex := cmbbxMessage.Items.Add(s);
    end
    else
    begin
      cmbbxMessage.ItemIndex := cmbbxMessage.Items.IndexOf(s);
    end;
  end;
end;

procedure TSignalForm.actSaveExecute(Sender: TObject);
begin
  AppendMessage;
  ModalResult := mrOk;
end;

procedure TSignalForm.actSaveUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (cmbxPeriodType.ItemIndex > -1) and (Trim(ledPeriod.Text) <> EmptyStr) and (Trim(ledTitle.Text) <> EmptyStr) and
    ((FileExists(GetWaveFileName) and actEnablePlayWaveFile.Checked) or (not actEnablePlayWaveFile.Checked)) and
    ((not actEnableShowMessage.Checked) or (actEnableShowMessage.Checked and (Trim(cmbbxMessage.Text) <> EmptyStr)));
  btnSave.Default := TAction(Sender).Enabled;
  btnCancel.Default := not TAction(Sender).Enabled;
end;

constructor TSignalForm.Create(AOwner: TComponent; const ANew: Boolean);
begin
  inherited Create(AOwner);
  case ANew of
    True:
      begin
        Caption := RsAddSignalCaption;
      end;
    False:
      begin
        Caption := RsEditSignalCaption;
      end;
  end;
end;

procedure TSignalForm.actPlayWaveFileExecute(Sender: TObject);
begin
  FNowPlaying := True;
  Screen.Cursor := crHourGlass;
  try
    actPlayWaveFile.Update;
    Application.ProcessMessages;
    sndPlaySound(PWideChar(GetWaveFileName), SND_FILENAME or SND_SYNC);
  finally
    Screen.Cursor := crDefault;
    FNowPlaying := False;
  end;
end;

procedure TSignalForm.actSelectWaveFileExecute(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter := RsWaveFile + ' ' + UpperCase(WAVEFILE_EXTENTION) + ' (*.' + WAVEFILE_EXTENTION + ')|*.' + WAVEFILE_EXTENTION;
      DefaultExt := WAVEFILE_EXTENTION;
      Title := RsSelectWaveFile;
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
      begin
        if cmbbxWaveFile.Items.IndexOf(FileName) = -1 then
        begin
          cmbbxWaveFile.ItemIndex := cmbbxWaveFile.Items.Add(FileName);
        end
        else
        begin
          cmbbxWaveFile.ItemIndex := cmbbxWaveFile.Items.IndexOf(FileName);
        end;
      end;
    finally
      Free;
    end;
end;

procedure TSignalForm.actSelectWaveFileUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := chkbxPlayWaveFile.Checked;
end;

function TSignalForm.GetWaveFileName: string;
begin
  if cmbbxWaveFile.ItemIndex > -1 then
  begin
    Result := Trim(cmbbxWaveFile.Items[cmbbxWaveFile.ItemIndex]);
  end
  else
  begin
    Result := EmptyStr;
  end;
end;

procedure TSignalForm.SetWaveFileHistory(const AValue: TStringList);
begin
  cmbbxWaveFile.Clear;
  cmbbxWaveFile.Items.AddStrings(AValue);
end;

procedure TSignalForm.SetMessageHistory(const AValue: TStringList);
begin
  cmbbxMessage.Clear;
  cmbbxMessage.Items.AddStrings(AValue);
end;

end.
