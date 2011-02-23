//                      Copyright@Дорохов А.В., 2004
//
//
//  Данный модуль разработан для упращения функций работы с объектами AutoCAD
//  из Delphi. Для работы необходимо транслировать в Delphi библиотеку типов
//  AutoCAD_TLB.
//
//  За идеальность кода автор ответственности не несёт
//

unit AcadDorUt;

interface

uses
  Windows, SysUtils, Classes, Controls, QStdCtrls, AutoCAD_TLB, Variants,
  ActiveX;

const
  IntKey: set of char = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  FloatKey: set of char = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                           chr(VK_DECIMAL)];
  FloatDECIMALKey: set of char = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                           '.', ','];

type
  TAcadPoint = record
    X, Y, Z: double;
  end;

// функция преобразует точку с коорд. X, Y, Z в точку AutoCAD типа OleVariant
  function GetFloatPoint(X, Y, Z: double): OleVariant;
  function GetStrPoint(X, Y, Z: string): OleVariant;
// функция преобразует точку AutoCAD типа OleVariant в точку типа  TAcadPoint
  function SetPoint(Point: OleVariant): TAcadPoint;
// присвоение точке AutoCAD значений X, Y, Z
  function SetXPoint(Point: OleVariant): double;
  function SetYPoint(Point: OleVariant): double;
  function SetZPoint(Point: OleVariant): double;
// вычисление расстояние между точками, взятыми из AutoCAD
  function Distanse(Point1, Point2: OleVariant): double;
// функция вычерчивания отрезка в модели AutoCAD между указанными точками
  function Line(AcadApp: IAcadApplication; Point1, Point2: TAcadPoint): boolean;

  function Point(SoursePoint: OleVariant):OleVariant;
  function SetTPoint(X, Y, Z: double): TAcadPoint;

  function LineW(Str: string): TOleEnum;

  Function GetAcadApplication(start: Boolean): IAcadApplication;

  function WrStrToFloat(str: string; Sender: TObject; Col,
                                                    Row: integer): extended;
  function WrFloatToStr (Fl: extended; Okrugl: integer): string;
  function Modul(Sourse: double): double;
  function WrFloatToString (Fl: extended; Okrugl: integer): string;

implementation

uses ComObj; 

function Modul(Sourse: double): double;
begin
  if Sourse < 0 then Result:= -Sourse
  else Result:= Sourse
end;

function WrFloatToString (Fl: extended; Okrugl: integer): string;
var
  i: integer;
  str, okstr: string;
begin
  str:= FloatToStr(Fl);
  if Okrugl<0 then exit;
  okStr:= '0.';
  for i:=0 to Okrugl+10 do okStr:= okStr + '0';
  for i:=Okrugl+10 downto Okrugl do
  begin
    Result:= FormatFloat(okStr, Fl);
    okStr:= Copy(okStr, 1, Length(okStr)-1);
  end;
  Result:= FormatFloat(okStr, Fl);
end;

function WrFloatToStr (Fl: extended; Okrugl: integer): string;
var
  FlProm: extended;
  i, Okr:integer;
  RezPlus: string;
  Intchk: boolean;
begin
  Intchk:= false;
  for i:=1 to Length(FloatToStr(Fl))-1 do
    if Copy(FloatToStr(Fl), i, 1) = DecimalSeparator then
    begin
      Intchk:= true;
      break
    end;
  if not Intchk then Exit;
  RezPlus:='';
  Okr:=1;
  for i:=1 to Okrugl do
  Okr:=10*Okr;
  FlProm:=Round(Fl*Okr)/Okr;
  if Length(FloatToStr(Frac(FlProm)))-2 < Okrugl then
  for i:=1 to (Okrugl-(Length(FloatToStr(Frac(FlProm)))-2)) do
  RezPlus:= RezPlus + '0';
  Result:=FloatToStr(FlProm) + RezPlus;
end;

function SetTPoint(X, Y, Z: double): TAcadPoint;
begin
  Result.X:= X;
  Result.Y:= Y;
  Result.Z:= Z
end;

function WrStrToFloat(str: string; Sender: TObject; Col,
                                                    Row: integer): extended;
var
  i, DecPos: integer;
  Dec: Char;
begin
  try
    Result:= StrToFloat (Str)
  except
    DecPos:= 0;
    for i:=0 to Length(Str)-1 do
      if (Str[i] in [',', '.']) then
      begin
        DecPos:=i;
        if (Str[DecPos] = ',') then Dec := '.'
        else Dec:= ',';
        Str[DecPos]:= Dec;
        if (Sender is TEdit) then (Sender as TEdit).Text:= Str
      end;
  end;
  Result:= StrToFloat (Str)
end;

function Point(SoursePoint: OleVariant):OleVariant;
begin
  Result:= VarArrayCreate([0, 2], varDouble);
  Result[0]:= SoursePoint[0];
  Result[1]:= SoursePoint[1];
  Result[2]:= SoursePoint[2];
end;

function GetFloatPoint(X, Y, Z: double): OleVariant;
begin
  Result:= VarArrayCreate([0, 2], varDouble);
  Result[0]:= x;
  Result[1]:= y;
  Result[2]:= z;
end;

function GetStrPoint(X, Y, Z: string): OleVariant;
begin
  Result:= VarArrayCreate([0, 2], varDouble);
  Result[0]:= WrStrToFloat(x, nil, 0, 0);
  Result[1]:= WrStrToFloat(y, nil, 0, 0);
  Result[2]:= WrStrToFloat(z, nil, 0, 0);
end;

function SetPoint(Point: OleVariant): TAcadPoint;
begin
  Result.X:= Point[0];
  Result.Y:= Point[1];
  Result.Z:= Point[2];
end;

function SetXPoint(Point: OleVariant): double;
begin
  Result:= Point[0];
end;

function SetYPoint(Point: OleVariant): double;
begin
  Result:= Point[1];
end;

function SetZPoint(Point: OleVariant): double;
begin
  Result:= Point[2];
end;

function Distanse(Point1, Point2: OleVariant): double;
begin
  Result:= Sqrt(Sqr(Point1[0] - Point2[0]) + Sqr(Point1[1] - Point2[1]) +
                Sqr(Point1[2] - Point2[2]))
end;

Function GetAcadApplication(start: Boolean): IAcadApplication;
var
  v : OleVariant;
begin
  Result := nil;
  try
    v := GetActiveOleObject('AutoCAD.Application');
    Result := IDispatch(v) as IAcadApplication;
  except
    v:= CreateOleObject('AutoCAD.Application');
    Result := IDispatch(v) as IAcadApplication    
  end;
  if start then
    begin
 //     Result := CoAcadApplication.Create;
      Result.Visible := True;
    end;
end;

// толщина линий Str указывается в миллиметрах
function LineW (Str: string): TOleEnum;
begin
  if (Str='ByLayer') or (Str='По слою') or (Str='ПоСлою')
     or (Str='по слою') then Result:= acLnWtByLayer;
  if (Str='ByBlock') or (Str='По блоку') or (Str='ПоБлоку')
     or (Str='по блоку') then Result:= acLnWtByBlock;
  if (Str='ByDefault') or (Str='По умолчанию') or (Str='ПоУмолчанию')
     or (Str='по умолчанию') then Result:= acLnWtByLwDefault;
  if (Str='0,05') or (Str='0.05') then Result:= acLnWt005;
  if (Str='0,09') or (Str='0.09') then Result:= acLnWt009;
  if (Str='0,13') or (Str='0.13') then Result:= acLnWt013;
  if (Str='0,15') or (Str='0.15') then Result:= acLnWt015;
  if (Str='0,18') or (Str='0.18') then Result:= acLnWt018;
  if (Str='0,20') or (Str='0.20') then Result:= acLnWt020;
  if (Str='0,25') or (Str='0.25') then Result:= acLnWt025;
  if (Str='0,30') or (Str='0.30') then Result:= acLnWt030;
  if (Str='0,35') or (Str='0.35') then Result:= acLnWt035;
  if (Str='0,40') or (Str='0.40') then Result:= acLnWt040;
  if (Str='0,50') or (Str='0.50') then Result:= acLnWt050;
  if (Str='0,53') or (Str='0.53') then Result:= acLnWt053;
  if (Str='0,60') or (Str='0.60') then Result:= acLnWt060;
  if (Str='0,70') or (Str='0.70') then Result:= acLnWt070;
  if (Str='0,80') or (Str='0.80') then Result:= acLnWt080;
  if (Str='0,90') or (Str='0.90') then Result:= acLnWt090;
  if (Str='1,00') or (Str='1.00') then Result:= acLnWt100;
  if (Str='1,06') or (Str='1.06') then Result:= acLnWt106;
  if (Str='1,20') or (Str='1.20') then Result:= acLnWt120;
  if (Str='1,40') or (Str='1.40') then Result:= acLnWt140;
  if (Str='1,58') or (Str='1.58') then Result:= acLnWt158;
  if (Str='2,00') or (Str='2.00') then Result:= acLnWt200;
  if (Str='2,11') or (Str='2.11') then Result:= acLnWt211;
end;

function Line(AcadApp: IAcadApplication; Point1, Point2: TAcadPoint): boolean;
var
  Pt1, Pt2: OleVariant;
begin
  Result:= false;
  if not Assigned(AcadApp) then Exit;
  try
    Pt1:= GetFloatPoint(Point1.X, Point1.Y, Point1.Z);
    Pt1:= GetFloatPoint(Point2.X, Point2.Y, Point2.Z);
    if AcadApp.WindowState = acMin then AcadApp.WindowState:= acMax;
    if AcadApp.ActiveDocument.ActiveSpace = acModelSpace
    then AcadApp.ActiveDocument.ModelSpace.AddLine(Pt1, Pt2)
    else AcadApp.ActiveDocument.PaperSpace.AddLine(Pt1, Pt2)
  except
    Exit
  end;
  Result:= true;
end;

end.
