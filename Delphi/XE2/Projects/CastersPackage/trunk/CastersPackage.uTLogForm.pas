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
    FSavedBusyCounter: Integer;
    FRefresh: TRefreshBusyStateMethod;
    FProgressBar: TProgressBar;
    FError: Boolean;
    FErrorMessage: string;
    procedure ClearError;
    procedure RunRefreshBusy;
    procedure RunIncreaseBusy;
    procedure RunDecreaseBusy;
  protected
    procedure SaveBusyCounter;
    procedure RestoreBusyCounter;
    procedure ShowErrorDialog;
    procedure ProcedureHeader(const ATitle, ALogGroupGUID: string);
    procedure ProcedureFooter;
    procedure GenerateError(const AMessage: string);
    function GetActionUpdateLogMessage(AAction: TCustomAction): string;
    procedure Initialize; virtual;
    procedure InitializeLog; virtual;
    procedure Finalize; virtual;
    procedure Help(const AHelpContext: THelpContext; const AGUID: string);
    procedure CloseModalWindowWithCancelResult(const AWindowCaption, AGUID: string);
    procedure CloseModalWindowWithOkResult(const AWindowCaption, AGUID: string);
  public
    constructor Create(AOwner: TComponent; ABusyCounter: PInteger = nil;
      ARefreshBusyStateMethod: TRefreshBusyStateMethod = nil; AProgressBar: TProgressBar = nil);
      reintroduce; virtual;
    destructor Destroy; override;
    function ShowModal: Integer; override;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uRoutines;

resourcestring
  RsContextHelpProcedure = '��������� ������ ����������� �������';
  RsTryingToOpenHelpFile = '������������ ������� �������� ����������� ����� ���������...';
  RsHelpFileNonFound = '��������, ���������� ���� � ������ ��������� �� ������.';
  RsProcedureExecutesWithoutError = '��������� ��������� ��� ������.';
  RsShowErrorDialogCaption = '%s - ������!';
  RsActionStateChanged = '�������� "%s" %s.';
  RsActionOn = '��������';
  RsActionOff = '���������';
  RsTryingToShowModalWindow = '������������ ������� ����������� ���������� �' + '��� "%s".';
  RsModalWindowHiden = '��������� ���� "%s" ������.';
  RsCloseModalWithCancelResultProcedure =
    '��������� �������� ���������� ���� %s � ����������� mrCancel';
  RsCloseModalWithOkResultProcedure = '��������� �������� ���������� ���� %s � ����������� mrOk';
  // RsWindowClosedByUser = '���� %s ������� �������������.';
  RsWindowClosed = '���� %s �������.';

procedure TLogForm.ProcedureHeader(const ATitle, ALogGroupGUID: string);
begin
  ClearError;
  Log.EnterMethod(ATitle, ALogGroupGUID);
  RunIncreaseBusy;
end;

procedure TLogForm.CloseModalWindowWithCancelResult(const AWindowCaption, AGUID: string);
begin
  ProcedureHeader(Format(RsCloseModalWithCancelResultProcedure, [AWindowCaption]), AGUID);
  ModalResult := mrCancel;
  Log.SendInfo(Format(RsWindowClosed, [AWindowCaption]));
  ProcedureFooter;
end;

procedure TLogForm.CloseModalWindowWithOkResult(const AWindowCaption, AGUID: string);
begin
  ProcedureHeader(Format(RsCloseModalWithOkResultProcedure, [AWindowCaption]), AGUID);
  ModalResult := mrOk;
  Log.SendInfo(Format(RsWindowClosed, [AWindowCaption]));
  ProcedureFooter;
end;

constructor TLogForm.Create(AOwner: TComponent; ABusyCounter: PInteger;
  ARefreshBusyStateMethod: TRefreshBusyStateMethod; AProgressBar: TProgressBar);
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
    Result := Format(RsActionStateChanged,
      [AAction.Caption, Routines.GetConditionalString(AAction.Enabled, RsActionOn, RsActionOff)]);
  end;
end;

procedure TLogForm.Help(const AHelpContext: THelpContext; const AGUID: string);
begin
  ProcedureHeader(RsContextHelpProcedure, AGUID);

  Log.SendInfo(RsTryingToOpenHelpFile);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(AHelpContext);
  end
  else
  begin
    GenerateError(RsHelpFileNonFound);
  end;

  ProcedureFooter;
end;

procedure TLogForm.Initialize;
begin
  FSavedBusyCounter := 0;
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
begin
  Log.SendError(FErrorMessage);
  try
    SaveBusyCounter;
    MessageBox(Handle, PWideChar(FErrorMessage),
      PWideChar(Format(RsShowErrorDialogCaption, [Application.Title])),
      MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
  finally
    RestoreBusyCounter;
  end;
end;

function TLogForm.ShowModal: Integer;
begin
  Log.SendDebug(Format(RsTryingToShowModalWindow, [Caption]));
  try
    SaveBusyCounter;
    Result := inherited;
  finally
    RestoreBusyCounter;
    Log.SendDebug(Format(RsModalWindowHiden, [Caption]));
  end;
end;

procedure TLogForm.SaveBusyCounter;
begin
  if Assigned(FBusyCounter) then
  begin
    FSavedBusyCounter := FBusyCounter^;
    FBusyCounter^ := 0;
    RunRefreshBusy;
  end;
end;

procedure TLogForm.RestoreBusyCounter;
begin
  if Assigned(FBusyCounter) then
  begin
    FBusyCounter^ := FSavedBusyCounter;
    FSavedBusyCounter := 0;
    RunRefreshBusy;
  end;
end;

end.
