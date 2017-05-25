unit UE.Modules.FakeItemsManager.Logic.Classes.TQuery;

interface

type
  TQuery = class(TObject)
  public type
    SpFIManagerSelFakeItem = class(TObject)
    public const
      name = 'dbo.fi_manager_sel_fake_item :ACustomerId, :ADomainId, :AItemNo';

    type
      Param = class
      public const
        ACustomerId = 'ACustomerId';
        ADomainId = 'ADomainId';
        AItemNo = 'AItemNo';
      end;

      Field = class(TObject)
      public const
        CustomerId = 'CustomerId';
        CustomerNo = 'CustomerNo';
        ItemDomainId = 'ItemDomainId';
        ItemDomainName = 'ItemDomainName';
        ItemNo = 'ItemNo';
        Quantity = 'Quantity';
      end;
    end;

    SpFIManagerMrgFakeItem = class(TObject)
    public const
      name = 'dbo.fi_manager_mrg_fake_item :ACustomerId, :ADomainId, :AItemNo, :AQuantity';

    type
      Param = class
      public const
        ACustomerId = 'ACustomerId';
        ADomainId = 'ADomainId';
        AItemNo = 'AItemNo';
        AQuantity = 'AQuantity';
      end;

      Field = class(TObject)
      public const
        Result = 'Result';
        message = 'Message';
      end;
    end;

    SpFIManagerDelFakeItem = class(TObject)
    public const
      name = 'dbo.fi_manager_del_fake_item :ACustomerId, :ADomainId, :AItemNo';

    type
      Param = class
      public const
        ACustomerId = 'ACustomerId';
        ADomainId = 'ADomainId';
        AItemNo = 'AItemNo';
      end;

      Field = class(TObject)
      public const
        Result = 'Result';
        message = 'Message';
      end;
    end;

    SpFIManagerSelCustomer = class(TObject)
    public const
      name = 'dbo.fi_manager_sel_customer :ACustomerId, :ADomainId';

    type
      Param = class
      public const
        ACustomerId = 'ACustomerId';
        ADomainId = 'ADomainId';
      end;

      Field = class(TObject)
      public const
        CustomerId = 'CustomerId';
        CustomerNo = 'CustomerNo';
      end;
    end;

    SpFIManagerSelDomain = class(TObject)
    public const
      name = 'dbo.fi_manager_sel_domain :ADomainId';

    type
      Param = class
      public const
        ADomainId = 'ADomainId';
      end;

      Field = class(TObject)
      public const
        DomainId = 'DomainId';
        name = 'Name';
      end;
    end;

    SpFIManagerSelItem = class(TObject)
    public const
      name = 'dbo.fi_manager_sel_item :ADomainId, :AItemNo';

    type
      Param = class
      public const
        ADomainId = 'ADomainId';
        AItemNo = 'AItemNo';
      end;

      Field = class(TObject)
      public const
        DomainId = 'DomainId';
        ItemNo = 'ItemNo';
      end;
    end;
  end;

implementation

end.
