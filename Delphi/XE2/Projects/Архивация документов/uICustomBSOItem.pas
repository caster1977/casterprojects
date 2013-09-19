unit uICustomBSOItem;

interface

uses
  uIArchiveDocumentItem;

type
  /// <summary>
  /// ��������� ��� ������� � �������� ���� ���
  /// </summary>
  ICustomBSOItem = interface(IArchiveDocumentItem)
  ['{745F9853-8503-45F4-94B7-DD295579CEC4}']
    function GetBSOId: Integer;
    procedure SetBSOId(const AValue: Integer);

    /// <summary>
    /// ������������� ���
    /// </summary>
    property BSOId: Integer read GetBSOId write SetBSOId;

    function GetSeries: string;
    procedure SetSeries(const AValue: string);

    /// <summary>
    /// ����� ���
    /// </summary>
    property Series: string read GetSeries write SetSeries;

    function GetNumber: string;
    procedure SetNumber(const AValue: string);

    /// <summary>
    /// ����� ���
    /// </summary>
    property Number: string read GetNumber write SetNumber;
  end;

implementation

end.
