unit TestCOMServerLib_TLB;

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
// File generated on 06.01.2012 15:39:50 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\caster\Documents\RAD Studio\9.0\Projects\SharedMemoryTest\COMServer\TestCOMServerLib (1)
// LIBID: {EADAB23A-B96E-4DA0-930A-935B885E7960}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  TestCOMServerLibMajorVersion = 1;
  TestCOMServerLibMinorVersion = 0;

  LIBID_TestCOMServerLib: TGUID = '{EADAB23A-B96E-4DA0-930A-935B885E7960}';

  IID_ITestCOMServer: TGUID = '{A72A75D9-DBF5-4375-9E2B-26D6322836B9}';
  CLASS_TestCOMServerCoClass: TGUID = '{5404E2B4-8BB6-4E1A-8945-858666A4C0FC}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ITestCOMServer = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  TestCOMServerCoClass = ITestCOMServer;


// *********************************************************************//
// Interface: ITestCOMServer
// Flags:     (256) OleAutomation
// GUID:      {A72A75D9-DBF5-4375-9E2B-26D6322836B9}
// *********************************************************************//
  ITestCOMServer = interface(IUnknown)
    ['{A72A75D9-DBF5-4375-9E2B-26D6322836B9}']
    function GetOut(out vText: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoTestCOMServerCoClass provides a Create and CreateRemote method to
// create instances of the default interface ITestCOMServer exposed by
// the CoClass TestCOMServerCoClass. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoTestCOMServerCoClass = class
    class function Create: ITestCOMServer;
    class function CreateRemote(const MachineName: string): ITestCOMServer;
  end;

implementation

uses ComObj;

class function CoTestCOMServerCoClass.Create: ITestCOMServer;
begin
  Result := CreateComObject(CLASS_TestCOMServerCoClass) as ITestCOMServer;
end;

class function CoTestCOMServerCoClass.CreateRemote(const MachineName: string): ITestCOMServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TestCOMServerCoClass) as ITestCOMServer;
end;

end.

