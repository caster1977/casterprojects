unit Budgeting.Logic.Classes.TQuery;

interface

type
  TQuery = class(TObject)
  public type
    sp_accounting_centers_sel = class(TObject)
    public const
      Name = 'dbo.accounting_centers_sel :AId, :AActivity';

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
        Name = 'name';
        Description = 'description';
        Activity = 'activity';
      end;
    end;

    sp_xxx_del = class(TObject)
    public const
      Name = 'dbo.%s :AId';

    type
      Param = class
      public const
        Id = 'AId';
      end;

      Field = class(TObject)
      public const
        Result = 'result';
        Message = 'message';
      end;
    end;

    sp_banks_sel = class(TObject)
    public const
      Name = 'dbo.banks_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Name = 'name';
        Code = 'code';
        Address = 'address';
        Activity = 'activity';
      end;
    end;

    sp_budget_items_sel = class(TObject)
    public const
      Name = 'dbo.budget_items_sel :AId, :AActivity';

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
      Name = 'dbo.budget_item_types_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Name = 'name';
        Activity = 'activity';
      end;
    end;

    sp_cosignatories_sel = class(TObject)
    public const
      Name = 'dbo.cosignatories_sel :AId, :AActivity';

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
        Name = 'name';
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
      Name = 'dbo.currencies_sel :AId, :AActivity';

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

    sp_goods_sel = class(TObject)
    public const
      Name = 'dbo.goods_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Id_GoodsType = 'id_goods_type';
        Code = 'code';
        Description = 'description';
        Activity = 'activity';
      end;
    end;

    sp_goods_types_sel = class(TObject)
    public const
      Name = 'dbo.goods_types_sel :AId, :AActivity';

    type
      Param = class
      public const
        Id = 'AId';
        Activity = 'AActivity';
      end;

      Field = class(TObject)
      public const
        Id = 'id';
        Name = 'name';
        Activity = 'activity';
      end;
    end;
  end;

implementation

end.
