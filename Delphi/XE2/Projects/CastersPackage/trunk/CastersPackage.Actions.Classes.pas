unit CastersPackage.Actions.Classes;

interface

uses
  VCL.Forms,
  Vcl.ActnList,
  System.Classes,
  Vcl.StdActns;

type
  TAction_Quit = class(TCustomAction)
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
  end;

  TAction_Configuration = class(TAction)
  end;

  TAction_Close = class(TWindowAction)
  end;

  TAction_Help = class(TAction)
  end;

  TAction_About = class(TCustomAction)
  strict private
    FFormClass: TForm; // Class;
    function GetFormClass: TFormClass;
    procedure SetFormClass(const Value: TFormClass);
  strict protected
    function GetForm(Target: TObject): TForm; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
    property OnUpdate;
    property FormClass: TForm read FFormClass write FFormClass; //Class read GetFormClass write SetFormClass;
  end;

  TAction_Apply = class(TAction)
  end;

  TAction_Defaults = class(TAction)
  end;

  TAction_PreviousPage = class(TAction)
  end;

  TAction_NextPage = class(TAction)
  end;

  TAction_Restore = class(TAction)
  end;

  TAction_Logon = class(TAction)
  end;

  TAction_Logoff = class(TAction)
  end;

  TAction_Accounts = class(TAction)
  end;

  TAction_Report = class(TAction)
  end;

procedure Register;

implementation

uses
  Winapi.Windows,
  CastersPackage.Actions.DataModule;

procedure register;
begin
  RegisterActions('Файл', [TAction_Quit, TAction_Configuration, TAction_Logon, TAction_Logoff], TActionsDataModule);
  RegisterActions('Справка', [TAction_Help, TAction_About], TActionsDataModule);
  RegisterActions('Окно', [TAction_Restore], TActionsDataModule);
  RegisterActions('Действие', [TAction_Close, TAction_Apply, TAction_Defaults, TAction_PreviousPage, TAction_NextPage, TAction_Accounts,
    TAction_Report], TActionsDataModule);
end;

{ TAction_Quit }

procedure TAction_Quit.ExecuteTarget(Target: TObject);
begin
  inherited;
  if Assigned(Application.MainForm) then
    begin
      Application.HelpCommand(HELP_QUIT, 0);
      Application.MainForm.Close;
    end;
end;

function TAction_Quit.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

{ TAction_About }

constructor TAction_About.Create(AOwner: TComponent);
begin
  inherited;
  DisableIfNoHandler := False;
  Enabled := csDesigning in ComponentState;
end;

procedure TAction_About.ExecuteTarget(Target: TObject);
begin
  // with GetForm(Target) do ;
  if Assigned(FFormClass) then
    begin
      with FFormClass.Create(Self) do
        try
          ShowModal;
        finally
          Free;
        end;
    end;
end;

function TAction_About.GetForm(Target: TObject): TForm;
begin
  Result := (Target as TForm);
end;

function TAction_About.GetFormClass: TFormClass;
begin
  Result := FFormClass;
end;

function TAction_About.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True; //((FFormClass <> nil) and (Target = FFormClass) or (FFormClass = nil) and (Target is TForm)) and (TForm(Target).FormStyle = fsMDIForm);
end;

procedure TAction_About.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent.ClassType = FFormClass) then
    FFormClass := nil;
end;

procedure TAction_About.SetFormClass(const Value: TFormClass);
begin
  if Value <> FFormClass then
    begin
      FFormClass := Value;
      //if Value <> nil then
      //  Value.FreeNotification(Self);
    end;
end;

procedure TAction_About.UpdateTarget(Target: TObject);
begin
  Enabled := True; // GetForm(Target).ActiveMDIChild <> nil;
end;

end.
