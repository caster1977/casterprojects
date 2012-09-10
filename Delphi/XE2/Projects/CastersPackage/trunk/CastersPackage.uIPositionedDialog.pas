unit CastersPackage.uIPositionedDialog;

interface

uses
  CastersPackage.uTDialogPosition;

type
  IPositionedDialog = interface
    ['{1BAF5428-091B-4F4F-984D-7E929422F60F}']
    function GetDialogPosition: TDialogPosition;
    procedure SetDialogPosition(const AValue: TDialogPosition);
    property DialogPosition: TDialogPosition read GetDialogPosition write SetDialogPosition;
  end;

implementation

end.
