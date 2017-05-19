object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 562
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TdxStatusBar
    AlignWithMargins = True
    Left = 3
    Top = 539
    Width = 778
    Height = 20
    Hint = #1055#1072#1085#1077#1083#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Margins.Top = 0
    Panels = <>
    SimplePanelStyle.Active = True
    SimplePanelStyle.AutoHint = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object pnlMain: TPanel
    Left = 0
    Top = 72
    Width = 784
    Height = 467
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMain'
    ShowCaption = False
    TabOrder = 1
    object cxgrdMain: TcxGrid
      Left = 0
      Top = 0
      Width = 784
      Height = 467
      Align = alClient
      TabOrder = 0
      object cxgrdtblvwGrid1TableView: TcxGridTableView
        OnKeyDown = cxgrdtblvwGrid1TableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxgrdtblvwGrid1TableViewCellDblClick
        OnFocusedRecordChanged = cxgrdtblvwGrid1TableViewFocusedRecordChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.CopyRecordsToClipboard = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object colIdCrossDocking: TcxGridColumn
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.ImmediatePost = True
          Properties.ReadOnly = True
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colOrderDateTime: TcxGridColumn
          Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          DataBinding.ValueType = 'DateTime'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.DisplayFormat = 'dd.mm.yyyy hh:nn:ss'
          Properties.EditFormat = 'dd.mm.yyyy hh:nn:ss'
          Properties.ImmediatePost = True
          Properties.ReadOnly = True
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colOrderNo: TcxGridColumn
          Caption = #1047#1072#1082#1072#1079' '#1087#1086#1082#1091#1087#1082#1080
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colSalesOrderNo: TcxGridColumn
          Caption = #1047#1072#1082#1072#1079' '#1087#1088#1086#1076#1072#1078#1080
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colExternalLocationCode: TcxGridColumn
          Caption = #1050#1086#1076' '#1089#1082#1083#1072#1076#1072
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colExternalUserID: TcxGridColumn
          Caption = #1050#1086#1076' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.ImmediatePost = True
          Properties.ReadOnly = True
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colExternalSystemID: TcxGridColumn
          Caption = #1050#1086#1076' '#1074#1085#1077#1096#1085#1077#1081' '#1089#1080#1089#1090#1077#1084#1099
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.ImmediatePost = True
          Properties.ReadOnly = True
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colDocumentStatusName: TcxGridColumn
          Caption = #1057#1090#1072#1090#1091#1089
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colStatusMessageErrorText: TcxGridColumn
          Caption = #1054#1096#1080#1073#1082#1072
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taLeftJustify
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
        object colStatusMessageRetryCount: TcxGridColumn
          Caption = #1050#1086#1083'-'#1074#1086' '#1087#1086#1087#1099#1090#1086#1082
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.ImmediatePost = True
          Properties.ReadOnly = True
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taCenter
          Width = 91
        end
      end
      object cxgrdlvlMain: TcxGridLevel
        GridView = cxgrdtblvwGrid1TableView
      end
    end
  end
  object actlstMain: TActionList
    Images = cxmglstActions
    Left = 368
    Top = 472
    object actRefresh: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1087#1080#1089#1082#1072
      ShortCut = 116
      OnExecute = actRefreshExecute
      OnUpdate = actRefreshUpdate
    end
    object actHistory: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1048#1089#1090#1086#1088#1080#1103
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1080#1089#1090#1086#1088#1080#1102'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1080#1089#1090#1086#1088#1080#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      OnExecute = actHistoryExecute
      OnUpdate = actHistoryUpdate
    end
  end
  object dxbrmngrMain: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.LargeImages = cxmglstActions
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 288
    Top = 472
    DockControlHeights = (
      0
      0
      72
      0)
    object dxbrButtons: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1055#1072#1085#1077#1083#1100' '#1076#1077#1081#1089#1090#1074#1080#1081
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 26
      DockingStyle = dsTop
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnHistory'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnRefresh'
        end>
      OneOnRow = True
      Row = 1
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object dxbrFilter: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1055#1072#1085#1077#1083#1100' '#1092#1080#1083#1100#1090#1088#1072
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxbrdtmBeginDate'
        end
        item
          Visible = True
          ItemName = 'cxbrdtmEndDate'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'cxbrdtmOrderCode'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 320
          Visible = True
          ItemName = 'cxbrdtmProgress'
        end>
      OneOnRow = True
      Row = 0
      ShowMark = False
      SizeGrip = False
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object btnRefresh: TdxBarLargeButton
      Action = actRefresh
      Category = 0
    end
    object cxbrdtmBeginDate: TcxBarEditItem
      Caption = #1055#1077#1088#1080#1086#1076': &'#1089
      Category = 0
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxDateEditProperties'
      Properties.DateButtons = [btnClear, btnNow, btnToday]
      Properties.DisplayFormat = 'dd.mm.yyyy'
      Properties.EditFormat = 'dd.mm.yyyy'
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowOnlyValidDates = True
      Properties.ShowTime = False
      InternalEditValue = nil
    end
    object cxbrdtmEndDate: TcxBarEditItem
      Caption = '&'#1087#1086
      Category = 0
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1086#1082#1086#1085#1095#1072#1085#1080#1077' '#1087#1077#1088#1080#1086#1076#1072
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxDateEditProperties'
      Properties.DisplayFormat = 'dd.mm.yyyy'
      Properties.EditFormat = 'dd.mm.yyyy'
      Properties.ImmediatePost = True
      Properties.ShowOnlyValidDates = True
      InternalEditValue = nil
    end
    object cxbrdtmProgress: TcxBarEditItem
      Align = iaClient
      Category = 0
      Visible = ivInCustomizing
      PropertiesClassName = 'TcxProgressBarProperties'
      BarStyleDropDownButton = False
      CanSelect = False
      Properties.AssignedValues.Min = True
      Properties.BeginColor = 54056
      Properties.PeakValue = 20.000000000000000000
      Properties.ShowTextStyle = cxtsText
      Properties.SolidTextColor = True
      InternalEditValue = 0
    end
    object dxbrsbtmDocumentTypes: TdxBarSubItem
      Caption = '&'#1058#1080#1087#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074':'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object cxbrdtmOrderCode: TcxBarEditItem
      Caption = '&'#1050#1086#1076' '#1079#1072#1082#1072#1079#1072':'
      Category = 0
      Hint = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1076' '#1079#1072#1082#1072#1079#1072
      Visible = ivAlways
      OnKeyDown = cxbrdtmOrderCodeKeyDown
      ShowCaption = True
      Width = 150
      PropertiesClassName = 'TcxTextEditProperties'
      Properties.OEMConvert = True
      Properties.OnChange = cxbrdtmOrderCodePropertiesChange
      InternalEditValue = nil
    end
    object dxbrdt1: TdxBarEdit
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
    object btnHistory: TdxBarLargeButton
      Action = actHistory
      Category = 0
    end
  end
  object cxmglstActions: TcxImageList
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 30933440
  end
end
