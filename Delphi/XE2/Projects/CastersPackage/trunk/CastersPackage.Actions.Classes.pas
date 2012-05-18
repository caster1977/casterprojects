unit CastersPackage.Actions.Classes;

interface

uses
  Vcl.ActnList,
  System.Classes;

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

  TAction_Close = class(TAction)
  end;

  TAction_Help = class(TAction)
  end;

  TAction_About = class(TAction)
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
  VCL.Forms,
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

end.
