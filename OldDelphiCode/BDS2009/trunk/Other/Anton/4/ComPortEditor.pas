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

// Отображение редактора
procedure TDCBPropertyEditor.Edit;
Var Comp     : TPersistent;
begin
 // Получить редактируемый компонент
 Comp:= GetComponent(0);
 // Проверим тип компонента для исключения ошибок
 If not (Comp is TComPort) then Exit;

 If TComPort(Comp).CommDialog then
  If Designer <> nil then {передаем уведомление об изменениях}
   Designer.Modified;     {дизайнеру форм}
end;

// Параметры редактора свойств:
//  paDialog   - для редактирования будет отображаться диалог
//  paReadOnly - нельзя редактировать свойство напрямую
function TDCBPropertyEditor.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog, paSubProperties];
end;

// Строка, отображаемая в Инспекторе Объектов
function TDCBPropertyEditor.GetValue: string;
begin
 Result := '(COM Properties)';
end;

// Установка значения
procedure TDCBPropertyEditor.SetValue(const Value: string);
begin
// нельзя устанавливать значение
end;

// Регистрация редактора свойств
procedure Register;
begin
 RegisterComponents('Comm', [TComPort]);
 RegisterPropertyEditor(TypeInfo(TComProp), TComPort, 'ComProp', TDCBPropertyEditor);
end;

end.
