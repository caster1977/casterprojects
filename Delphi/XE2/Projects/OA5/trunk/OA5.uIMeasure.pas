unit OA5.uIMeasure;

interface

type
  IMeasure = interface
    ['{2345D94F-33A3-4DBA-9BAD-515277902732}']
    function GetAuthor: string;
    procedure SetAuthor(const AValue: string);
    /// <summary>
    /// ����� �����������
    /// </summary>
    property Author: string read GetAuthor write SetAuthor;

    function GetDurationDays: Integer;
    procedure SetDurationDays(const AValue: Integer);
    /// <summary>
    /// ����������������� ����������� � ������
    /// </summary>
    property DurationDays: Integer read GetDurationDays write SetDurationDays;

    function GetDurationHours: Integer;
    procedure SetDurationHours(const AValue: Integer);
    /// <summary>
    /// ����������������� ����������� � �����
    /// </summary>
    property DurationHours: Integer read GetDurationHours write SetDurationHours;

    function GetDurationMinutes: Integer;
    procedure SetDurationMinutes(const AValue: Integer);
    /// <summary>
    /// ����������������� ����������� � �������
    /// </summary>
    property DurationMinutes: Integer read GetDurationMinutes write SetDurationMinutes;

    function GetForAdultsOnly: Boolean;
    procedure SetForAdultsOnly(const AValue: Boolean);
    /// <summary>
    /// �����������"������ ��� ��������"?
    /// </summary>
    property ForAdultsOnly: Boolean read GetForAdultsOnly write SetForAdultsOnly;

    function GetForChildren: Boolean;
    procedure SetForChildren(const AValue: Boolean);
    /// <summary>
    /// ����������� �������� �������?
    /// </summary>
    property ForChildren: Boolean read GetForChildren write SetForChildren;

    function GetForTeenagers: Boolean;
    procedure SetForTeenagers(const AValue: Boolean);
    /// <summary>
    /// ����������� �������� ������������?
    /// </summary>
    property ForTeenagers: Boolean read GetForTeenagers write SetForTeenagers;

    function GetHasUnknownDuration: Boolean;
    procedure SetHasUnknownDuration(const AValue: Boolean);
    /// <summary>
    /// ������������ ����������� ����������?
    /// </summary>
    property HasUnknownDuration: Boolean read GetHasUnknownDuration write SetHasUnknownDuration;

    function GetHasStartDateTime: Boolean;
    procedure SetHasStartDateTime(const AValue: Boolean);
    /// <summary>
    /// ���� �� � ����������� ����/����� ������
    /// </summary>
    property HasStartDateTime: Boolean read GetHasStartDateTime write SetHasStartDateTime;

    function GetHasStopDateTime: Boolean;
    procedure SetHasStopDateTime(const AValue: Boolean);
    /// <summary>
    /// ���� �� � ����������� ����/����� ���������
    /// </summary>
    property HasStopDateTime: Boolean read GetHasStopDateTime write SetHasStopDateTime;

    function GetIsPremier: Boolean;
    procedure SetIsPremier(const AValue: Boolean);
    /// <summary>
    /// ����������� �������� ����������?
    /// </summary>
    property IsPremier: Boolean read GetIsPremier write SetIsPremier;

    function GetIsTour: Boolean;
    procedure SetIsTour(const AValue: Boolean);
    /// <summary>
    /// ����������� �������� �����������?
    /// </summary>
    property IsTour: Boolean read GetIsTour write SetIsTour;

    function GetIsSport: Boolean;
    procedure SetIsSport(const AValue: Boolean);
    /// <summary>
    /// ����������� �������� ����������?
    /// </summary>
    property IsSport: Boolean read GetIsSport write SetIsSport;

    function GetName: string;
    procedure SetName(const AValue: string);
    /// <summary>
    /// ������������ �����������
    /// </summary>
    property Name: string read GetName write SetName;

    function GetOrganizationID: Integer;
    procedure SetOrganizationID(const AValue: Integer);
    /// <summary>
    /// ������������� �����������, ������� �������� �����������
    /// </summary>
    property OrganizationID: Integer read GetOrganizationID write SetOrganizationID;

    function GetOrganizer: string;
    procedure SetOrganizer(const AValue: string);
    /// <summary>
    /// ����������� �����������
    /// </summary>
    property Organizer: string read GetOrganizer write SetOrganizer;

    function GetOtherInfoPlane: AnsiString;
    procedure SetOtherInfoPlane(const AValue: AnsiString);
    /// <summary>
    /// ������ ���������� � ����������� � ���� plain-������
    /// </summary>
    property OtherInfoPlane: AnsiString read GetOtherInfoPlane write SetOtherInfoPlane;

    function GetOtherInfoRTF: AnsiString;
    procedure SetOtherInfoRTF(const AValue: AnsiString);
    /// <summary>
    /// ������ ���������� � ������������ ���� ����������� RTF-���������
    /// </summary>
    property OtherInfoRTF: AnsiString read GetOtherInfoRTF write SetOtherInfoRTF;

    function GetPerformer: string;
    procedure SetPerformer(const AValue: string);
    /// <summary>
    /// �����������(�) �����������
    /// </summary>
    property Performer: string read GetPerformer write SetPerformer;

    function GetProducer: string;
    procedure SetProducer(const AValue: string);
    /// <summary>
    /// �������/��������� �����������
    /// </summary>
    property Producer: string read GetProducer write SetProducer;

    function GetStartDateTime: TDateTime;
    procedure SetStartDateTime(const AValue: TDateTime);
    /// <summary>
    /// ����/����� ������ �����������
    /// </summary>
    property StartDateTime: TDateTime read GetStartDateTime write SetStartDateTime;

    function GetStopDateTime: TDateTime;
    procedure SetStopDateTime(const AValue: TDateTime);
    /// <summary>
    /// ����/��������������� �����������
    /// </summary>
    property StopDateTime: TDateTime read GetStopDateTime write SetStopDateTime;

    function GetTicketPrice: string;
    procedure SetTicketPrice(const AValue: string);
    /// <summary>
    /// ��������� ������� �� �����������
    /// </summary>
    property TicketPrice: string read GetTicketPrice write SetTicketPrice;

    function GetType: string;
    procedure SetType(const AValue: string);
    /// <summary>
    /// ��� �����������
    /// </summary>
    property Type_: string read GetType write SetType;
  end;

implementation

end.
