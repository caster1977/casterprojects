object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'SysMenuTest'
  ClientHeight = 202
  ClientWidth = 331
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
  object CheckBox1: TCheckBox
    Left = 8
    Top = 184
    Width = 113
    Height = 17
    Caption = #1052#1077#1085#1102' '#1076#1086#1073#1072#1074#1083#1077#1085#1086
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object PopupMenu1: TPopupMenu
    Left = 8
    Top = 8
    object N3: TMenuItem
      Caption = '-'
    end
    object Options1: TMenuItem
      Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1080'...'
      OnClick = Options1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object About1: TMenuItem
      Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      OnClick = About1Click
    end
  end
  object fisSysMenu1: TfisSysMenu
    Menu = PopupMenu1
    Left = 40
    Top = 8
  end
end
