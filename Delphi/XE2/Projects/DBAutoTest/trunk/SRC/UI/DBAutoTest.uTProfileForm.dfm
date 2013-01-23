object ProfileForm: TProfileForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = 'ProfileForm'
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
  object pnlButtons: TPanel
    Left = 0
    Top = 289
    Width = 462
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MaxHeight = 31
    Constraints.MinHeight = 31
    TabOrder = 0
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 462
    Height = 289
    Align = alClient
    Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1082' '#1080#1089#1090#1086#1095#1085#1080#1082#1091' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1090#1077#1089#1090#1086#1074' '
    TabOrder = 1
    DesignSize = (
      462
      289)
    object lblGroup: TLabel
      Left = 10
      Top = 20
      Width = 199
      Height = 13
      Caption = '&1. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1080#1083#1080' '#1074#1074#1077#1076#1080#1090#1077' '#1080#1084#1103' '#1089#1077#1088#1074#1077#1088#1072':'
      FocusControl = cmbGroup
    end
    object lblName: TLabel
      Left = 10
      Top = 208
      Width = 194
      Height = 13
      Caption = '&3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093' '#1085#1072' '#1089#1077#1088#1074#1077#1088#1077':'
      FocusControl = cmbName
    end
    object Label1: TLabel
      Left = 43
      Top = 134
      Width = 72
      Height = 13
      Caption = #1055#1086'&'#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      FocusControl = Edit1
    end
    object Label2: TLabel
      Left = 43
      Top = 161
      Width = 37
      Height = 13
      Caption = #1055#1072'&'#1088#1086#1083#1100
      FocusControl = MaskEdit1
    end
    object Label3: TLabel
      Left = 10
      Top = 66
      Width = 197
      Height = 13
      Caption = '&2. '#1044#1083#1103' '#1074#1093#1086#1076#1072' '#1085#1072' '#1089#1077#1088#1074#1077#1088' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100':'
      FocusControl = RadioButton1
    end
    object cmbGroup: TComboBox
      Left = 17
      Top = 39
      Width = 442
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Sorted = True
      TabOrder = 0
    end
    object cmbName: TComboBox
      Left = 10
      Top = 227
      Width = 442
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
    end
    object RadioButton1: TRadioButton
      Left = 26
      Top = 85
      Width = 426
      Height = 17
      Action = actUseWinNTSecurity
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 26
      Top = 108
      Width = 426
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = #1089#1083#1077#1076#1091#1102#1097#1080#1077' &'#1080#1084#1103' '#1080' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
      TabOrder = 2
    end
    object Button1: TButton
      Left = 306
      Top = 254
      Width = 146
      Height = 25
      Cursor = crHandPoint
      Action = actTestConnection
      Anchors = [akTop, akRight]
      TabOrder = 8
    end
    object CheckBox1: TCheckBox
      Left = 121
      Top = 185
      Width = 97
      Height = 17
      Caption = #1087#1091#1089#1090#1086'&'#1081' '#1087#1072#1088#1086#1083#1100
      TabOrder = 5
    end
    object CheckBox2: TCheckBox
      Left = 224
      Top = 185
      Width = 228
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = #1088#1072#1079#1088#1077#1096#1080#1090#1100' '#1089#1086'&'#1093#1088#1072#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103
      TabOrder = 6
    end
    object Edit1: TEdit
      Left = 121
      Top = 131
      Width = 331
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object MaskEdit1: TMaskEdit
      Left = 121
      Top = 158
      Width = 331
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      PasswordChar = '*'
      TabOrder = 4
      Text = ''
    end
  end
  object ActionList: TActionList
    Left = 400
    Top = 72
    object actCancel: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = '&'#1054#1090#1084#1077#1085#1072
      Hint = #1054#1090#1084#1077#1085#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
    end
    object actApply: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
    end
    object actClear: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1054'&'#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1089#1087#1080#1089#1082#1072
    end
    object actHelp: TAction_Help
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Enabled = False
      Hint = #1057#1087#1088#1072#1074#1082#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 2
      ShortCut = 112
    end
    object actTestConnection: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = '&'#1058#1077#1089#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077
      Hint = 
        #1058#1077#1089#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1090#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1089#1086#1077#1076#1080 +
        #1085#1077#1085#1080#1103' '
    end
    object actUseWinNTSecurity: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1074#1089#1090#1088#1086#1077#1085#1085#1091#1102' '#1089#1080#1089#1090#1077#1084#1091' &'#1073#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1080' Windows NT'
      Checked = True
    end
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=CSC_Frito;Data Source=SRV-SQL-TEST01'
    Provider = 'SQLOLEDB.1'
    Left = 320
    Top = 72
  end
end
