unit uMultiBufferClass;

interface

uses
  System.Generics.Collections;

resourcestring
  SMultiBufferIndexError = 'Произошла ошибка при попытке получения элемента буфера!';

type
  TMeasureRec=class
  strict private
    FType: string;
    FMsrName: string;
    FMsrAuthor: string;
    FMsrProducer: string;
    FMsrPerformer: string;
    FMsrOrganizer: string;
    FMsrTicketPrice: string;
    FMsrOtherInfo: AnsiString;
    FMsrHasStartDateTime: boolean;
    FMsrHasStopDateTime: boolean;
    FMsrStartDateTime: TDateTime;
    FMsrStopDateTime: TDateTime;
    FMsrDurationDays: integer;
    FMsrDurationHours: integer;
    FMsrDurationMinutes: integer;
    FMsrIsPremier: boolean;
    FMsrIsTour: boolean;
    FMsrForChildren: boolean;
    FMsrForTeenagers: boolean;
    FMsrForAdultsOnly: boolean;
    FMsrUnknownDuration: boolean;
    FMsrOrganizationID: integer;
    FMsrOtherInfoPlane: AnsiString;
  public
    property _Type: string read FType write SetType;
    property _Name: string read F write Set;
    property _Author: string read F write Set;
    property _Producer: string read F write Set;
    property _Performer: string read F write Set;
    property _Organizer: string read F write Set;
    property _TicketPrice: string read F write Set;
    property _OtherInfo: AnsiString;
    property _HasStartDateTime: boolean;
    property _HasStopDateTime: boolean;
    property MsrStartDateTime: TDateTime;
    property MsrStopDateTime: TDateTime;
    property MsrDurationDays: integer;
    property MsrDurationHours: integer;
    property MsrDurationMinutes: integer;
    property MsrIsPremier: boolean;
    property MsrIsTour: boolean;
    property MsrForChildren: boolean;
    property MsrForTeenagers: boolean;
    property MsrForAdultsOnly: boolean;
    property MsrUnknownDuration: boolean;
    property MsrOrganizationID: integer;
    property MsrOtherInfoPlane: AnsiString;
  end;

  TMultiBufferClass=class
  strict private
    FItems: TList<TMeasureRec>;
  private
    function GetCount: Integer;
    function GetItem(Index: Integer): TMeasureRec;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const Value: TMeasureRec): integer;
    function Append(const Value: TMeasureRec): boolean;
    function Delete(const Value: integer): boolean;
    procedure Clear;
    property Count: Integer read GetCount;
    property Items[index: Integer]: TMeasureRec read GetItem; default;
  end;

implementation

uses
  System.SysUtils;

function TMultiBufferClass.Add(const Value: TMeasureRec): integer;
begin

end;

function TMultiBufferClass.Append(const Value: TMeasureRec): boolean;
begin

end;

procedure TMultiBufferClass.Clear;
begin

end;

constructor TMultiBufferClass.Create;
begin

end;

function TMultiBufferClass.Delete(const Value: integer): boolean;
begin
  inherited;

end;

destructor TMultiBufferClass.Destroy;
begin
  while Count > 0 do Items[0].Free;
  FreeAndNil(FItems);
  inherited;
end;

function TMultiBufferClass.GetCount: Integer;
begin
  if FItems=nil then
    Result:=0
  else
    Result:=FItems.Count;
end;

function TMultiBufferClass.GetItem(Index: Integer): TMeasureRec;
begin
  if FItems = nil then
    Error({$IFNDEF CLR}@{$ENDIF}SMultiBufferIndexError);
  Result := TMeasureRec(FItems[Index]);
end;

end.
