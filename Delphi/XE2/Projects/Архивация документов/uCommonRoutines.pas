unit uCommonRoutines;

interface

uses
  Controls,
  StdCtrls,
  SysUtils;

function GetControlByName(const AName: string; const AParent: TCustomControl): TControl;

/// <summary>
/// ��������� ��������� ������ ���������� ���� "�����" � ��������� ������
/// </summary>
/// <param name="AParentControl">
/// �������, ���������� �����
/// </param>
/// <param name="ALabelName">
/// ��� ���������� ���� "�����"
/// </param>
/// <param name="ACaption">
/// �����, ������� ����� ��������� �����
/// </param>
procedure SetLabelCaption(const AParentControl: TCustomControl; const ALabelName, ACaption: string);

implementation

function GetControlByName(const AName: string; const AParent: TCustomControl): TControl;
var
  k: Integer;
  c: TControl;
begin
  Result := nil;
  for k := 0 to AParent.ControlCount - 1 do
  begin
    if AParent.Controls[k].Name = AName then
    begin
      Result := AParent.Controls[k];
      Break;
    end;
  end;
end;

procedure SetLabelCaption(const AParentControl: TCustomControl; const ALabelName, ACaption: string);
var
  cc: TControl;
begin
  if Assigned(AParentControl) then
  begin
    cc := GetControlByName(Trim(ALabelName), AParentControl);
    if Assigned(cc) then
    begin
      if cc is TLabel then
      begin
        (cc as TLabel).Caption := ACaption;
      end;
    end;
  end;
end;

end.
