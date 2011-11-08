library SharedMemoryActiveX;

uses
  ComServ,
  SharedMemoryActiveX_TLB in 'SharedMemoryActiveX_TLB.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.RES}

begin

end.
