object FindGUIDForm: TFindGUIDForm
  Left = 0
  Top = 0
  ActiveControl = edbxGUID
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = #1055#1086#1080#1089#1082' GUID'
  ClientHeight = 105
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
    105)
  PixelsPerInch = 96
  TextHeight = 13
  object lblGUID: TLabel
    Left = 0
    Top = 3
    Width = 75
    Height = 13
    Caption = '&'#1042#1074#1077#1076#1080#1090#1077' GUID:'
    FocusControl = edbxGUID
  end
  object lblSearchDirecton: TLabel
    Left = 0
    Top = 28
    Width = 109
    Height = 13
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1080#1089#1082#1072':'
    FocusControl = edbxGUID
  end
  object Bevel2: TBevel
    Left = 0
    Top = 73
    Width = 282
    Height = 32
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 56
  end
  object edbxGUID: TEdit
    Left = 81
    Top = 0
    Width = 201
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 38
    TabOrder = 0
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1080#1089#1082#1086#1084#1091#1102' '#1089#1090#1088#1086#1082#1091' GUID...'
    OnChange = FieldsChange
  end
  object rbSearchUpward: TRadioButton
    Left = 163
    Top = 27
    Width = 50
    Height = 17
    Caption = #1074#1074'&'#1077#1088#1093
    TabOrder = 2
  end
  object rbSearchDownward: TRadioButton
    Left = 115
    Top = 27
    Width = 42
    Height = 17
    Caption = #1074#1085'&'#1080#1079
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object cbFromCursor: TCheckBox
    Left = 0
    Top = 50
    Width = 282
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = ' &'#1055#1086#1080#1089#1082' '#1086#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072
    TabOrder = 3
  end
  object btnClose: TButton
    Left = 201
    Top = 80
    Width = 81
    Height = 25
    Cursor = crHandPoint
    Action = Action_Close
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 4
  end
  object btnFind: TButton
    Left = 114
    Top = 80
    Width = 81
    Height = 25
    Cursor = crHandPoint
    Action = Action_Find
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object btnHelp: TButton
    Left = 0
    Top = 80
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Help
    Anchors = [akLeft, akBottom]
    TabOrder = 6
  end
  object ActionManager1: TActionManager
    Left = 232
    Top = 24
    StyleName = 'Platform Default'
    object Action_Find: TAction
      Caption = '&'#1048#1089#1082#1072#1090#1100
      OnExecute = Action_FindExecute
    end
    object Action_Help: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      OnExecute = Action_HelpExecute
    end
    object Action_Close: TAction
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      OnExecute = Action_CloseExecute
    end
  end
end
