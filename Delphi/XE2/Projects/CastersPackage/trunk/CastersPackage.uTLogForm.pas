unit CastersPackage.uTLogForm;

interface

uses
  CastersPackage.uLogProvider,
  CastersPackage.uICustomized,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.ActnList,
  CastersPackage.uTDialogPosition,
  CastersPackage.uTRefreshBusyStateMethod;

type
  TLogForm = class(TForm, ICustomized)
    Log: TLogProvider;
  strict private
    FBusyCounter: PInteger;
    FRefresh: TRefreshBusyStateMethod;
    FProgressBar: TProgressBar;
    FError: Boolean;
    FErrorMessage: string;
    procedure ClearError;
    procedure RunRefreshBusy;
    procedure RunIncreaseBusy;
    procedure RunDecreaseBusy;
  protected
    procedure ShowErrorDialog;
    procedure ProcedureHeader(const ATitle, ALogGroupGUID: string);
    procedure ProcedureFooter;
    procedure GenerateError(const AMessage: string);
    function GetActionUpdateLogMessage(AAction: TCustomAction): string;
    procedure Initialize; virtual;
    procedure InitializeLog; virtual;
    procedure Finalize; virtual;
  public
    constructor Create(AOwner: TComponent; ABusyCounter: PInteger = nil;
      ARefreshBusyStateMethod: TRefreshBusyStateMethod = nil; AProgressBar: TProgressBar = nil); reintroduce; virtual;
    destructor Destroy; override;
    function ShowModal: Integer; override;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uRoutines;

resourcestring
  RsProcedureExecutesWithoutError = 'Процедура выполнена без ошибок.';
  RsShowErrorDialogCaption = '%s - Ошибка!';
  RsActionStateChanged = 'Действие "%s" %s.';
  RsActionOn = 'включено';
  RsActionOff = 'отключено';
  RsTryingToShowModalWindow = 'Производится попытка отображения модального о' + 'кна "%s".';
  RsModalWindowHiden = 'Модальное окно "%s" скрыто.';

procedure TLogForm.ProcedureHeader(const ATitle, ALogGroupGUID: string);
begin
  ClearError;
  Log.EnterMethod(ATitle, ALogGroupGUID);
  RunIncreaseBusy;
end;

constructor TLogForm.Create(AOwner: TComponent; ABusyCounter: PInteger; ARefreshBusyStateMethod: TRefreshBusyStateMethod;
  AProgressBar: TProgressBar);
begin
  inherited Create(AOwner);
  FBusyCounter := ABusyCounter;
  FRefresh := ARefreshBusyStateMethod;
  FProgressBar := AProgressBar;
  Initialize;
end;

destructor TLogForm.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TLogForm.Finalize;
begin
end;

procedure TLogForm.GenerateError(const AMessage: string);
begin
  FErrorMessage := AMessage;
  FError := True;
end;

function TLogForm.GetActionUpdateLogMessage(AAction: TCustomAction): string;
begin
  Result := EmptyStr;
  if Assigned(AAction) then
  begin
    Result := Format(RsActionStateChanged, [AAction.Caption, Routines.GetConditionalString(AAction.Enabled, RsActionOn,
      RsActionOff)]);
  end;
end;

procedure TLogForm.Initialize;
begin
  InitializeLog;
end;

procedure TLogForm.InitializeLog;
begin
  Log.LogFile.FileNameSuffix := Application.Title + '_' + Self.Name;
end;

procedure TLogForm.RunIncreaseBusy;
begin
  if Assigned(FBusyCounter) then
  begin
    FBusyCounter^ := FBusyCounter^ + 1;
    if FBusyCounter^ < 0 then
    begin
      FBusyCounter^ := 0;
    end;
    RunRefreshBusy;
  end;
end;

procedure TLogForm.RunDecreaseBusy;
begin
  if Assigned(FBusyCounter) then
  begin
    FBusyCounter^ := FBusyCounter^ - 1;
    if FBusyCounter^ < 0 then
    begin
      FBusyCounter^ := 0;
    end;
    RunRefreshBusy;
  end;
end;

procedure TLogForm.RunRefreshBusy;
begin
  if Assigned(FRefresh) then
  begin
    FRefresh;
  end;
end;

procedure TLogForm.ProcedureFooter;
begin
  if FError then
  begin
    ShowErrorDialog;
    ClearError;
  end
  else
  begin
    Log.SendDebug(RsProcedureExecutesWithoutError);
  end;
  if Assigned(FProgressBar) then
  begin
    FProgressBar.Position := FProgressBar.Min;
  end;
  RunDecreaseBusy;
  Log.ExitMethod;
end;

procedure TLogForm.ClearError;
begin
  FError := False;
  FErrorMessage := EmptyStr;
end;

procedure TLogForm.ShowErrorDialog;
var
  old_busy_counter: Integer;
begin
  old_busy_counter := 0;
  Log.SendError(FErrorMessage);
  try
    if Assigned(FBusyCounter) then
    begin
      old_busy_counter := FBusyCounter^;
      FBusyCounter^ := 0;
      RunRefreshBusy;
    end;
    MessageBox(Handle, PWideChar(FErrorMessage), PWideChar(Format(RsShowErrorDialogCaption, [Application.Title])),
      MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
  finally
    if Assigned(FBusyCounter) then
    begin
      FBusyCounter^ := old_busy_counter;
      RunRefreshBusy;
    end;
  end;
end;

function TLogForm.ShowModal: Integer;
var
  old_busy_counter: Integer;
begin
  old_busy_counter := 0;
  Log.SendDebug(Format(RsTryingToShowModalWindow, [Caption]));
  try
    if Assigned(FBusyCounter) then
    begin
      old_busy_counter := FBusyCounter^;
      FBusyCounter^ := 0;
      RunRefreshBusy;
    end;
    Result := inherited;
  finally
    if Assigned(FBusyCounter) then
    begin
      FBusyCounter^ := old_busy_counter;
      RunRefreshBusy;
    end;
    Log.SendDebug(Format(RsModalWindowHiden, [Caption]));
  end;
end;

end.
