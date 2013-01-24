unit CastersPackage.Actions.Classes;

interface

uses
  VCL.Forms,
  VCL.ActnList,
  System.Classes,
  VCL.StdActns;

type
  TQuitAction = class(TAction); { class(TCustomAction)
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
    end; }

  TWindowCloseAction = class(TCustomAction)
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

  TAction_Cancel = class(TAction)
  end;

  TAction_Help = class(THelpContents)
  end;

  TAction_About = class(TAction) { (TCustomAction)
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
      property FormClass: TForm read FFormClass write FFormClass; //Class read GetFormClass write SetFormClass; }
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

  TMenuGroupAction = class(TCustomAction)
  public
    function HandlesTarget(Target: TObject): Boolean; override;
  published
    property Caption;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property Visible;
    property OnHint;
    property OnUpdate;
  end;

  THelpContentsAction = class(THelpContents);

  TFileMenuGroupAction = class(TMenuGroupAction);
  TActionMenuGroupAction = class(TMenuGroupAction);
  THelpMenuGroupAction = class(TMenuGroupAction);
  TViewMenuGroupAction = class(TMenuGroupAction);

procedure Register;

implementation

uses
  System.Actions,
  Winapi.Windows,
  Winapi.Messages,
  CastersPackage.Actions.DataModule;

procedure Register;
begin
  RegisterActions('Файл', [TQuitAction, TAction_Configuration, TAction_Logon, TAction_Logoff,
    TFileMenuGroupAction], TActionsDataModule);
  RegisterActions('Справка', [TAction_Help, TAction_About, THelpContentsAction,
    THelpMenuGroupAction], TActionsDataModule);
  RegisterActions('Окно', [TAction_Restore], TActionsDataModule);
  RegisterActions('Действие', [TWindowCloseAction, TAction_Apply, TAction_Defaults,
    TAction_PreviousPage, TAction_NextPage, TAction_Accounts, TAction_Report, TAction_Cancel,
    TActionMenuGroupAction], TActionsDataModule);
  RegisterActions('Вид', [TViewMenuGroupAction], TActionsDataModule);
end;

{ TAction_About

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
  end; }

{ TQuitAction }

{ procedure TQuitAction.ExecuteTarget(Target: TObject);
  begin
  inherited;
  if Assigned(Application.MainForm) then
  begin
  Application.HelpCommand(HELP_QUIT, 0);
  SendMessage(Application.MainForm.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
  //Application.MainForm.Close;
  end;
  end;

  function TQuitAction.HandlesTarget(Target: TObject): Boolean;
  begin
  Result := True;
  end; }

{ TWindowCloseAction }

procedure TWindowCloseAction.ExecuteTarget(Target: TObject);
begin
  if Assigned(Owner) then
    (Owner as TCustomForm).Close;
end;

function TWindowCloseAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

{ TMenuGroupAction }

function TMenuGroupAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

end.
