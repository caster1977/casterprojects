unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ActnList, ExtCtrls, OleServer, AutoCAD_TLB, AcadDorUt,
  ComObj, ComCtrls, jpeg, XPMan;

type
  TForm1 = class(TForm)
    AcadDoc: TAcadDocument;
    Timer1: TTimer;
    ActionList1: TActionList;
    aMakeRamka: TAction;
    MainMenu1: TMainMenu;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button2: TButton;
    Edit13: TEdit;
    Edit14: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    XPManifest1: TXPManifest;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
     Procedure MakeFigura;
    procedure MakeSymetricLine(x0, y0, x1, y1: real; Added: boolean);
    procedure MakeSymetricArc(x0,y0,r,sa,ea: real);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  OX,OY:real;

implementation

{$R *.dfm}

Function GetPoint(X, Y, Z: double): OleVariant;
begin
  Result:= VarArrayCreate([0, 2], varDouble);
  Result[0]:= x;
  Result[1]:= y;
  Result[2]:= z;
end;



procedure TForm1.MakeSymetricArc(x0,y0,r,sa,ea:real);
var
    CentredPoint : OleVariant;
    Arc: IAcadArc;
begin
  CentredPoint := GetPoint(OX+x0,OY+y0,0);
  Arc := AcadDoc.ModelSpace.AddArc(CentredPoint,r,sa*pi/180,ea*pi/180);

  CentredPoint := GetPoint(OX+x0,OY-y0,0);
  Arc := AcadDoc.ModelSpace.AddArc(CentredPoint,r,(360-ea)*pi/180,(360-sa)*pi/180);

end;

procedure TForm1.MakeSymetricLine(x0,y0,x1,y1:real;Added:boolean);
var
    StartPoint : OleVariant;
    EndPoint: OleVariant;
    line: IAcadLine;
begin
  StartPoint := GetPoint(OX+x0,OY+y0,0);
  if Added then EndPoint := GetPoint(OX+x0+x1,OY+y0+y1,0)
           else EndPoint := GetPoint(OX+x1,OY+y1,0);
  line := AcadDoc.ModelSpace.AddLine(StartPoint, EndPoint);

  StartPoint := GetPoint(OX+x0,OY-y0,0);
  if Added then EndPoint := GetPoint(OX+x0+x1,OY-y0-y1,0)
           else EndPoint := GetPoint(OX+x1,OY-y1,0);
  line := AcadDoc.ModelSpace.AddLine(StartPoint, EndPoint);

end;


Procedure TForm1.MakeFigura;
var R1,R2,R3,R4,R5,R6:real;
    L1,L2,L3,L4,L5,L6:real;
begin
  R1 := strToFloat(Edit1.Text)/2;
  R2 := strToFloat(Edit2.Text)/2;
  R3 := strToFloat(Edit3.Text)/2;

  L1 := strToFloat(Edit7.Text);
  L2 := strToFloat(Edit8.Text);
  L3 := strToFloat(Edit9.Text);

  OX := strToFloat(Edit14.Text);
  OY := strToFloat(Edit13.Text);

  if R2 < 10 then R2 := 10;
  if L2 < 1 then L2 := 2;

  if R6 < 10 then R6 :=10;
  if L6 < 53 then L6:=53;

  MakeSymetricLine(0,0,0,R1-2,true);
  MakeSymetricLine(0,R1-2,2,2,true);
  MakeSymetricLine(2,0,0,R1,true);
  MakeSymetricLine(2,R1,L1,0,true);
  MakeSymetricLine(L1+2,R2,L2,0,true);
  MakeSymetricLine(L1+2,0,0,R2,true);
  MakeSymetricLine(L1+L2+2,0,0,R2,true);
  MakeSymetricLine(L1+L2+2,R3,L3,0,true);
  MakeSymetricLine(L1+L2+2,0,0,R2,true);
  MakeSymetricLine(L1+L2+L3+2,0,0,R3,true);
  MakeSymetricLine(L1+L2+L3+2,R3,2,-2,true);
  MakeSymetricLine(L1+L2+L3+4,R3-2,0,-R3-2,true);


end;

procedure TForm1.Button1Click(Sender: TObject);
var AcadApp: IAcadApplication;
begin
  AcadDoc.Connect;
    AcadApp := (IDispatch(GetActiveOleObject('AutoCAD.Application')) as IAcadApplication);
    AcadApp.WindowState := 1;
    AcadDoc.ConnectTo(AcadApp.ActiveDocument);
    MakeFigura;


  AcadDoc.Disconnect;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
