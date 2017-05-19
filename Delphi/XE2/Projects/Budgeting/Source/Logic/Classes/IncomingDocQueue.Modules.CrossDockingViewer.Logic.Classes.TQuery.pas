unit IncomingDocQueue.Modules.CrossDockingViewer.Logic.Classes.TQuery;

interface

type
  TQuery = class(TObject)
  public type
    SpCrossDockingViewerCrossDockingSel = class(TObject)
    public const
      name = 'dbo.cdv_cross_docking_sel :AOrderCode, :ABeginDate, :AEndDate';

    type
      Param = class
      public const
        AOrderCode = 'AOrderCode';
        ABeginDate = 'ABeginDate';
        AEndDate = 'AEndDate';
      end;

      Field = class(TObject)
      public const
        Id_CrossDocking = 'Id_CrossDocking';
        OrderDateTime = 'OrderDateTime';
        OrderNo = 'OrderNo';
        SalesOrderNo = 'SalesOrderNo';
        ExternalLocationCode = 'ExternalLocationCode';
        ExternalUserID = 'ExternalUserID';
        ExternalSystemID = 'ExternalSystemID';
        DocumentStatusName = 'DocumentStatusName';
        ErrorText = 'ErrorText';
        RetryCount = 'RetryCount';
      end;
    end;

    SpCrossDockingViewerCrossDockingHistorySel = class(TObject)
    public const
      name = 'dbo.cdv_cross_docking_history_sel :AStatusMessageId';

    type
      Param = class
      public const
        AStatusMessageId = 'AStatusMessageId';
      end;

      Field = class(TObject)
      public const
        CreateDate = 'CreateDate';
        ErrorText = 'ErrorText';
        RetryCount = 'RetryCount';
        DocumentStatusName = 'DocumentStatusName';
      end;
    end;

  end;

implementation

end.
