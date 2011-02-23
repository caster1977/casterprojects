object ConfigurationForm: TConfigurationForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
  ClientHeight = 162
  ClientWidth = 211
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    211
    162)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 122
    Width = 193
    Height = 7
    Anchors = [akLeft, akBottom]
    Shape = bsTopLine
    ExplicitTop = 146
  end
  object ButtonOk: TButton
    Left = 8
    Top = 129
    Width = 93
    Height = 25
    Cursor = crHandPoint
    Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1087#1080#1089#1080' '#1080#1079#1084#1077#1085#1105#1085#1085#1086#1081' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    ModalResult = 1
    TabOrder = 0
  end
  object ButtonCancel: TButton
    Left = 108
    Top = 129
    Width = 93
    Height = 25
    Cursor = crHandPoint
    Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 211
    Height = 39
    Align = alTop
    Caption = ' '#1050#1083#1072#1074#1080#1096#1080' '#1074#1082#1083#1102#1095#1077#1085#1080#1103' '#1089#1080#1075#1085#1072#1083#1086#1074' '
    TabOrder = 2
    object CheckBox1: TCheckBox
      Left = 8
      Top = 15
      Width = 47
      Height = 17
      Caption = 'Ctrl +'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 58
      Top = 15
      Width = 43
      Height = 17
      Caption = 'Alt +'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object CheckBox3: TCheckBox
      Left = 104
      Top = 15
      Width = 56
      Height = 17
      Caption = 'Shift +'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object ComboBox1: TComboBox
      Left = 157
      Top = 13
      Width = 51
      Height = 21
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1101#1083#1077#1084#1077#1085#1090' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      Style = csDropDownList
      TabOrder = 3
      OnChange = CheckBox1Click
      OnSelect = CheckBox1Click
      Items.Strings = (
        'F9'
        'F10'
        'F11'
        'F12')
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 39
    Width = 211
    Height = 39
    Align = alTop
    Caption = ' '#1050#1083#1072#1074#1080#1096#1080' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1089#1080#1075#1085#1072#1083#1086#1074' '
    TabOrder = 3
    object CheckBox4: TCheckBox
      Left = 8
      Top = 15
      Width = 47
      Height = 17
      Caption = 'Ctrl +'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox5: TCheckBox
      Left = 58
      Top = 15
      Width = 43
      Height = 17
      Caption = 'Alt +'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object CheckBox6: TCheckBox
      Left = 104
      Top = 15
      Width = 56
      Height = 17
      Caption = 'Shift +'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object ComboBox2: TComboBox
      Left = 157
      Top = 13
      Width = 51
      Height = 21
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1101#1083#1077#1084#1077#1085#1090' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      Style = csDropDownList
      TabOrder = 3
      OnChange = CheckBox1Click
      OnSelect = CheckBox1Click
      Items.Strings = (
        'F9'
        'F10'
        'F11'
        'F12')
    end
  end
  object CheckBox7: TCheckBox
    Left = 8
    Top = 84
    Width = 195
    Height = 17
    Hint = 
      #1042#1082#1083#1102#1095#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1074#1089#1087#1083#1099#1074#1072#1102#1097#1080#1093' '#1090#1077#1082#1089#1090#1086#1074#1099#1093' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1085#1072#1076' '#1080#1082#1086 +
      #1085#1082#1086#1081
    Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1074' '#1090#1088#1077#1077
    TabOrder = 4
  end
  object CheckBox8: TCheckBox
    Left = 8
    Top = 102
    Width = 195
    Height = 17
    Hint = #1042#1082#1083#1102#1095#1080#1090#1077' '#1076#1083#1103' '#1085#1072#1083#1080#1095#1080#1103' '#1079#1074#1091#1082#1086#1074#1086#1075#1086' '#1089#1086#1087#1088#1086#1074#1086#1078#1076#1077#1085#1080#1103
    Caption = #1055#1088#1086#1080#1075#1088#1099#1074#1072#1090#1100' '#1079#1074#1091#1082#1080
    TabOrder = 5
  end
end
