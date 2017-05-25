unit Budgeting.Logic.Classes.TQuery;

interface

type
  TQuery = class(TObject)
  public type
    sp_accounting_centers_sel = class(TObject)
    public const
      name = 'dbo.accounting_centers_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Code = 'code';
        name = 'name';
        Description = 'description';
        Activity = 'activity';
      end;
    end;

    sp_xxx_del = class(TObject)
    public const
      name = 'dbo.%s :AId';

    type
      Param = class
      public const
        Id = 'AId';
      end;

      Field = class(TObject)
      public const
        Result = 'result';
        message = 'message';
      end;
    end;

    sp_banks_sel = class(TObject)
    public const
      name = 'dbo.banks_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        name = 'name';
        Code = 'code';
        Address = 'address';
        Activity = 'activity';
      end;
    end;

    sp_budget_items_sel = class(TObject)
    public const
      name = 'dbo.budget_items_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Id_BudgetItemType = 'id_budget_item_type';
        Code = 'code';
        Description = 'description';
        Activity = 'activity';
      end;
    end;

    sp_budget_item_types_sel = class(TObject)
    public const
      name = 'dbo.budget_item_types_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        name = 'name';
        Activity = 'activity';
      end;
    end;

    sp_cosignatories_sel = class(TObject)
    public const
      name = 'dbo.cosignatories_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Id_Bank = 'id_bank';
        name = 'name';
        UNP = 'unp';
        Address = 'address';
        AgreementNumber = 'agreementnumber';
        AgreementStart = 'agreementstart';
        AgreementStop = 'agreementstop';
        Account = 'account';
        Activity = 'activity';
      end;
    end;

    sp_currencies_sel = class(TObject)
    public const
      name = 'dbo.currencies_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Code = 'code';
        Description = 'description';
        Activity = 'activity';
      end;
    end;

    sp_products_sel = class(TObject)
    public const
      name = 'dbo.products_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Id_ProductType = 'id_product_type';
        Code = 'code';
        Description = 'description';
        Activity = 'activity';
      end;
    end;

    sp_product_types_sel = class(TObject)
    public const
      name = 'dbo.product_types_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        name = 'name';
        Activity = 'activity';
      end;
    end;

    sp_actual_budget_sel = class(TObject)
    public const
      name = 'dbo.actual_budget_sel :AId';

    type
      Param = class
      public const
        Id = 'AId';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Id_BudgetItem = 'id_budget_item';
        Id_AccountingCenter = 'id_account_center';
        Id_Cosignatory = 'id_cosignatory';
        Id_Product = 'id_product';
        Id_Currency = 'id_currency';
        Document = 'document';
        DocumentDate = 'document_date';
        Description = 'description';
        Amount = 'amount';
      end;
    end;

    sp_planned_budget_sel = class(TObject)
    public const
      name = 'dbo.planned_budget_sel :AId';

    type
      Param = class
      public const
        Id = 'AId';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Id_BudgetItem = 'id_budget_item';
        Id_AccountingCenter = 'id_account_center';
        Id_Currency = 'id_currency';
        Year = 'year';
        Month = 'month';
        Amount = 'amount';
      end;
    end;
  end;

implementation

end.
