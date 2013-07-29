unit TAPEstimator.Profile.uTProfile;

interface

uses
  ConfigPackage.uTCustomConfiguration,
  TAPEstimator.uConsts;

type
  TProfile = class(TCustomConfiguration)
  strict protected
    procedure Initialize; override;
  end;

implementation

// uses
// TAPEstimator.Profile.uEProfile;

// resourcestring
// RsProfileSaveError = 'Произошла ошибка при попытке записи настроек профиля в файл!';

procedure TProfile.Initialize;
begin
  inherited;
  // RegisterSection();
end;

end.
