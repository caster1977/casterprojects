unit LoginPackage.uShowLoginForm;

interface

uses
  System.Classes,
  Vcl.Controls;

function ShowLoginForm(const AOwner: TComponent; const ALogin: string = ''; const APassword: string = ''): TModalResult;

implementation

uses
  LoginPackage.uTLoginForm;

function ShowLoginForm(const AOwner: TComponent; const ALogin, APassword: string): TModalResult;
var
  form: TLoginForm;
begin
  form := TLoginForm.Create(AOwner, ALogin, APassword);
  if not Assigned(form) then
  begin
    Result := mrCancel;
    Exit;
  end;

  try
    Result := form.ShowModal;
  finally
    form.Free;
  end;
end;

end.
