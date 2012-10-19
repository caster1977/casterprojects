unit OA5.uIMeasureList;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  CastersPackage.uINormalized,
  CastersPackage.uICustomized,
  System.Classes,
  OA5.uIMeasure;

type
  IMeasureList = interface(IInterfaceListOfGivenType<IMeasure>)
    ['{EDB472CB-45F2-40EE-B518-8FADC247C37C}']
  end;

function GetIMeasureList: IMeasureList;
function GetINormalized(const AMeasureList: IMeasureList): INormalized; overload;
function GetICustomized(const AMeasureList: IMeasureList): ICustomized; overload;

implementation

uses
  System.SysUtils,
  OA5.uTMeasureList;

function GetIMeasureList: IMeasureList;
begin
  Result := TMeasureList.Create;
end;

function GetINormalized(const AMeasureList: IMeasureList): INormalized; overload;
begin
  Result := nil;
  if Assigned(AMeasureList) then
  begin
    if Supports(AMeasureList, INormalized) then
    begin
      Result := AMeasureList as INormalized;
    end;
  end;
end;

function GetICustomized(const AMeasureList: IMeasureList): ICustomized; overload;
begin
  Result := nil;
  if Assigned(AMeasureList) then
  begin
    if Supports(AMeasureList, ICustomized) then
    begin
      Result := AMeasureList as ICustomized;
    end;
  end;
end;

end.
