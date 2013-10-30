unit uArchivingCommonRoutines;

interface

uses
  Windows,
  Controls,
  StdCtrls,
  SysUtils,
  DB,
  ADODB,
  SQLExpr,
  uTArchiveDocumentItemClass,
  uIArchiveDocumentItem,
  uTArchiveDocumentItem,
  uTArchiveDocumentListClass,
  uIArchiveDocumentList,
  uTArchiveDocumentList,
  uIShowable;

/// <summary>
/// ���������, ���������� �������������� ������� �� ������ ������ �������,
/// ����������� ���������� ������� �������
/// </summary>
/// <param name="AQuery">
/// ������ ������� ���� <b>TADOQuery</b> ��� <b>TSQLQuery</b>
/// </param>
/// <param name="ASQL">
/// ����� �������
/// </param>
/// <param name="AOpen">
/// ���������� �� ��������� ��������� �������������� �������
/// </param>
procedure SetSQLForQuery(const AQuery: TDataSet; const ASQL: string; const AOpen: Boolean);

/// <summary>
/// ������� ��������� ������ �� ������� �� ����� ��������
/// </summary>
/// <param name="AName">
/// ��� ��������
/// </param>
/// <param name="AParent">
/// ������� �������, ����� �������� ��������� �������� ����� �����������
/// ����� ��������
/// </param>
/// <returns>
/// ������ �� ������� �������
/// </returns>
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

/// <summary>
/// ���������������� ������� ������� <b>TADOQuery</b> ��� <b>TSQLQuery</b> �
/// ��������� ������ �� ���� � ���� ������ �� �������
/// </summary>
/// <param name="AConnection">
/// ������ ����������� � ��
/// </param>
/// <returns>
/// ������ �� ������ �������
/// </returns>
function GetQuery(const AConnection: TCustomConnection): TDataSet;

/// <summary>
/// �������, ������������ ����������� ���������� �� ���������� ����
/// </summary>
function GetArchiveDocumentListClassByTypeId(const ATypeId: Integer): TArchiveDocumentListClass;

/// <summary>
/// ��������� �������� ���� �������� ��������� �� ���������� ��������
/// </summary>
procedure EmptyControl(const AControl: TCustomControl);

/// <summary>
/// ������� �����������, ������� �� ��������� ������ �� ����
/// </summary>
function IsNumericString(const AString: string): Boolean;

/// <summary>
/// ��������� ��������� ������ ��������� ����� ��� ��������� ������ �����
/// </summary>
procedure SetNumbersOnly(const Handle: HWND);

/// <summary>
/// ��������� ����������� ������ ���������� "�������������" �������
/// </summary>
procedure ShowShowableItem(const AParentControl: TCustomControl; const AShowableItem: IShowable);

implementation

uses
  uTShipmentBSOItem,
  uTShipmentBSOWithActItem,
  uTDamagedBSOItem,
  uTShipmentBSOList,
  uTShipmentBSOWithActList,
  uTDamagedBSOList,
  uIShowableField;

function GetControlByName(const AName: string; const AParent: TCustomControl): TControl;
var
  k: Integer;
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

procedure SetSQLForQuery(const AQuery: TDataSet; const ASQL: string; const AOpen: Boolean);
begin
  if AQuery is TADOQuery then
  begin
    (AQuery as TADOQuery).SQL.Clear;
    (AQuery as TADOQuery).SQL.Append(ASQL);
    if not AOpen then
    begin
      (AQuery as TADOQuery).ExecSQL;
    end;
  end
  else
  begin
    (AQuery as TSQLQuery).SQL.Clear;
    (AQuery as TSQLQuery).SQL.Append(ASQL);
    if not AOpen then
    begin
      (AQuery as TSQLQuery).ExecSQL;
    end;
  end;
  if AOpen then
  begin
    AQuery.Open;
  end;
end;

function GetADOQuery(const AConnection: TCustomConnection): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.Connection := AConnection as TADOConnection;
  Result.CommandTimeout := 60000;
  Result.LockType := ltReadOnly;
  Result.CursorType := ctOpenForwardOnly;
end;

function GetSQLQuery(const AConnection: TCustomConnection): TSQLQuery;
begin
  Result := TSQLQuery.Create(nil);
  Result.SQLConnection := AConnection as TSQLConnection;
end;

function GetQuery(const AConnection: TCustomConnection): TDataSet;
begin
  Result := nil;
  if Assigned(AConnection) then
  begin
    if AConnection is TADOConnection then
    begin
      Result := GetADOQuery(AConnection);
    end
    else
    begin
      Result := GetSQLQuery(AConnection);
    end;
  end;
end;

function GetArchiveDocumentListClassByTypeId(const ATypeId: Integer): TArchiveDocumentListClass;
begin
  case ATypeId of
    1:
      begin
        Result := TShipmentBSOList;
      end;
    2:
      begin
        Result := TShipmentBSOWithActList;
      end;
    5:
      begin
        Result := TDamagedBSOList;
      end;
  else
    begin
      Result := nil;
    end;
  end;
end;

procedure EmptyControl(const AControl: TCustomControl);
var
  i: Integer;
  c: TControl;
begin
  if Assigned(AControl) then
  begin
    for i := AControl.ControlCount - 1 downto 0 do
    begin
      c := AControl.Controls[i];
      c.Parent := nil;
      FreeAndNil(c);
    end;
  end;
end;

function IsNumericString(const AString: string): Boolean;
var
  s: string;
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(s) do
  begin
{$IFDEF VER150}
    case s[i] of
      '0' .. '9':
        begin
        end;
    else
      begin
        Result := False;
        Break;
      end;
    end;
{$ELSE}
    if not CharInSet(s[i], ['0' .. '9']) then
    begin
      Result := False;
      Break;
    end;
{$ENDIF}
  end;
end;

procedure SetNumbersOnly(const Handle: HWND);
begin
  SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or ES_NUMBER);
end;

procedure ShowShowableItem(const AParentControl: TCustomControl; const AShowableItem: IShowable);
var
  l1, l2: TLabel;
  j: Integer;
  c: TControl;
  old_height: Integer;
  wc: TWinControl;
begin
  if (not Assigned(AParentControl)) or (not Assigned(AShowableItem)) then
  begin
    Exit;
  end;

  EmptyControl(AParentControl);
  old_height := AParentControl.Height;

  if Assigned(AShowableItem.ShowableFields) then
  begin
    for j := 0 to AShowableItem.ShowableFields.Count - 1 do
    begin
      c := GetControlByName('lblShowInfo' + IShowableField(AShowableItem.ShowableFields[j]).Name + 'Caption',
        AParentControl);
      if Assigned(c) then
      begin
        l1 := c as TLabel;
      end
      else
      begin
        l1 := TLabel.Create(AParentControl);
      end;
      if j = 0 then
      begin
        AParentControl.Height := Integer(AParentControl is TGroupBox) * 10 +
{$IFDEF VER150}3{$ELSE}l1.Margins.Top{$ENDIF} +
{$IFDEF VER150}3{$ELSE}l1.Margins.Bottom{$ENDIF} + AShowableItem.ShowableFields.Count * (17 +
{$IFDEF VER150}3{$ELSE}l1.Margins.Top{$ENDIF});
      end;
      l1.Name := 'lblShowInfo' + IShowableField(AShowableItem.ShowableFields[j]).Name + 'Caption';
      l1.Parent := AParentControl;
      l1.Caption := IShowableField(AShowableItem.ShowableFields[j]).Caption;
      l1.Left := 8;
      l1.Top := Integer(AParentControl is TGroupBox) * 10 +
{$IFDEF VER150}3{$ELSE}AParentControl.Margins.Top{$ENDIF} +
{$IFDEF VER150}3{$ELSE}AParentControl.Margins.Bottom{$ENDIF} + j * (17 +
{$IFDEF VER150}3{$ELSE}AParentControl.Margins.Top{$ENDIF});

      c := GetControlByName('lblShowInfo' + IShowableField(AShowableItem.ShowableFields[j]).Name, AParentControl);
      if Assigned(c) then
      begin
        l2 := c as TLabel;
      end
      else
      begin
        l2 := TLabel.Create(AParentControl);
      end;
      if j = 0 then
      begin
        AParentControl.Height := Integer(AParentControl is TGroupBox) * 10 +
{$IFDEF VER150}3{$ELSE}l2.Margins.Top{$ENDIF} +
{$IFDEF VER150}3{$ELSE}l2.Margins.Bottom{$ENDIF} + AShowableItem.ShowableFields.Count * (17 +
{$IFDEF VER150}3{$ELSE}l2.Margins.Top{$ENDIF});
        wc := AParentControl.Parent;
        while Assigned(wc) do
        begin
          wc.Height := wc.Height - (old_height - AParentControl.Height);
          wc := wc.Parent;
        end;
      end;
      l2.Name := 'lblShowInfo' + IShowableField(AShowableItem.ShowableFields[j]).Name;
      l2.Caption := IShowableField(AShowableItem.ShowableFields[j]).Value;
      l2.Parent := AParentControl;
      l2.Left := AParentControl.ClientWidth div 2 + 8;
      l2.Top := Integer(AParentControl is TGroupBox) * 10 +
{$IFDEF VER150}3{$ELSE}AParentControl.Margins.Top{$ENDIF} +
{$IFDEF VER150}3{$ELSE}AParentControl.Margins.Bottom{$ENDIF} + j * (17 +
{$IFDEF VER150}3{$ELSE}AParentControl.Margins.Top{$ENDIF});
    end;
  end;
end;

end.
