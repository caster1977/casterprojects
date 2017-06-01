object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 562
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TdxStatusBar
    Left = 0
    Top = 542
    Width = 784
    Height = 20
    Panels = <>
    SimplePanelStyle.Active = True
    SimplePanelStyle.AutoHint = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object pcMain: TcxPageControl
    AlignWithMargins = True
    Left = 0
    Top = 31
    Width = 784
    Height = 508
    Margins.Left = 0
    Margins.Right = 0
    Align = alClient
    TabOrder = 5
    Properties.ActivePage = shtReports
    Properties.CustomButtons.Buttons = <>
    OnChange = pcMainChange
    ClientRectBottom = 504
    ClientRectLeft = 4
    ClientRectRight = 780
    ClientRectTop = 24
    object shtReferences: TcxTabSheet
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      ImageIndex = 0
      object cbbReferences: TcxComboBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alTop
        Properties.AutoSelect = False
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.ImmediateUpdateText = True
        Properties.ReadOnly = False
        Properties.Revertable = True
        Properties.Sorted = True
        Properties.OnChange = cbbReferencesPropertiesChange
        TabOrder = 0
        Width = 770
      end
      object cxgrdReferences: TcxGrid
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 770
        Height = 447
        Align = alClient
        PopupMenu = pctnbrMain
        TabOrder = 1
        object tblvAccountingCenters: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colAccountingCenters_Id_AccountingCenter: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colAccountingCenters_Code: TcxGridColumn
            Caption = #1050#1086#1076
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colAccountingCenters_Name: TcxGridColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colAccountingCenters_Description: TcxGridColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 195
          end
          object colAccountingCenters_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object tblvBanks: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colBanks_Id_Bank: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colBanks_Name: TcxGridColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colBanks_Code: TcxGridColumn
            Caption = #1050#1086#1076
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colBanks_Address: TcxGridColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 195
          end
          object colBanks_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object tblvBudgetItems: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colBudgetItems_Id_BudgetItem: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colBudgetItems_Id_BudgetItemType: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1090#1080#1087#1072' '#1089#1090#1072#1090#1100#1080' '#1079#1072#1090#1088#1072#1090
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colBudgetItems_BudgetItemType: TcxGridColumn
            Caption = #1058#1080#1087
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 75
            HeaderAlignmentHorz = taCenter
            Width = 75
          end
          object colBudgetItems_Code: TcxGridColumn
            Caption = #1050#1086#1076
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colBudgetItems_Description: TcxGridColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 195
          end
          object colBudgetItems_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object tblvBudgetItemTypes: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colBudgetItemTypes_Id_BudgetItemType: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colBudgetItemTypes_Name: TcxGridColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 300
          end
          object colBudgetItemTypes_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object tblvCosignatories: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colCosignatories_Id_Cosignatory: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_Id_Bank: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_Name: TcxGridColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_UNP: TcxGridColumn
            Caption = #1059#1053#1055
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_Address: TcxGridColumn
            Caption = #1040#1076#1088#1077#1089
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_AgreementNumber: TcxGridColumn
            Caption = #1044#1086#1075#1086#1074#1086#1088
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_AgreementStart: TcxGridColumn
            Caption = #1044#1086#1075#1086#1074#1086#1088' '#1089
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = 'dd.mm.yyyy'
            Properties.ReadOnly = True
            Properties.SaveTime = False
            Properties.ShowTime = False
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_AgreementStop: TcxGridColumn
            Caption = #1044#1086#1075#1086#1074#1086#1088' '#1087#1086
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = 'dd.mm.yyyy'
            Properties.ReadOnly = True
            Properties.SaveTime = False
            Properties.ShowTime = False
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_Bank: TcxGridColumn
            Caption = #1041#1072#1085#1082
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colCosignatories_Account: TcxGridColumn
            Caption = #1053#1086#1084#1077#1088' '#1089#1095#1105#1090#1072
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCosignatories_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object tblvCurrencies: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colCurrencies_Id_Currency: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCurrencies_Code: TcxGridColumn
            Caption = #1050#1086#1076
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colCurrencies_Description: TcxGridColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 195
          end
          object colCurrencies_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object tblvProducts: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colProducts_Id_Product: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colProducts_Id_ProductType: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1074#1080#1076#1072' '#1090#1086#1074#1072#1088#1072
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colProducts_ProductType: TcxGridColumn
            Caption = #1058#1080#1087
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 75
            HeaderAlignmentHorz = taCenter
            Width = 75
          end
          object colProducts_Code: TcxGridColumn
            Caption = #1050#1086#1076
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colProducts_Description: TcxGridColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 195
          end
          object colProducts_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object tblvProductTypes: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colProductTypes_Id_ProductType: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colProductTypes_Name: TcxGridColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 195
          end
          object colProductTypes_Activity: TcxGridColumn
            Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taCenter
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object lvl1: TcxGridLevel
          GridView = tblvCosignatories
        end
      end
    end
    object shtOperations: TcxTabSheet
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080
      ImageIndex = 0
      object cxgrdOperations: TcxGrid
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 770
        Height = 447
        Align = alClient
        PopupMenu = pctnbrMain
        TabOrder = 0
        object tblvActualBudget: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colActualBudget_Id_ActualBudget: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colActualBudget_Id_BudgetItem: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1089#1090#1072#1090#1100#1080' '#1073#1102#1076#1078#1077#1090#1072
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colActualBudget_BudgetItem: TcxGridColumn
            Caption = #1057#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colActualBudget_Id_AccountingCenter: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1094#1077#1085#1090#1088#1072
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colActualBudget_AccountingCenter: TcxGridColumn
            Caption = #1062#1060#1054
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colActualBudget_Id_Cosignatory: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colActualBudget_Cosignatory: TcxGridColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colActualBudget_Id_Product: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1090#1086#1074#1072#1088#1072
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colActualBudget_Product: TcxGridColumn
            Caption = #1058#1086#1074#1072#1088
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colActualBudget_Id_Currency: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1074#1072#1083#1102#1090#1099
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colActualBudget_Currency: TcxGridColumn
            Caption = #1042#1072#1083#1102#1090#1072
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colActualBudget_Document: TcxGridColumn
            Caption = #1044#1086#1082#1091#1084#1077#1085#1090
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colActualBudget_DocumentDate: TcxGridColumn
            Caption = #1044#1072#1090#1072
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = 'dd.mm.yyyy'
            Properties.ReadOnly = True
            Properties.SaveTime = False
            Properties.ShowTime = False
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colActualBudget_Description: TcxGridColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 195
          end
          object colActualBudget_Amount: TcxGridColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
        end
        object tblvPlannedBudget: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colPlannedBudget_Id_PlannedBudget: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colPlannedBudget_Id_BudgetItem: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1089#1090#1072#1090#1100#1080' '#1073#1102#1076#1078#1077#1090#1072
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colPlannedBudget_AccountingCenter: TcxGridColumn
            Caption = #1062#1060#1054
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colPlannedBudget_BudgetItem: TcxGridColumn
            Caption = #1057#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 100
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object colPlannedBudget_Id_AccountingCenter: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1094#1077#1085#1090#1088#1072
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colPlannedBudget_Id_Currency: TcxGridColumn
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1074#1072#1083#1102#1090#1099
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            Visible = False
            BestFitMaxWidth = 50
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colPlannedBudget_Currency: TcxGridColumn
            Caption = #1042#1072#1083#1102#1090#1072
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 40
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colPlannedBudget_Year: TcxGridColumn
            Caption = #1043#1086#1076
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            BestFitMaxWidth = 40
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colPlannedBudget_Month: TcxGridColumn
            Caption = #1052#1077#1089#1103#1094
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            BestFitMaxWidth = 40
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colPlannedBudget_Amount: TcxGridColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object cxgrdlvl2: TcxGridLevel
          GridView = tblvPlannedBudget
        end
      end
      object pnlOperations: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 770
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlOperations'
        ShowCaption = False
        TabOrder = 1
        object cbbOperationTypes: TcxComboBox
          AlignWithMargins = True
          Left = 0
          Top = 0
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Properties.AutoSelect = False
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.ImmediateUpdateText = True
          Properties.ReadOnly = False
          Properties.Revertable = True
          Properties.Sorted = True
          Properties.OnChange = cbbOperationTypesPropertiesChange
          TabOrder = 0
          Width = 214
        end
        object cbbBudgetItemTypes: TcxComboBox
          AlignWithMargins = True
          Left = 220
          Top = 0
          Margins.Left = 6
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Properties.AutoSelect = False
          Properties.DropDownListStyle = lsFixedList
          Properties.ReadOnly = False
          Properties.Revertable = True
          Properties.Sorted = True
          Properties.OnChange = cbbBudgetItemTypesPropertiesChange
          TabOrder = 1
          Width = 550
        end
      end
    end
    object shtReports: TcxTabSheet
      Caption = #1054#1090#1095#1105#1090#1099
      ImageIndex = 1
      object cxgrdReports: TcxGrid
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 770
        Height = 447
        Align = alClient
        PopupMenu = pctnbrMain
        TabOrder = 0
        object tblvSummaryReport: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnFocusedRecordChanged = tblvFocusedRecordChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1054#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colSummaryReport_BudgetItem: TcxGridColumn
            Caption = #1057#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colSummaryReport_BudgetItemType: TcxGridColumn
            Caption = #1058#1080#1087' '#1089#1090#1072#1090#1100#1080
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colSummaryReport_AccountingCenter: TcxGridColumn
            Caption = #1062#1060#1054
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colSummaryReport_Month: TcxGridColumn
            Caption = #1052#1077#1089#1103#1094
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ImmediatePost = True
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colSummaryReport_Currency: TcxGridColumn
            Caption = #1042#1072#1083#1102#1090#1072
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.MaxLength = 0
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colSummaryReport_PlannedAmount: TcxGridColumn
            Caption = #1055#1083#1072#1085
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colSummaryReport_ActualAmount: TcxGridColumn
            Caption = #1060#1072#1082#1090
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colSummaryReport_Balance: TcxGridColumn
            Caption = #1041#1072#1083#1072#1085#1089
            DataBinding.ValueType = 'Currency'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = True
            BestFitMaxWidth = 50
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
        end
        object cxgrdlvl1: TcxGridLevel
          GridView = tblvSummaryReport
        end
      end
      object cbbReports: TcxComboBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alTop
        Properties.AutoSelect = False
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.ImmediateUpdateText = True
        Properties.ReadOnly = False
        Properties.Revertable = True
        Properties.Sorted = True
        TabOrder = 1
        Width = 770
      end
    end
  end
  object dxbrmngrMain: TdxBarManager
    AllowReset = False
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
    ImageOptions.Images = cxmglstActions
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 376
    Top = 256
    DockControlHeights = (
      0
      0
      28
      0)
    object dxbrToolBar: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      Images = cxmglstActions
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnQuit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnConfiguration'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnConnect'
        end
        item
          Visible = True
          ItemName = 'btn1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnExcel'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnHelpContext'
        end
        item
          Visible = True
          ItemName = 'btnAbout'
        end
        item
          BeginGroup = True
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
      WholeRow = False
    end
    object btnQuit: TdxBarButton
      Action = actQuit
      Category = 0
    end
    object btnHelpContext: TdxBarButton
      Action = actHelpContext
      Category = 0
    end
    object btnAbout: TdxBarButton
      Action = actAbout
      Category = 0
    end
    object btnConfiguration: TdxBarButton
      Action = actConfiguration
      Category = 0
    end
    object btnExcel: TdxBarButton
      Action = actExportToExcel
      Category = 0
    end
    object btnConnect: TdxBarButton
      Action = actConnect
      Category = 0
    end
    object btn1: TdxBarButton
      Action = actDisconnect
      Category = 0
    end
    object dxBarButton1: TdxBarButton
      Action = actAdd
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actEdit
      Category = 0
    end
    object dxBarButton3: TdxBarButton
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
    object btnRefresh: TdxBarButton
      Action = actRefresh
      Category = 0
    end
  end
  object cxmglstActions: TcxImageList
    FormatVersion = 1
    DesignInfo = 16777672
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF8596
          DCFF0E2FB5FF1535B8FF1938B8FF1938B7FF1738BBFF1638B9FF1236BDFF0C34
          C0FF0931C0FF062EBEFF012BC0FF0025B6FF7E90D1FFFFFFFFFFFFFFFFFF1037
          D4FF1E43D9FF294CDAFF2E50DAFF2D50DBFF2B50DBFF2850DCFF234EDFFF1B4A
          E0FF1446E0FF0C41E0FF0439E0FF0031D7FF0025B5FFFFFFFFFFFFFFFFFF1840
          DEFF2B4FE1FF3658E3FF4363E5FF7D94EDFFE2E8FBFFFFFFFFFFFFFFFFFFDCE4
          FBFF7092F1FF124AE9FF0942E8FF0338E0FF012ABEFFFFFFFFFFFFFFFFFF2147
          DFFF3759E3FF4262E4FFA2B2F2FFFFFFFFFFBBC8F6FF718FEEFF6E8FEFFFBACA
          F8FFFFFFFFFF98B1F6FF0D47E9FF073DE1FF042DC1FFFFFFFFFFFFFFFFFF2B50
          E1FF4160E4FF8B9EEEFFFFFFFFFF8398EEFF4568E6FF3F65E7FF3662E8FF2B5C
          E9FF7194F1FFFFFFFFFF6A8DF0FF0E42E1FF0A32C1FFFFFFFFFFFFFFFFFF3457
          E2FF4A67E5FFEBEFFCFFBBC6F5FF4D6CE6FF4869E6FFFFFFFFFFFFFFFFFF2C5B
          E8FF2355E8FFB6C7F8FFDBE3FBFF1747E0FF1137C2FFFFFFFFFFFFFFFFFF3E5E
          E4FF526EE7FFFFFFFFFF8195EDFF4F6CE6FF4767E5FFFFFFFFFFFFFFFFFF2B57
          E6FF2251E6FF6487EEFFFFFFFFFF1E4BDFFF173BC0FFFFFFFFFFFFFFFFFF4463
          E5FF5974E8FFFFFFFFFF8195EDFF4F6BE6FF4766E5FFFFFFFFFFFFFFFFFF2B54
          E4FF234FE4FF6383ECFFFFFFFFFF244DDEFF1C3EBFFFFFFFFFFFFFFFFFFF4E6B
          E6FF627CE8FFEFF1FDFFB7C2F5FF506BE6FF4764E4FFFFFFFFFFFFFFFFFF2B51
          E2FF254DE2FFB0BFF5FFE0E6FBFF294FDCFF2040BFFFFFFFFFFFFFFFFFFF526E
          E7FF6B85EAFF97A9F1FFFFFFFFFF8093EDFF4B66E5FF4160E4FF395AE3FF2F53
          E2FF6B86EBFFFFFFFFFF718AECFF2C50DCFF2241BEFFFFFFFFFFFFFFFFFF5D78
          E8FF7991ECFF6F89EBFFA6B5F2FFFFFFFFFFB1BDF4FF6F86EAFF6A83E9FFB0BD
          F4FFFFFFFFFF95A8F0FF2F52E1FF2E51DBFF2241BDFFFFFFFFFFFFFFFFFF6A85
          EAFF8DA1EFFF8097EDFF6E88EBFF97A8F0FFEEF0FCFFFFFFFFFFFFFFFFFFE9ED
          FCFF899DEEFF4061E4FF395BE3FF2F52DCFF1D3DBCFFFFFFFFFFFFFFFFFF768E
          ECFF9DAEF1FF8CA0EFFF7890ECFF6F89EBFF6983E9FF647DE9FF617BE9FF5C77
          E8FF5572E7FF4D6BE6FF4061E4FF2E51DBFF1838BAFFFFFFFFFFFFFFFFFFB2BF
          F4FF758DECFF6681EAFF5A75E8FF536FE7FF4E6BE6FF4968E6FF4A68E5FF4564
          E5FF3E5FE3FF3A5CE3FF3053E2FF2246D8FF8A9BDEFFFFFFFFFF00000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00800100000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008001
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000996363FF9963
          63FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000996330FFCC9963FF9963
          30FF996363FF0000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000996330FFCC9999FFFFECCCFF9963
          30FF996363FF0000000000000000000000000000000000000000000000000000
          00000000000000000000996363FF996330FFF0CAA6FFF0CAA6FFF0CAA6FF9999
          63FF633000FF633030FF996363FF000000000000000000000000000000000000
          0000CC9999FFCC9999FFCCCC99FFF0CAA6FFFFECCCFFFFECCCFFFFFFCCFFF0CA
          A6FFCCCC99FF999963FF633000FF996363FF000000000000000000000000CCCC
          99FFFFECCCFFF0CAA6FFFFECCCFFF0CAA6FFCC6330FFFF9963FFCC9963FFCC99
          63FFFFECCCFFF0CAA6FFCCCC99FF633030FF996363FF00000000CCCC99FFFFEC
          CCFFFFECCCFFFFECCCFFFFECCCFFF1F1F1FFCC9963FF800000FF993000FFFFEC
          CCFFFFECCCFFFFECCCFFF0CAA6FFCCCC99FF633000FF00000000B2B2B2FFFFEC
          CCFFFFECCCFFFFECCCFFFFECCCFFF8F8F8FFCCCC99FF630000FF996330FFF8F8
          F8FFFFECCCFFFFECCCFFFFECCCFFFFECCCFF999963FF996363FFC0C0C0FFFFEC
          CCFFFFECCCFFFFECCCFFFFECCCFFF8F8F8FFCC9999FF800000FF996330FFF8F8
          F8FFFFECCCFFFFECCCFFFFECCCFFFFECCCFFF0CAA6FF996363FFC0C0C0FFF1F1
          F1FFF1F1F1FFFFECCCFFFFECCCFFFFFFFFFFCCCC99FF800000FF996330FFFFFF
          FFFFFFECCCFFFFECCCFFFFECCCFFFFECCCFFFFCCCCFF996363FFCBCBCBFFF1F1
          F1FFF8F8F8FFF1F1F1FFF8F8F8FFE3E3E3FF993030FF630000FF993030FFFFFF
          FFFFFFECCCFFFFECCCFFFFECCCFFF1F1F1FFFFECCCFF808080FFD7D7D7FFF1F1
          F1FFFFFFFFFFF1F1F1FFFFFFFFFFD7D7D7FFCC9999FFCC9999FFCC9999FFFFFF
          FFFFF1F1F1FFFFECCCFFF8F8F8FFFFFFFFFFF0CAA6FF808080FF00000000E3E3
          E3FFFFFFFFFFFFFFFFFFF8F8F8FFFFFFFFFFFFFFFFFFFFCC99FFF8F8F8FFFFFF
          FFFFF1F1F1FFF8F8F8FFFFFFFFFFFFFFFFFF969696FF0000000000000000EAEA
          EAFFEAEAEAFFFFFFFFFFFFFFFFFFFFFFFFFF996330FF630000FF993030FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFCCCC99FF0000000000000000000000000000
          0000EAEAEAFFF1F1F1FFFFFFFFFFFFFFFFFFCCCCCCFF633030FFB2B2B2FFFFFF
          FFFFFFFFFFFFFFFFFFFFDDDDDDFF000000000000000000000000000000000000
          00000000000000000000E3E3E3FFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFF8F8
          F8FFCCCCCCFF0000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000004A4A4AFF4A4A4AFF4A4A4AFF4A4A4AFF4A4A
          4AFF4A4A4AFF0000000000000000000000000000000000000000000000000000
          000000000000CC9963FFCC9999FFFFECCCFFE3E3E3FFE3E3E3FFEAEAEAFFFFEC
          CCFFCC9999FF4A4A4AFF4A4A4AFF000000000000000000000000000000000000
          0000CC9999FFEAEAEAFFF8F8F8FFDDDDDDFFCCCC99FFCC9999FFF0CAA6FFEAEA
          EAFFF1F1F1FFFFECCCFFF0CAA6FF4A4A4AFF000000000000000000000000CC99
          99FFEAEAEAFFFFFFFFFFCC9963FFCC6330FFCC6330FFCCCC99FFCC6330FFCC63
          30FFCC9999FFF1F1F1FFEAEAEAFFCBCBCBFF4A4A4AFF0000000000000000CC99
          99FFFFFFFFFFCC6330FFCC6330FFCC6330FFCC9999FFFFFFFFFFCC9963FFCC63
          30FFCC6330FFCC9963FFF8F8F8FFFFECCCFF4A4A4AFF00000000CC9999FFFFFF
          FFFFCC9963FFCC6330FFCC6330FFCC6330FFCC6330FFCC9963FFCC6330FFCC63
          30FFCC6330FFCC6330FFF0CAA6FFF1F1F1FFCCCCCCFF4A4A4AFFCBCBCBFFF8F8
          F8FFCC6330FFCC6330FFCC6330FFCC6330FFCC9963FFEAEAEAFFCC6330FFCC63
          30FFCC6330FFCC6330FFCC6330FFFFFFFFFFF0CAA6FF4A4A4AFFCBCBCBFFFFEC
          CCFFCC6330FFCC6330FFCC6330FFCC6330FFCC9963FFFFFFFFFFCC9999FFCC63
          30FFCC6330FFCC6330FFCC6330FFF1F1F1FFFFECCCFF4A4A4AFFCBCBCBFFFFCC
          CCFFCC6330FFCC6330FFCC6330FFCC6330FFCC6330FFCC9999FFF8F8F8FFFF99
          63FFCC6330FFCC6330FFCC6330FFF1F1F1FFE3E3E3FF4A4A4AFFCBCBCBFFF1F1
          F1FFCC6330FFCC6330FFCC6330FFCC6330FFCC6330FFCC6330FFCCCCCCFFFFFF
          FFFFCC6330FFCC6330FFCC6330FFFFFFFFFFFFECCCFF4A4A4AFFCBCBCBFFFFFF
          FFFFFF9963FFCC6330FFCC9963FFEAEAEAFFCC9963FFCC6330FFCC9963FFFFFF
          FFFFCC9963FFCC6330FFFF9963FFFFFFFFFFCBCBCBFF4A4A4AFF00000000CBCB
          CBFFFFECCCFFFF9963FFCC9963FFF1F1F1FFFFFFFFFFF0CAA6FFFFFFFFFFF1F1
          F1FFCC6330FFCC6330FFF1F1F1FFEAEAEAFF4A4A4AFF0000000000000000CBCB
          CBFFFFFFFFFFFFECCCFFFF9963FFFF9999FFE3E3E3FFEAEAEAFFEAEAEAFFFF99
          63FFFF9963FFFFECCCFFFFFFFFFFCBCBCBFF0000000000000000000000000000
          0000CBCBCBFFFFFFFFFFFFFFFFFFFFECCCFFF0CAA6FFFFCC99FFFFCC99FFF0CA
          A6FFFFFFFFFFFFFFFFFFCBCBCBFF000000000000000000000000000000000000
          000000000000CBCBCBFFCBCBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFCCCCCCFFCBCBCBFF00000000000000000000000000000000000000000000
          0000000000000000000000000000CCCCCCFFCBCBCBFFCBCBCBFFCBCBCBFFCBCB
          CBFF000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000636399FFCC63CCFF996399FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00003030CCFF6363CCFF0030CCFFCC99CCFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000003030
          CCFF6363FFFF3030FFFF3030CCFF9999CCFF0000000000000000000000000000
          00000000000000000000000000000000000000000000000000003030CCFF6363
          FFFF0030FFFF0030CCFF6363CCFF000000000000000000000000000000000000
          000000000000000000000000000000000000000000003030CCFF6363FFFF0030
          FFFF0030CCFF4D4DFFFF90A9ADFF000000000000000000000000000000000000
          0000000000000000000000000000000000003030CCFF6363FFFF0030FFFF0030
          CCFF3063FFFF9999CCFFF1F1F1FFA4A0A0FF0000000000000000000000000000
          00000000000000000000000000003063CCFF6399FFFF0030FFFF0030CCFF4D4D
          FFFF868686FFA4A0A0FFEAEAEAFFD7D7D7FFEAEAEAFF00000000000000000000
          0000969696FF999999FF868686FF3099FFFF0030FFFF0030CCFF3063CCFF0000
          00000000000000000000A4A0A0FFF1F1F1FFC0C0C0FF00000000000000008686
          86FFA4A0A0FFC0C0C0FFC0C0C0FF969696FF0030CCFF3099CCFF000000000000
          0000000000000000000000000000CCCCCCFFDDDDDDFFA4A0A0FF868686FF9999
          99FFB2B2B2FFC0C0C0FFC0C0C0FFB2B2B2FF868686FF996399FF000000000000
          0000000000000000000000000000CCCCCCFFCCCCCCFF999999FF969696FFC0C0
          C0FF00000000A4A0A0FFC0C0C0FFC0C0C0FF999999FFFF9999FFCC9999FF0000
          00000000000000000000999999FFFFCCCCFFC0C0C0FF00000000999999FF0000
          00000000000000000000B2B2B2FFC0C0C0FFA4A0A0FF969696FFFF9999FFCC99
          99FF969696FFCC9999FFF0CAA6FFCC9999FFC0C0C0FF00000000000000000000
          000000000000A4A0A0FFC0C0C0FFCCCCCCFFA4A0A0FF00000000CC9999FFCC99
          99FFFF9999FFCC9999FFFF9999FFA4A0A0FF0000000000000000000000000000
          0000969696FFDDDDDDFFB2B2B2FF000000000000000000000000969696FF0000
          0000FF9999FF999999FF969696FF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000006A20FFF256607FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000006A20FFF2DC95DFF10AC23FF256607FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000006A20FFF2DC95DFF30CC63FF2DC95DFF17B330FF256607FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000006A20FFF30CC63FF33CF66FF38D46BFF3AD66DFF37D366FF15B128FF2566
          07FF000000000000000000000000000000000000000000000000000000000000
          000006A20FFF39D56CFF3DD970FF3DD970FF3DD970FF3DD970FF3DD970FF35D1
          62FF25AA37FF256607FF00000000000000000000000000000000000000000000
          000006A20FFF3DD970FF3FDB72FF46E179FF4AE580FF4AE580FF49E47CFF45E1
          78FF45E178FF2ECA54FF256607FF000000000000000000000000000000000000
          000006A20FFF3FDB72FF49E47CFF4AE580FF4DE883FF4DE883FF41DC6EFF41DC
          6EFF21B22DFF256607FF00000000000000000000000000000000000000000000
          000006A20FFF47E27AFF4AE580FF53EF89FF4BE778FF4BE778FF2FC141FF2566
          07FF000000000000000000000000000000000000000000000000000000000000
          000006A20FFF4AE580FF43DF70FF43DF70FF1EBA32FF256607FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000006A20FFF4AE580FF24BF3DFF256607FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000006A20FFF256607FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000004A4A
          4AFF4A4A4AFF4A4A4AFF4A4A4AFF4A4A4AFF4A4A4AFF4A4A4AFF4A4A4AFF4A4A
          4AFF4A4A4AFF4A4A4AFF4A4A4AFF000000000000000000000000AE786BFFD9AD
          9DFFD5AA9CFFD1A79AFFCEA498FFCBA196FFC89F93FFC49C92FFC09990FFBC96
          8EFFB9938DFF97796FFF4A4A4AFF000000000000000000000000AE786BFFEFE7
          DEFFFFEEDDFFFFEAD6FFFFE6CDFFFFE3C8FFFFDFBEFFFFDCB9FFFFD8B2FFFFD4
          A9FFFFD0A2FFD9AAA8FF6D5B51FF4A4A4AFF000000000000000000000000C28F
          76FFFFF2E5FFFFEEDDFF679D55FFFFE6CDFFFFE3C8FFFFDFBEFFFFDCB9FFFFD8
          B2FFFFD4A9FFF7BFB0FF7B635AFF4A4A4AFF000000000000000000000000C895
          79FFFEF5EBFFFFF2E5FF2A8428FF7CA867FFFFE6CDFFFFE3C8FFFFDFBEFFFFDC
          B9FFFFD8B2FFFFCFAEFF997B74FF4A4A4AFF000000000000000000000000CF9C
          80FFF3EFEAFFFFF5ECFF2A8428FF2A8428FFB1C194FFFFE6CDFFFFE3C8FFFFDF
          BEFFFFDCB9FFFFD8B2FFDDA5A1FF4A4A4AFF00000000000000002A8428FF2A84
          28FF2A8428FF2A8428FF2A8428FF1BB739FF0A820FFFE9DFC4FFFFE6CDFFFFE3
          C8FFFFDFBEFFFFDCB9FFF7B9ACFF7C655BFF4A4A4AFF00000000309036FF52EF
          88FF44E178FF36D369FF2ECA60FF1EBB41FF0DA81EFF21801DFFFFEAD6FFFFE6
          CDFFFFE3C8FFFFDFBEFFFFD2B7FF9F8578FF4A4A4AFF00000000309036FF45D9
          70FF39CD64FF2EC259FF28BD54FF22BE48FF0FA522FF2A8428FFFFEEDDFFFFEA
          D6FFFFE6CDFFFFE3C8FFFFDFBEFFE1A29BFF4A4A4AFF00000000000000000000
          0000CF9C80FFC8D1BBFF288C31FF24BF4BFF238525FFFFF5ECFFFFF2E5FFFFEE
          DDFFFFEAD6FFFFE6CDFFFFE3C8FFF8B3A8FF4A4A4AFF4A4A4AFF000000000000
          000000000000CF9C80FF2F9038FF1B8625FFF7F9F4FFFFF8F1FFFFF5ECFFFFF2
          E5FFFFEEDDFFFFE4D3FFFFDEC9FFFFC4B6FFA3887CFF4A4A4AFF000000000000
          000000000000DCA987FF2C812CFFDBE9DBFFFFFFFFFFFFFDFBFFFFF8F1FFFFF5
          ECFFF8E6D7FFDBA383FFD6966EFFD08E69FFBF9F84FF4A4A4AFF000000000000
          000000000000DCA987FFF9F2EBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFFFFF8
          F1FFFDF3E9FFDCA987FFFFB34BFFE0A869FF4A4A4AFF00000000000000000000
          00000000000000000000DCA987FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
          FBFFFFF8F1FFDCA987FFE6BB93FF4A4A4AFF0000000000000000000000000000
          00000000000000000000DCA987FFDCA987FFDCA987FFDCA987FFDCA987FFDCA9
          87FFDCA987FFDCA987FF4A4A4AFF000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000005C5E6FFF5C5E6FFF626582FF6265
          82FF5C5E6FFF0000000000000000000000000000000000000000000000000000
          00000000000000000000626582FF4250B9FF1C32DBFF0B21CCFF071BB7FF434F
          B0FF61668BFF676767FF5C5E6FFF000000000000000000000000000000000000
          000000000000626582FF0F28EBFF112BF5FF112BF5FF112BF5FF112BF5FF102A
          F0FF0B21CCFF4753AAFF626582FF626582FF0000000000000000000000000000
          0000112BF5FF112BF5FF112BF5FF1F38F5FF0C23D6FF0C23D6FF0B22D1FF112B
          F5FF112BF5FF0C23D6FF4C57A7FF6A6A6AFF0000000000000000000000000000
          0000112BF5FF112BF5FF112BF5FF000000000000000000000000000000001F37
          F5FF112BF5FF112BF5FF0A1FC6FF5C5E6FFF626582FF0000000000000000112B
          F5FF112BF5FF0C23D6FF000000000000000000000000000000001F37F5FF102A
          F0FF112BF5FF112BF5FF0F28EBFF545DA5FF5C5E6FFF00000000000000002038
          F6FF112BF5FF0C23D6FF0000000000000000000000001F37F5FF102AF0FF2038
          F6FF000000000C23D6FF112BF5FF4250B9FF626582FF0000000000000000112B
          F5FF112BF5FF0C23D6FF00000000000000001F37F5FF112BF5FF2038F6FF0000
          0000000000000C23D6FF112BF5FF525EBFFF626582FF0000000000000000112B
          F5FF112BF5FF0B22D1FF000000001F37F5FF112BF5FF2038F6FF000000000000
          0000000000000C23D6FF112BF5FF5460BCFF000000000000000000000000112B
          F5FF112BF5FF112BF5FF1F37F5FF102AF0FF2038F6FF00000000000000000000
          000000000000112BF5FF102AF0FF626582FF0000000000000000000000000000
          0000112BF5FF112BF5FF112BF5FF102AF0FF0000000000000000000000000000
          00002038F6FF112BF5FF112BF5FF000000000000000000000000000000000000
          0000112BF5FF112BF5FF112BF5FF0C23D6FF0C23D6FF091EC1FF0C23D6FF112B
          F5FF112BF5FF112BF5FF00000000000000000000000000000000000000000000
          000000000000112BF5FF112BF5FF112BF5FF112BF5FF112BF5FF112BF5FF112B
          F5FF112BF5FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000112BF5FF112BF5FF112BF5FF112BF5FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000007304FF007304FF007304FF0073
          04FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000007304FF15A42DFF17B330FF0073
          04FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000007304FF1AA937FF1DB93DFF0073
          04FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000007304FF1EAE40FF23BF4AFF0073
          04FF000000000000000000000000000000000000000000000000000000000000
          0000007304FF007304FF007304FF007304FF007304FF26B950FF2BC75AFF0073
          04FF007304FF007304FF007304FF007304FF0000000000000000000000000000
          0000007304FF4AE580FF45E178FF3DD970FF38D46BFF38D46BFF2FCB61FF2ABF
          56FF1EAD3FFF1AA937FF13A228FF007304FF0000000000000000000000000000
          0000007304FF52ED88FF4AE580FF45E178FF3DD970FF38D46BFF2FCB61FF2BC7
          5AFF23BF4AFF1CB83AFF17B330FF007304FF0000000000000000000000000000
          000009750FFF007304FF007304FF007304FF006D03FF3DD970FF35D168FF006D
          03FF006D03FF006D03FF006D03FF006D03FF0000000000000000000000000000
          000000000000000000000000000000000000006D03FF44E077FF3DD970FF006D
          03FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000006D03FF4AE580FF42DE75FF006D
          03FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000006D03FF4FEB85FF4AE580FF006D
          03FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000006D03FF006D03FF006D03FF006D
          03FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000008976
          6DFF7A6B62FF716057FF705F56FF705F56FF705F56FF705F56FF705F56FF705F
          56FF716057FF7A6B62FF89766DFF000000000000000000000000AE786BFFD9AD
          9DFFD6A89AFFD3A698FFD2A497FFCCA199FFC99E97FFC69C96FFC49995FFC196
          93FFB6918BFFC0948EFF7B6C63FF000000000000000000000000B5826FFFFCE1
          CBFFFBE0C8FFFBDEC4FFFBDCC2FF8C5857FF8C5857FFF3CEB1FFA26F65FFA26E
          62FFAB7668FFFDC6A2FF716057FF000000000000000000000000BB8872FFFCE4
          CFFFFCE2CCFFFBE0C9FFFBDEC6FF8C5857FF8C5857FFEFCFB3FFFCC990FFFDC4
          85FFFDCA98FFF0BFA7FF705F56FF000000000000000000000000C28F76FFFCE7
          D4FFFCE4D1FFFCE3CEFFFCE1CAFFFBDFC7FFEFD2BBFFB39C89FF745B3CFF8468
          4CFF9F866FFFD3AA96FF6D5C53FF000000000000000000000000C89579FFFCE8
          D8FF2600DFFF2600DFFFFCE3CEFF3911DDFF2600DCFF9370BEFFCF8E39FF9172
          6FFF734533FF82675CFF544740FF000000000000000000000000CF9C80FFFCEB
          DDFF2600DFFF2600DFFFFCE6D3FFFCE4CFFFFCE2CCFFF0D6C5FF8B8B83FFBCA3
          7AFFEEB171FFB17540FF4F3116FF534F4EFF0000000000000000D5A283FFFDEE
          E0FFFDECDDFFFCEADBFFFCE8D7FFFCE6D3FFFCE4D1FFFBE2CDFFFBE1CAFFE5C4
          A1FFE3AE7AFFF9D7B6FFF7C796FFB88148FF686868FF7A7A87FFDCA987FFFEF0
          E5FFFDEEE1FFFDECDFFFFDEBDBFF8C5857FF8C5857FFF4DBC8FFA2736EFFA273
          6DFFC9A394FFECBDA3FFB48454FFC6AB91FF5974D3FF3A57BEFFDCA987FFFDF3
          EAFFFDF1E6FFFDEFE3FFFDEDDFFF8C5857FF8C5857FFFBE4D4FFE6C9BBFFE6C9
          B8FFF0D2BFFFF3CCBAFF705F56FF00000000999FCCFFADB1DFFFDCA987FFFDF5
          EDFFFEF3EAFFFDF2E7FFFDEFE4FFFDEDE1FFFDECDEFFFCEADAFFFCE8D7FFFCE6
          D3FFFCE4D0FFF3CDBDFF75645CFF000000000000000000000000DCA987FFFEF8
          F2FF8C5857FF8C5857FFF3E4DBFF8C5857FF8C5857FF8C5857FF8C5857FF8C58
          57FFE8CDBEFFF4C9BAFF89766DFF000000000000000000000000DCA987FFFFFA
          F7FF8C5857FF8C5857FFFEF4ECFFFEF2E9FFFDF1E6FFFDEFE2FFFFD5CCFFFFD5
          CCFFF5B3AAFFB3887BFF89766DFF000000000000000000000000DCA987FFFFFD
          FBFFFFFBF7FFFEF9F4FFFEF7F1FFFEF5EDFFFDF3EBFFFDF1E7FFF7A640FFF7A6
          40FFE0923EFF96867AFF00000000000000000000000000000000DCA987FFFFFF
          FFFFFFFEFBFFFFFBF8FFFEFAF5FFFEF8F1FFFEF6EEFFFDF3ECFFDCA987FFEAB3
          74FF8C7160FF0000000000000000000000000000000000000000DCA987FFDCA9
          87FFDCA987FFDCA987FFDCA987FFDCA987FFDEAB88FFD6A384FFDCA987FF8976
          6DFF000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000094FF000094FF000094FF000094FF000094FF000094FF000094FF0000
          94FF000094FF000094FF000094FF000094FF0000000000000000000000000000
          0000000094FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000E1FF0000
          E1FF0000BFFF0000BFFF0000BFFF000094FF0000000000000000000000000000
          0000000094FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          E1FF0000E1FF0000BFFF0000BFFF000094FF0000000000000000000000000000
          0000000094FF000094FF000094FF000094FF000094FF000094FF000094FF0000
          94FF000094FF000094FF000094FF000094FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00006B6B6BFF6B6B6BFF00000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000765C
          EAFF2600DFFF3C25A6FF626262FF000000000000000000000000000000000000
          000000000000000000005F4DB2FF2B04D8FF000000000000000000000000765C
          EAFF2600DFFF2D07DBFF504B67FF626262FF0000000000000000000000000000
          0000000000004326C3FF2600DFFF5743B6FF0000000000000000000000000000
          0000765CEAFF2600DFFF3A19D2FF5C5C5CFF0000000000000000000000000000
          00003715CDFF2B04D8FF5743B6FF000000000000000000000000000000000000
          000000000000775DEBFF2600DFFF4F35C3FF616161FF00000000000000003715
          CDFF2B04D8FF5743B6FF00000000000000000000000000000000000000000000
          00000000000000000000775DEBFF2600DFFF4E34C3FF504D5BFF300FC7FF2903
          D7FF5743B6FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000765CEAFF2600DFFF2903D7FF2802D6FF675F
          8CFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000002C05D9FF2600DFFF4428C4FF675F
          8CFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000003715CDFF2B04D8FF5743B6FF330CE0FF563A
          D6FF675F8CFF0000000000000000000000000000000000000000000000000000
          000000000000000000003715CDFF2600DFFF5743B6FF0000000000000000401C
          E2FF4725DDFF675F8CFF00000000000000000000000000000000000000000000
          0000000000003614CCFF2600DFFF5743B6FF0000000000000000000000000000
          00005C3DE7FF320BDFFF675F8CFF000000000000000000000000000000000000
          00003614CCFF2600DFFF5743B6FF000000000000000000000000000000000000
          0000000000005C3DE7FF2600DFFF000000000000000000000000000000003E1A
          E0FF2600DFFF4326C3FF00000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000330D
          E1FF4A29E1FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000CE2D00FFCE2D00FFCE2D00FFCE2D00FFCE2D
          00FFCE2D00FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000CE2D00FFFF9E00FFFF9E00FFFF9E00FFFF9E
          00FFCE2D00FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000CE2D00FFFFA60DFFFFA60DFFFFA60DFFFF9E
          00FFCE2D00FF0000000000000000000000000000000000000000FF5E2EFFCE2D
          00FFCE2D00FFCE2D00FFCE2D00FFCE2D00FFFFB636FFFFB636FFFFB636FFFF9E
          00FFCE2D00FFCE2D00FFCE2D00FFCE2D00FF9C2D00FF9C2D00FF00000000FFCF
          2EFFFFFFF7FFFFCF9CFFFFCF9CFFFFCF9CFFFFC757FFFFC757FFFFC757FFFF9E
          00FFFF9E00FFFF9E00FFFF9E00FFFF9E00FF9C2D00FF00000000000000000000
          0000FFCF2EFF00000000FFD770FFFFD770FFFFD770FFFFD770FFFFD770FFFFD7
          70FFFFD770FFFFD770FFFFE79CFF9C2D00FF0000000000000000000000000000
          000000000000FFCF2EFF00000000FFE78CFFFFE78CFFFFE78CFFFFE78CFFFFE7
          8CFFFFE78CFFFFF7CEFF9C2D00FF000000000000000000000000000000000000
          00000000000000000000FFCF2EFF00000000FFEFA5FFFFEFA5FFFFEFA5FFFFEF
          A5FFFFFFE7FF9C2D00FF00000000000000000000000000000000000000000000
          0000000000000000000000000000FFCF2EFF00000000FFFFBDFFFFFFBDFFFFFF
          F7FF9C2D00FF0000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FFCF2EFF00000000000000009C2D
          00FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FFCF2EFF9C2D00FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000A5461EFFCE5E2EFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000009C2D00FFFF9E00FFFF9E00FFA546
          1EFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000009C2D00FFFFFFF7FFFFA60DFFFFA60DFFFFA6
          0DFFA5461EFF0000000000000000000000000000000000000000000000000000
          000000000000000000009C2D00FFFFFFF7FFFFB636FFFFB636FFFFB636FFFFB6
          36FFFFB636FFA5461EFF00000000000000000000000000000000000000000000
          000000000000A5461EFF00000000FFC757FFFFC757FFFFC757FFFFCF60FFFFC7
          57FFFFC757FFFFC757FFA5461EFF000000000000000000000000000000000000
          0000A5461EFF00000000FFDF84FFFFDF84FFFFDF84FFFFDF84FFFFDF84FFFFDF
          84FFFFDF84FFFFDF84FFFFDF84FFA5461EFF0000000000000000000000009C2D
          00FF00000000F7FFFFFFF7FFFFFFFFEFA5FFFFEFA5FFFFEFA5FFFFEFA5FFFFEF
          A5FFFFEFA5FFFFE78CFFFFB636FFFFB636FFA5461EFF00000000FFCF2EFFFFCF
          2EFFFFCF2EFFFFCF2EFFFFCF2EFF00000000FFFFBDFFFFFFBDFFFFFFBDFFFFFF
          BDFFFFB636FFFF5E2EFFFF5E2EFFFF5E2EFFFF5E2EFFA5461EFF000000000000
          0000000000000000000000000000FFCF2EFFF7FFFFFFFFFFBDFFFFFFBDFFFFFF
          BDFF9C2D00FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFCF2EFFF7FFFFFFFFFFBDFFFFFFBDFFFFFF
          BDFF9C2D00FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFCF2EFFFFCF2EFFFFCF2EFFFFCF2EFFFFCF
          2EFFFF5E2EFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000006D6D6DFF555555FF555555FF5555
          55FF6D6D6DFF0000000000000000000000000000000000000000000000006D6D
          6DFF555555FF555555FF555555FF0073A9FF006EA3FF006EA3FF0072A8FF006C
          A2FF3D3D3DFF555555FF555555FF555555FF555555FF555555FF232323FF2323
          23FF232323FF232323FF232323FF12ADD9FF28C1EBFF27B8DFFF25C0EAFF027B
          AFFF232323FF232323FF232323FF232323FF232323FF3D3D3DFF999999FFFFF1
          DFFFFFF1DFFFFFF1E0FFFFF1E0FF2FADD5FFBBE5EFFFCDF7FFFFAFE4F2FF168F
          BDFFFFF1DFFFFFF1DFFFFFF1DFFFFFF1DFFF232323FF555555FF999999FF9999
          99FF999999FF999999FF999999FF4AB6D8FFDAEBEFFFFFFFFFFFD4EEF5FF1290
          BEFF999999FF999999FF999999FF999999FF999999FF00000000000000000000
          000000000000000000000000000022A7D2FF3DB1D8FF45B0D2FF289FC6FF41A6
          C8FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000828282FFAAA195FF111111FF3535
          35FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000929292FF4C4C4CFF8E8281FF302C2CFF1A1A
          1AFF505050FF888888FF00000000000000000000000000000000000000000000
          000000000000808080FF717171FF8C8C8CFFA5A5A5FF716C6CFF3B3838FF4540
          40FF544B4BFF4B4848FF525252FF6E6E6EFF0000000000000000000000008888
          88FF888888FFC9C9C9FFA3A3A3FF7C7C7CFF828282FF797878FF4A4A4AFF6D6D
          6DFF797979FF706A6AFF716161FF534D4DFF4E4E4EFF777777FFA5A5A5FFAEAE
          AEFF989898FF828282FFA4A4A4FFB9B9B9FFD1D1D1FF8E8E8EFF757575FF6868
          68FF818181FF5E5E5EFF303030FFB79898FF8A7373FF676767FF9F9F9FFF9C9C
          9CFFB5B5B5FFC7C7C7FFE1E1E1FFE6E6E6FFD0D0D0FFD8D8D8FFD1D1D1FFC3C3
          C3FF9A9999FF797474FF423F3FFF938080FF847272FF797979FFB9B9B9FFD3D3
          D3FFDEDEDEFFC7C7C7FFE1E1E1FFDFDFDFFFF2F2F2FFFCFCFCFFECECECFFDFDF
          DFFFF7F7F7FFEEEAEAFFDECCCCFF8F8A8AFF8D8888FF00000000B9B9B9FFB9B9
          B9FFBABABAFF757575FF686868FFB8B8B8FFF2F2F2FFFCFCFCFFECECECFFDFDF
          DFFFF7F7F7FFCACACAFFC0C0C0FFB9B9B9FF0000000000000000000000000000
          000000000000B9B9B9FFB9B9B9FFC8C8C8FFD5D5D5FFE6E6E6FFCDCDCDFFD3D3
          D3FFB9B9B9FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000007676A0FF333372FF28283AFF4A4A4AFF555555FF3333
          56FF202064FF585873FF00000000000000000000000000000000000000006D6D
          6DFF555555FF555555FF3E3E8DFF2424DEFF1A1AA9FF003354FF054380FF2424
          E0FF2121BAFF404051FF555555FF555555FF555555FF555555FF232323FF2323
          23FF232323FF232323FF232323FF1E66D9FF292AE1FF1E26A8FF2527CBFF252C
          D5FF1B1A2BFF232323FF232323FF232323FF232323FF3D3D3DFF999999FFFFF1
          DFFFFFF1DFFFFFF1E0FFFFF1E0FF2FACD5FF5D6CDDFF302FF3FF3130EEFF1240
          79FFFFF1DFFFFFF1DFFFFFF1DFFFFFF1DFFF232323FF555555FF999999FF9999
          99FF999999FF999999FF999999FF46AAD1FF5E64DCFF4C4CFFFF3C3AF5FF122C
          73FF707070FF999999FF999999FF999999FF999999FF00000000000000000000
          00000000000000000000000000002353ADFF5152FDFF5167D4FF515FF0FF4141
          F1FF3F3F66FF0000000000000000000000000000000000000000000000000000
          000000000000000000005959FFFF5959FFFF5756BEFF98908BFF1F1F43FF5A5A
          EBFF4A4ADCFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000929292FF4C4C4CFF8E8281FF302C2CFF1A1A
          1AFF505050FF6E6E6EFF00000000000000000000000000000000000000000000
          000000000000808080FF717171FF8C8C8CFFA5A5A5FF716C6CFF3B3838FF4540
          40FF544B4BFF4B4848FF525252FF6E6E6EFF0000000000000000000000008888
          88FF888888FFC9C9C9FFA3A3A3FF7C7C7CFF828282FF797878FF4A4A4AFF6D6D
          6DFF797979FF706A6AFF716161FF534D4DFF4E4E4EFF777777FFA5A5A5FFAEAE
          AEFF989898FF828282FFA4A4A4FFB9B9B9FFD1D1D1FF8E8E8EFF757575FF6868
          68FF818181FF5E5E5EFF303030FFB79898FF8A7373FF676767FF9F9F9FFF9C9C
          9CFFB5B5B5FFC7C7C7FFE1E1E1FFE6E6E6FFD0D0D0FFD8D8D8FFD1D1D1FFC3C3
          C3FF9A9999FF797474FF423F3FFF938080FF847272FF797979FF9F9F9FFFD3D3
          D3FFDEDEDEFFC7C7C7FFE1E1E1FFDFDFDFFFF2F2F2FFFCFCFCFFECECECFFDFDF
          DFFFF7F7F7FFEEEAEAFFDECCCCFF8F8A8AFF8D8888FF00000000000000009F9F
          9FFF9F9F9FFF757575FF686868FFB8B8B8FFF2F2F2FFFCFCFCFFECECECFFDFDF
          DFFFF7F7F7FF9F9F9FFF9F9F9FFF9F9F9FFF0000000000000000000000000000
          000000000000000000009F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F
          9FFF9F9F9FFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000001300FF001300FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000001300FF006300FF006300FF001300FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000001300FF006300FF1BB22EFF1CB130FF006300FF001300FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000001300FF006300FF2EC24CFF1FB735FF17B02AFF1EB434FF006300FF0013
          00FF000000000000000000000000000000000000000000000000000000000013
          00FF006300FF44D36AFF38CB5BFF22A838FF006300FF18A92BFF1AB12FFF0063
          00FF001300FF0000000000000000000000000000000000000000001300FF0063
          00FF4CD676FF50DE7CFF2EB54AFF006300FF001300FF006300FF149D24FF1BAE
          2EFF006300FF001300FF00000000000000000000000000000000000000000013
          00FF006300FF3EC560FF006300FF001300FF0000000000000000001300FF0063
          00FF16AA28FF006300FF001300FF000000000000000000000000000000000000
          0000001300FF006300FF001300FF000000000000000000000000000000000013
          00FF004500FF119D1EFF006300FF001300FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000800FF001300FF006300FF006300FF001300FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000001300FF006300FF006300FF001300FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000001300FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000006A625CFF6A625CFF6A625CFF69635EFF726F
          6DFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000C06C27FFA6622DFFBD5D15FFB14F0EFFAB4C15FFB665
          2BFF000000000000000000000000000000000000000000000000000000000000
          000000000000C06C27FFCB6F1DFFD7791DFFB36223FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000C06C27FFD07522FFE89128FFB6631EFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000C06C27FFE58E2AFFDC8424FF83522EFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000C06C27FFEA952EFFDB8222FF7C4B27FF544E49FF6D6660FF000000000000
          0000B25C1AFFBA5403FF00000000000000000000000000000000C06C27FFC76C
          24FFE18B2CFFEC972FFFE48D26FFC76B1AFFBB5C14FFA46C3EFF00000000AE64
          2DFFC75F00FFC96100FFA9500CFF00000000000000000000000000000000C06C
          27FFED9A33FFEC972EFFE89128FFDD831FFFB16323FF00000000C86104FFC861
          04FFCC6300FFCB6200FFC75E00FF984D15FF0000000000000000000000000000
          0000C06C27FFEC972EFFE58F27FFBD651EFF00000000C86104FFBB580BFFCB64
          03FFCB6300FFCA6100FFC96000FFBD5703FFAD6734FF00000000000000000000
          000000000000C06C27FFCC7020FF00000000C86104FFA4704FFFA4704FFFC16F
          30FFC96100FFCA6100FFA9510FFFA4704FFFA4704FFFA4704FFF000000000000
          000000000000000000000000000000000000000000000000000000000000B25C
          1AFFC75F00FFC55D00FF8D542BFF000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000B25C
          1AFFCB6300FFBD5603FFAD6E3FFF000000000000000000000000000000000000
          00000000000000000000000000000000000089837CFF80685BFFA55C25FFCA64
          04FFC35C01FFAD6E3FFF00000000000000000000000000000000000000000000
          0000000000000000000000000000BF6A2EFFB65412FFB9560FFFBF5A0CFFBF5F
          15FFAD6E3FFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000C1BEBEFFC1BEBEFFC1BEBEFFC1BEBEFFC1BE
          BEFFC1BEBEFF0000000000000000000000000000000000000000000000000000
          000000000000C1BEBEFFC1BEBEFF699462FF3D8235FF327627FF35802AFF428C
          3AFF74A86EFFC1BEBEFFC1BEBEFF000000000000000000000000000000000000
          0000C1BEBEFF6D9868FF3D8235FF398030FF35802AFF2F7125FF398030FF3A89
          31FF3F9439FF439B3FFF85BA82FFC1BEBEFF000000000000000000000000C1BE
          BEFF709B6CFF41873CFF3D8235FF398030FF35802AFF24581CFF2B6523FF3980
          30FF40963BFF449E41FF48A546FF8BC48AFFC1BEBEFF0000000000000000C1BE
          BEFF468941FF41873CFF3D8235FF398030FFD7D7D7FFB9C3B8FF4D7947FF2E6A
          29FF3A8835FF449E41FF48A546FF4BAA4AFFC1BEBEFF00000000C1BEBEFF87A8
          83FF599756FF41873CFF3D8235FF398030FFCACACAFFBABABAFFB9C3B8FF6C94
          69FF2E6A29FF388234FF46A043FF48A546FF81B77AFFC1BEBEFFC1BEBEFF68A0
          65FF6CA46AFF4A8C45FF3D8235FF388234FFBABABAFFAEAEAEFFAEAEAEFFB5B5
          B5FF94AA92FF2E6A29FF347630FF439B3FFF4C9E47FFC1BEBEFFC1BEBEFF68A0
          65FF6DA56CFF68A065FF4A8C45FF3D8235FFBABABAFFA4A4A4FFA4A4A4FFA4A4
          A4FFA9A9A9FFA4A4A4FF32722CFF3F9439FF3F9439FFC1BEBEFFC1C1C1FF68A0
          65FF6DA56CFF6CA46AFF649E62FF549350FFC1C1C1FFAEAEAEFFA4A4A4FFA4A4
          A4FFA4A4A4FFA4A4A4FF3A8931FF3A8931FF3A8931FFC1BEBEFFC1C1C1FF75AA
          75FF6DA56CFF6DA56CFF68A065FF619B5CFFCACACAFFB5B5B5FFB5B5B5FFB5B5
          B5FF84A37BFF327627FF35802AFF35802AFF3D8433FFC1BEBEFFC1C1C1FF9BBD
          9AFF6DA56CFF6DA56CFF68A065FF649E62FFD7D7D7FFC1C1C1FFC1C1C1FF77A4
          72FF44873BFF3D8235FF3D8433FF347630FF699462FFC1BEBEFF00000000C1C1
          C1FF77A472FF71A871FF6CA46AFF649E62FFEAEAEAFFC9D4C8FF68A065FF4D8D
          46FF468941FF44873BFF3D8433FF3D8433FFC1BEBEFF0000000000000000C1BE
          BEFF9BBD9AFF71A871FF6DA56CFF68A065FF619B5CFF5F9B5CFF549350FF4D8D
          46FF4D8D46FF468941FF44873BFF6D9866FFC1BEBEFF00000000000000000000
          0000C1BEBEFF9BBD9AFF68A065FF6DA56CFF68A065FF619B5CFF5B9959FF5493
          50FF4D8D46FF4D8D46FF6D9868FFC1BEBEFF0000000000000000000000000000
          000000000000C1BEBEFFC1C1C1FF98BA97FF75AA75FF619B5CFF5B9959FF649E
          62FF84A37BFFC1BEBEFFC1BEBEFF000000000000000000000000000000000000
          0000000000000000000000000000C1BEBEFFC1BEBEFFC1BEBEFFC1BEBEFFC1BE
          BEFFC1BEBEFF0000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00F81F0000E0070000C0030000800100008001000000000000000000000000
          00000000000000000000000000008001000080010000C0030000E0070000F81F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000C5C2C9FFC5C2C9FFC5C2C9FFC5C2C9FFC5C2
          C9FFC5C2C9FF0000000000000000000000000000000000000000000000000000
          000000000000C5C2C9FFC5C2C9FF121298FF0C0CA2FF0C0CA2FF0F0FB0FF0F0F
          B0FF1919B8FFC5C2C9FFC5C2C9FF000000000000000000000000000000000000
          0000C5C2C9FF282795FF0A0A94FF0C0C9CFF0C0CA2FF0F0FADFF0F0FB0FF0F0F
          B0FF1212C2FF1212C2FF3433C7FFC5C2C9FF000000000000000000000000C5C2
          C9FF282795FF09098EFF0A0A94FF0C0C9CFF0C0CA2FF0F0FADFF0F0FADFF1111
          BAFF1919B8FF1313C5FF1414CDFF3636D0FFC5C2C9FF0000000000000000C5C2
          C9FF080888FF09098EFF0A0A94FF0C0C9CFF080874FF080874FF0A0A89FF0909
          8EFF09098EFF0A0A94FF1414CDFF1414CDFFC5C2C9FF00000000C5C2C9FF3E3D
          99FF14148DFF09098EFF0A0A94FFC1C1C1FFCCCCCCFFD0D0D0FFD0D0D0FFD9D9
          D9FFD0D0D0FF0A0A94FF1212C2FF1414CDFF1C1CC6FFC5C2C9FFC5C2C9FF3838
          99FF383899FF121291FF0A0A94FFC1C1C1FFB0B0B0FFB0B0B0FFBCBCBCFFBCBC
          BCFFD0D0D0FF121291FF1919B8FF1212C2FF1212C2FFC5C2C9FFC5C2C9FF3838
          99FF3A3A9DFF3737A1FF121291FFBCBCBCFFA5A5A5FFA9A9A9FFA9A9A9FFB0B0
          B0FFC1C1C1FF121291FF1111BAFF1111BAFF1111BAFFC5C2C9FFC5C2C9FF3838
          99FF3E3D99FF3737A1FF3737A1FFC1C1C1FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
          A5FFBCBCBCFF080888FF0F0FB0FF1111BAFF0F0FB0FFC5C2C9FFC5C2C9FF3E3D
          99FF383899FF3737A1FF3737A1FFCCCCCCFFB0B0B0FFB0B0B0FFA9A9A9FFA9A9
          A9FFBCBCBCFF080874FF0F0FB0FF0F0FADFF0F0FB0FFC5C2C9FFC5C2C9FF5555
          A2FF383899FF383899FF383899FFD9D9D9FFD9D9D9FFD0D0D0FFCCCCCCFFCCCC
          CCFFBCBCBCFF1C1CAAFF1616AAFF1616AAFF1818A5FFC5C2C9FF00000000C5C2
          C9FF383896FF383899FF383899FF2E2E9EFF2E2E9EFF2A2AA0FF2626A1FF2222
          A3FF2222A3FF2222A3FF1818A5FF0C0CA2FFC5C2C9FF0000000000000000C5C2
          C9FF8080B4FF383896FF383896FF2E2E9EFF2C2C95FF29299BFF29299BFF1F1F
          9EFF1F1F9EFF121298FF1818A5FF2A2AA0FFC8C8C8FF00000000000000000000
          0000C5C2C9FF8080B4FF383896FF2C2C95FF2C2C95FF282795FF282795FF1F1F
          9EFF1D1D98FF121298FF383899FFC5C2C9FF0000000000000000000000000000
          000000000000C5C2C9FFC1C1C1FF6464AAFF383899FF282795FF232392FF2827
          95FF2E2E9EFFC8C8C8FFC5C2C9FF000000000000000000000000000000000000
          0000000000000000000000000000C5C2C9FFC5C2C9FFC5C2C9FFC5C2C9FFC1C1
          C1FFC5C2C9FF0000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020101010400000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000505040E4F42
          3074876F4EBB89714FC1564835890909091C0000000000000000000000000000
          000000000000000000000000000000000000000000000E0C0918A28661CFD1AA
          78FFD0A975FFCFA772FFCEA56FFF977C56D30909091C00000000000000000000
          00000000000000000000000000000000000000000000836E54A7D4AF82FF957B
          5BBF30281D423A30224CB19164DDCEA771FF5749368900000000000000000000
          0000000000000000000000000000000000000C0B0914D2B28AFBBB9D79E91311
          0F2A0E0D0B22000000003A30224CD0A976FF8B7352C101010104000000000000
          000000000000000000000000000000000000241F1A30DABA95FFA18A6FD99E80
          58CFA0825BDB0C0B0A1E30281E42D2AC7CFF897154BB00000002000000000000
          000000000000000000000303030A050505120F0E0C1AD0B494FBCAA77AFFD0A9
          75FF927753C1100E0D24977F61BFD4AF82FF5044347400000000000000000000
          00000908071469573F93A98A61DFB59364ED897150CBB99B75EFD2AD7DFFCBA9
          7EFF9F8A72D5BEA282E9D8B68EFFA58B6CCF0505040E00000000000000000A08
          0712A58964D1D1AB7AFFCEA875FDC49F6EFBCDAB81FFD6B388FFB59976EBD3BA
          9CFBDEC1A0FFD7BA97FB87745DA70E0C0A18000000000000000000000000705E
          498FD4B084FF917959BB1E1B1634A89278CFDABA95FFCCAB82FF8B7352CB100E
          0D1A25201C300C0B0A140000000000000000000000000000000000000002BB9F
          7CE1CEAE86F911100E264038304EDCC0A2FD9C8972C3C6A272FBB7956AED0505
          051200000000000000000000000000000000000000000000000001010104CDB1
          8FF3C7AA89F30909091E000000003B342D481916122CD0AB7CFDAB8D67DF0303
          030A00000000000000000000000000000000000000000000000000000000AA93
          7AC7DCBE9CFF6A5D4F9D0909091E11100E26937C60BBD4B084FF6B5A44930000
          0000000000000000000000000000000000000000000000000000000000003A33
          2B46DBC0A1FBDDC09FFFCAAE8FF3D2B390F9D8B890FFA88E6FD10A0907140000
          0000000000000000000000000000000000000000000000000000000000000000
          00003A332C46AB9780C7D1B799F3BEA689E17363518F0A090712000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000001010104000000020000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFC70000FF030000FE310000FE790000FE190000FE130000E003
          0000C0070000887F0000987F00009E7F00008C7F0000C0FF0000E1FF0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000050A0D38152A
          378B1427338D1225309111222D9510202B990F1E299B0E1D279D0D1B259F0E1B
          249D0D1A219B0A141A930000003E00000024000000140000000412222C484179
          9EFF3F789CFF3D759AFF3B7398FF397196FF376F93FF366D92FF356C90FF496E
          87FF808E96FF9A9FA2FB808080CB3434346A000000060000000014232D464881
          A5FF4680A3FF447DA2FF437BA0FF417A9EFF3F789DFF3E769BFF55778DFFB6B7
          B7FFCFCFCFFFB3C4B5FFCACFCAFFCACACAFF565656990000000416252F464F88
          ACFF4D87AAFF4C85A8FF4A83A7FF4882A5FF4780A4FF45789AFFA4A7A9FFCFCF
          CFFFD4D5D4FF248130FF9ABA9EFFDCDCDCFFC6C6C6FD1717173E18273146568F
          B2FF558EB1FF538CAFFF518AAEFF5089ACFF4E87AAFF5A819AFFBFBFBFFF95BC
          9AFF77B07EFF278832FF5B9E63FF79AA80FFD4D6D5FF4C4C4C85192933485891
          B4FF568FB3FF558EB1FF548DB0FF528BAFFF518AADFF61879FFFD8D8D8FFA6CE
          ABFF88C18FFF76B77DFF87BC8DFF96C19BFFEAEBEAFF5B5B5B8B1526304A4983
          A6FF4982A6FF4881A5FF4781A4FF4780A4FF467EA3FF497C9DFFD1D2D3FFE9E9
          E9FFEBECEBFFA6D3ABFFD7E6D9FFF2F2F2FFEEEEEEFF2C2C2C4C45708BC7568E
          B0FF558DAFFF538BAEFF528AADFF5189ABFF4F88AAFF4E86A9FF8EA9B9FFE9E9
          E9FFF0F0F0FFD8E9DAFFEBF1ECFFF4F4F4FF9B9B9BB7000000023C5D719369A1
          C4FF67A0C3FF669FC1FF649DC0FF639CBFFF629BBDFF6099BCFF5F98BAFF94B3
          C6FFDADFE3FFF1F1F1FFDFDFDFF17E7E7E910505050A0000000021313A486A97
          B4DD86B3D0FD8AB8D4FF8AB7D4FF8AB7D3FF88B6D2FF86B3CFFF84B1CDFF83B0
          CCFF6996B2E75C8399C901010102000000000000000000000000000000000000
          000CCDCDCDEBF0F0F0FFF5F5F5FFF9F9F9FFFCFCFCFFF8F8F8FFF3F3F3FFF3F3
          F3FF2E2E2E4C0000000000000000000000000000000000000000000000000000
          000CCCCCCCEBEEEEEEFFF1F1F1FFF5F5F5FFF8F8F8FFFBFBFBFFFDFDFDFFFEFE
          FEFF2E2E2E4C0000000000000000000000000000000000000000000000000000
          000CCBCBCBEBEDEDEDFFEFEFEFFFF0F0F0FFF3F3F3FFF6F6F6FFF7F7F7FFF8F8
          F8FF2E2E2E4C0000000000000000000000000000000000000000000000000000
          000CC9C9C9EBEBEBEBFFEDEDEDFFEEEEEEFFEFEFEFFFF1F1F1FFF2F2F2FFF3F3
          F3FF2E2E2E4C0000000000000000000000000000000000000000000000000000
          000CC9C9C9EBEAEAEAFFEBEBEBFFECECECFFEDEDEDFFEEEEEEFFEFEFEFFFEFEF
          EFFF2E2E2E4C0000000000000000000000000000000000000000000000000000
          00085E5E5E7E7070708B7070708B7171718B7171718B7272728B7272728B7272
          728B1515152A0000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00800F00008007000080010000800100008000000080000000800100000001
          000000030000800F0000C03F0000C03F0000C03F0000C03F0000C03F0000E03F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000101
          0108252525602C2C2C662C2C2C662C2C2C662C2C2C662C2C2C662C2C2C662C2C
          2C66080808260000000000000000000000000000000000000000000000000202
          020EC2C2C2E3FCFCFCFFFDFDFDFFFAFAFAFFF3F3F3FFE9E9E9FFD9D9D9FFB1B1
          B1FF7B7B7BCF0808082600000000000000000000000000000000000000000202
          020EC2C2C2E3D3D4F8FFD9DBF9FFC8CAF5FFD0D1EDFFC4C5C4FFBEBFBEFF999A
          9AFFAAAAAAFF888888CD07070722000000000000000000000000000000000202
          020EC2C2C2E3EAEBFAFFF1F2FCFFE4E5F8FFE8E8F3FFE3E3E3FFDCDCDCFFBBBB
          BBFFB2B2B2FFEAEAEAFF7F7F7FC70505051E0000000000000000000000000202
          020EC2C2C2E3E2E3F9FFE5E6FBFFDEDFF8FFE2E3F1FFD6D6D6FFD6D7D6FFBFC0
          BFFFAAABABFF9D9D9DFFA3A3A3FF676767BD0101010A00000000000000000202
          020EC1C1C1E3DADBF7FFE5E6FAFFD1D3F8FFDDDEF6FFDCDCDCFFDADADAFFD2D3
          D3FFCBCBCBFFB8B9B8FFAEAFAFFF9C9C9CE30202020E00000000000000000202
          020EC0C0C0E3E8E9F8FFE8E9FAFFE8E9FBFFECECF7FFE4E4E4FFE4E5E5FFDDDD
          DDFFDDDDDDFFD1D2D1FFD1D2D1FFB1B1B1E30202020E00000000000000000202
          020EBEBEBEE3CFD1F4FFDFE0F8FFC9CBF7FFDCDDF9FFDCDDDCFFE2E3E3FFDBDB
          DBFFDFDFDFFFD8D8D8FFD7D8D7FFBABABAE30202020E00000000000000000202
          020EBCBCBCE3ECECF4FFE9EAF7FFEEEFFAFFF4F4FAFFF7F8F7FFF0F1F0FFF1F1
          F1FFF3F3F3FFF0F0F0FFEEEFEFFFBFBFBFE30202020E00000000000000000202
          020EBBBBBBE3C2C3EEFFD7D8F3FFBEC0F3FFD4D5F5FFCED0CFFFE4E5E4FFDADB
          DAFFE5E5E5FFD7D8D8FFE1E2E1FFC3C3C3E30202020E00000000000000000202
          020EB8B8B8E3EDEDEDFFF1F1F1FFF5F5F5FFF8F8F8FFFAFAFAFFFBFBFBFFFCFC
          FCFFFDFDFDFFFDFDFDFFFDFDFDFFC4C4C4E30202020E00000000000000000202
          020EB5B5B5E3B3B5E7FFC1C2EBFFABAEECFFC5C7EDFFC5C6C6FFD5D6D6FFCFD0
          D0FFDEDFDFFFD2D3D2FFDDDEDDFFC3C3C3E30202020E00000000000000000202
          020EB3B3B3E3E5E5E5FFE9E9E9FFECECECFFEFEFEFFFF2F2F2FFF4F4F4FFF6F6
          F6FFF7F7F7FFF8F8F8FFF8F8F8FFC1C1C1E30202020E00000000000000000202
          020EB0B0B0E3ADAEE0FFB9BBE3FFA5A7E5FFBDBFE5FFBEC0BFFFCECECEFFC8CA
          C9FFD7D8D8FFCBCDCCFFDCDCDCFFBEBEBEE30202020E00000000000000000202
          020EB0B0B0E3DDDDDDFFDFDFDFFFE2E2E2FFE5E5E5FFE7E7E7FFE9E9E9FFEBEB
          EBFFECECECFFEDEDEDFFEDEDEDFFBBBBBBE30202020E00000000000000000101
          01084A4A4A725D5D5D7E5D5D5D7E5D5D5D7E5E5E5E7E5E5E5E7E5E5E5E7E5F5F
          5F7E5F5F5F7E5F5F5F7E5F5F5F7E4C4C4C720101010800000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000C01F0000C00F0000C0070000C0030000C0030000C0030000C003
          0000C0030000C0030000C0030000C0030000C0030000C0030000C0030000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086622200805E21007D5B
          200079581F0074551E0071521E007B5A210088642500FF00FF00FF00FF00FF00
          FF008863220077561E006F511C006A4E1B00775F3200826E47009D917300A8A0
          8400B8B49F00CED2C300DAE2D400C2C1A9007A5A2100FF00FF001E6C1F001E6C
          1F0087A68800C5D2C600D3DCD200FAFFFC00F9FFFB00F8FFFA00F7FFFA00F6FF
          F900F4FFF800F3FFF800F2FFF700C1D2BF0079592100FF00FF001E6C1F009BB9
          9D00C3D0C500FDFFFD00FCFFFD00FBFFFC00F9FFFB00F7FEF900F6FEF8008BC0
          99000C6F32000C6F3200E8F8EF00D7E7DA0077572000FF00FF0020702100B6CD
          B80082A28500FDFFFE00B9DDBB007DBF81006CB771006CB7710060AE69001273
          36000C6F320058A66800DCF2E000EEFBF20074562000FF00FF0022732200BAD1
          BB003C744000FEFFFE00FDFFFE00BEE0C0006FB974006BB67000207E3F000C6F
          32005FA3770062AF6A009BCEA200F4FFF8007F653300FF00FF0025762400BBD2
          BC001D5F2200EAEFEB00FEFFFE00FDFFFE00DDEFDE00439658000C6F32001B7A
          3C00B7DDBC00F8FFFA00F7FFFA00F6FFF9008B754B00FF00FF0027792600BBD2
          BC001E612300B6CBB700FFFFFF00FEFFFE00C1DBCC000F7134000F7134005AA9
          65006CB77100A1D2A500F5FDF700F7FFFA0099896400FF00FF00297D2700BBD2
          BC001F64240088A98A00FFFFFF00EEF5F1000F7135000C6F32008EBDA000E1F0
          E2006CB771006CB771008AC68E00E9F7EB00A89B7C00FF00FF002C802800D0E3
          D10074AB77008AB38C00FFFFFF003D8C5B002D834E005EA37300FDFFFE00FDFF
          FD00FCFFFD00FBFFFC00FAFFFC00F9FFFB00BCB19500FF00FF00297C1D00D5E6
          D50085BA87007FB28100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFFFE00FDFF
          FE00FDFFFD00FCFFFD00FBFFFC00FAFFFC00D2C9B000FF00FF003B8D3700CFE4
          CE009ACA9C0082BB8400D1E4D100CADFCB00CBE0CB00CBE2CC00BBDABC00B3D6
          B400A2CFA40095CA9800D1E5D1006EAB6B00A8874A00FF00FF004F7D240099C6
          9700E5F2E60090C8930090C8930090C8930090C8930090C8930090C8930090C8
          930090C8930094CA9700EBF7EB002E8D2500FF00FF00FF00FF00FF00FF002A85
          2200C0DDBF00E8F5E900AEDAB0009CD29F009CD29F009CD29F009CD29F009CD2
          9F009CD29F0097CC9A00EBF7EB002E8D2500FF00FF00FF00FF00FF00FF00FF00
          FF002E89240093C59000D7EBD600EBF7EB00EBF7EB00EBF7EB00EBF7EB00EBF7
          EB00EBF7EB00EBF7EB00EBF7EB002E8D2500FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF004D7E270044993C002E8D25002E8D25002E8D25002E8D25002E8D
          25002E8D25002E8D25002E8D25002E8D2500FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end>
  end
  object actlstMain: TActionList
    Images = cxmglstActions
    Left = 600
    Top = 256
    object actFile: TAction
      Category = #1060#1072#1081#1083
      Caption = '&'#1060#1072#1081#1083
      OnExecute = actFileExecute
    end
    object actQuit: TAction
      Category = #1060#1072#1081#1083
      Caption = '&'#1042#1099#1093#1086#1076
      Hint = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1088#1072#1073#1086#1090#1099'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 0
      ShortCut = 32883
      OnExecute = actQuitExecute
      OnUpdate = actQuitUpdate
    end
    object actHelp: TAction
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&?'
      OnExecute = actHelpExecute
    end
    object actHelpContext: TAction
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Hint = 
        #1057#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1089#1087#1088#1072#1074#1082#1080'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1089#1087#1088#1072#1074#1086#1095#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '#1087#1088#1086#1075#1088#1072 +
        #1084#1084#1099
      ImageIndex = 2
      ShortCut = 112
      OnExecute = actHelpContextExecute
      OnUpdate = actHelpContextUpdate
    end
    object actAbout: TAction
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Hint = 
        #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077 +
        #1081' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 1
      ShortCut = 122
      OnExecute = actAboutExecute
      OnUpdate = actAboutUpdate
    end
    object actView: TAction
      Category = #1042#1080#1076
      Caption = '&'#1042#1080#1076
      OnExecute = actViewExecute
    end
    object actStatusBar: TAction
      Category = #1042#1080#1076
      AutoCheck = True
      Caption = #1055#1072#1085#1077#1083#1100' &'#1089#1086#1089#1090#1086#1103#1085#1080#1103
      Checked = True
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1082#1083#1102#1095#1077#1085#1080#1103'/'#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1089#1086#1089#1090#1086#1103#1085#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnExecute = actStatusBarExecute
    end
    object actToolBar: TAction
      Category = #1042#1080#1076
      AutoCheck = True
      Caption = #1055#1072#1085#1077#1083#1100' &'#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      Checked = True
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1082#1083#1102#1095#1077#1085#1080#1103'/'#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnExecute = actToolBarExecute
    end
    object actAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1044#1077#1081#1089#1090#1074#1080#1077
      OnExecute = actActionExecute
    end
    object actConfiguration: TAction
      Category = #1060#1072#1081#1083
      Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1080'...'
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 3
      ShortCut = 120
      OnExecute = actConfigurationExecute
      OnUpdate = actConfigurationUpdate
    end
    object actExportToExcel: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074
      Hint = 
        #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' '#1074' '#1076#1086#1082#1091 +
        #1084#1077#1085#1090' Microsoft Excel'
      ImageIndex = 22
      SecondaryShortCuts.Strings = (
        'F2')
      ShortCut = 16467
      OnExecute = actExportToExcelExecute
      OnUpdate = actExportToExcelUpdate
    end
    object actConnect: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082' '#1089#1077#1088#1074#1077#1088#1091
      Hint = 
        #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082' '#1089#1077#1088#1074#1077#1088#1091'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1084#1077#1085#1077#1076#1078#1077#1088#1072' '#1082' '#1089#1077#1088#1074#1077 +
        #1088#1091
      ImageIndex = 13
      OnExecute = actConnectExecute
      OnUpdate = actConnectUpdate
    end
    object actDisconnect: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1086#1090' '#1089#1077#1088#1074#1077#1088#1072
      Enabled = False
      Hint = 
        #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1086#1090' '#1089#1077#1088#1074#1077#1088#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1084#1077#1085#1077#1076#1078#1077#1088#1072' '#1086#1090' '#1089#1077#1088#1074#1077 +
        #1088#1072
      ImageIndex = 14
      OnExecute = actDisconnectExecute
      OnUpdate = actDisconnectUpdate
    end
    object actAdd: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 7
      ShortCut = 45
      OnExecute = actAddExecute
      OnUpdate = actAddUpdate
    end
    object actEdit: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
      Hint = 
        #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1101#1083#1077#1084#1077#1085#1090'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077 +
        #1084#1077#1085#1090#1072' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 8
      ShortCut = 113
      OnExecute = actEditExecute
      OnUpdate = actEditUpdate
    end
    object actDelete: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
      Hint = 
        #1059#1076#1072#1083#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1080#1079' '#1089#1087#1080 +
        #1089#1082#1072
      ImageIndex = 9
      ShortCut = 46
      OnExecute = actDeleteExecute
      OnUpdate = actDeleteUpdate
    end
    object actRefresh: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 16
      ShortCut = 116
      OnExecute = actRefreshExecute
      OnUpdate = actRefreshUpdate
    end
  end
  object gsflvrsnfMain: TGSFileVersionInfo
    Left = 136
    Top = 256
  end
  object mmMain: TMainMenu
    Images = cxmglstActions
    Left = 528
    Top = 256
    object N1: TMenuItem
      Action = actFile
      object N27: TMenuItem
        Action = actConfiguration
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object N10: TMenuItem
        Action = actQuit
      end
    end
    object N4: TMenuItem
      Action = actAction
      object N11: TMenuItem
        Action = actConnect
      end
      object N12: TMenuItem
        Action = actDisconnect
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object N14: TMenuItem
        Action = actAdd
      end
      object N16: TMenuItem
        Action = actEdit
      end
      object N17: TMenuItem
        Action = actDelete
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object N31: TMenuItem
        Action = actRefresh
      end
    end
    object N2: TMenuItem
      Action = actView
      object N8: TMenuItem
        Action = actStatusBar
        AutoCheck = True
      end
      object N9: TMenuItem
        Action = actToolBar
        AutoCheck = True
      end
    end
    object N3: TMenuItem
      Action = actHelp
      object N5: TMenuItem
        Action = actHelpContext
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        Action = actAbout
      end
    end
  end
  object pctnbrMain: TPopupActionBar
    Images = cxmglstActions
    Left = 208
    Top = 256
    object N18: TMenuItem
      Action = actAdd
    end
    object N15: TMenuItem
      Action = actEdit
    end
    object N19: TMenuItem
      Action = actDelete
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object N22: TMenuItem
      Action = actRefresh
    end
  end
  object fdphysmsqldrvrlnk: TFDPhysMSSQLDriverLink
    Left = 292
    Top = 255
  end
end
