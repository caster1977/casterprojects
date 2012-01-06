unit Unit1;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows,
  ActiveX,
  Classes,
  ComObj,
  TestCOMServerLib_TLB,
  StdVcl;

type
  TTestCOMServerClassTestCOMServerClass=class(TTypedComObject, ITestCOMServer)
  public
    function Get: WideString; safecall;
    function GetOut(out vText: WideString): HRESULT; safecall;
  end;

implementation

uses
  ComServ;

{ TTestCOMServerClassTestCOMServerClass }

function TTestCOMServerClassTestCOMServerClass.Get: WideString;
begin
  Result:='Hello, world!';
end;

function TTestCOMServerClassTestCOMServerClass.GetOut(out vText: WideString): HRESULT;
begin
  vText:='Hello, world!';
  Result:=S_OK;
end;

initialization

TTypedComObjectFactory.Create(ComServer, TTestCOMServerClassTestCOMServerClass, CLASS_TestCOMServerCoClass, ciMultiInstance, tmApartment);

finalization

ComServer:=nil;

end.
