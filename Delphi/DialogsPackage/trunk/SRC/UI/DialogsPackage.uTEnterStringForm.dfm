object EnterStringForm: TEnterStringForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  ClientHeight = 81
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  DesignSize = (
    284
    81)
  PixelsPerInch = 96
  TextHeight = 13
  object lblValue: TLabel
    Left = 0
    Top = 3
    Width = 3
    Height = 13
    FocusControl = edtValue
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 49
    Width = 284
    Height = 32
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      284
      30)
    object btnHelp: TButton
      Left = 0
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      TabOrder = 0
    end
    object btnApply: TButton
      Left = 116
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actApply
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btnClose: TButton
      Left = 203
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actClose
      Anchors = [akTop, akRight]
      Cancel = True
      Default = True
      TabOrder = 2
    end
  end
  object edtValue: TEdit
    Left = 0
    Top = 22
    Width = 284
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 240
    object actApply: TAction
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1055#1088#1080#1084#1077#1085#1077#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1081'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actApplyExecute
      OnUpdate = actApplyUpdate
    end
    object actClose: TAction
      Caption = '&'#1054#1090#1084#1077#1085#1072
      Hint = 
        #1054#1090#1084#1077#1085#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1081'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080' '#1079#1072#1082#1088#1099#1090 +
        #1080#1103' '#1086#1082#1085#1072
      OnExecute = actCloseExecute
    end
    object actHelp: TAction
      Caption = #1057'&'#1087#1088#1072#1074#1082#1072
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1088#1072#1074#1082#1091'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1089#1087#1088#1072#1074#1086#1095#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 0
      OnExecute = actHelpExecute
      OnUpdate = actHelpUpdate
    end
  end
  object ImageList: TImageList
    Left = 192
  end
end
