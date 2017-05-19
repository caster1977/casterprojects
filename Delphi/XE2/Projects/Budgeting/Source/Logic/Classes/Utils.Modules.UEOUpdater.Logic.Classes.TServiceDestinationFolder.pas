unit Utils.Modules.UEOUpdater.Logic.Classes.TServiceDestinationFolder;

interface

uses
  Vcl.Controls, Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceDestinationFolder;

type
  TServiceDestinationFolder = class(TInterfacedObject, IServiceDestinationFolder)
  strict private
    function GetName(const aParent: TWinControl): string;
    function Check(const aName: string): Boolean;
  end;

implementation

uses
  Vcl.Dialogs, System.SysUtils, System.IOUtils;

resourcestring
  RsDestinationFolderTitle = 'Выберите папку для сохранения результатов...';

function TServiceDestinationFolder.Check(const aName: string): Boolean;
begin
  Result := TDirectory.Exists(aName);
end;

function TServiceDestinationFolder.GetName(const aParent: TWinControl): string;
var
  tmpForm: TFileOpenDialog;
begin
  Result := EmptyStr;
  tmpForm := TFileOpenDialog.Create(aParent);
  try
    tmpForm.Options := tmpForm.Options + [fdoPickFolders, fdoPathMustExist];
    tmpForm.Title := RsDestinationFolderTitle;
    if tmpForm.Execute(aParent.Handle) then
      Result := tmpForm.FileName;
  finally
    tmpForm.Free();
  end;
end;

end.
