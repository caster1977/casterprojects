unit DBAutoTest.uTProfile;

interface

uses
  DBAutoTest.uIProfile,
  DBAutoTest.uITasks,
  DBAutoTest.uConsts,
  CastersPackage.uICustomized,
  CastersPackage.uTIniFileDataStorage,
  System.IniFiles,
  DBAutoTest.uIProfileProperties;

type
  TProfile = class(TIniFileDataStorage, IProfile)
  strict protected
    procedure Initialize; override;
    procedure Loading; override;
    procedure Saving; override;
    //function GetModified: Boolean; override;
  public
    constructor Create(const AProfileFileName: string = ''); override;
    property Modified: Boolean read GetModified nodefault;

  strict private
    function GetADOConnectionString: string;
  public
    property ADOConnectionString: string read GetADOConnectionString;

  strict private
    FTasks: ITasks;
    function GetTasks: ITasks;
  public
    property Tasks: ITasks read GetTasks nodefault;

  strict private
    FProperties: IProfileProperties;
    function GetProperties: IProfileProperties;
  public
    property Properties: IProfileProperties read GetProperties nodefault;
  end;

function GetIProfile(const AProfileFileName: string = ''): IProfile;

implementation

uses
  CastersPackage.uIModified,
  System.SysUtils,
  DBAutoTest.uTTasks,
  DBAutoTest.uEProfile,
  DBAutoTest.uTProfileProperties;

resourcestring
  RsProfileSaveError = 'Произошла ошибка при попытке записи настроек профиля в файл!';

function GetIProfile(const AProfileFileName: string): IProfile;
begin
  Result := TProfile.Create(AProfileFileName);
end;

constructor TProfile.Create(const AProfileFileName: string);
begin
  inherited;
end;

function TProfile.GetADOConnectionString: string;
begin
  Result := Format(ADO_CONNECTION_STRING_PREFIX, [Properties.Server]);

  if Properties.WinNTSecurity then
  begin
    Result := Result + ADO_CONNECTION_STRING_SUFFIX_INTEGRATED_SECURITY;
  end
  else
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_USER_ID, [Properties.Login]);
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO, [BoolToStr(Properties.EnableStorePassword, True)]);
    if Properties.EnableStorePassword then
    begin
      Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PASSWORD, [Properties.Password]);
    end;
  end;
  if Properties.Database > EmptyStr then
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_INITIAL_CATALOG, [Properties.Database]);
  end;
end;

function TProfile.GetTasks: ITasks;
begin
  if not Assigned(FTasks) then
  begin
    FTasks := GetITasks;
  end;
  Result := FTasks;
end;

{function TProfile.GetModified: Boolean;
begin
  Result := (inherited Modified) and (Properties as IModified).Modified;
end;}

function TProfile.GetProperties: IProfileProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties := GetIProfileProperties;
  end;
  Result := FProperties;
end;

procedure TProfile.Initialize;
begin
  inherited;
  FTasks := GetITasks;
end;

procedure TProfile.Loading;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
    begin

    end;
  end;
end;

procedure TProfile.Saving;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
      try

      except
        on EIniFileException do
        begin
          raise EProfile.Create(RsProfileSaveError);
        end;
      end;
  end;
end;

end.
