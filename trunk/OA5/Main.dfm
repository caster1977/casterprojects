object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'OA5'
  ClientHeight = 710
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 690
    Width = 1008
    Height = 20
    Hint = #1055#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Panels = <
      item
        Alignment = taCenter
        Width = 20
      end
      item
        Alignment = taCenter
        Width = 100
      end
      item
        Alignment = taCenter
        Width = 0
      end
      item
        Width = 50
      end>
    ExplicitTop = 691
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 192
    object N1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
    end
    object N2: TMenuItem
      Caption = '&'#1044#1077#1081#1089#1090#1074#1080#1103
    end
    object N3: TMenuItem
      Caption = '&'#1042#1080#1076
    end
    object N4: TMenuItem
      Caption = '&?'
    end
  end
  object ActionManager1: TActionManager
    Left = 48
    Top = 192
    StyleName = 'Platform Default'
  end
end
