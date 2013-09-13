unit uIDocumentArchivingBusinessLogic;

interface

uses
  Controls,
  uICustomBusinessLogic,
  uIArchiveBoxItem,
  uIShowable;

type
  ///	<summary>
  ///	  Интерфейс доступа к объекту бизнес-логики процесса архивации документов
  ///	</summary>
  IDocumentArchivingBusinessLogic = interface(ICustomBusinessLogic)
    ['{B4D4317B-5679-4A31-9F53-F31CFFD99A6F}']
    function GetCurrentBox: IArchiveBoxItem;
    /// <summary>
    /// Текущий архивный короб
    /// </summary>
    property CurrentBox: IArchiveBoxItem read GetCurrentBox;
    /// <summary>
    /// Функция определения вместимости указанного типа короба
    /// указанного типа
    /// </summary>
    /// <param name="AType">
    /// Тип короба
    /// </param>
    /// <returns>
    /// Количество документов в данном типе короба
    /// </returns>
    function GetBoxCapacity(const AType: Integer): Integer; overload;
    /// <summary>
    /// Функция определения вместимости указанного типа короба
    /// указанного типа
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Количество документов в данном типе короба
    /// </returns>
    function GetBoxCapacity(const ABox: IArchiveBoxItem): Integer; overload;
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
    //function GetOpenedBoxQuantity(const ADocument: IDocument): Integer; overload;

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
    //function GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer; overload;
    /// <summary>
    /// Процедура отображения данных указанного "отображаемого" объекта
    /// </summary>
    //procedure ShowShowableItem(const AParentControl: TCustomControl; const AShowableItem: IShowable);

    ///	<summary>
    ///	  Процедура "откладывания" указанного короба
    ///	</summary>
    ///	<param name="ABox">
    ///	  Короб
    ///	</param>
//    procedure PutBoxAside(const ABox: IArchiveBoxItem);

    ///	<summary>
    ///	  Процедура закрытия указанного короба
    ///	</summary>
    ///	<param name="ABox">
    ///	  Короб
    ///	</param>
//    procedure CloseBox(const ABox: IArchiveBoxItem);

//    procedure DeleteBox(const ABox: IArchiveBoxItem);
  end;

implementation

end.
