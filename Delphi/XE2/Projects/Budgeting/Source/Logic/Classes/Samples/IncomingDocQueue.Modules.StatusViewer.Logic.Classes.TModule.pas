unit IncomingDocQueue.Modules.StatusViewer.Logic.Classes.TModule;

interface

uses
  ERP.Package.CustomClasses.Consts;

type
  TModule = class(TObject)
  public const
    ModuleName = 'Состояние статусов документов';
    ModuleGuid: TGUID = '{C1ADF24E-BE99-484E-8D80-6BBD394BBEF8}';
    TypeDB = TYPE_DATABASE_INCOMING_DOC_QUEUE;
  end;

implementation

end.
