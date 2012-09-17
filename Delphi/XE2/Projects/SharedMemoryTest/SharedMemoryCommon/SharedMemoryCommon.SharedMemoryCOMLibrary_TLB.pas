unit SharedMemoryCommon.SharedMemoryCOMLibrary_TLB;

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
// File generated on 08.01.2012 23:48:58 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\caster\Documents\RAD Studio\Projects\SharedMemoryTest\SharedMemoryCOM\SharedMemoryCOMLibrary (1)
// LIBID: {B700842C-690F-42BB-AC87-0F089F491CCA}
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
  SharedMemoryCOMLibraryMajorVersion = 1;
  SharedMemoryCOMLibraryMinorVersion = 0;

  LIBID_SharedMemoryCOMLibrary: TGUID = '{B700842C-690F-42BB-AC87-0F089F491CCA}';

  IID_ISharedMemoryCOMInterface: TGUID = '{7BE80D96-AC20-4C37-B58B-B543058F4BA0}';
  CLASS_SharedMemoryCOMCoClass: TGUID = '{06464D22-3E60-4F58-85BD-DE05CEB33CEC}';

type

  // *********************************************************************//
  // Forward declaration of types defined in TypeLibrary
  // *********************************************************************//
  ISharedMemoryCOMInterface = interface;

  // *********************************************************************//
  // Declaration of CoClasses defined in Type Library
  // (NOTE: Here we map each CoClass to its Default Interface)
  // *********************************************************************//
  SharedMemoryCOMCoClass = ISharedMemoryCOMInterface;

  // *********************************************************************//
  // Interface: ISharedMemoryCOMInterface
  // Flags:     (256) OleAutomation
  // GUID:      {7BE80D96-AC20-4C37-B58B-B543058F4BA0}
  // *********************************************************************//
  ISharedMemoryCOMInterface = interface(IUnknown)
    ['{7BE80D96-AC20-4C37-B58B-B543058F4BA0}']
    function GetSharedMemoryName(out vName: WideString): HResult; stdcall;
  end;

  // *********************************************************************//
  // The Class CoSharedMemoryCOMCoClass provides a Create and CreateRemote method to
  // create instances of the default interface ISharedMemoryCOMInterface exposed by
  // the CoClass SharedMemoryCOMCoClass. The functions are intended to be used by
  // clients wishing to automate the CoClass objects exposed by the
  // server of this typelibrary.
  // *********************************************************************//
  CoSharedMemoryCOMCoClass = class
    class function Create: ISharedMemoryCOMInterface;
    class function CreateRemote(const MachineName: string): ISharedMemoryCOMInterface;
  end;

implementation

uses
  ComObj;

class function CoSharedMemoryCOMCoClass.Create: ISharedMemoryCOMInterface;
begin
  Result := CreateComObject(CLASS_SharedMemoryCOMCoClass) as ISharedMemoryCOMInterface;
end;

class function CoSharedMemoryCOMCoClass.CreateRemote(const MachineName: string): ISharedMemoryCOMInterface;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SharedMemoryCOMCoClass) as ISharedMemoryCOMInterface;
end;

end.
