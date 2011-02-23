object AccountCreateForm: TAccountCreateForm
  Left = 0
  Top = 0
  ActiveControl = edbxLogin
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = #1053#1086#1074#1099#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  ClientHeight = 250
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
    250)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 218
    Width = 282
    Height = 32
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -1
  end
  object lblLogin: TLabel
    Left = 0
    Top = 3
    Width = 76
    Height = 13
    Caption = '&'#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
    FocusControl = edbxLogin
  end
  object lblFullname: TLabel
    Left = 0
    Top = 30
    Width = 62
    Height = 13
    Caption = #1055'&'#1086#1083#1085#1086#1077' '#1080#1084#1103':'
    FocusControl = edbxFullname
  end
  object lblPosition: TLabel
    Left = 0
    Top = 57
    Width = 61
    Height = 13
    Caption = '&'#1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    FocusControl = edbxPosition
  end
  object lblPhone: TLabel
    Left = 0
    Top = 84
    Width = 88
    Height = 13
    Caption = '&'#1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072':'
    FocusControl = edbxPhone
  end
  object lblConfirmation: TLabel
    Left = 0
    Top = 148
    Width = 87
    Height = 13
    Caption = #1055#1086#1076'&'#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077':'
    FocusControl = mskConfirmation
  end
  object lblPassword: TLabel
    Left = 0
    Top = 121
    Width = 41
    Height = 13
    Caption = #1055'&'#1072#1088#1086#1083#1100':'
    FocusControl = mskPassword
  end
  object Bevel1: TBevel
    Left = 0
    Top = 108
    Width = 282
    Height = 2
    Align = alCustom
    Shape = bsTopLine
  end
  object edbxLogin: TEdit
    Left = 94
    Top = 0
    Width = 188
    Height = 21
    TabOrder = 0
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1083#1086#1075#1080#1085' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    OnChange = FieldsChange
  end
  object edbxFullname: TEdit
    Left = 94
    Top = 27
    Width = 188
    Height = 21
    TabOrder = 1
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1060'.'#1048'.'#1054'. '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    OnChange = FieldsChange
  end
  object edbxPosition: TEdit
    Left = 94
    Top = 54
    Width = 188
    Height = 21
    TabOrder = 2
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1079#1072#1085#1080#1084#1072#1077#1084#1091#1102' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
    OnChange = FieldsChange
  end
  object edbxPhone: TEdit
    Left = 94
    Top = 81
    Width = 188
    Height = 21
    TabOrder = 3
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1090#1077#1083#1077#1092#1086#1085#1072
    OnChange = FieldsChange
  end
  object mskPassword: TMaskEdit
    Left = 94
    Top = 118
    Width = 188
    Height = 21
    PasswordChar = '*'
    TabOrder = 4
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    OnChange = FieldsChange
  end
  object mskConfirmation: TMaskEdit
    Left = 94
    Top = 145
    Width = 188
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    TextHint = #1055#1086#1074#1090#1086#1088#1085#1086' '#1074#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
    OnChange = FieldsChange
  end
  object chkbxIsAdmin: TCheckBox
    Left = 0
    Top = 172
    Width = 282
    Height = 17
    Caption = '&'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1089#1082#1080#1077' '#1087#1088#1080#1074#1077#1083#1077#1075#1080#1080
    TabOrder = 6
  end
  object chkbxDisable: TCheckBox
    Left = 0
    Top = 195
    Width = 282
    Height = 17
    Caption = #1054#1090'&'#1082#1083#1102#1095#1080#1090#1100' '#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
    TabOrder = 7
  end
  object btnHelp: TButton
    Left = 0
    Top = 225
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Help
    Anchors = [akLeft, akBottom]
    TabOrder = 8
  end
  object btnCreate: TButton
    Left = 116
    Top = 225
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Create
    Anchors = [akLeft, akBottom]
    TabOrder = 9
  end
  object btnClose: TButton
    Left = 202
    Top = 225
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Close
    Anchors = [akLeft, akBottom]
    Cancel = True
    ModalResult = 11
    TabOrder = 10
  end
  object ActionManager1: TActionManager
    Left = 240
    Top = 184
    StyleName = 'Platform Default'
    object Action_Create: TAction
      Caption = #1057'&'#1086#1079#1076#1072#1090#1100
      OnExecute = Action_CreateExecute
    end
    object Action_Close: TAction
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      OnExecute = Action_CloseExecute
    end
    object Action_Help: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      OnExecute = Action_HelpExecute
    end
  end
end
