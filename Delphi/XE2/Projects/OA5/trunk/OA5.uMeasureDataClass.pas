unit OA5.uMeasureDataClass;

interface

type
  /// <summary>
  /// �����, �������������� ��� �������� ������ �����������
  /// </summary>
  TMeasureDataClass=class
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
  private
    procedure SetAuthor(const Value: string);
    procedure SetDurationDays(const Value: integer);
    procedure SetDurationHours(const Value: integer);
    procedure SetDurationMinutes(const Value: integer);
    procedure SetForAdultsOnly(const Value: boolean);
    procedure SetForChildren(const Value: boolean);
    procedure SetForTeenagers(const Value: boolean);
    procedure SetHasStartDateTime(const Value: boolean);
    procedure SetHasStopDateTime(const Value: boolean);
    procedure SetIsPremier(const Value: boolean);
    procedure SetIsTour(const Value: boolean);
    procedure SetName(const Value: string);
    procedure SetOrganizationID(const Value: integer);
    procedure SetOrganizer(const Value: string);
    procedure SetOtherInfoPlane(const Value: AnsiString);
    procedure SetOtherInfoRTF(const Value: AnsiString);
    procedure SetPerformer(const Value: string);
    procedure SetProducer(const Value: string);
    procedure SetStartDateTime(const Value: TDateTime);
    procedure SetStopDateTime(const Value: TDateTime);
    procedure SetTicketPrice(const Value: string);
    procedure SetType(const Value: string);
    procedure SetUnknownDuration(const Value: boolean);
    procedure SetAutoNormalizeData(const Value: boolean);
  public
    ///	<summary>
    ///	  ����������� ������
    ///	</summary>
    ///	<param name="AutoNormalizeData">
    ///	  <para>
    ///	    ����� �� ����� ������������� ��������� ������������ ������ ���
    ///	    ���������� �������� ��������� ��������� �������.
    ///	  </para>
    ///	  <para>
    ///	    <b>��������������</b> ��������.
    ///	  </para>
    ///	  <para>
    ///	    �������� �� ��������� - <b>False</b>.
    ///	  </para>
    ///	</param>
    constructor Create(const AutoNormalizeData: boolean=False);

    /// <summary>
    /// ���������� ������
    /// </summary>
    destructor Destroy; override;

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
    function Normalized: boolean;

    /// <summary>
    /// ��������� ������������ �������� ������ ������
    /// </summary>
    /// <remarks>
    /// ��. ����� ������� <b>Normalized</b>
    /// </remarks>
    procedure Normalize;

    /// <summary>
    /// ��������� �� ��� ������ ������ � ���� ������������� ��������� ��
    /// ������������?
    /// </summary>
    /// <remarks>
    /// ��� �� �������� �������� ����� �������� ��� �������� ������� �����
    /// �����������<b>Create(<i>��������</i>);</b>
    /// </remarks>
    property AutoNormalizeData: boolean write SetAutoNormalizeData;

    /// <summary>
    /// ������������� �����������, ������� �������� �����������
    /// </summary>
    property _OrganizationID: integer read FOrganizationID write SetOrganizationID;

    /// <summary>
    /// ��� �����������
    /// </summary>
    property _Type: string read FType write SetType;

    /// <summary>
    /// ������������ �����������
    /// </summary>
    property _Name: string read FName write SetName;

    /// <summary>
    /// ����� �����������
    /// </summary>
    property _Author: string read FAuthor write SetAuthor;

    /// <summary>
    /// �������/��������� �����������
    /// </summary>
    property _Producer: string read FProducer write SetProducer;

    /// <summary>
    /// �����������(�) �����������
    /// </summary>
    property _Performer: string read FPerformer write SetPerformer;

    /// <summary>
    /// ����������� �����������
    /// </summary>
    property _Organizer: string read FOrganizer write SetOrganizer;

    /// <summary>
    /// ��������� ������� �� �����������
    /// </summary>
    property _TicketPrice: string read FTicketPrice write SetTicketPrice;

    /// <summary>
    /// ������ ���������� � ������������ ���� ����������� RTF-���������
    /// </summary>
    property _OtherInfoRTF: AnsiString read FOtherInfoRTF write SetOtherInfoRTF;

    /// <summary>
    /// ������ ���������� � ����������� � ���� plain-������
    /// </summary>
    property _OtherInfoPlane: AnsiString read FOtherInfoPlane write SetOtherInfoPlane;

    /// <summary>
    /// ���� �� � ����������� ����/����� ������
    /// </summary>
    property _HasStartDateTime: boolean read FHasStartDateTime write SetHasStartDateTime;

    /// <summary>
    /// ���� �� � ����������� ����/����� ���������
    /// </summary>
    property _HasStopDateTime: boolean read FHasStopDateTime write SetHasStopDateTime;

    /// <summary>
    /// ����/����� ������ �����������
    /// </summary>
    property _StartDateTime: TDateTime read FStartDateTime write SetStartDateTime;

    /// <summary>
    /// ����/��������������� �����������
    /// </summary>
    property _StopDateTime: TDateTime read FStopDateTime write SetStopDateTime;

    /// <summary>
    /// ����������������� ����������� � ������
    /// </summary>
    property _DurationDays: integer read FDurationDays write SetDurationDays;

    /// <summary>
    /// ����������������� ����������� � �����
    /// </summary>
    property _DurationHours: integer read FDurationHours write SetDurationHours;

    /// <summary>
    /// ����������������� ����������� � �������
    /// </summary>
    property _DurationMinutes: integer read FDurationMinutes write SetDurationMinutes;

    /// <summary>
    /// ������������ ����������� ����������?
    /// </summary>
    property _UnknownDuration: boolean read FUnknownDuration write SetUnknownDuration;

    /// <summary>
    /// ����������� �������� ����������?
    /// </summary>
    property _IsPremier: boolean read FIsPremier write SetIsPremier;

    /// <summary>
    /// ����������� �������� �����������?
    /// </summary>
    property _IsTour: boolean read FIsTour write SetIsTour;

    /// <summary>
    /// ����������� �������� �������?
    /// </summary>
    property _ForChildren: boolean read FForChildren write SetForChildren;

    /// <summary>
    /// ����������� �������� ������������?
    /// </summary>
    property _ForTeenagers: boolean read FForTeenagers write SetForTeenagers;

    /// <summary>
    /// �����������"������ ��� ��������"?
    /// </summary>
    property _ForAdultsOnly: boolean read FForAdultsOnly write SetForAdultsOnly;
  end;

implementation

uses
  System.SysUtils,
  uRoutines;

{ TMeasureDataClass }

constructor TMeasureDataClass.Create(const AutoNormalizeData: boolean=False);
begin
  inherited Create;
  FAutoNormalizeData:=AutoNormalizeData;
  FOrganizationID:=-1;
  FType:='';
  FName:='';
  FAuthor:='';
  FProducer:='';
  FPerformer:='';
  FOrganizer:='';
  FTicketPrice:='';
  FOtherInfoRTF:='';
  FOtherInfoPlane:='';
  FHasStartDateTime:=False;
  FHasStopDateTime:=False;
  FStartDateTime:=EncodeDate(1900, 1, 1);
  FStopDateTime:=EncodeDate(1900, 1, 1);
  FDurationDays:=0;
  FDurationHours:=0;
  FDurationMinutes:=0;
  FIsPremier:=False;
  FIsTour:=False;
  FForChildren:=False;
  FForTeenagers:=False;
  FForAdultsOnly:=False;
  FUnknownDuration:=True;
end;

destructor TMeasureDataClass.Destroy;
begin
  inherited;
end;

function TMeasureDataClass.Normalized: boolean;
var
  a1: Comp;
  a2: Int64 absolute a1;
  t1, t2: TTimeStamp;
  DurationDays, DurationHours, DurationMinutes: integer;
begin
  Result:=False;
  DurationDays:=0;
  DurationHours:=0;
  DurationMinutes:=0;
  // ��������� �������� ����� �� ������� ���������� � ��������� ������������
  if FOrganizationID<0 then
    Exit;
  if FHasStartDateTime and FHasStopDateTime then
    begin
      // ����� ���������� �� �� ����� �������, ���� ����� �������� �������, �������
      if FStartDateTime>FStopDateTime then
        Exit;
      // ���� �������� ������������ - ���������� ������������
      if not FUnknownDuration then
        begin
          // �������� ���� ������, ���� ����� � ����������� ����������� �����������
          t1:=DateTimeToTimeStamp(FStartDateTime);
          t2:=DateTimeToTimeStamp(FStopDateTime);
          a1:=TimeStampToMSecs(t2)-TimeStampToMSecs(t1);
          // ��������! �������� a2 � ������ ������ ��� ����� a1, �.�. ���������� ����������!!!
          if (a2>0) then
            begin
              DurationDays:=Int64(a2)div Int64(86400000);
              a2:=Int64(a2)-Int64((Int64(FDurationDays)*Int64(86400000)));
              DurationHours:=a2 div 3600000;
              a2:=a2-FDurationHours*3600000;
              DurationMinutes:=a2 div 60000;
            end;
          if FDurationDays<>DurationDays then
            Exit;
          if FDurationHours<>DurationHours then
            Exit;
          if FDurationMinutes<>DurationMinutes then
            Exit;
        end;
    end;
  if FType<>Routines.PrepareStringForRNE5(FType) then
    Exit;
  if FName<>Routines.PrepareStringForRNE5(FName) then
    Exit;
  if FAuthor<>Routines.PrepareStringForRNE5(FAuthor) then
    Exit;
  if FProducer<>Routines.PrepareStringForRNE5(FProducer) then
    Exit;
  if FPerformer<>Routines.PrepareStringForRNE5(FPerformer) then
    Exit;
  if FOrganizer<>Routines.PrepareStringForRNE5(FOrganizer) then
    Exit;
  if FTicketPrice<>Routines.PrepareStringForRNE5(FTicketPrice) then
    Exit;
  if FOtherInfoPlane<>Routines.PrepareStringForRNE5(FOtherInfoPlane) then
    Exit;
  if (FForChildren or FForTeenagers)and FForAdultsOnly then
    Exit;
  Result:=True;
end;

procedure TMeasureDataClass.Normalize;
var
  DT: TDateTime;
  a1: Comp;
  a2: Int64 absolute a1;
  t1, t2: TTimeStamp;
begin
  // ���� ������ ��� �������������, ������� �� ���������
  if Normalized then
    Exit;
  // �������� ������������
  if FOrganizationID<0 then
    FOrganizationID:=0;

  // �������� ������������
  FDurationDays:=0;
  FDurationHours:=0;
  FDurationMinutes:=0;

  // ���� ���� � ���� ������ � ���� �����
  if FHasStartDateTime and FHasStopDateTime then
    begin
      // ����� ���������� �� �� ����� �������, �������� �������, ���� �����
      if FStartDateTime>FStopDateTime then
        begin
          DT:=FStartDateTime;
          FStartDateTime:=FStopDateTime;
          FStopDateTime:=DT;
        end;
      // ���� �������� ������������ - ������������� ������������
      if not FUnknownDuration then
        begin
          // �������� ���� ������, ���� ����� � ����������� ����������� �����������
          t1:=DateTimeToTimeStamp(FStartDateTime);
          t2:=DateTimeToTimeStamp(FStopDateTime);
          a1:=TimeStampToMSecs(t2)-TimeStampToMSecs(t1);
          // ��������! �������� a2 � ������ ������ ��� ����� a1, �.�. ���������� ����������!!!
          if (a2>0) then
            begin
              FDurationDays:=Int64(a2)div Int64(86400000);
              a2:=Int64(a2)-Int64((Int64(FDurationDays)*Int64(86400000)));
              FDurationHours:=a2 div 3600000;
              a2:=a2-FDurationHours*3600000;
              FDurationMinutes:=a2 div 60000;
            end;
        end;
    end;

  _Type:=Routines.PrepareStringForRNE5(FType);
  _Name:=Routines.PrepareStringForRNE5(FName);
  _Author:=Routines.PrepareStringForRNE5(FAuthor);
  _Producer:=Routines.PrepareStringForRNE5(FProducer);
  _Performer:=Routines.PrepareStringForRNE5(FPerformer);
  _Organizer:=Routines.PrepareStringForRNE5(FOrganizer);
  _TicketPrice:=Routines.PrepareStringForRNE5(FTicketPrice);
  _OtherInfoPlane:=Routines.PrepareStringForRNE5(FOtherInfoPlane);

  if FForChildren or FForTeenagers then
    _ForAdultsOnly:=False;
end;

procedure TMeasureDataClass.SetAuthor(const Value: string);
begin
  if FAutoNormalizeData then
    begin
      if FAuthor<>Routines.PrepareStringForRNE5(Value) then
        FAuthor:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FAuthor<>Value then
      FAuthor:=Value;
end;

procedure TMeasureDataClass.SetAutoNormalizeData(const Value: boolean);
begin
  if FAutoNormalizeData<>Value then
    FAutoNormalizeData:=Value;
end;

procedure TMeasureDataClass.SetForAdultsOnly(const Value: boolean);
begin
  if FAutoNormalizeData then
    begin
      if FForChildren or FForTeenagers then
        begin
          if not FForAdultsOnly then
            FForAdultsOnly:=False
        end
      else
        if FForAdultsOnly<>Value then
          FForAdultsOnly:=Value;
    end
  else
    if FForAdultsOnly<>Value then
      FForAdultsOnly:=Value;
end;

procedure TMeasureDataClass.SetForChildren(const Value: boolean);
begin
  if FAutoNormalizeData then
    begin
      if FForAdultsOnly then
        begin
          if not FForChildren then
            FForChildren:=False;
        end
      else
        if FForChildren<>Value then
          FForChildren:=Value;
    end
  else
    if FForChildren<>Value then
      FForChildren:=Value;
end;

procedure TMeasureDataClass.SetForTeenagers(const Value: boolean);
begin
  if FAutoNormalizeData then
    begin
      if FForAdultsOnly then
        begin
          if not FForTeenagers then
            FForTeenagers:=False;
        end
      else
        if FForTeenagers<>Value then
          FForTeenagers:=Value;
    end
  else
    if FForTeenagers<>Value then
      FForTeenagers:=Value;
end;

procedure TMeasureDataClass.SetIsPremier(const Value: boolean);
begin
  if FIsPremier<>Value then
    FIsPremier:=Value;
end;

procedure TMeasureDataClass.SetIsTour(const Value: boolean);
begin
  if FIsTour<>Value then
    FIsTour:=Value;
end;

procedure TMeasureDataClass.SetName(const Value: string);
begin
  if FAutoNormalizeData then
    begin
      if FName<>Routines.PrepareStringForRNE5(Value) then
        FName:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FName<>Value then
      FName:=Value;
end;

procedure TMeasureDataClass.SetOrganizationID(const Value: integer);
begin
  if FAutoNormalizeData then
    begin
      if Value<0 then
        FOrganizationID:=0
      else
        if FOrganizationID<>Value then
          FOrganizationID:=Value;
    end
  else
    if FOrganizationID<>Value then
      FOrganizationID:=Value;
end;

procedure TMeasureDataClass.SetOrganizer(const Value: string);
begin
  if FAutoNormalizeData then
    begin
      if FOrganizer<>Routines.PrepareStringForRNE5(Value) then
        FOrganizer:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FOrganizer<>Value then
      FOrganizer:=Value;
end;

procedure TMeasureDataClass.SetOtherInfoPlane(const Value: AnsiString);
begin
  if FAutoNormalizeData then
    begin
      if FOtherInfoPlane<>Routines.PrepareStringForRNE5(Value) then
        FOtherInfoPlane:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FOtherInfoPlane<>Value then
      FOtherInfoPlane:=Value;
end;

procedure TMeasureDataClass.SetOtherInfoRTF(const Value: AnsiString);
begin
  if FOtherInfoRTF<>Value then
    FOtherInfoRTF:=Value;
end;

procedure TMeasureDataClass.SetPerformer(const Value: string);
begin
  if FAutoNormalizeData then
    begin
      if FPerformer<>Routines.PrepareStringForRNE5(Value) then
        FPerformer:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FPerformer<>Value then
      FPerformer:=Value;
end;

procedure TMeasureDataClass.SetProducer(const Value: string);
begin
  if FAutoNormalizeData then
    begin
      if FProducer<>Routines.PrepareStringForRNE5(Value) then
        FProducer:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FProducer<>Value then
      FProducer:=Value;
end;

procedure TMeasureDataClass.SetTicketPrice(const Value: string);
begin
  if FAutoNormalizeData then
    begin
      if FTicketPrice<>Routines.PrepareStringForRNE5(Value) then
        FTicketPrice:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FTicketPrice<>Value then
      FTicketPrice:=Value;
end;

procedure TMeasureDataClass.SetType(const Value: string);
begin
  if FAutoNormalizeData then
    begin
      if FType<>Routines.PrepareStringForRNE5(Value) then
        FType:=Routines.PrepareStringForRNE5(Value);
    end
  else
    if FType<>Value then
      FType:=Value;
end;

{ TODO : ���� ����� �������� ������ ������ (������������ � ����������� �� �������� ���������� FAutoNormalizeData) }

procedure TMeasureDataClass.SetDurationDays(const Value: integer);
begin
  if FDurationDays<>Value then
    FDurationDays:=Value;
end;

procedure TMeasureDataClass.SetDurationHours(const Value: integer);
begin
  if FDurationHours<>Value then
    FDurationHours:=Value;
end;

procedure TMeasureDataClass.SetDurationMinutes(const Value: integer);
begin
  if FDurationMinutes<>Value then
    FDurationMinutes:=Value;
end;

procedure TMeasureDataClass.SetHasStartDateTime(const Value: boolean);
begin
  if FHasStartDateTime<>Value then
    FHasStartDateTime:=Value;
end;

procedure TMeasureDataClass.SetHasStopDateTime(const Value: boolean);
begin
  if FHasStopDateTime<>Value then
    FHasStopDateTime:=Value;
end;

procedure TMeasureDataClass.SetStartDateTime(const Value: TDateTime);
begin
  if FStartDateTime<>Value then
    FStartDateTime:=Value;
end;

procedure TMeasureDataClass.SetStopDateTime(const Value: TDateTime);
begin
  if FStopDateTime<>Value then
    FStopDateTime:=Value;
end;


procedure TMeasureDataClass.SetUnknownDuration(const Value: boolean);
begin
  if FUnknownDuration<>Value then
    FUnknownDuration:=Value;
end;

end.
