unit CastersPackage.Actions.Classes;

interface

uses
  Vcl.ActnList,
  System.Classes;

type
  TAction_Close=class(TAction)
  end;

  TAction_Help=class(TAction)
  end;

  TAction_Apply=class(TAction)
  end;

  TAction_Defaults=class(TAction)
  end;

  TAction_PreviousPage=class(TAction)
  end;

  TAction_NextPage=class(TAction)
  end;

implementation

uses
  CastersPackage.Actions.DataModule;

initialization

RegisterActions('CastersPackage', [TAction_Close, TAction_Help, TAction_Apply, TAction_Defaults, TAction_PreviousPage, TAction_NextPage], TDataModule1);

finalization

UnRegisterActions([TAction_Close, TAction_Help, TAction_Apply, TAction_Defaults, TAction_PreviousPage, TAction_NextPage]);

end.
