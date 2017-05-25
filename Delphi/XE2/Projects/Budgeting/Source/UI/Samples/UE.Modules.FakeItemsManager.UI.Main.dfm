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
  object dxstsbrMain: TdxStatusBar
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
  object cxgrdMain: TcxGrid
    Left = 0
    Top = 46
    Width = 784
    Height = 493
    Align = alClient
    TabOrder = 5
    object cxgrdtblvwGrid1TableView: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      OnFocusedRecordChanged = cxgrdtblvwGrid1TableViewFocusedRecordChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colCustomerId: TcxGridColumn
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1082#1083#1080#1077#1085#1090#1072
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.ImmediatePost = True
        Properties.ReadOnly = True
        Visible = False
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taCenter
        Width = 118
      end
      object colCustomerName: TcxGridColumn
        Caption = #1050#1086#1076' '#1082#1083#1080#1077#1085#1090#1072
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 35
      end
      object colItemDomainId: TcxGridColumn
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1076#1086#1084#1077#1085#1072' '#1090#1086#1074#1072#1088#1072
        DataBinding.ValueType = 'DateTime'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.ReadOnly = True
        Visible = False
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 138
      end
      object colItemDomainName: TcxGridColumn
        Caption = #1044#1086#1084#1077#1085' '#1090#1086#1074#1072#1088#1072
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 35
      end
      object colItemNo: TcxGridColumn
        Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 35
      end
      object colQuantity: TcxGridColumn
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.ImmediatePost = True
        Properties.ReadOnly = True
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taCenter
        Width = 35
      end
    end
    object cxgrdlvlMain: TcxGridLevel
      GridView = cxgrdtblvwGrid1TableView
    end
  end
  object actlstMain: TActionList
    Images = cxmglstActions
    Left = 368
    Top = 472
    object actAdd: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1089#1087#1080#1089#1086#1082
      ShortCut = 45
      OnExecute = actAddExecute
      OnUpdate = actAddUpdate
    end
    object actEdit: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = 
        #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1101#1083#1077#1084#1077#1085#1090'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077 +
        #1084#1077#1085#1090#1072' '#1089#1087#1080#1089#1082#1072
      ShortCut = 113
      OnExecute = actEditExecute
      OnUpdate = actEditUpdate
    end
    object actDelete: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      Hint = 
        #1059#1076#1072#1083#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1080#1079' '#1089#1087#1080 +
        #1089#1082#1072
      ShortCut = 46
      OnExecute = actDeleteExecute
      OnUpdate = actDeleteUpdate
    end
    object actRefresh: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1087#1080#1089#1082#1072
      ShortCut = 116
      OnExecute = actRefreshExecute
      OnUpdate = actRefreshUpdate
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
      46
      0)
    object dxbrmngrMainBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
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
          ItemName = 'dxbrlrgbtn4'
        end
        item
          Visible = True
          ItemName = 'dxbrlrgbtn5'
        end
        item
          Visible = True
          ItemName = 'dxbrlrgbtn6'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxbrlrgbtn3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'cxbrdtmProgress'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxbrlrgbtn3: TdxBarLargeButton
      Action = actRefresh
      Category = 0
    end
    object dxbrlrgbtn4: TdxBarLargeButton
      Action = actAdd
      Category = 0
    end
    object dxbrlrgbtn5: TdxBarLargeButton
      Action = actEdit
      Category = 0
    end
    object dxbrlrgbtn6: TdxBarLargeButton
      Action = actDelete
      Category = 0
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
  end
  object cxmglstActions: TcxImageList
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 30933440
  end
end
