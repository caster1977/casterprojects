object AccountPropertiesForm: TAccountPropertiesForm
  Left = 0
  Top = 0
  ActiveControl = btnCancel
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072
  ClientHeight = 167
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    282
    167)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 135
    Width = 282
    Height = 32
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -1
    ExplicitTop = 218
  end
  object lblFullname: TLabel
    Left = 0
    Top = 3
    Width = 62
    Height = 13
    Caption = #1055#1086#1083#1085#1086#1077' &'#1080#1084#1103':'
    FocusControl = edbxFullname
  end
  object lblPosition: TLabel
    Left = 0
    Top = 30
    Width = 61
    Height = 13
    Caption = '&'#1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    FocusControl = edbxPosition
  end
  object lblPhone: TLabel
    Left = 0
    Top = 57
    Width = 88
    Height = 13
    Caption = '&'#1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072':'
    FocusControl = edbxPhone
  end
  object Bevel1: TBevel
    Left = 0
    Top = 81
    Width = 282
    Height = 2
    Align = alCustom
    Shape = bsTopLine
  end
  object edbxFullname: TEdit
    Left = 94
    Top = 0
    Width = 188
    Height = 21
    TabOrder = 0
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1060'.'#1048'.'#1054'. '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    OnChange = FieldsChange
  end
  object edbxPosition: TEdit
    Left = 94
    Top = 27
    Width = 188
    Height = 21
    TabOrder = 1
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1079#1072#1085#1080#1084#1072#1077#1084#1091#1102' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
    OnChange = FieldsChange
  end
  object chkbxIsAdmin: TCheckBox
    Left = 0
    Top = 89
    Width = 282
    Height = 17
    Caption = '&'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1089#1082#1080#1077' '#1087#1088#1080#1074#1077#1083#1077#1075#1080#1080
    TabOrder = 3
    OnClick = FieldsChange
  end
  object chkbxDisable: TCheckBox
    Left = 0
    Top = 112
    Width = 282
    Height = 17
    Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' &'#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
    TabOrder = 4
    OnClick = FieldsChange
  end
  object btnHelp: TButton
    Left = 0
    Top = 142
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Help
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object btnApply: TButton
    Left = 116
    Top = 142
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Apply
    Anchors = [akRight, akBottom]
    TabOrder = 6
  end
  object btnCancel: TButton
    Left = 202
    Top = 142
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Cancel
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 7
  end
  object edbxPhone: TEdit
    Left = 94
    Top = 54
    Width = 188
    Height = 21
    TabOrder = 2
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1090#1077#1083#1077#1092#1086#1085#1072
    OnChange = FieldsChange
  end
  object ActionManager1: TActionManager
    Left = 240
    Top = 96
    StyleName = 'Platform Default'
    object Action_Apply: TAction
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      OnExecute = Action_ApplyExecute
    end
    object Action_Cancel: TAction
      Caption = '&'#1054#1090#1084#1077#1085#1072
      OnExecute = Action_CancelExecute
    end
    object Action_Help: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      OnExecute = Action_HelpExecute
    end
  end
end
