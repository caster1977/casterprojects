object frmDetail: TfrmDetail
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1089#1090#1086#1088#1080#1080
  ClientHeight = 559
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bvl1: TBevel
    Left = 0
    Top = 523
    Width = 782
    Height = 5
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 191
    ExplicitWidth = 299
  end
  object pnlButtons: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 534
    Width = 782
    Height = 25
    Margins.Left = 0
    Margins.Top = 6
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 707
      Top = 0
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Margins.Left = 6
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actClose
      Align = alRight
      Cancel = True
      TabOrder = 0
    end
  end
  object cxgrdDetail: TcxGrid
    Left = 0
    Top = 0
    Width = 782
    Height = 523
    Align = alClient
    TabOrder = 1
    object cxgrdtblvwGrid1TableView: TcxGridTableView
      OnKeyDown = cxgrdtblvwGrid1TableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
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
      object colCreateDate: TcxGridColumn
        Caption = #1044#1072#1090#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
        DataBinding.ValueType = 'DateTime'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.DisplayFormat = 'dd.mm.yyyy hh:nn:ss'
        Properties.EditFormat = 'dd.mm.yyyy hh:nn:ss'
        Properties.ImmediatePost = True
        Properties.ReadOnly = True
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object colErrorText: TcxGridColumn
        Caption = #1054#1096#1080#1073#1082#1072
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object colRetryCount: TcxGridColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1087#1086#1087#1099#1090#1086#1082
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.ImmediatePost = True
        Properties.ReadOnly = True
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object colDocumentStatusName: TcxGridColumn
        Caption = #1057#1090#1072#1090#1091#1089
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
    end
    object cxgrdlvlMain: TcxGridLevel
      GridView = cxgrdtblvwGrid1TableView
    end
  end
  object ActionList: TActionList
    Left = 224
    Top = 32
    object actClose: TAction
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = actCloseExecute
      OnUpdate = actCloseUpdate
    end
  end
end
