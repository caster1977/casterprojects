unit uTTestLogicMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DBXMSSQL, System.Actions, Vcl.ActnList, Data.Win.ADODB, Data.DB,
  Data.SqlExpr;

type
  TTestLogicMainForm = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    SQLConnection: TSQLConnection;
    ADOConnection: TADOConnection;
    ActionList: TActionList;
    actTestLogic: TAction;
    procedure actTestLogicExecute(Sender: TObject);
  end;

var
  TestLogicMainForm: TTestLogicMainForm;

implementation

{$R *.dfm}

uses
  uIArchiveCompany,
  uTArchiveCompany,
  uIArchiveCompanies,
  uTArchiveCompanies;

procedure TTestLogicMainForm.actTestLogicExecute(Sender: TObject);
var
  ac: IArchiveCompany;
  acs: IArchiveCompanies;
begin
  ADOConnection.Connected := True;
  try
    acs := TArchiveCompanies.Create;
    acs.Load(ADOConnection);
    ac := TArchiveCompany.Create(ADOConnection, 1);
//    acs.Add;
    acs.Add(ac);
    ShowMessage(IntToStr(acs.IndexOf(ac)));
//    acs.GetItemById(1).Save(ADOConnection);
    ShowMessage(acs.GetItemById(1).Name);
    ac := TArchiveCompany.Create(ADOConnection, 2);
    ShowMessage(ac.Name);
  finally
    ADOConnection.Connected := False;
  end;
end;

end.
