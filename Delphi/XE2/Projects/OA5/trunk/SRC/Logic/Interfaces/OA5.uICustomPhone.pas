unit OA5.uICustomPhone;

interface

uses
  OA5.uTPhoneTypes;

type
  ICustomPhone = interface
    ['{B5ACA0CA-E73B-46FD-8E5B-B110BBED5789}']
    function GetCheckDate: TDate;
    function GetComments: string;
    function GetCreationDateTime: TDateTime;
    function GetId: Int64;
    function GetModificationDateTime: TDateTime;
    function GetPhoneNumber: string;
    function GetPriority: byte;
    function GetPhoneType: TPhoneTypes;
    function PhoneTypeToString: string;
    procedure SetPhoneNumber(const AValue: string);
    procedure SetPriority(const AValue: byte);
    procedure SetPhoneType(const AValue: TPhoneTypes);
    procedure SetCheckDate(const AValue: TDate);
    procedure SetComments(const AValue: string);
    procedure SetCreationDateTime(const AValue: TDateTime);
    procedure SetId(const AValue: Int64);
    procedure SetModificationDateTime(const AValue: TDateTime);
    property Id: Int64 read GetId write SetId;
    property CheckDate: TDate read GetCheckDate write SetCheckDate;
    property Comments: string read GetComments write SetComments;
    property CreationDateTime: TDateTime read GetCreationDateTime write SetCreationDateTime;
    property ModificationDateTime: TDateTime read GetModificationDateTime
      write SetModificationDateTime;
    property PhoneNumber: string read GetPhoneNumber write SetPhoneNumber;
    property Priority: byte read GetPriority write SetPriority;
    property PhoneType: TPhoneTypes read GetPhoneType write SetPhoneType;
  end;

implementation

end.
