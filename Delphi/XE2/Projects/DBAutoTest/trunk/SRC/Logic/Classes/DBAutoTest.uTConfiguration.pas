unit DBAutoTest.uTConfiguration;

interface

uses
  System.IniFiles,
  DBAutoTest.uConsts,
  DBAutoTest.uIRecents,
  ConfigPackage.uTIniFileSerilizator;

type
  TConfiguration = class(TIniFileSerilizator)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
  strict private
    FRecents: IRecents;
    function GetRecents: IRecents;
  public
    property Recents: IRecents read GetRecents nodefault;
  end;

implementation

uses
  CastersPackage.uIModified,
  System.SysUtils,
  DBAutoTest.uEConfiguration,
  DBAutoTest.uTInterfaceOptions,
  DBAutoTest.uTReportsOptions,
  DBAutoTest.uTOtherOptions,
  DBAutoTest.uTRecents,
  DBAutoTest.uIRecent,
  DBAutoTest.uTRecent;

resourcestring
  RsInterface = '���������';
  RsRecents = '����� �������� �������';
  RsRecentProfile = '������� %s';
  RsOther = '������';
  RsReports = '������';
  RsQuantity = '����������';
  RsConfigurationSaveError = '��������� ������ ��� ������� ������ �������� ��������� � ����.';

  RsEnableQuitConfirmation = 'EnableQuitConfirmation';
  RsEnableSplashAtStart = 'EnableSplashAtStart';
  RsEnableStatusbar = 'EnableStatusbar';
  RsEnableToolbar = 'EnableToolbar';
  RsEnablePlaySoundOnComplete = 'EnablePlaySoundOnComplete';
  RsEnableStoreMainFormSizesAndPosition = 'EnableStoreMainFormSizesAndPosition';
  RsEnableGenerateFastReportDocument = 'EnableGenerateFastReportDocument';
  RsEnableGenerateExcelDocument = 'EnableGenerateExcelDocument';

function TConfiguration.GetRecents: IRecents;
begin
  if not Assigned(FRecents) then
  begin
    FRecents := GetIRecents;
  end;
  Result := FRecents;
end;

procedure TConfiguration.Initialize;
var
  i: Integer;
  s: string;
  r: IRecent;
begin
  inherited;
  RegisterOptions(TInterfaceOptions);
  RegisterOptions(TReportsOptions);
  RegisterOptions(TOtherOptions);
  Recents.Clear;
  if Assigned(FIniFile) then
  begin
    with FIniFile do
    begin
      Recents.Clear;
      for i := 0 to ReadInteger(RsRecents, RsQuantity, RECENTS_DEFAULT_COUNT) - 1 do
      begin
        s := Format(RsRecentProfile, [IntToStr(i)]);
        r := GetIRecent;
        r.FullName := ReadString(RsRecents, s, RECENT_DEFAULT_FULL_NAME);
        if r.FullName <> RECENT_DEFAULT_FULL_NAME then
        begin
          Recents.Add(r);
        end;
      end;
    end;
  end;
end;

procedure TConfiguration.Finalize;
var
  i: Integer;
  j: Integer;
  r: IRecent;
begin
  inherited;
  if Assigned(FIniFile) then
  begin
    with FIniFile do
      try
        if Recents.Count <> RECENTS_DEFAULT_COUNT then
        begin
          j := 0;
          for i := 0 to Recents.Count - 1 do
          begin
            r := Recents.Items[i];
            if Assigned(r) then
            begin
              if r.FullName <> RECENT_DEFAULT_FULL_NAME then
              begin
                WriteString(RsRecents, Format(RsRecentProfile, [IntToStr(j)]), r.FullName);
                Inc(j);
              end;
            end;
          end;
          WriteInteger(RsRecents, RsQuantity, j);
        end;
      except
        on EIniFileException do
        begin
          raise EConfiguration.Create(RsConfigurationSaveError);
        end;
      end;
  end;
end;

end.
