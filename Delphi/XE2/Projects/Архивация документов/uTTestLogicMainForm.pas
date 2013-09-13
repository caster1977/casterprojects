unit uTTestLogicMainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Data.DBXMSSQL,
  System.Actions,
  Vcl.ActnList,
  Data.Win.ADODB,
  Data.DB,
  Data.SqlExpr,
  uIDocumentArchivingBusinessLogic,
  uTMessageType;

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
  private
    FLogic: IDocumentArchivingBusinessLogic;
    function GetLogic: IDocumentArchivingBusinessLogic;
    property Logic: IDocumentArchivingBusinessLogic read GetLogic nodefault;
  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string);
  end;

var
  TestLogicMainForm: TTestLogicMainForm;

implementation

{$R *.dfm}

uses
  uIArchiveCompanyItem,
  uTArchiveCompanyItem,
  uIArchiveCompanyList,
  uTArchiveCompanyList;

procedure TTestLogicMainForm.DisplayMessage(const AType: TMessageType;
  const AText: string);
begin
  case AType of
    mtInfo:
      begin
        Caption := Trim('Info' + ' ' + Trim(AText));
      end;
    mtSuccess:
      begin
        Caption := Trim('Success' + ' ' + Trim(AText));
      end;
    mtError:
      begin
        Caption := Trim('Error' + ' ' + Trim(AText));
      end;
    mtNone:
      begin
        Caption := EmptyStr;
      end;
  end;
end;

function TTestLogicMainForm.GetLogic: IDocumentArchivingBusinessLogic;
begin
  if not Assigned(FLogic) then
  begin
    //FLogic := TBSOArchivingLogic.Create(ADOConnection);
    FLogic.OnDisplayMessage := DisplayMessage;
  end;
  Result := FLogic;
end;

procedure TTestLogicMainForm.actTestLogicExecute(Sender: TObject);
var
  ac: IArchiveCompanyItem;
  acs: IArchiveCompanyList;
begin
  ADOConnection.Connected := True;
  try
    acs := TArchiveCompanyList.Create;
    acs.Load(ADOConnection);
    ac := TArchiveCompanyItem.Create(ADOConnection, 1);
    // acs.Add;
    acs.Add(ac);
    ShowMessage(IntToStr(acs.IndexOf(ac)));
    // acs.GetItemById(1).Save(ADOConnection);
    ShowMessage(acs.GetItemById(1).Name);
    ac := TArchiveCompanyItem.Create(ADOConnection, 2);
    ShowMessage(ac.Name);
  finally
    ADOConnection.Connected := False;
  end;
end;

end.
