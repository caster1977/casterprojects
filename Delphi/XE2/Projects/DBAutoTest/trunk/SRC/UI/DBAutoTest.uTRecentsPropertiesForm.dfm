object RecentsPropertiesForm: TRecentsPropertiesForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = 'RecentsPropertiesForm'
  ClientHeight = 320
  ClientWidth = 462
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
  object Bevel1: TBevel
    Left = 0
    Top = 288
    Width = 462
    Height = 1
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = 8
    ExplicitTop = 289
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 289
    Width = 462
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MaxHeight = 31
    Constraints.MinHeight = 31
    TabOrder = 2
    DesignSize = (
      462
      31)
    object btnApply: TButton
      Left = 225
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actApply
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 306
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actCancel
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 1
    end
    object btnHelp: TButton
      Left = 387
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
  end
  object lvRecentsList: TListView
    Left = 0
    Top = 66
    Width = 462
    Height = 185
    Hint = #1057#1087#1080#1089#1086#1082' '#1088#1072#1085#1077#1077' '#1086#1090#1082#1088#1099#1074#1072#1074#1096#1080#1093#1089#1103' '#1092#1072#1081#1083#1086#1074' '#1087#1088#1086#1092#1080#1083#1077#1081
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
      end>
    ColumnClick = False
    FlatScrollBars = True
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 1
    ViewStyle = vsReport
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 462
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    Constraints.MaxHeight = 66
    Constraints.MinHeight = 66
    TabOrder = 0
    object lblRecentsListSize: TLabel
      Left = 0
      Top = 0
      Width = 113
      Height = 13
      Caption = '&'#1056#1072#1079#1084#1077#1088' '#1089#1087#1080#1089#1082#1072' '#1092#1072#1081#1083#1086#1074
      FocusControl = seRecentsListSize
    end
    object lblRecentsList: TLabel
      Left = 0
      Top = 47
      Width = 77
      Height = 13
      Caption = #1057#1087#1080#1089#1086#1082' &'#1092#1072#1081#1083#1086#1074
      FocusControl = lvRecentsList
    end
    object seRecentsListSize: TSpinEdit
      Left = 0
      Top = 19
      Width = 121
      Height = 22
      MaxLength = 2
      MaxValue = 20
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnKeyUp = seRecentsListSizeKeyUp
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 251
    Width = 462
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MaxHeight = 37
    Constraints.MinHeight = 37
    TabOrder = 3
    DesignSize = (
      462
      37)
    object btnClear: TButton
      Left = 387
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actClear
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object Button1: TButton
      Left = 306
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actDelete
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btnDeleteNotExists: TButton
      Left = 150
      Top = 6
      Width = 150
      Height = 25
      Cursor = crHandPoint
      Action = actDeleteNotExists
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
  end
  object ActionList: TActionList
    Left = 16
    Top = 200
    object actCancel: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1054#1090#1084#1077#1085#1072
      OnExecute = actCancelExecute
    end
    object actApply: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      OnExecute = actApplyExecute
      OnUpdate = actApplyUpdate
    end
    object actHelp: TAction_Help
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Enabled = False
      Hint = #1057#1087#1088#1072#1074#1082#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 2
      ShortCut = 112
    end
    object actClear: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1054'&'#1095#1080#1089#1090#1080#1090#1100
      OnExecute = actClearExecute
      OnUpdate = actClearUpdate
    end
    object actDelete: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 9
      ShortCut = 46
      OnExecute = actDeleteExecute
      OnUpdate = actDeleteUpdate
    end
    object actDeleteNotExists: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1085#1077#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1077
      Hint = 
        #1059#1076#1072#1083#1080#1090#1100' '#1085#1077#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1080#1079#1089' '#1087#1080#1089#1082#1072' '#1085#1077#1089#1091#1097#1077#1089#1090#1074#1091 +
        #1102#1097#1080#1093' '#1092#1072#1081#1083#1086#1074
      OnExecute = actDeleteNotExistsExecute
      OnUpdate = actDeleteNotExistsUpdate
    end
  end
end
