Unit ComPortEditor;

                                 interface

{$IFDEF VER140}
uses Windows, Classes, Graphics, Forms, Controls, Buttons, DesignIntf,
  DesignWindows, StdCtrls, ComCtrls, DesignEditors, TypInfo, SysUtils;
{$ELSE}

{$IFDEF VER150}
uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ComCtrls, TypInfo, SysUtils, 
  DesignEditors, DesignIntf;
{$ELSE}
uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ComCtrls, TypInfo, SysUtils, dsgnintf;
{$ENDIF}
{$ENDIF}

type
  TDCBPropertyEditor = class(TClassProperty) 
  public
   procedure Edit; override;
   function  GetAttributes: TPropertyAttributes; override;
   function  GetValue: string; override;
   procedure SetValue(const Value: string); override;
  end;

procedure Register;

implementation

Uses Dialogs, ComPort;

// ����������� ���������
procedure TDCBPropertyEditor.Edit;
Var Comp     : TPersistent;
begin
 // �������� ������������� ���������
 Comp:= GetComponent(0);
 // �������� ��� ���������� ��� ���������� ������
 If not (Comp is TComPort) then Exit;

 If TComPort(Comp).CommDialog then
  If Designer <> nil then {�������� ����������� �� ����������}
   Designer.Modified;     {��������� ����}
end;

// ��������� ��������� �������:
//  paDialog   - ��� �������������� ����� ������������ ������
//  paReadOnly - ������ ������������� �������� ��������
function TDCBPropertyEditor.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog, paSubProperties];
end;

// ������, ������������ � ���������� ��������
function TDCBPropertyEditor.GetValue: string;
begin
 Result := '(COM Properties)';
end;

// ��������� ��������
procedure TDCBPropertyEditor.SetValue(const Value: string);
begin
// ������ ������������� ��������
end;

// ����������� ��������� �������
procedure Register;
begin
 RegisterComponents('Comm', [TComPort]);
 RegisterPropertyEditor(TypeInfo(TComProp), TComPort, 'ComProp', TDCBPropertyEditor);
end;

end.
