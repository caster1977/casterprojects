object AddEditPhoneForm: TAddEditPhoneForm
  Left = 0
  Top = 0
  ActiveControl = edbxPhoneNumber
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = 'OA4 - '#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077'/'#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1090#1077#1083#1077#1092#1086#1085#1072
  ClientHeight = 256
  ClientWidth = 634
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
    Top = 215
    Width = 634
    Height = 41
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object btnApply: TButton
      Left = 386
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1074' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      ModalResult = 1
      TabOrder = 1
    end
    object btnClose: TButton
      Left = 467
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 2
    end
    object btnHelp: TButton
      Left = 548
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      TabOrder = 3
    end
    object btnClear: TButton
      Left = 6
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1087#1086#1083#1077#1081' '#1092#1086#1088#1084#1099
      Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 0
      OnClick = btnClearClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 634
    Height = 215
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlID: TPanel
      Left = 0
      Top = 190
      Width = 634
      Height = 25
      Hint = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object lblIDCaption: TLabel
        Left = 0
        Top = 6
        Width = 123
        Height = 13
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080':'
        Transparent = False
        Layout = tlCenter
      end
      object lblPhoneID: TLabel
        Left = 129
        Top = 6
        Width = 5
        Height = 13
        Caption = '?'
        Enabled = False
        Transparent = False
      end
      object Bevel4: TBevel
        Left = 0
        Top = 0
        Width = 634
        Height = 6
        Align = alTop
        Shape = bsTopLine
        ExplicitTop = 20
        ExplicitWidth = 233
      end
    end
    object pnlModification: TPanel
      Left = 0
      Top = 165
      Width = 634
      Height = 25
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label3: TLabel
        Left = 0
        Top = 6
        Width = 111
        Height = 13
        Caption = #1050#1090#1086' '#1080' '#1082#1086#1075#1076#1072' '#1076#1086#1073#1072#1074#1080#1083':'
        Transparent = False
        Layout = tlCenter
      end
      object lblPhoneModifiedAt: TLabel
        Left = 129
        Top = 6
        Width = 5
        Height = 13
        Caption = '?'
        Enabled = False
        Transparent = False
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 634
        Height = 6
        Align = alTop
        Shape = bsTopLine
        ExplicitLeft = 1
      end
    end
    object mePhoneComments: TMemo
      Left = 0
      Top = 49
      Width = 634
      Height = 116
      Align = alClient
      MaxLength = 255
      TabOrder = 1
      WantReturns = False
      OnExit = mePhoneCommentsExit
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 634
      Height = 49
      Align = alTop
      BevelEdges = []
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        634
        49)
      object lblPhoneNumber: TLabel
        Left = 1
        Top = 0
        Width = 84
        Height = 13
        Caption = '&'#1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
        FocusControl = edbxPhoneNumber
        Transparent = False
        Layout = tlCenter
      end
      object lblPhoneType: TLabel
        Left = 166
        Top = 0
        Width = 71
        Height = 13
        Caption = '&'#1058#1080#1087' '#1090#1077#1083#1077#1092#1086#1085#1072
        FocusControl = cmbbxPhoneType
        Transparent = False
        Layout = tlCenter
      end
      object lblPhoneComments: TLabel
        Left = 1
        Top = 35
        Width = 67
        Height = 13
        Caption = '&'#1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
        FocusControl = mePhoneComments
        Transparent = False
        Layout = tlCenter
      end
      object lblPhoneCompared: TLabel
        Left = 332
        Top = 0
        Width = 37
        Height = 13
        Caption = #1057'&'#1074#1077#1088#1077#1085
        FocusControl = dtpPhoneCompared
        Transparent = False
        Layout = tlCenter
      end
      object lblPhonePriority: TLabel
        Left = 428
        Top = 0
        Width = 55
        Height = 13
        Caption = #1055'&'#1088#1080#1086#1088#1080#1090#1077#1090
        FocusControl = edbxPhonePriority
        Transparent = False
        Layout = tlCenter
      end
      object edbxPhoneNumber: TEdit
        Left = 0
        Top = 14
        Width = 160
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        OEMConvert = True
        TabOrder = 0
        OnChange = edbxPhoneNumberChange
        OnExit = edbxPhoneNumberExit
      end
      object cmbbxPhoneType: TComboBox
        Left = 166
        Top = 14
        Width = 160
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          ''
          #1089#1090#1072#1094#1080#1086#1085#1072#1088#1085#1099#1081
          #1084#1086#1073#1080#1083#1100#1085#1099#1081
          #1084#1086#1073#1080#1083#1100#1085#1099#1081' (Velcom/'#1052#1062#1057')'
          #1084#1086#1073#1080#1083#1100#1085#1099#1081' ('#1052#1058#1057')'
          #1084#1086#1073#1080#1083#1100#1085#1099#1081' (Diallog/'#1041#1077#1083#1057#1077#1083')'
          #1084#1086#1073#1080#1083#1100#1085#1099#1081' ('#1041#1077#1057#1058')')
      end
      object dtpPhoneCompared: TDateTimePicker
        Left = 332
        Top = 14
        Width = 89
        Height = 21
        Date = 2.000000000000000000
        Time = 2.000000000000000000
        TabOrder = 2
      end
      object edbxPhonePriority: TEdit
        Left = 427
        Top = 14
        Width = 56
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 3
        OEMConvert = True
        TabOrder = 3
        Text = '0'
        OnChange = edbxPhonePriorityChange
        OnEnter = edbxPhonePriorityEnter
        OnExit = edbxPhonePriorityExit
        OnKeyPress = edbxPhonePriorityKeyPress
      end
    end
  end
end
