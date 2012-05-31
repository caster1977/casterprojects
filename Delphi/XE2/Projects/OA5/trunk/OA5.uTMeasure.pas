unit OA5.uTMeasure;

interface

uses
  OA5.uINormalized,
  OA5.uIMeasure;

type

  /// <summary>
  /// Класс, предназначеный для хранения данных мероприятия
  /// </summary>
  TMeasure = class(TInterfacedObject, IMeasure, INormalized)
  strict private
    FAutoNormalizeData: boolean;
    FOrganizationID: integer;
    FType: string;
    FName: string;
    FAuthor: string;
    FProducer: string;
    FPerformer: string;
    FOrganizer: string;
    FTicketPrice: string;
    FOtherInfoRTF: AnsiString;
    FOtherInfoPlane: AnsiString;
    FHasStartDateTime: boolean;
    FHasStopDateTime: boolean;
    FStartDateTime: TDateTime;
    FStopDateTime: TDateTime;
    FDurationDays: integer;
    FDurationHours: integer;
    FDurationMinutes: integer;
    FUnknownDuration: boolean;
    FIsPremier: boolean;
    FIsTour: boolean;
    FForChildren: boolean;
    FForTeenagers: boolean;
    FForAdultsOnly: boolean;
  public
    /// <summary>
    /// Конструктор класса
    /// </summary>
    /// <param name="AAutoNormalizeData">
    /// <para>
    /// Нужно ли будет автоматически выполнять нормализацию данных при
    /// присвоении значений остальным свойствам объекта.
    /// </para>
    /// <para>
    /// <b>Необязательный</b> параметр.
    /// </para>
    /// <para>
    /// Значение по умолчанию - <b>False</b>.
    /// </para>
    /// </param>
    constructor Create(const AAutoNormalizeData: boolean = False);
    /// <summary>
    /// Функция валидации данных класса (только проверка значений)
    /// </summary>
    /// <returns>
    /// <para>
    /// Если нормализация данных <i>
    /// <b>не требуется</b>
    /// </i> - будет возвращено <b>True</b>.
    /// </para>
    /// <para>
    /// Если нормализация данных <i>
    /// <b>требуется</b>
    /// </i>, будет возвращено <b>False</b>.
    /// </para>
    /// </returns>
    /// <remarks>
    /// См. также процедуру <b>Normalize</b>
    /// </remarks>
    function Normalized: boolean;
    /// <summary>
    /// Процедура нормализации значений данных класса
    /// </summary>
    /// <remarks>
    /// См. также функцию <b>Normalized</b>
    /// </remarks>
    procedure Normalize;
    /// <summary>
    /// Требуется ли при записи данных в поля автоматически проводить их
    /// нормализацию?
    /// </summary>
    /// <remarks>
    /// Так же исходное значение можно передать при создании объекта через
    /// конструктор <b>Create(<i>значение</i>);</b>
    /// </remarks>
    function GetAutoNormalizeData: boolean;
    procedure SetAutoNormalizeData(const Value: boolean);
    /// <summary>
    /// Идентификатор организации, которая проводит мероприятие
    /// </summary>
    function GetOrganizationID: integer;
    procedure SetOrganizationID(const Value: integer);
    /// <summary>
    /// Тип мероприятия
    /// </summary>
    function GetType: string;
    procedure SetType(const Value: string);
    /// <summary>
    /// Наименование мероприятия
    /// </summary>
    function GetName: string;
    procedure SetName(const Value: string);
    /// <summary>
    /// Автор мероприятия
    /// </summary>
    function GetAuthor: string;
    procedure SetAuthor(const Value: string);
    /// <summary>
    /// Режиссёр/продюссер мероприятия
    /// </summary>
    function GetProducer: string;
    procedure SetProducer(const Value: string);
    /// <summary>
    /// Исполнитель(и) мероприятия
    /// </summary>
    function GetPerformer: string;
    procedure SetPerformer(const Value: string);
    /// <summary>
    /// Организатор мероприятия
    /// </summary>
    function GetOrganizer: string;
    procedure SetOrganizer(const Value: string);
    /// <summary>
    /// Стоимость билетов на мероприятие
    /// </summary>
    function GetTicketPrice: string;
    procedure SetTicketPrice(const Value: string);
    /// <summary>
    /// Прочая информация о мероприятии в виде содержимого RTF-документа
    /// </summary>
    function GetOtherInfoRTF: AnsiString;
    procedure SetOtherInfoRTF(const Value: AnsiString);
    /// <summary>
    /// Прочая информация о мероприятии в виде plain-текста
    /// </summary>
    function GetOtherInfoPlane: AnsiString;
    procedure SetOtherInfoPlane(const Value: AnsiString);
    /// <summary>
    /// Есть ли у мероприятия дата/время начала
    /// </summary>
    function GetHasStartDateTime: boolean;
    procedure SetHasStartDateTime(const Value: boolean);
    /// <summary>
    /// Есть ли у мероприятия дата/время окончания
    /// </summary>
    function GetHasStopDateTime: boolean;
    procedure SetHasStopDateTime(const Value: boolean);
    /// <summary>
    /// Дата/время начала мероприятия
    /// </summary>
    function GetStartDateTime: TDateTime;
    procedure SetStartDateTime(const Value: TDateTime);
    /// <summary>
    /// Дата/время окончания мероприятия
    /// </summary>
    function GetStopDateTime: TDateTime;
    procedure SetStopDateTime(const Value: TDateTime);
    /// <summary>
    /// Продолжительность мероприятия в сутках
    /// </summary>
    function GetDurationDays: integer;
    procedure SetDurationDays(const Value: integer);
    /// <summary>
    /// Продолжительность мероприятия в часах
    /// </summary>
    function GetDurationHours: integer;
    procedure SetDurationHours(const Value: integer);
    /// <summary>
    /// Продолжительность мероприятия в минутах
    /// </summary>
    function GetDurationMinutes: integer;
    procedure SetDurationMinutes(const Value: integer);
    /// <summary>
    /// Длительность мероприятия неизвестна?
    /// </summary>
    function GetUnknownDuration: boolean;
    procedure SetUnknownDuration(const Value: boolean);
    /// <summary>
    /// Мероприятие является премьерным?
    /// </summary>
    function GetIsPremier: boolean;
    procedure SetIsPremier(const Value: boolean);
    /// <summary>
    /// Мероприятие является гастрольным?
    /// </summary>
    function GetIsTour: boolean;
    procedure SetIsTour(const Value: boolean);
    /// <summary>
    /// Мероприятие является детским?
    /// </summary>
    function GetForChildren: boolean;
    procedure SetForChildren(const Value: boolean);
    /// <summary>
    /// Мероприятие является подростковым?
    /// </summary>
    function GetForTeenagers: boolean;
    procedure SetForTeenagers(const Value: boolean);
    /// <summary>
    /// Мероприятие "только для взрослых"?
    /// </summary>
    function GetForAdultsOnly: boolean;
    procedure SetForAdultsOnly(const Value: boolean);
    property _AutoNormalizeData: boolean read GetAutoNormalizeData write SetAutoNormalizeData;
    property _Author: string read GetAuthor write SetAuthor;
    property _DurationDays: integer read GetDurationDays write SetDurationDays;
    property _DurationHours: integer read GetDurationHours write SetDurationHours;
    property _DurationMinutes: integer read GetDurationMinutes write SetDurationMinutes;
    property _ForAdultsOnly: boolean read GetForAdultsOnly write SetForAdultsOnly;
    property _ForChildren: boolean read GetForChildren write SetForChildren;
    property _ForTeenagers: boolean read GetForTeenagers write SetForTeenagers;
    property _HasStartDateTime: boolean read GetHasStartDateTime write SetHasStartDateTime;
    property _HasStopDateTime: boolean read GetHasStopDateTime write SetHasStopDateTime;
    property _IsPremier: boolean read GetIsPremier write SetIsPremier;
    property _IsTour: boolean read GetIsTour write SetIsTour;
    property _Name: string read GetName write SetName;
    property _OrganizationID: integer read GetOrganizationID write SetOrganizationID;
    property _Organizer: string read GetOrganizer write SetOrganizer;
    property _OtherInfoPlane: AnsiString read GetOtherInfoPlane write SetOtherInfoPlane;
    property _OtherInfoRTF: AnsiString read GetOtherInfoRTF write SetOtherInfoRTF;
    property _Performer: string read GetPerformer write SetPerformer;
    property _Producer: string read GetProducer write SetProducer;
    property _StartDateTime: TDateTime read GetStartDateTime write SetStartDateTime;
    property _StopDateTime: TDateTime read GetStopDateTime write SetStopDateTime;
    property _TicketPrice: string read GetTicketPrice write SetTicketPrice;
    property _Type: string read GetType write SetType;
    property _UnknownDuration: boolean read GetUnknownDuration write SetUnknownDuration;
  end;

implementation

uses
  System.SysUtils,
  CastersPackage.uRoutines;

{ TMeasureDataClass }

constructor TMeasure.Create(const AAutoNormalizeData: boolean = False);
begin
  inherited Create;
  FAutoNormalizeData := AAutoNormalizeData;
  FOrganizationID := - 1;
  FType := '';
  FName := '';
  FAuthor := '';
  FProducer := '';
  FPerformer := '';
  FOrganizer := '';
  FTicketPrice := '';
  FOtherInfoRTF := '';
  FOtherInfoPlane := '';
  FHasStartDateTime := False;
  FHasStopDateTime := False;
  FStartDateTime := EncodeDate(1900, 1, 1);
  FStopDateTime := EncodeDate(1900, 1, 1);
  FDurationDays := 0;
  FDurationHours := 0;
  FDurationMinutes := 0;
  FIsPremier := False;
  FIsTour := False;
  FForChildren := False;
  FForTeenagers := False;
  FForAdultsOnly := False;
  FUnknownDuration := True;
end;

function TMeasure.Normalized: boolean;
var
  a1: Comp;
  a2: Int64 absolute a1;
  t1, t2: TTimeStamp;
  duration_days, duration_hours, duration_minutes: integer;
begin
  Result := False;
  duration_days := 0;
  duration_hours := 0;
  duration_minutes := 0;
  // проверяем значения полей на предмет совпадения с правилами нормализации
  if _OrganizationID < 0 then
    Exit;
  if _HasStartDateTime and _HasStopDateTime then
    begin
      // нужно провериить их по линии времени, если нужно поменять местами, выходим
      if _StartDateTime > _StopDateTime then
        Exit;
      // если известна длительность - сравниваем длительность
      if not _UnknownDuration then
        begin
          // получаем дату начала, дату конца и высчитываем длителность мероприятия
          t1 := DateTimeToTimeStamp(_StartDateTime);
          t2 := DateTimeToTimeStamp(_StopDateTime);
          a1 := TimeStampToMSecs(t2) - TimeStampToMSecs(t1);
          // внимание! значение a2 в данном случае УЖЕ равно a1, т.к. переменная абсолютная!!!
          if (a2 > 0) then
            begin
              duration_days := Int64(a2) div Int64(86400000);
              a2 := Int64(a2) - Int64((Int64(_DurationDays) * Int64(86400000)));
              duration_hours := a2 div 3600000;
              a2 := a2 - FDurationHours * 3600000;
              duration_minutes := a2 div 60000;
            end;
          if _DurationDays <> duration_days then
            Exit;
          if _DurationHours <> duration_hours then
            Exit;
          if _DurationMinutes <> duration_minutes then
            Exit;
        end;
    end;
  if _Type <> Routines.PrepareStringForRNE5(_Type) then
    Exit;
  if _Name <> Routines.PrepareStringForRNE5(_Name) then
    Exit;
  if _Author <> Routines.PrepareStringForRNE5(_Author) then
    Exit;
  if _Producer <> Routines.PrepareStringForRNE5(_Producer) then
    Exit;
  if _Performer <> Routines.PrepareStringForRNE5(_Performer) then
    Exit;
  if _Organizer <> Routines.PrepareStringForRNE5(_Organizer) then
    Exit;
  if _TicketPrice <> Routines.PrepareStringForRNE5(_TicketPrice) then
    Exit;
  if _OtherInfoPlane <> Routines.PrepareStringForRNE5(_OtherInfoPlane) then
    Exit;
  if (_ForChildren or _ForTeenagers) and _ForAdultsOnly then
    Exit;
  Result := True;
end;

function TMeasure.GetAuthor: string;
begin
  Result := FAuthor;
end;

function TMeasure.GetAutoNormalizeData: boolean;
begin
  Result := FAutoNormalizeData;
end;

function TMeasure.GetDurationDays: integer;
begin
  Result := FDurationDays;
end;

function TMeasure.GetDurationHours: integer;
begin
  Result := FDurationHours;
end;

function TMeasure.GetDurationMinutes: integer;
begin
  Result := FDurationMinutes;
end;

function TMeasure.GetForAdultsOnly: boolean;
begin
  Result := FForAdultsOnly;
end;

function TMeasure.GetForChildren: boolean;
begin
  Result := FForChildren;
end;

function TMeasure.GetForTeenagers: boolean;
begin
  Result := FForTeenagers;
end;

function TMeasure.GetHasStartDateTime: boolean;
begin
  Result := FHasStartDateTime;
end;

function TMeasure.GetHasStopDateTime: boolean;
begin
  Result := FHasStopDateTime;
end;

function TMeasure.GetIsPremier: boolean;
begin
  Result := FIsPremier;
end;

function TMeasure.GetIsTour: boolean;
begin
  Result := FIsTour;
end;

function TMeasure.GetName: string;
begin
  Result := FName;
end;

function TMeasure.GetOrganizationID: integer;
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

function TMeasure.GetUnknownDuration: boolean;
begin
  Result := FUnknownDuration;
end;

procedure TMeasure.Normalize;
var
  dt: TDateTime;
  a1: Comp;
  a2: Int64 absolute a1;
  t1, t2: TTimeStamp;
begin
  // если данные уже нормализованы, выходим из процедуры
  if Normalized then
    Exit;
  // начинаем нормализацию
  if _OrganizationID < 0 then
    _OrganizationID := 0;

  // обнуляем длительности
  _DurationDays := 0;
  _DurationHours := 0;
  _DurationMinutes := 0;

  // если есть и дата начала и дата конца
  if _HasStartDateTime and _HasStopDateTime then
    begin
      // нужно провериить их по линии времени, поменять местами, если нужно
      if _StartDateTime > _StopDateTime then
        begin
          dt := _StartDateTime;
          _StartDateTime := _StopDateTime;
          _StopDateTime := dt;
        end;
      // если известна длительность - пересчитываем длительность
      if not _UnknownDuration then
        begin
          // получаем дату начала, дату конца и высчитываем длителность мероприятия
          t1 := DateTimeToTimeStamp(_StartDateTime);
          t2 := DateTimeToTimeStamp(_StopDateTime);
          a1 := TimeStampToMSecs(t2) - TimeStampToMSecs(t1);
          // внимание! значение a2 в данном случае УЖЕ равно a1, т.к. переменная абсолютная!!!
          if (a2 > 0) then
            begin
              _DurationDays := Int64(a2) div Int64(86400000);
              a2 := Int64(a2) - Int64((Int64(_DurationDays) * Int64(86400000)));
              _DurationHours := a2 div 3600000;
              a2 := a2 - _DurationHours * 3600000;
              _DurationMinutes := a2 div 60000;
            end;
        end;
    end;

  _Type := Routines.PrepareStringForRNE5(_Type);
  _Name := Routines.PrepareStringForRNE5(_Name);
  _Author := Routines.PrepareStringForRNE5(_Author);
  _Producer := Routines.PrepareStringForRNE5(_Producer);
  _Performer := Routines.PrepareStringForRNE5(_Performer);
  _Organizer := Routines.PrepareStringForRNE5(_Organizer);
  _TicketPrice := Routines.PrepareStringForRNE5(_TicketPrice);
  _OtherInfoPlane := Routines.PrepareStringForRNE5(_OtherInfoPlane);

  if _ForChildren or _ForTeenagers then
    _ForAdultsOnly := False;
end;

procedure TMeasure.SetAuthor(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if _AutoNormalizeData then
    begin
      if FAuthor <> Routines.PrepareStringForRNE5(s) then
        FAuthor := Routines.PrepareStringForRNE5(s);
    end
  else
    if FAuthor <> s then
      FAuthor := s;
end;

procedure TMeasure.SetAutoNormalizeData(const Value: boolean);
begin
  if FAutoNormalizeData <> Value then
    FAutoNormalizeData := Value;
end;

procedure TMeasure.SetForAdultsOnly(const Value: boolean);
begin
  if _AutoNormalizeData then
    begin
      if FForChildren or FForTeenagers then
        begin
          if not FForAdultsOnly then
            FForAdultsOnly := False
        end
      else
        if FForAdultsOnly <> Value then
          FForAdultsOnly := Value;
    end
  else
    if FForAdultsOnly <> Value then
      FForAdultsOnly := Value;
end;

procedure TMeasure.SetForChildren(const Value: boolean);
begin
  if _AutoNormalizeData then
    begin
      if FForAdultsOnly then
        begin
          if not FForChildren then
            FForChildren := False;
        end
      else
        if FForChildren <> Value then
          FForChildren := Value;
    end
  else
    if FForChildren <> Value then
      FForChildren := Value;
end;

procedure TMeasure.SetForTeenagers(const Value: boolean);
begin
  if _AutoNormalizeData then
    begin
      if FForAdultsOnly then
        begin
          if not FForTeenagers then
            FForTeenagers := False;
        end
      else
        if FForTeenagers <> Value then
          FForTeenagers := Value;
    end
  else
    if FForTeenagers <> Value then
      FForTeenagers := Value;
end;

procedure TMeasure.SetIsPremier(const Value: boolean);
begin
  if FIsPremier <> Value then
    FIsPremier := Value;
end;

procedure TMeasure.SetIsTour(const Value: boolean);
begin
  if FIsTour <> Value then
    FIsTour := Value;
end;

procedure TMeasure.SetName(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if _AutoNormalizeData then
    begin
      if FName <> Routines.PrepareStringForRNE5(s) then
        FName := Routines.PrepareStringForRNE5(s);
    end
  else
    if FName <> s then
      FName := s;
end;

procedure TMeasure.SetOrganizationID(const Value: integer);
begin
  if _AutoNormalizeData then
    begin
      if Value < 0 then
        FOrganizationID := 0
      else
        if FOrganizationID <> Value then
          FOrganizationID := Value;
    end
  else
    if FOrganizationID <> Value then
      FOrganizationID := Value;
end;

procedure TMeasure.SetOrganizer(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if _AutoNormalizeData then
    begin
      if FOrganizer <> Routines.PrepareStringForRNE5(s) then
        FOrganizer := Routines.PrepareStringForRNE5(s);
    end
  else
    if FOrganizer <> s then
      FOrganizer := s;
end;

procedure TMeasure.SetOtherInfoPlane(const Value: AnsiString);
begin
  if _AutoNormalizeData then
    begin
      if FOtherInfoPlane <> Routines.PrepareStringForRNE5(Value) then
        FOtherInfoPlane := Routines.PrepareStringForRNE5(Value);
    end
  else
    if FOtherInfoPlane <> Value then
      FOtherInfoPlane := Value;
end;

procedure TMeasure.SetOtherInfoRTF(const Value: AnsiString);
begin
  if FOtherInfoRTF <> Value then
    FOtherInfoRTF := Value;
end;

procedure TMeasure.SetPerformer(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if _AutoNormalizeData then
    begin
      if FPerformer <> Routines.PrepareStringForRNE5(s) then
        FPerformer := Routines.PrepareStringForRNE5(s);
    end
  else
    if FPerformer <> s then
      FPerformer := s;
end;

procedure TMeasure.SetProducer(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if _AutoNormalizeData then
    begin
      if FProducer <> Routines.PrepareStringForRNE5(s) then
        FProducer := Routines.PrepareStringForRNE5(s);
    end
  else
    if FProducer <> s then
      FProducer := s;
end;

procedure TMeasure.SetTicketPrice(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if _AutoNormalizeData then
    begin
      if FTicketPrice <> Routines.PrepareStringForRNE5(s) then
        FTicketPrice := Routines.PrepareStringForRNE5(s);
    end
  else
    if FTicketPrice <> s then
      FTicketPrice := s;
end;

procedure TMeasure.SetType(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if _AutoNormalizeData then
    begin
      if FType <> Routines.PrepareStringForRNE5(s) then
        FType := Routines.PrepareStringForRNE5(s);
    end
  else
    if FType <> s then
      FType := s;
end;

{ TODO : Ниже нужно дописать методы класса (нормализацию в зависимости от значения переменной FAutoNormalizeData) }

procedure TMeasure.SetDurationDays(const Value: integer);
begin
  if FDurationDays <> Value then
    FDurationDays := Value;
end;

procedure TMeasure.SetDurationHours(const Value: integer);
begin
  if FDurationHours <> Value then
    FDurationHours := Value;
end;

procedure TMeasure.SetDurationMinutes(const Value: integer);
begin
  if FDurationMinutes <> Value then
    FDurationMinutes := Value;
end;

procedure TMeasure.SetHasStartDateTime(const Value: boolean);
begin
  if FHasStartDateTime <> Value then
    FHasStartDateTime := Value;
end;

procedure TMeasure.SetHasStopDateTime(const Value: boolean);
begin
  if FHasStopDateTime <> Value then
    FHasStopDateTime := Value;
end;

procedure TMeasure.SetStartDateTime(const Value: TDateTime);
begin
  if FStartDateTime <> Value then
    FStartDateTime := Value;
end;

procedure TMeasure.SetStopDateTime(const Value: TDateTime);
begin
  if FStopDateTime <> Value then
    FStopDateTime := Value;
end;

procedure TMeasure.SetUnknownDuration(const Value: boolean);
begin
  if FUnknownDuration <> Value then
    FUnknownDuration := Value;
end;

end.
