unit TAPEstimator.Profile.uTProfile;

interface

uses
  ConfigPackage.uTCustomConfiguration,
  TAPEstimator.uConsts;

type
  TProfile = class(TCustomConfiguration)
  strict protected
    procedure Initialize; override;
  public
    constructor Create(const AMemoryFile: Boolean = True; const AFileName: string = '');
  end;

implementation

uses
  System.SysUtils;

// uses
// TAPEstimator.Profile.uEProfile;

// resourcestring
// RsProfileSaveError = 'Произошла ошибка при попытке записи настроек профиля в файл!';

constructor TProfile.Create(const AMemoryFile: Boolean;
  const AFileName: string);
var
  s: string;
begin
  s := Trim(AFileName);
  if s = EmptyStr then
  begin
    s := ChangeFileExt(ExpandFileName(ParamStr(0)), '.profile');
  end;
  inherited Create(AMemoryFile, s);
end;

procedure TProfile.Initialize;
begin
  inherited;
  // RegisterSection();
end;

end.
