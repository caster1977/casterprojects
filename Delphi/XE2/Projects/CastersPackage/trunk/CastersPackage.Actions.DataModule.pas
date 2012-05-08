unit CastersPackage.Actions.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.ImgList,
  Vcl.Controls, CastersPackage.Actions.Classes, Vcl.ActnList;

type
  TDataModule1 = class(TDataModule)
    ActionList1: TActionList;
    Action_Close: TAction_Close;
    Action_Help: TAction_Help;
    Action_Apply: TAction_Apply;
    Action_Defaults: TAction_Defaults;
    Action_PreviousPage: TAction_PreviousPage;
    Action_NextPage: TAction_NextPage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
