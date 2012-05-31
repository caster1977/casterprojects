unit OA5.uIMeasure;

interface

type
  IMeasure = interface(IUnknown)
    ['{2345D94F-33A3-4DBA-9BAD-515277902732}']
    function GetAuthor: string;
    procedure SetAuthor(const Value: string);
    /// <summary>
    /// Автор мероприятия
    /// </summary>
    property _Author: string read GetAuthor write SetAuthor;

    function GetDurationDays: Integer;
    procedure SetDurationDays(const Value: Integer);
    /// <summary>
    /// Продолжительность мероприятия в сутках
    /// </summary>
    property _DurationDays: Integer read GetDurationDays write SetDurationDays;

    function GetDurationHours: Integer;
    procedure SetDurationHours(const Value: Integer);
    /// <summary>
    /// Продолжительность мероприятия в часах
    /// </summary>
    property _DurationHours: Integer read GetDurationHours write SetDurationHours;

    function GetDurationMinutes: Integer;
    procedure SetDurationMinutes(const Value: Integer);
    /// <summary>
    /// Продолжительность мероприятия в минутах
    /// </summary>
    property _DurationMinutes: Integer read GetDurationMinutes write SetDurationMinutes;

    function GetForAdultsOnly: boolean;
    procedure SetForAdultsOnly(const Value: boolean);
    /// <summary>
    /// Мероприятие "только для взрослых"?
    /// </summary>
    property _ForAdultsOnly: boolean read GetForAdultsOnly write SetForAdultsOnly;

    function GetForChildren: boolean;
    procedure SetForChildren(const Value: boolean);
    /// <summary>
    /// Мероприятие является детским?
    /// </summary>
    property _ForChildren: boolean read GetForChildren write SetForChildren;

    function GetForTeenagers: boolean;
    procedure SetForTeenagers(const Value: boolean);
    /// <summary>
    /// Мероприятие является подростковым?
    /// </summary>
    property _ForTeenagers: boolean read GetForTeenagers write SetForTeenagers;

    function GetHasStartDateTime: boolean;
    procedure SetHasStartDateTime(const Value: boolean);
    /// <summary>
    /// Есть ли у мероприятия дата/время начала
    /// </summary>
    property _HasStartDateTime: boolean read GetHasStartDateTime write SetHasStartDateTime;

    function GetHasStopDateTime: boolean;
    procedure SetHasStopDateTime(const Value: boolean);
    /// <summary>
    /// Есть ли у мероприятия дата/время окончания
    /// </summary>
    property _HasStopDateTime: boolean read GetHasStopDateTime write SetHasStopDateTime;

    function GetIsPremier: boolean;
    procedure SetIsPremier(const Value: boolean);
    /// <summary>
    /// Мероприятие является премьерным?
    /// </summary>
    property _IsPremier: boolean read GetIsPremier write SetIsPremier;

    function GetIsTour: boolean;
    procedure SetIsTour(const Value: boolean);
    /// <summary>
    /// Мероприятие является гастрольным?
    /// </summary>
    property _IsTour: boolean read GetIsTour write SetIsTour;

    function GetName: string;
    procedure SetName(const Value: string);
    /// <summary>
    /// Наименование мероприятия
    /// </summary>
    property _Name: string read GetName write SetName;

    function GetOrganizationID: Integer;
    procedure SetOrganizationID(const Value: Integer);
    /// <summary>
    /// Идентификатор организации, которая проводит мероприятие
    /// </summary>
    property _OrganizationID: Integer read GetOrganizationID write SetOrganizationID;

    function GetOrganizer: string;
    procedure SetOrganizer(const Value: string);
    /// <summary>
    /// Организатор мероприятия
    /// </summary>
    property _Organizer: string read GetOrganizer write SetOrganizer;

    function GetOtherInfoPlane: AnsiString;
    procedure SetOtherInfoPlane(const Value: AnsiString);
    /// <summary>
    /// Прочая информация о мероприятии в виде plain-текста
    /// </summary>
    property _OtherInfoPlane: AnsiString read GetOtherInfoPlane write SetOtherInfoPlane;

    function GetOtherInfoRTF: AnsiString;
    procedure SetOtherInfoRTF(const Value: AnsiString);
    /// <summary>
    /// Прочая информация о мероприятии в виде содержимого RTF-документа
    /// </summary>
    property _OtherInfoRTF: AnsiString read GetOtherInfoRTF write SetOtherInfoRTF;

    function GetPerformer: string;
    procedure SetPerformer(const Value: string);
    /// <summary>
    /// Исполнитель(и) мероприятия
    /// </summary>
    property _Performer: string read GetPerformer write SetPerformer;

    function GetProducer: string;
    procedure SetProducer(const Value: string);
    /// <summary>
    /// Режиссёр/продюссер мероприятия
    /// </summary>
    property _Producer: string read GetProducer write SetProducer;

    function GetStartDateTime: TDateTime;
    procedure SetStartDateTime(const Value: TDateTime);
    /// <summary>
    /// Дата/время начала мероприятия
    /// </summary>
    property _StartDateTime: TDateTime read GetStartDateTime write SetStartDateTime;

    function GetStopDateTime: TDateTime;
    procedure SetStopDateTime(const Value: TDateTime);
    /// <summary>
    /// Дата/время окончания мероприятия
    /// </summary>
    property _StopDateTime: TDateTime read GetStopDateTime write SetStopDateTime;

    function GetTicketPrice: string;
    procedure SetTicketPrice(const Value: string);
    /// <summary>
    /// Стоимость билетов на мероприятие
    /// </summary>
    property _TicketPrice: string read GetTicketPrice write SetTicketPrice;

    function GetType: string;
    procedure SetType(const Value: string);
    /// <summary>
    /// Тип мероприятия
    /// </summary>
    property _Type: string read GetType write SetType;

    function GetUnknownDuration: boolean;
    procedure SetUnknownDuration(const Value: boolean);
    /// <summary>
    /// Длительность мероприятия неизвестна?
    /// </summary>
    property _UnknownDuration: boolean read GetUnknownDuration write SetUnknownDuration;
  end;

implementation

end.
