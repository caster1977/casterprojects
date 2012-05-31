unit OA5.uIMeasure;

interface

type
  IMeasure = interface(IUnknown)
    ['{2345D94F-33A3-4DBA-9BAD-515277902732}']
    function GetAuthor: string;
    procedure SetAuthor(const Value: string);
    /// <summary>
    /// ����� �����������
    /// </summary>
    property _Author: string read GetAuthor write SetAuthor;

    function GetDurationDays: Integer;
    procedure SetDurationDays(const Value: Integer);
    /// <summary>
    /// ����������������� ����������� � ������
    /// </summary>
    property _DurationDays: Integer read GetDurationDays write SetDurationDays;

    function GetDurationHours: Integer;
    procedure SetDurationHours(const Value: Integer);
    /// <summary>
    /// ����������������� ����������� � �����
    /// </summary>
    property _DurationHours: Integer read GetDurationHours write SetDurationHours;

    function GetDurationMinutes: Integer;
    procedure SetDurationMinutes(const Value: Integer);
    /// <summary>
    /// ����������������� ����������� � �������
    /// </summary>
    property _DurationMinutes: Integer read GetDurationMinutes write SetDurationMinutes;

    function GetForAdultsOnly: boolean;
    procedure SetForAdultsOnly(const Value: boolean);
    /// <summary>
    /// �����������"������ ��� ��������"?
    /// </summary>
    property _ForAdultsOnly: boolean read GetForAdultsOnly write SetForAdultsOnly;

    function GetForChildren: boolean;
    procedure SetForChildren(const Value: boolean);
    /// <summary>
    /// ����������� �������� �������?
    /// </summary>
    property _ForChildren: boolean read GetForChildren write SetForChildren;

    function GetForTeenagers: boolean;
    procedure SetForTeenagers(const Value: boolean);
    /// <summary>
    /// ����������� �������� ������������?
    /// </summary>
    property _ForTeenagers: boolean read GetForTeenagers write SetForTeenagers;

    function GetHasStartDateTime: boolean;
    procedure SetHasStartDateTime(const Value: boolean);
    /// <summary>
    /// ���� �� � ����������� ����/����� ������
    /// </summary>
    property _HasStartDateTime: boolean read GetHasStartDateTime write SetHasStartDateTime;

    function GetHasStopDateTime: boolean;
    procedure SetHasStopDateTime(const Value: boolean);
    /// <summary>
    /// ���� �� � ����������� ����/����� ���������
    /// </summary>
    property _HasStopDateTime: boolean read GetHasStopDateTime write SetHasStopDateTime;

    function GetIsPremier: boolean;
    procedure SetIsPremier(const Value: boolean);
    /// <summary>
    /// ����������� �������� ����������?
    /// </summary>
    property _IsPremier: boolean read GetIsPremier write SetIsPremier;

    function GetIsTour: boolean;
    procedure SetIsTour(const Value: boolean);
    /// <summary>
    /// ����������� �������� �����������?
    /// </summary>
    property _IsTour: boolean read GetIsTour write SetIsTour;

    function GetName: string;
    procedure SetName(const Value: string);
    /// <summary>
    /// ������������ �����������
    /// </summary>
    property _Name: string read GetName write SetName;

    function GetOrganizationID: Integer;
    procedure SetOrganizationID(const Value: Integer);
    /// <summary>
    /// ������������� �����������, ������� �������� �����������
    /// </summary>
    property _OrganizationID: Integer read GetOrganizationID write SetOrganizationID;

    function GetOrganizer: string;
    procedure SetOrganizer(const Value: string);
    /// <summary>
    /// ����������� �����������
    /// </summary>
    property _Organizer: string read GetOrganizer write SetOrganizer;

    function GetOtherInfoPlane: AnsiString;
    procedure SetOtherInfoPlane(const Value: AnsiString);
    /// <summary>
    /// ������ ���������� � ����������� � ���� plain-������
    /// </summary>
    property _OtherInfoPlane: AnsiString read GetOtherInfoPlane write SetOtherInfoPlane;

    function GetOtherInfoRTF: AnsiString;
    procedure SetOtherInfoRTF(const Value: AnsiString);
    /// <summary>
    /// ������ ���������� � ������������ ���� ����������� RTF-���������
    /// </summary>
    property _OtherInfoRTF: AnsiString read GetOtherInfoRTF write SetOtherInfoRTF;

    function GetPerformer: string;
    procedure SetPerformer(const Value: string);
    /// <summary>
    /// �����������(�) �����������
    /// </summary>
    property _Performer: string read GetPerformer write SetPerformer;

    function GetProducer: string;
    procedure SetProducer(const Value: string);
    /// <summary>
    /// �������/��������� �����������
    /// </summary>
    property _Producer: string read GetProducer write SetProducer;

    function GetStartDateTime: TDateTime;
    procedure SetStartDateTime(const Value: TDateTime);
    /// <summary>
    /// ����/����� ������ �����������
    /// </summary>
    property _StartDateTime: TDateTime read GetStartDateTime write SetStartDateTime;

    function GetStopDateTime: TDateTime;
    procedure SetStopDateTime(const Value: TDateTime);
    /// <summary>
    /// ����/��������������� �����������
    /// </summary>
    property _StopDateTime: TDateTime read GetStopDateTime write SetStopDateTime;

    function GetTicketPrice: string;
    procedure SetTicketPrice(const Value: string);
    /// <summary>
    /// ��������� ������� �� �����������
    /// </summary>
    property _TicketPrice: string read GetTicketPrice write SetTicketPrice;

    function GetType: string;
    procedure SetType(const Value: string);
    /// <summary>
    /// ��� �����������
    /// </summary>
    property _Type: string read GetType write SetType;

    function GetUnknownDuration: boolean;
    procedure SetUnknownDuration(const Value: boolean);
    /// <summary>
    /// ������������ ����������� ����������?
    /// </summary>
    property _UnknownDuration: boolean read GetUnknownDuration write SetUnknownDuration;
  end;

implementation

end.
