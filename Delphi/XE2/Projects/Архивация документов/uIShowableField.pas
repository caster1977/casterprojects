unit uIShowableField;

interface

type
  IShowableField = interface
    ['{0EDC1B3E-4F99-483A-911F-37DAD5EC2104}']
    function GetCaption: string;

    /// <summary>
    /// Заголовок поля для вывода в виде текстовой метки
    /// </summary>
    property Caption: string read GetCaption;

    function GetName: string;

    /// <summary>
    /// Наименование поля
    /// </summary>
    /// <remarks>
    /// Используется для именования меток
    /// </remarks>
    property Name: string read GetName;

    function GetValue: string;

    ///	<summary>
    ///	Значение поля в виде текстовой строки
    ///	</summary>
    property Value: string read GetValue;
  end;

implementation

end.
