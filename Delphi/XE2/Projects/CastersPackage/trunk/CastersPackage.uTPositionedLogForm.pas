unit CastersPackage.uTPositionedLogForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  CastersPackage.uTLogForm,
  CastersPackage.uIPositionedDialog,
  CastersPackage.uTDialogPosition,
  Vcl.ComCtrls,
  CastersPackage.uTRefreshBusyStateMethod;

type
  TPositionedLogForm = class(TLogForm, IPositionedDialog)
  strict private
    FDialogPosition: TDialogPosition;
    function GetDialogPosition: TDialogPosition;
    procedure SetDialogPosition(const AValue: TDialogPosition);
  public
    constructor Create(AOwner: TComponent; const ADialogPosition: TDialogPosition;
      ABusyCounter: PInteger = nil; ARefreshBusyStateMethod: TRefreshBusyStateMethod = nil;
      AProgressBar: TProgressBar = nil); reintroduce; virtual;
  published
    property DialogPosition: TDialogPosition read GetDialogPosition
      write SetDialogPosition nodefault;
  end;

implementation

{$R *.dfm}

constructor TPositionedLogForm.Create(AOwner: TComponent; const ADialogPosition: TDialogPosition;
  ABusyCounter: PInteger; ARefreshBusyStateMethod: TRefreshBusyStateMethod;
  AProgressBar: TProgressBar);
begin
  inherited Create(AOwner, ABusyCounter, ARefreshBusyStateMethod, AProgressBar);
  DialogPosition := ADialogPosition;
end;

function TPositionedLogForm.GetDialogPosition: TDialogPosition;
begin

  Result := FDialogPosition;
end;

procedure TPositionedLogForm.SetDialogPosition(const AValue: TDialogPosition);
begin
  if not FDialogPosition.Equals(AValue) then
  begin
    FDialogPosition.Assign(AValue);
    if FDialogPosition.Centered then
    begin
      Position := poScreenCenter;
    end
    else
    begin
      Position := poDesigned;
      if Assigned(Screen) then
      begin
        if FDialogPosition.Left < Screen.WorkAreaLeft then
        begin
          Left := Screen.WorkAreaLeft;
        end
        else
        begin
          if FDialogPosition.Left > Screen.WorkAreaLeft + Screen.WorkAreaWidth then
          begin
            Left := Screen.WorkAreaLeft + Screen.WorkAreaWidth - Width;
          end
          else
          begin
            Left := FDialogPosition.Left;
          end;
        end;
        if FDialogPosition.Top < Screen.WorkAreaTop then
        begin
          Top := Screen.WorkAreaTop;
        end
        else
        begin
          if FDialogPosition.Top > Screen.WorkAreaTop + Screen.WorkAreaHeight then
          begin
            Top := Screen.WorkAreaTop + Screen.WorkAreaHeight - Height;
          end
          else
          begin
            Top := FDialogPosition.Top;
          end;
        end;
      end;
    end;
  end;
end;

end.
