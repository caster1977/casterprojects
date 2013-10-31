unit uTOnDisplayMessage;

interface

uses
  uTMessageType;

type
  TOnDisplayMessage = procedure(const AType: TMessageType; const AText: string = '') of object;

implementation

end.
