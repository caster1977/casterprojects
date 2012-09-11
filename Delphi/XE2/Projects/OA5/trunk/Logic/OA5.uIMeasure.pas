unit OA5.uIMeasure;

interface

type
  IMeasure = interface
    ['{2345D94F-33A3-4DBA-9BAD-515277902732}']
    function GetAuthor: string;
    procedure SetAuthor(const AValue: string);
    /// <summary>
    /// Автор мероприятия
    /// </summary>
    property Author: string read GetAuthor write SetAuthor;

    function GetDurationDays: Integer;
    procedure SetDurationDays(const AValue: Integer);
    /// <summary>
    /// Продолжительность мероприятия в сутках
    /// </summary>
    property DurationDays: Integer read GetDurationDays write SetDurationDays;

    function GetDurationHours: Integer;
    procedure SetDurationHours(const AValue: Integer);
    /// <summary>
    /// Продолжительность мероприятия в часах
    /// </summary>
    property DurationHours: Integer read GetDurationHours write SetDurationHours;

    function GetDurationMinutes: Integer;
    procedure SetDurationMinutes(const AValue: Integer);
    /// <summary>
    /// Продолжительность мероприятия в минутах
    /// </summary>
    property DurationMinutes: Integer read GetDurationMinutes write SetDurationMinutes;

    function GetForAdultsOnly: Boolean;
    procedure SetForAdultsOnly(const AValue: Boolean);
    /// <summary>
    /// Мероприятие "только для взрослых"?
    /// </summary>
    property ForAdultsOnly: Boolean read GetForAdultsOnly write SetForAdultsOnly;

    function GetForChildren: Boolean;
    procedure SetForChildren(const AValue: Boolean);
    /// <summary>
    /// Мероприятие является детским?
    /// </summary>
    property ForChildren: Boolean read GetForChildren write SetForChildren;

    function GetForTeenagers: Boolean;
    procedure SetForTeenagers(const AValue: Boolean);
    /// <summary>
    /// Мероприятие является подростковым?
    /// </summary>
    property ForTeenagers: Boolean read GetForTeenagers write SetForTeenagers;

    function GetHasUnknownDuration: Boolean;
    procedure SetHasUnknownDuration(const AValue: Boolean);
    /// <summary>
    /// Длительность мероприятия неизвестна?
    /// </summary>
    property HasUnknownDuration: Boolean read GetHasUnknownDuration write SetHasUnknownDuration;

    function GetHasStartDateTime: Boolean;
    procedure SetHasStartDateTime(const AValue: Boolean);
    /// <summary>
    /// Есть ли у мероприятия дата/время начала
    /// </summary>
    property HasStartDateTime: Boolean read GetHasStartDateTime write SetHasStartDateTime;

    function GetHasStopDateTime: Boolean;
    procedure SetHasStopDateTime(const AValue: Boolean);
    /// <summary>
    /// Есть ли у мероприятия дата/время окончания
    /// </summary>
    property HasStopDateTime: Boolean read GetHasStopDateTime write SetHasStopDateTime;

    function GetIsPremier: Boolean;
    procedure SetIsPremier(const AValue: Boolean);
    /// <summary>
    /// Мероприятие является премьерным?
    /// </summary>
    property IsPremier: Boolean read GetIsPremier write SetIsPremier;

    function GetIsTour: Boolean;
    procedure SetIsTour(const AValue: Boolean);
    /// <summary>
    /// Мероприятие является гастрольным?
    /// </summary>
    property IsTour: Boolean read GetIsTour write SetIsTour;

    function GetIsSport: Boolean;
    procedure SetIsSport(const AValue: Boolean);
    /// <summary>
    /// Мероприятие является спортивным?
    /// </summary>
    property IsSport: Boolean read GetIsSport write SetIsSport;

    function GetName: string;
    procedure SetName(const AValue: string);
    /// <summary>
    /// Наименование мероприятия
    /// </summary>
    property Name: string read GetName write SetName;

    function GetOrganizationID: Integer;
    procedure SetOrganizationID(const AValue: Integer);
    /// <summary>
    /// Идентификатор организации, которая проводит мероприятие
    /// </summary>
    property OrganizationID: Integer read GetOrganizationID write SetOrganizationID;

    function GetOrganizer: string;
    procedure SetOrganizer(const AValue: string);
    /// <summary>
    /// Организатор мероприятия
    /// </summary>
    property Organizer: string read GetOrganizer write SetOrganizer;

    function GetOtherInfoPlane: AnsiString;
    procedure SetOtherInfoPlane(const AValue: AnsiString);
    /// <summary>
    /// Прочая информация о мероприятии в виде plain-текста
    /// </summary>
    property OtherInfoPlane: AnsiString read GetOtherInfoPlane write SetOtherInfoPlane;

    function GetOtherInfoRTF: AnsiString;
    procedure SetOtherInfoRTF(const AValue: AnsiString);
    /// <summary>
    /// Прочая информация о мероприятии в виде содержимого RTF-документа
    /// </summary>
    property OtherInfoRTF: AnsiString read GetOtherInfoRTF write SetOtherInfoRTF;

    function GetPerformer: string;
    procedure SetPerformer(const AValue: string);
    /// <summary>
    /// Исполнитель(и) мероприятия
    /// </summary>
    property Performer: string read GetPerformer write SetPerformer;

    function GetProducer: string;
    procedure SetProducer(const AValue: string);
    /// <summary>
    /// Режиссёр/продюссер мероприятия
    /// </summary>
    property Producer: string read GetProducer write SetProducer;

    function GetStartDateTime: TDateTime;
    procedure SetStartDateTime(const AValue: TDateTime);
    /// <summary>
    /// Дата/время начала мероприятия
    /// </summary>
    property StartDateTime: TDateTime read GetStartDateTime write SetStartDateTime;

    function GetStopDateTime: TDateTime;
    procedure SetStopDateTime(const AValue: TDateTime);
    /// <summary>
    /// Дата/время окончания мероприятия
    /// </summary>
    property StopDateTime: TDateTime read GetStopDateTime write SetStopDateTime;

    function GetTicketPrice: string;
    procedure SetTicketPrice(const AValue: string);
    /// <summary>
    /// Стоимость билетов на мероприятие
    /// </summary>
    property TicketPrice: string read GetTicketPrice write SetTicketPrice;

    function GetType: string;
    procedure SetType(const AValue: string);
    /// <summary>
    /// Тип мероприятия
    /// </summary>
    property Type_: string read GetType write SetType;
  end;

implementation

end.
