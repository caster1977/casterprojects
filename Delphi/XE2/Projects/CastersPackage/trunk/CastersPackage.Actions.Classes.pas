unit CastersPackage.Actions.Classes;

interface

uses
  Vcl.ActnList,
  System.Classes;

type
  TAction_Quit = class(TAction)
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

implementation

uses
  CastersPackage.Actions.DataModule;

initialization

RegisterActions('CastersPackage', [TAction_Quit, TAction_Configuration, TAction_Close, TAction_Help, TAction_About, TAction_Apply, TAction_Defaults,
  TAction_PreviousPage, TAction_NextPage, TAction_Restore, TAction_Logon, TAction_Logoff, TAction_Accounts, TAction_Report], TActionsDataModule);

finalization

UnRegisterActions([TAction_Quit, TAction_Configuration, TAction_Close, TAction_Help, TAction_About, TAction_Apply, TAction_Defaults,
  TAction_PreviousPage, TAction_NextPage, TAction_Restore, TAction_Logon, TAction_Logoff, TAction_Accounts, TAction_Report]);

end.
