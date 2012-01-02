unit SharedMemoryCOM_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 41960 $
// File generated on 03.01.2012 1:59:22 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\caster\Documents\RAD Studio\9.0\Projects\SharedMemoryTest\SharedMemoryCOM\SharedMemoryCOM (1)
// LIBID: {B683A7DE-924D-4206-B1B6-C54EA3609B21}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
// (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses
  Windows,
  ActiveX,
  Classes,
  Graphics,
  OleServer,
  StdVCL,
  Variants;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
// Type Libraries     : LIBID_xxxx
// CoClasses          : CLASS_xxxx
// DISPInterfaces     : DIID_xxxx
// Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SharedMemoryCOMMajorVersion=1;
  SharedMemoryCOMMinorVersion=0;

  LIBID_SharedMemoryCOM: TGUID='{B683A7DE-924D-4206-B1B6-C54EA3609B21}';

  IID_ITest: TGUID='{7B2536CC-0169-4299-8269-6137DC86F6EB}';
  CLASS_Test: TGUID='{A0359679-AFD4-45A2-8D2D-E17FFA67317A}';

type

  // *********************************************************************//
  // Forward declaration of types defined in TypeLibrary
  // *********************************************************************//
  ITest=interface;
  ITestDisp=dispinterface;

  // *********************************************************************//
  // Declaration of CoClasses defined in Type Library
  // (NOTE: Here we map each CoClass to its Default Interface)
  // *********************************************************************//
  Test=ITest;

  // *********************************************************************//
  // Interface: ITest
  // Flags:     (4416) Dual OleAutomation Dispatchable
  // GUID:      {7B2536CC-0169-4299-8269-6137DC86F6EB}
  // *********************************************************************//
  ITest=interface(IDispatch)
    ['{7B2536CC-0169-4299-8269-6137DC86F6EB}']
    function GetSharedMemoryName: WideString; stdcall;
  end;

  // *********************************************************************//
  // DispIntf:  ITestDisp
  // Flags:     (4416) Dual OleAutomation Dispatchable
  // GUID:      {7B2536CC-0169-4299-8269-6137DC86F6EB}
  // *********************************************************************//
  ITestDisp=dispinterface
    ['{7B2536CC-0169-4299-8269-6137DC86F6EB}']
    function GetSharedMemoryName: WideString; dispid 201;
  end;

  // *********************************************************************//
  // The Class CoTest provides a Create and CreateRemote method to
  // create instances of the default interface ITest exposed by
  // the CoClass Test. The functions are intended to be used by
  // clients wishing to automate the CoClass objects exposed by the
  // server of this typelibrary.
  // *********************************************************************//
  CoTest=class
    class function Create: ITest;
    class function CreateRemote(const MachineName: string): ITest;
  end;

implementation

uses
  ComObj;

class function CoTest.Create: ITest;
begin
  Result:=CreateComObject(CLASS_Test) as ITest;
end;

class function CoTest.CreateRemote(const MachineName: string): ITest;
begin
  Result:=CreateRemoteComObject(MachineName, CLASS_Test) as ITest;
end;

end.
