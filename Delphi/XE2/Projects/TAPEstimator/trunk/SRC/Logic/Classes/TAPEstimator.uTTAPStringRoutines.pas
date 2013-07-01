unit TAPEstimator.uTTAPStringRoutines;

interface

uses
  System.Classes;

type
  /// <summary>
  /// �����, ���������� ��������� � ������� ��� ������ �� �������� TAP-�����
  /// </summary>
  TTAPStringRoutines = class

    /// <summary>
    /// ��������� �������, ������������, �������� �� �������� ������
    /// ������������
    /// </summary>
    /// <param name="AValue">
    /// �������� ������
    /// </param>
    /// <returns>
    /// ���� ������ �������� ������������, ����� ���������� ��������
    /// <b>True</b>, � ��������� ������ ����� ���������� <b>False</b>.
    /// </returns>
    class function IsComment(const AValue: string): Boolean; static;

    /// <summary>
    /// ��������� �������, ������������, �������� �� �������� ������
    /// ���������������
    /// </summary>
    /// <param name="AValue">
    /// �������� ������
    /// </param>
    /// <returns>
    /// ���� ������ �������� ���������������, ����� ���������� ��������
    /// <b>True</b>, � ��������� ������ ����� ���������� <b>False</b>.
    /// </returns>
    class function Normalized(const AValue: string): Boolean; static;

    /// <summary>
    /// ��������� �������, ����������� ������������ �������� ������
    /// </summary>
    /// <param name="AValue">
    /// �������� ������
    /// </param>
    /// <returns>
    /// ��������������� ������
    /// </returns>
    class function Normalize(const AValue: string): string;

    /// <summary>
    /// ��������� �������, ����������� ��������� �������� ������ �� ���������
    /// � ��������� �� � ������ �����
    /// </summary>
    /// <param name="AValue">
    /// �������� ������
    /// </param>
    /// <returns>
    /// �������������� ������ �����
    /// </returns>
    class function ToStringList(const AValue: string): TStringList; static;

    /// <summary>
    /// ��������� �������, ������������, �������� �� �������� ������ ������
    /// ���������� �������
    /// </summary>
    /// <param name="AValue">
    /// �������� ������
    /// </param>
    /// <returns>
    /// ���� ������ �������� ����������, ����� ���������� �������� <b>True</b>
    /// , � ��������� ������ ����� ���������� <b>False</b>.
    /// </returns>
    class function Valid(const AValue: string; out AWrongSymbol: Char): Boolean;
  end;

implementation

uses
  System.SysUtils,
  VCL.Dialogs,
  CastersPackage.uRoutines,
  System.Character,
  TAPEstimator.uTTAPCommandPrefixes,
  TAPEstimator.uTTAPNonCommandChars,
  TAPEstimator.uETAPWrongSymbol;

{var
  sTAPString: string;
  cWrongSymbol: Char;}

class function TTAPStringRoutines.IsComment(const AValue: string): Boolean;
var
  s: string;
begin
  // ������� ������� � ������ � ����� ������
  s := Trim(AValue);
  Result :=
  // ����������� ������� � ������������ �������� ������ [],
  // ������� ����� ������ ������ ���� ������� 2 �������
    (Length(s) > 1) and
  // ������ ������ ���������� �� [
    (s[low(string)] = '[') and
  // � ������������ �� ]
    (s[Length(s) - 1 + low(string)] = ']');
end;

class function TTAPStringRoutines.Normalize(const AValue: string): string;
var
  s: string;
  s1: string;
  i: Integer;
begin
  s1 := EmptyStr;
  // ������� ������� � ������ � ����� ������
  s := Trim(AValue);
  // ���� ������ �� �������� ������������, ���������� ������������
  if not IsComment(s) then
  begin
    // ����������� ������ � ������� �������
    s := AnsiUpperCase(s);
    // ���������� ��� ������� � ������
    for i := low(string) to Length(s) - 1 + low(string) do
    begin
      if i > low(string) then // ���� ������ �� �������� ������ � ������
      begin
        // ���� ������ �������� ��������� �������
        if CharInSet(s[i], TTAPCommandPrefixes) and
        // � ���������� ������ �� ��� ��������� ������� ���� ��������
          (not CharInSet(s[i - 1], TTAPCommandPrefixes + [' '])) then
        begin
          // ��������� ������ ����� ��������� ���������
          s1 := s1 + ' ';
        end;
      end;
      // ��������� ��������� ������
      s1 := s1 + s[i];
    end;
    // ���������� ��������������� ������
    s := s1;
  end;
  // ���������� ������
  Result := s;
end;

class function TTAPStringRoutines.Normalized(const AValue: string): Boolean;
begin
  // ���� ������ ��������� � ��������������� ���������, ������ ��� �������� ���������������
  Result := AValue <> Normalize(AValue);
end;

class function TTAPStringRoutines.ToStringList(const AValue: string): TStringList;
begin
  // ������ ������ �����
  Result := TStringList.Create;
  // ��������� ������ �� ��������� � ���������� �� � ���� ������
  Routines.CutStringByLimiterToStringList(AValue, Result, ' ');
end;

class function TTAPStringRoutines.Valid(const AValue: string; out AWrongSymbol: Char): Boolean;
var
  s: string;
  i: Integer;
begin
  AWrongSymbol := Char(0);
  Result := IsComment(AValue);
  // ���� ������ �� �������� ������������, ���������� ���������
  if not Result then
  begin
    // �������� ��������������� ������ ������
    s := Normalize(AValue);
    // ������������� ��������� �� ��������� "������"
    Result := True;
    // ���������� ��� ������� � ������
    for i := low(string) to Length(s) - 1 + low(string) do
    begin
      // ���� ������ �� ��������� � ���������� ��������
      if not CharInSet(s[i], TTAPCommandPrefixes + TTAPNonCommandChars) then
      begin
        // ���������� "����"
        Result := False;
        // ���������� ������ �����
        AWrongSymbol := s[i];
        Break;
      end;
    end;
  end;
end;

{initialization

sTAPString := ' G90G1Z0f350 y10z20 xyz ';
try
  if TTAPStringRoutines.Valid(TTAPStringRoutines.Normalize(sTAPString), cWrongSymbol) then
  begin
    ShowMessage(TTAPStringRoutines.Normalize(sTAPString));
  end
  else
  begin
    raise ETAPWrongSymbol.Create('������������ ������ [%s] � ������.', cWrongSymbol);
  end;
except
  on E: Exception do
  begin
    ShowMessage(E.Message);
  end;
end;}

end.
