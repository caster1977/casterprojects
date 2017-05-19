object AboutForm: TAboutForm
  Left = 0
  Top = 0
  Hint = #1054#1082#1085#1086' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  AlphaBlend = True
  AlphaBlendValue = 222
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'About "DBAutoTest"...'
  ClientHeight = 240
  ClientWidth = 347
  Color = clSilver
  TransparentColor = True
  TransparentColorValue = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape: TShape
    Left = 0
    Top = 0
    Width = 347
    Height = 240
    Align = alClient
    Pen.Color = clInactiveCaptionText
    Pen.Width = 4
    Shape = stEllipse
    ExplicitTop = -8
  end
  object lblEMail: TLabel
    Left = 98
    Top = 167
    Width = 32
    Height = 13
    Caption = 'E-Mail:'
    Transparent = True
  end
  object lblEMailAddress: TLabel
    Left = 136
    Top = 166
    Width = 110
    Height = 15
    Cursor = crHandPoint
    Hint = #1053#1072#1078#1084#1080#1090#1077' '#1085#1072' '#1089#1089#1099#1083#1082#1091', '#1095#1090#1086#1073#1099' '#1085#1072#1087#1080#1089#1072#1090#1100' '#1087#1080#1089#1100#1084#1086' '#1072#1074#1090#1086#1088#1091
    Caption = 'support@shate-m.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
    OnClick = lblEMailAddressClick
  end
  object lblLegalCopyright: TLabel
    Left = 14
    Top = 133
    Width = 320
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblVersion: TLabel
    Left = 14
    Top = 112
    Width = 320
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object imgApplicationIcon: TImage
    Left = 157
    Top = 47
    Width = 32
    Height = 32
    AutoSize = True
    Transparent = True
  end
  object lblTitle: TLabel
    Left = 14
    Top = 88
    Width = 320
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 0
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlBottom
    WordWrap = True
  end
  object btnClose: TButton
    Left = 133
    Top = 191
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = actClose
    Cancel = True
    Default = True
    TabOrder = 0
  end
  object CloseTimer: TTimer
    Interval = 3000
    OnTimer = CloseTimerTimer
    Left = 312
    Top = 208
  end
  object FadeTimer: TTimer
    Interval = 5
    OnTimer = FadeTimerTimer
    Left = 312
    Top = 8
  end
  object ActionList: TActionList
    Left = 8
    Top = 208
    object actClose: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = actCloseExecute
    end
  end
  object GSFileVersionInfo: TGSFileVersionInfo
    Left = 280
    Top = 208
  end
end
