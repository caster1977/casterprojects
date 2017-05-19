unit Budgeting.Logic.Exported;

interface

uses
  ERP.Package.ClientInterface.IERPClientData, ERP.Package.ClientInterface.IModuleInfo, ERP.Package.ClientInterface.IModuleAccess;

function CreateForm(aERPClientData: IERPClientData): THandle; stdcall;
procedure RegisterAccess(aModuleAccess: IModuleAccess); stdcall;
procedure SetModuleInfo(aModuleInfo: IModuleInfo); stdcall;

exports CreateForm, RegisterAccess, SetModuleInfo;

implementation

uses
  ERP.Package.CustomClasses.Consts, Utils.Modules.UEOUpdater.Logic.Interfaces.IPresenterMain, Utils.Modules.UEOUpdater.Logic.Classes.TPresenterMain,
  Utils.Modules.UEOUpdater.UI.Main, Utils.Modules.UEOUpdater.Logic.Classes.TServiceOldFile,
  Utils.Modules.UEOUpdater.Logic.Classes.TServiceNewFile,
  Utils.Modules.UEOUpdater.Logic.Classes.TServiceDestinationFolder,
  Utils.Modules.UEOUpdater.Logic.Classes.TModelItems;

var
  PresenterMain: IPresenterMain;

function CreateForm(aERPClientData: IERPClientData): THandle;
var
  tmpForm: TfrmMain;
begin
  tmpForm := TfrmMain.Create(aERPClientData);
  PresenterMain := TPresenterMain.Create(tmpForm, TModelItems.Create(), TModelItems.Create(), TServiceOldFile.Create(), TServiceNewFile.Create(), TServiceDestinationFolder.Create());
  Result := tmpForm.Handle;
end;

procedure SetModuleInfo(aModuleInfo: IModuleInfo);
begin
  aModuleInfo.GUID := MODULE_GUID;
  aModuleInfo.Name := MODULE_NAME;
  aModuleInfo.TypeDB := MODULE_TYPEDB;
  aModuleInfo.TypeGuid := TYPEMODULE_MODULES;
end;

procedure RegisterAccess(aModuleAccess: IModuleAccess);
begin
end;

end.
