unit Unit19;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, System.Actions,
  Vcl.ActnList, uTArchiveFrame;

type
  TForm19 = class(TForm)
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    ArchiveFrame1: TArchiveFrame;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  Form19: TForm19;

implementation

{$R *.dfm}

uses
  dxBar,
  DateUtils;

constructor TForm19.Create(AOwner: TComponent);
var
  d: TDate;
begin
  inherited;
  ArchiveFrame1.Initialize(ActionList1, True, 'Период подачи', Today, Today);
end;

end.
