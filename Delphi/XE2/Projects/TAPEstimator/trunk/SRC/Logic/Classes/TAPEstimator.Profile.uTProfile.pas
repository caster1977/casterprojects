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
// RsProfileSaveError = '��������� ������ ��� ������� ������ �������� ������� � ����!';

procedure TProfile.Initialize;
begin
  inherited;
  // RegisterSection();
end;

end.
