unit uIBSOArchivingLogic;

interface

uses
  uIDocumentArchivingLogic,
  uIDocument,
  uIArchiveBox,
  uIArchiveCompanies,
  uIArchiveBoxTypes;

type
  IBSOArchivingLogic = interface(IDocumentArchivingLogic)
    ['{48F51256-F7AB-49D3-9593-AFFA2A2DFAB7}']
    /// <summary>
    /// Функция получения количества открытых коробов для типа и компании
    /// соответствующих указанному документу
    /// </summary>
    /// <param name="ADocument">
    /// Документ
    /// </param>
    /// <returns>
    /// Количество коробов
    /// </returns>
    function GetOpenedBoxQuantity(const ADocument: IDocument): Integer; overload;

    /// <summary>
    /// Функция получения количества открытых коробов для типа и компании
    /// </summary>
    /// <param name="AType">
    /// Тип короба
    /// </param>
    /// <param name="ACompanyId">
    /// Идентификатор компании
    /// </param>
    /// <returns>
    /// Количество коробов
    /// </returns>
    function GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer; overload;

    function GetArchiveCompanies: IArchiveCompanies;

    ///	<summary>
    ///	  Список архивных компаний
    ///	</summary>
    property ArchiveCompanies: IArchiveCompanies read GetArchiveCompanies;

    function GetArchiveBoxTypes: IArchiveBoxTypes;

    ///	<summary>
    ///	  Список типов архивных коробов
    ///	</summary>
    property ArchiveBoxTypes: IArchiveBoxTypes read GetArchiveBoxTypes;

    ///	<summary>
    ///	  Процедура закрытия текущего короба
    ///	</summary>
    procedure CloseCurrentBox;
  end;

implementation

end.
