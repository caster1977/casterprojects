unit uTOnShowMessage;

interface

uses
  uTMessageType;

type
  TOnShowMessage = procedure(const AText: string; const AType: TMessageType) of object;

implementation

end.
