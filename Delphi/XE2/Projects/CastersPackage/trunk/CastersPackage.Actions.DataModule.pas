unit CastersPackage.Actions.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.ActnList,
  CastersPackage.Actions.Classes;

type
  TDataModule1 = class(TDataModule)
    ActionList1: TActionList;
    Action_Close: TAction_Close;
    Action_Help: TAction_Help;
    Action_Apply: TAction_Apply;
    Action_Defaults: TAction_Defaults;
    Action_PreviousPage: TAction_PreviousPage;
    Action_NextPage: TAction_NextPage;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
