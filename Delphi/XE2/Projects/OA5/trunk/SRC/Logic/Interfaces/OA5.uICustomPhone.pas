unit OA5.uICustomPhone;

interface

uses
  OA5.uTPhoneTypes;

type
  ICustomPhone = interface
  ['{B5ACA0CA-E73B-46FD-8E5B-B110BBED5789}']
    function GetCheckDate: TDate;
    procedure SetCheckDate(const AValue: TDate);
    function GetComments: string;
    procedure SetComments(const AValue: string);
    function GetCreationDateTime: TDateTime;
    procedure SetCreationDateTime(const AValue: TDateTime);
    function GetId: Int64;
    procedure SetId(const AValue: Int64);
    function GetModificationDateTime: TDateTime;
    procedure SetModificationDateTime(const AValue: TDateTime);
    function GetPhoneNumber: string;
    procedure SetPhoneNumber(const AValue: string);
    function GetPriority: byte;
    procedure SetPriority(const AValue: byte);
    procedure SetPhoneType(const AValue: TPhoneTypes);
    function GetPhoneType: TPhoneTypes;
    function PhoneTypeToString: string;
    property CheckDate: TDate read GetCheckDate write SetCheckDate;
    property Comments: string read GetComments write SetComments;
    property CreationDateTime: TDateTime read GetCreationDateTime write SetCreationDateTime;
    property Id: Int64 read GetId write SetId;
    property ModificationDateTime: TDateTime read GetModificationDateTime write SetModificationDateTime;
    property PhoneNumber: string read GetPhoneNumber write SetPhoneNumber;
    property Priority: byte read GetPriority write SetPriority;
    property PhoneType: TPhoneTypes read GetPhoneType write SetPhoneType;
  end;

implementation

end.
