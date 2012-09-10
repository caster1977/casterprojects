unit OA5.uTMeasure;

interface

uses
  OA5.uINormalized,
  OA5.uIMeasure,
  System.SysUtils,
  System.Classes,
  OA5.uDefaultConsts;

type
  /// <summary>
  /// �����, �������������� ��� �������� ������ �����������
  /// </summary>
  TMeasure = class(TInterfacedPersistent, IMeasure, INormalized)
  strict private
    FAutoNormalizeData: Boolean;
    FOrganizationID: Integer;
    FType: string;
    FName: string;
    FAuthor: string;
    FProducer: string;
    FPerformer: string;
    FOrganizer: string;
    FTicketPrice: string;
    FOtherInfoRTF: AnsiString;
    FOtherInfoPlane: AnsiString;
    FHasUnknownDuration: Boolean;
    FHasStartDateTime: Boolean;
    FHasStopDateTime: Boolean;
    FStartDateTime: TDateTime;
    FStopDateTime: TDateTime;
    FDurationDays: Integer;
    FDurationHours: Integer;
    FDurationMinutes: Integer;
    FIsPremier: Boolean;
    FIsTour: Boolean;
    FIsSport: Boolean;
    FForChildren: Boolean;
    FForTeenagers: Boolean;
    FForAdultsOnly: Boolean;
    function GetAutoNormalizeData: Boolean;
    procedure SetAutoNormalizeData(const AValue: Boolean);
    function GetOrganizationID: Integer;
    procedure SetOrganizationID(const AValue: Integer);
    function GetType: string;
    procedure SetType(const AValue: string);
    function GetName: string;
    procedure SetName(const AValue: string);
    function GetAuthor: string;
    procedure SetAuthor(const AValue: string);
    function GetProducer: string;
    procedure SetProducer(const AValue: string);
    function GetPerformer: string;
    procedure SetPerformer(const AValue: string);
    function GetOrganizer: string;
    procedure SetOrganizer(const AValue: string);
    function GetTicketPrice: string;
    procedure SetTicketPrice(const AValue: string);
    function GetOtherInfoRTF: AnsiString;
    procedure SetOtherInfoRTF(const AValue: AnsiString);
    function GetOtherInfoPlane: AnsiString;
    procedure SetOtherInfoPlane(const AValue: AnsiString);
    function GetHasStartDateTime: Boolean;
    procedure SetHasStartDateTime(const AValue: Boolean);
    function GetHasStopDateTime: Boolean;
    procedure SetHasStopDateTime(const AValue: Boolean);
    function GetStartDateTime: TDateTime;
    procedure SetStartDateTime(const AValue: TDateTime);
    function GetStopDateTime: TDateTime;
    procedure SetStopDateTime(const AValue: TDateTime);
    function GetDurationDays: Integer;
    procedure SetDurationDays(const AValue: Integer);
    function GetDurationHours: Integer;
    procedure SetDurationHours(const AValue: Integer);
    function GetDurationMinutes: Integer;
    procedure SetDurationMinutes(const AValue: Integer);
    function GetHasUnknownDuration: Boolean;
    procedure SetHasUnknownDuration(const AValue: Boolean);
    function GetIsPremier: Boolean;
    procedure SetIsPremier(const AValue: Boolean);
    function GetIsTour: Boolean;
    procedure SetIsTour(const AValue: Boolean);
    function GetIsSport: Boolean;
    procedure SetIsSport(const AValue: Boolean);
    function GetForChildren: Boolean;
    procedure SetForChildren(const AValue: Boolean);
    function GetForTeenagers: Boolean;
    procedure SetForTeenagers(const AValue: Boolean);
    function GetForAdultsOnly: Boolean;
    procedure SetForAdultsOnly(const AValue: Boolean);
    class procedure SetField(const AValue: Integer; var AField: Integer); overload; static;
    class procedure SetField(const AValue: Boolean; var AField: Boolean); overload; static;
    class procedure SetField(const AValue: TDateTime; var AField: TDateTime); overload; static;
    class procedure SetField(const AValue: AnsiString; var AField: AnsiString); overload; static;
    procedure SetField(const AValue: string; var AField: string); overload;
  public
    /// <summary>
    /// ����������� ������
    /// </summary>
    /// <param name="AAutoNormalizeData">
    /// ����� �� ����� ������������� ��������� ������������ ������ ���
    /// ���������� �������� ��������� ��������� �������. �������� ��
    /// ����������- <b>DEFAULT_MEASURE_AUTO_NORMALIZE_DATA</b>.
    /// </param>
    constructor Create(const AAutoNormalizeData: Boolean = DEFAULT_MEASURE_AUTO_NORMALIZE_DATA); virtual;
    /// <summary>
    /// ����������������� ������ ������ (������ ����������������)
    /// </summary>
    /// <returns>
    /// <para>
    /// ���� ������������ ������ <i>
    /// <b>�� ���������</b>
    /// </i> - ����� ���������� <b>True</b>.
    /// </para>
    /// <para>
    /// ���� ������������ ������ <i>
    /// <b>���������</b>
    /// </i>, ����� ���������� <b>False</b>.
    /// </para>
    /// </returns>
    /// <remarks>
    /// ��. ����� ��������� <b>Normalize</b>
    /// </remarks>
    function IsNormalized: Boolean; virtual;
    /// <summary>
    /// ��������� ������������ �������� ������ ������
    /// </summary>
    /// <remarks>
    /// ��. ����� ������� <b>Normalized</b>
    /// </remarks>
    procedure Normalize; virtual;
  published
    /// <summary>
    /// ��������� �� ��� ������ ������ � ���� ������������� ��������� ��
    /// ������������?
    /// </summary>
    /// <remarks>
    /// ��� �� �������� �������� ����� �������� ��� �������� ������� �����
    /// �����������<b>Create(<i>��������</i>);</b>
    /// </remarks>
    property AutoNormalizeData: Boolean read GetAutoNormalizeData write SetAutoNormalizeData default True;
    /// <summary>
    /// ����� �����������
    /// </summary>
    property Author: string read GetAuthor write SetAuthor nodefault;
    /// <summary>
    /// ����������������� ����������� � ������
    /// </summary>
    property DurationDays: Integer read GetDurationDays write SetDurationDays default DEFAULT_MEASURE_DURATION_DAYS;
    /// <summary>
    /// ����������������� ����������� � �����
    /// </summary>
    property DurationHours: Integer read GetDurationHours write SetDurationHours default DEFAULT_MEASURE_DURATION_HOURS;
    /// <summary>
    /// ����������������� ����������� � �������
    /// </summary>
    property DurationMinutes: Integer read GetDurationMinutes write SetDurationMinutes
      default DEFAULT_MEASURE_DURATION_MINUTES;
    /// <summary>
    /// �����������"������ ��� ��������"?
    /// </summary>
    property ForAdultsOnly: Boolean read GetForAdultsOnly write SetForAdultsOnly
      default DEFAULT_MEASURE_FOR_ADULTS_ONLY;
    /// <summary>
    /// ����������� �������� �������?
    /// </summary>
    property ForChildren: Boolean read GetForChildren write SetForChildren default DEFAULT_MEASURE_FOR_CHILDREN;
    /// <summary>
    /// ����������� �������� ������������?
    /// </summary>
    property ForTeenagers: Boolean read GetForTeenagers write SetForTeenagers default DEFAULT_MEASURE_FOR_TEENAGERS;
    /// <summary>
    /// ������������ ����������� ����������?
    /// </summary>
    property HasUnknownDuration: Boolean read GetHasUnknownDuration write SetHasUnknownDuration
      default DEFAULT_MEASURE_HAS_UNKNOWN_DURATION;
    /// <summary>
    /// ���� �� � ����������� ����/����� ������
    /// </summary>
    property HasStartDateTime: Boolean read GetHasStartDateTime write SetHasStartDateTime
      default DEFAULT_MEASURE_HAS_START_DATETIME;
    /// <summary>
    /// ���� �� � ����������� ����/����� ���������
    /// </summary>
    property HasStopDateTime: Boolean read GetHasStopDateTime write SetHasStopDateTime
      default DEFAULT_MEASURE_HAS_STOP_DATETIME;
    /// <summary>
    /// ����������� �������� ����������?
    /// </summary>
    property IsPremier: Boolean read GetIsPremier write SetIsPremier default DEFAULT_MEASURE_IS_PREMIER;
    /// <summary>
    /// ����������� �������� �����������?
    /// </summary>
    property IsTour: Boolean read GetIsTour write SetIsTour default DEFAULT_MEASURE_IS_TOUR;
    /// <summary>
    /// ����������� �������� ����������?
    /// </summary>
    property IsSport: Boolean read GetIsSport write SetIsSport default DEFAULT_MEASURE_IS_SPORT;
    /// <summary>
    /// ������������ �����������
    /// </summary>
    property name: string read GetName write SetName nodefault;
    /// <summary>
    /// ������������� �����������, ������� �������� �����������
    /// </summary>
    property OrganizationID: Integer read GetOrganizationID write SetOrganizationID
      default DEFAULT_MEASURE_ORGANIZATION_ID;
    /// <summary>
    /// ����������� �����������
    /// </summary>
    property Organizer: string read GetOrganizer write SetOrganizer nodefault;
    /// <summary>
    /// ������ ���������� � ����������� � ���� plain-������
    /// </summary>
    property OtherInfoPlane: AnsiString read GetOtherInfoPlane write SetOtherInfoPlane nodefault;
    /// <summary>
    /// ������ ���������� � ������������ ���� ����������� RTF-���������
    /// </summary>
    property OtherInfoRTF: AnsiString read GetOtherInfoRTF write SetOtherInfoRTF nodefault;
    /// <summary>
    /// �����������(�) �����������
    /// </summary>
    property Performer: string read GetPerformer write SetPerformer nodefault;
    /// <summary>
    /// �������/��������� �����������
    /// </summary>
    property Producer: string read GetProducer write SetProducer nodefault;
    /// <summary>
    /// ����/����� ������ �����������
    /// </summary>
    property StartDateTime: TDateTime read GetStartDateTime write SetStartDateTime nodefault;
    /// <summary>
    /// ����/��������������� �����������
    /// </summary>
    property StopDateTime: TDateTime read GetStopDateTime write SetStopDateTime nodefault;
    /// <summary>
    /// ��������� ������� �� �����������
    /// </summary>
    property TicketPrice: string read GetTicketPrice write SetTicketPrice nodefault;
    /// <summary>
    /// ��� �����������
    /// </summary>
    property Type_: string read GetType write SetType nodefault;
  end;

  /// <summary>
  /// ������� ��� �������� ������ ������� ���� <b>TMasure</b> � ���������
  /// ������������ ������ �� ��������� ������.
  /// </summary>
  /// <param name="AAutoNormalizeData">
  /// ����� �� ����� ������������� ��������� ������������ ������ ���
  /// ���������� �������� ��������� ��������� �������. �������� ��
  /// ����������- <b>DEFAULT_MEASURE_AUTO_NORMALIZE_DATA</b>.
  /// </param>
  /// <returns>
  /// ������������ ������ �� ��������� ������ � ������ ��������� ����������
  /// �������, ���� <b>nil</b> � ������ ������.
  /// </returns>
function GetIMeasure(const AAutoNormalizeData: Boolean = DEFAULT_MEASURE_AUTO_NORMALIZE_DATA): IMeasure;

/// <summary>
/// ������� ��� ��������� ������������ ������ ���� <b>INormalized</b> ��
/// ������ ���� <b>TMeasure</b> ����� ������������ ������ ���� <b>IMeasure</b>
/// .
/// </summary>
/// <param name="AMeasure">
/// ������������ ������ ���� <b>IMeasure</b> �� ������ ���� <b>TMeasure</b>.
/// </param>
/// <returns>
/// ������������ ������ ���� <b>INormalized</b> �� ������ ���� <b>TMeasure</b>
/// � ������ ��������� ���������� ������� ���� <b>nil</b> � ������ ������.
/// </returns>
function GetINormalized(const AMeasure: IMeasure): INormalized; overload;

implementation

uses
  CastersPackage.uRoutines;

const
  MSECONDS_PER_SECOND = 1000;
  MSECONDS_PER_MINUTE = MSECONDS_PER_SECOND * 60;
  MSECONDS_PER_HOUR = MSECONDS_PER_MINUTE * 60;
  MSECONDS_PER_DAY = MSECONDS_PER_HOUR * 24;

function GetIMeasure(const AAutoNormalizeData: Boolean = DEFAULT_MEASURE_AUTO_NORMALIZE_DATA): IMeasure;
begin
  Result := TMeasure.Create(AAutoNormalizeData);
end;

function GetINormalized(const AMeasure: IMeasure): INormalized;
begin
  Result := nil;
  if Assigned(AMeasure) then
  begin
    if Supports(AMeasure, INormalized) then
    begin
      Result := AMeasure as INormalized;
    end;
  end;
end;

constructor TMeasure.Create(const AAutoNormalizeData: Boolean);
begin
  inherited Create;
  FAutoNormalizeData := AAutoNormalizeData;
  FOrganizationID := DEFAULT_MEASURE_ORGANIZATION_ID;
  FType := DEFAULT_MEASURE_TYPE;
  FName := DEFAULT_MEASURE_NAME;
  FAuthor := DEFAULT_MEASURE_AUTHOR;
  FProducer := DEFAULT_MEASURE_PRODUCER;
  FPerformer := DEFAULT_MEASURE_PERFORMER;
  FOrganizer := DEFAULT_MEASURE_ORGANIZER;
  FTicketPrice := DEFAULT_MEASURE_TICKET_PRICE;
  FOtherInfoRTF := DEFAULT_MEASURE_OTHER_INFO_RTF;
  FOtherInfoPlane := DEFAULT_MEASURE_OTHER_INFO_PLANE;
  FHasUnknownDuration := DEFAULT_MEASURE_HAS_UNKNOWN_DURATION;
  FHasStartDateTime := DEFAULT_MEASURE_HAS_START_DATETIME;
  FHasStopDateTime := DEFAULT_MEASURE_HAS_STOP_DATETIME;
  FStartDateTime := DEFAULT_MEASURE_START_DATETIME;
  FStopDateTime := DEFAULT_MEASURE_STOP_DATETIME;
  FDurationDays := DEFAULT_MEASURE_DURATION_DAYS;
  FDurationHours := DEFAULT_MEASURE_DURATION_HOURS;
  FDurationMinutes := DEFAULT_MEASURE_DURATION_MINUTES;
  FIsPremier := DEFAULT_MEASURE_IS_PREMIER;
  FIsTour := DEFAULT_MEASURE_IS_TOUR;
  FIsSport := DEFAULT_MEASURE_IS_SPORT;
  FForChildren := DEFAULT_MEASURE_FOR_CHILDREN;
  FForTeenagers := DEFAULT_MEASURE_FOR_TEENAGERS;
  FForAdultsOnly := DEFAULT_MEASURE_FOR_ADULTS_ONLY;
end;

class procedure TMeasure.SetField(const AValue: Integer; var AField: Integer);
begin
  if AField <> AValue then
  begin
    AField := AValue;
  end;
end;

class procedure TMeasure.SetField(const AValue: Boolean; var AField: Boolean);
begin
  if AField <> AValue then
  begin
    AField := AValue;
  end;
end;

class procedure TMeasure.SetField(const AValue: TDateTime; var AField: TDateTime);
begin
  if AField <> AValue then
  begin
    AField := AValue;
  end;
end;

class procedure TMeasure.SetField(const AValue: AnsiString; var AField: AnsiString);
begin
  if AField <> AValue then
  begin
    AField := AValue;
  end;
end;

procedure TMeasure.SetField(const AValue: string; var AField: string);
var
  s: string;
begin
  s := Trim(AValue);
  if AutoNormalizeData and (AField <> Routines.PrepareStringForRNE5(s)) then
  begin
    AField := Routines.PrepareStringForRNE5(s);
  end
  else
  begin
    if AField <> s then
    begin
      AField := s;
    end;
  end;
end;

function TMeasure.GetAuthor: string;
begin
  Result := FAuthor;
end;

function TMeasure.GetAutoNormalizeData: Boolean;
begin
  Result := FAutoNormalizeData;
end;

function TMeasure.GetDurationDays: Integer;
begin
  Result := FDurationDays;
end;

function TMeasure.GetDurationHours: Integer;
begin
  Result := FDurationHours;
end;

function TMeasure.GetDurationMinutes: Integer;
begin
  Result := FDurationMinutes;
end;

function TMeasure.GetForAdultsOnly: Boolean;
begin
  Result := FForAdultsOnly;
end;

function TMeasure.GetForChildren: Boolean;
begin
  Result := FForChildren;
end;

function TMeasure.GetForTeenagers: Boolean;
begin
  Result := FForTeenagers;
end;

function TMeasure.GetHasUnknownDuration: Boolean;
begin
  Result := FHasUnknownDuration;
end;

function TMeasure.GetHasStartDateTime: Boolean;
begin
  Result := FHasStartDateTime;
end;

function TMeasure.GetHasStopDateTime: Boolean;
begin
  Result := FHasStopDateTime;
end;

function TMeasure.GetIsPremier: Boolean;
begin
  Result := FIsPremier;
end;

function TMeasure.GetIsSport: Boolean;
begin
  Result := FIsSport;
end;

function TMeasure.GetIsTour: Boolean;
begin
  Result := FIsTour;
end;

function TMeasure.GetName: string;
begin
  Result := FName;
end;

function TMeasure.GetOrganizationID: Integer;
begin
  Result := FOrganizationID;
end;

function TMeasure.GetOrganizer: string;
begin
  Result := FOrganizer;
end;

function TMeasure.GetOtherInfoPlane: AnsiString;
begin
  Result := FOtherInfoPlane;
end;

function TMeasure.GetOtherInfoRTF: AnsiString;
begin
  Result := FOtherInfoRTF;
end;

function TMeasure.GetPerformer: string;
begin
  Result := FPerformer;
end;

function TMeasure.GetProducer: string;
begin
  Result := FProducer;
end;

function TMeasure.GetStartDateTime: TDateTime;
begin
  Result := FStartDateTime;
end;

function TMeasure.GetStopDateTime: TDateTime;
begin
  Result := FStopDateTime;
end;

function TMeasure.GetTicketPrice: string;
begin
  Result := FTicketPrice;
end;

function TMeasure.GetType: string;
begin
  Result := FType;
end;

procedure TMeasure.SetAuthor(const AValue: string);
begin
  SetField(AValue, FAuthor);
end;

procedure TMeasure.SetAutoNormalizeData(const AValue: Boolean);
begin
  SetField(AValue, FAutoNormalizeData);
end;

procedure TMeasure.SetForAdultsOnly(const AValue: Boolean);
begin
  if AutoNormalizeData and (ForChildren or ForTeenagers) then
  begin
    SetField(False, FForAdultsOnly);
  end
  else
  begin
    SetField(AValue, FForAdultsOnly);
  end;
end;

procedure TMeasure.SetForChildren(const AValue: Boolean);
begin
  if AutoNormalizeData and ForChildren then
  begin
    SetField(False, FForChildren);
  end
  else
  begin
    SetField(AValue, FForChildren);
  end;
end;

procedure TMeasure.SetForTeenagers(const AValue: Boolean);
begin
  if AutoNormalizeData and ForAdultsOnly then
  begin
    SetField(False, FForTeenagers);
  end
  else
  begin
    SetField(AValue, FForTeenagers);
  end;
end;

procedure TMeasure.SetIsPremier(const AValue: Boolean);
begin
  SetField(AValue, FIsPremier);
end;

procedure TMeasure.SetIsSport(const AValue: Boolean);
begin
  SetField(AValue, FIsSport);
end;

procedure TMeasure.SetIsTour(const AValue: Boolean);
begin
  SetField(AValue, FIsTour);
end;

procedure TMeasure.SetName(const AValue: string);
begin
  SetField(AValue, FName);
end;

procedure TMeasure.SetOrganizationID(const AValue: Integer);
begin
  if AutoNormalizeData and (AValue < 0) then
  begin
    SetField(0, FOrganizationID);
  end
  else
  begin
    SetField(AValue, FOrganizationID);
  end;
end;

procedure TMeasure.SetOrganizer(const AValue: string);
begin
  SetField(AValue, FOrganizer);
end;

procedure TMeasure.SetOtherInfoPlane(const AValue: AnsiString);
begin
  if AutoNormalizeData and (OtherInfoPlane <> Routines.PrepareStringForRNE5(AValue)) then
  begin
    SetField(Routines.PrepareStringForRNE5(AValue), FOtherInfoPlane);
  end
  else
  begin
    SetField(AValue, FOtherInfoPlane);
  end;
end;

procedure TMeasure.SetOtherInfoRTF(const AValue: AnsiString);
begin
  SetField(AValue, FOtherInfoRTF);
end;

procedure TMeasure.SetPerformer(const AValue: string);
begin
  SetField(AValue, FPerformer);
end;

procedure TMeasure.SetProducer(const AValue: string);
begin
  SetField(AValue, FProducer);
end;

procedure TMeasure.SetTicketPrice(const AValue: string);
begin
  SetField(AValue, FTicketPrice);
end;

procedure TMeasure.SetType(const AValue: string);
begin
  SetField(AValue, FType);
end;

procedure TMeasure.SetDurationDays(const AValue: Integer);
begin
  SetField(AValue, FDurationDays);
end;

procedure TMeasure.SetDurationHours(const AValue: Integer);
begin
  SetField(AValue, FDurationHours);
end;

procedure TMeasure.SetDurationMinutes(const AValue: Integer);
begin
  SetField(AValue, FDurationMinutes);
end;

procedure TMeasure.SetHasUnknownDuration(const AValue: Boolean);
begin
  SetField(AValue, FHasUnknownDuration);
end;

procedure TMeasure.SetHasStartDateTime(const AValue: Boolean);
begin
  SetField(AValue, FHasStartDateTime);
end;

procedure TMeasure.SetHasStopDateTime(const AValue: Boolean);
begin
  SetField(AValue, FHasStopDateTime);
end;

procedure TMeasure.SetStartDateTime(const AValue: TDateTime);
begin
  SetField(AValue, FStartDateTime);
end;

procedure TMeasure.SetStopDateTime(const AValue: TDateTime);
begin
  SetField(AValue, FStopDateTime);
end;

{ TODO : ����� ���������� ������ ������ (������������ � ����������� �� �������� �������� AutoNormalizeData) }

function TMeasure.IsNormalized: Boolean;
var
  a1: Comp;
  a2: Int64 absolute a1;
  a3: Int64;
  a4: Int64;
  duration_days: Integer;
  duration_hours: Integer;
  duration_minutes: Integer;
  measure_type: string;
  measure_name: string;
  measure_author: string;
  measure_producer: string;
  measure_performer: string;
  measure_organizer: string;
  measure_ticket_price: string;
  measure_other_info_plane: AnsiString;
  start_date_time: TDateTime;
  stop_date_time: TDateTime;
begin
  Result := False;
  duration_days := 0;
  duration_hours := 0;
  duration_minutes := 0;
  measure_type := Type_;
  measure_name := name;
  measure_author := Author;
  measure_producer := Producer;
  measure_performer := Performer;
  measure_organizer := Organizer;
  measure_ticket_price := TicketPrice;
  measure_other_info_plane := OtherInfoPlane;
  start_date_time := StartDateTime;
  stop_date_time := StopDateTime;

  if (OrganizationID < 0) or (measure_type <> Routines.PrepareStringForRNE5(measure_type)) or
    (measure_name <> Routines.PrepareStringForRNE5(measure_name)) or
    (measure_author <> Routines.PrepareStringForRNE5(measure_author)) or
    (measure_producer <> Routines.PrepareStringForRNE5(measure_producer)) or
    (measure_performer <> Routines.PrepareStringForRNE5(measure_performer)) or
    (measure_organizer <> Routines.PrepareStringForRNE5(measure_organizer)) or
    (measure_ticket_price <> Routines.PrepareStringForRNE5(measure_ticket_price)) or
    (measure_other_info_plane <> Routines.PrepareStringForRNE5(measure_other_info_plane)) or
    ((ForChildren or ForTeenagers) and ForAdultsOnly) then
  begin
    Exit;
  end;

  if HasStartDateTime and HasStopDateTime then
  begin
    if start_date_time > stop_date_time then
    begin
      Exit;
    end;

    if not HasUnknownDuration then
    begin
      // �������� ���� ������, ���� ����� � ����������� ����������� ����������� � ������������
      a1 := TimeStampToMSecs(DateTimeToTimeStamp(stop_date_time)) -
        TimeStampToMSecs(DateTimeToTimeStamp(start_date_time));

      // ��������! �������� a2 � ������ ������ ��� ����� a1, �.�. ���������� ����������!!!
      if (a2 > 0) then
      begin
        duration_days := a2 div MSECONDS_PER_DAY;
        a3 := a2 - Int64(DurationDays) * MSECONDS_PER_DAY;
        duration_hours := a3 div MSECONDS_PER_HOUR;
        a4 := a3 - Int64(FDurationHours) * MSECONDS_PER_HOUR;
        duration_minutes := a4 div MSECONDS_PER_MINUTE;
      end;

      if (DurationDays <> duration_days) or (DurationHours <> duration_hours) or (DurationMinutes <> duration_minutes)
      then
      begin
        Exit;
      end;
    end;
  end;
  Result := True;
end;

procedure TMeasure.Normalize;
var
  a1: Comp;
  a2: Int64 absolute a1;
  a3: Int64;
  a4: Int64;
  start_date_time: TDateTime;
  stop_date_time: TDateTime;
begin
  // ���� ������ ��� �������������, ������� �� ���������
  if IsNormalized then
  begin
    Exit;
  end;

  // �������� ������������
  if OrganizationID < 0 then
  begin
    OrganizationID := 0;
  end;

  // �������� ������������
  DurationDays := 0;
  DurationHours := 0;
  DurationMinutes := 0;

  Type_ := Routines.PrepareStringForRNE5(Type_);
  name := Routines.PrepareStringForRNE5(name);
  Author := Routines.PrepareStringForRNE5(Author);
  Producer := Routines.PrepareStringForRNE5(Producer);
  Performer := Routines.PrepareStringForRNE5(Performer);
  Organizer := Routines.PrepareStringForRNE5(Organizer);
  TicketPrice := Routines.PrepareStringForRNE5(TicketPrice);
  OtherInfoPlane := Routines.PrepareStringForRNE5(OtherInfoPlane);

  if ForChildren or ForTeenagers then
  begin
    ForAdultsOnly := False;
  end;

  // ���� ���� � ���� ������ � ���� �����
  if HasStartDateTime and HasStopDateTime then
  begin
    // ����� ���������� �� �� ����� �������, �������� �������, ���� �����
    start_date_time := StartDateTime;
    stop_date_time := StopDateTime;
    if start_date_time > stop_date_time then
    begin
      StartDateTime := stop_date_time;
      StopDateTime := start_date_time;
      start_date_time := StartDateTime;
      stop_date_time := StopDateTime;
    end;
    // ���� �������� ������������ - ������������� ������������
    if not HasUnknownDuration then
    begin
      // �������� ���� ������, ���� ����� � ����������� ������������ �����������
      a1 := TimeStampToMSecs(DateTimeToTimeStamp(stop_date_time)) -
        TimeStampToMSecs(DateTimeToTimeStamp(start_date_time));
      // ��������! �������� a2 � ������ ������ ��� ����� a1, �.�. ���������� ����������!!!
      if (a2 > 0) then
      begin
        DurationDays := a2 div MSECONDS_PER_DAY;
        a3 := a2 - Int64(DurationDays) * MSECONDS_PER_DAY;
        DurationHours := a3 div MSECONDS_PER_HOUR;
        a4 := a3 - Int64(DurationHours) * MSECONDS_PER_HOUR;
        DurationMinutes := a4 div MSECONDS_PER_MINUTE;
      end;
    end;
  end;

end;

end.
