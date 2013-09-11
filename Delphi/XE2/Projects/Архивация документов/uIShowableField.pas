unit uIShowableField;

interface

type
  IShowableField = interface
    ['{0EDC1B3E-4F99-483A-911F-37DAD5EC2104}']
    function GetCaption: string;
    procedure SetCaption(const AValue: string);

    /// <summary>
    /// Заголовок поля для вывода в виде текстовой метки
    /// </summary>
    property Caption: string read GetCaption write SetCaption;

    function GetName: string;
    procedure SetName(const AValue: string);

    /// <summary>
    /// Наименование поля
    /// </summary>
    /// <remarks>
    /// Используется для именования меток
    /// </remarks>
    property Name: string read GetName write SetName;
  end;

implementation

end.
