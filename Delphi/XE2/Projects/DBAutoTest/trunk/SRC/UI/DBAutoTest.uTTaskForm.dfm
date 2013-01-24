object TaskForm: TTaskForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = 'TaskForm'
  ClientHeight = 320
  ClientWidth = 462
  Color = clBtnFace
  Constraints.MaxHeight = 360
  Constraints.MaxWidth = 480
  Constraints.MinHeight = 360
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
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
      TabOrder = 1
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
      TabOrder = 2
    end
    object btnClear: TButton
      Left = 0
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actClear
      TabOrder = 0
    end
    object btnHelp: TButton
      Left = 387
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      Anchors = [akTop, akRight]
      TabOrder = 3
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 462
    Height = 111
    Align = alTop
    BevelOuter = bvNone
    Constraints.MaxHeight = 111
    Constraints.MinHeight = 111
    TabOrder = 0
    DesignSize = (
      462
      111)
    object lblGroup: TLabel
      Left = 0
      Top = 0
      Width = 36
      Height = 13
      Caption = '&'#1043#1088#1091#1087#1087#1072
    end
    object lblName: TLabel
      Left = 0
      Top = 46
      Width = 73
      Height = 13
      Caption = '&'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    end
    object lblSQL: TLabel
      Left = 0
      Top = 92
      Width = 72
      Height = 13
      Caption = '&'#1058#1077#1082#1089#1090' '#1079#1072#1087#1088#1086#1089#1072
      FocusControl = meSQL
    end
    object cmbGroup: TComboBox
      Left = 0
      Top = 19
      Width = 462
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Sorted = True
      TabOrder = 0
    end
    object cmbName: TComboBox
      Left = 0
      Top = 65
      Width = 462
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
  object meSQL: TMemo
    Left = 0
    Top = 111
    Width = 462
    Height = 178
    Align = alClient
    TabOrder = 1
    WordWrap = False
  end
  object ActionList: TActionList
    Left = 16
    Top = 200
    object actCancel: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = '&'#1054#1090#1084#1077#1085#1072
      Hint = #1054#1090#1084#1077#1085#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actCancelExecute
    end
    object actApply: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actApplyExecute
      OnUpdate = actApplyUpdate
    end
    object actClear: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1054'&'#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1089#1087#1080#1089#1082#1072
      OnExecute = actClearExecute
      OnUpdate = actClearUpdate
    end
    object actHelp: TAction_Help
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Enabled = False
      Hint = #1057#1087#1088#1072#1074#1082#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 2
      ShortCut = 112
    end
  end
end
