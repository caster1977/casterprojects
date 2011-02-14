object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TaxiQueue 1.11'
  ClientHeight = 546
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar2: TStatusBar
    Left = 0
    Top = 0
    Width = 792
    Height = 19
    Align = alTop
    Panels = <
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Alignment = taCenter
        Width = 100
      end
      item
        Style = psOwnerDraw
        Width = 200
      end
      item
        Width = 50
      end>
    SizeGrip = False
    OnDrawPanel = StatusBar2DrawPanel
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 19
    Width = 792
    Height = 19
    Align = alTop
    Panels = <
      item
        Style = psOwnerDraw
        Width = 50
      end>
    SizeGrip = False
    OnDrawPanel = StatusBar1DrawPanel
  end
  object Panel1: TPanel
    Left = 0
    Top = 38
    Width = 792
    Height = 508
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object StringGrid1: TStringGrid
      Left = 0
      Top = 0
      Width = 792
      Height = 508
      Align = alClient
      ColCount = 7
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -7
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = StringGrid1DrawCell
      OnKeyPress = StringGrid1KeyPress
      OnSelectCell = StringGrid1SelectCell
      ColWidths = (
        213
        45
        524
        64
        64
        64
        64)
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 95
    object N1: TMenuItem
      Caption = #1056#1072#1079#1085#1086#1077
      object N3: TMenuItem
        Action = Action_Login
      end
      object N4: TMenuItem
        Action = Action_Logoff
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object N6: TMenuItem
        Action = Action_About
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N8: TMenuItem
        Action = Action_Quit
      end
    end
    object N2: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      object N9: TMenuItem
        Action = Action_Logbook
      end
    end
  end
  object ActionManager1: TActionManager
    Left = 145
    Top = 250
    StyleName = 'XP Style'
    object Action_Login: TAction
      Caption = #1055#1088#1080#1089#1090#1091#1087#1080#1090#1100' '#1082' '#1088#1072#1073#1086#1090#1077
      ShortCut = 119
      OnExecute = Action_LoginExecute
    end
    object Action_Logoff: TAction
      Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1088#1072#1073#1086#1090#1091
      ShortCut = 16503
      OnExecute = Action_LogoffExecute
    end
    object Action_About: TAction
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ShortCut = 49344
      OnExecute = Action_AboutExecute
    end
    object Action_Quit: TAction
      Caption = #1042#1099#1093#1086#1076
      ShortCut = 32856
      OnExecute = Action_QuitExecute
    end
    object Action_Logbook: TAction
      Caption = #1046#1091#1088#1085#1072#1083
      ShortCut = 118
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 75
    Top = 95
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer2Timer
    Left = 110
    Top = 95
  end
  object ImageList1: TImageList
    Height = 15
    Width = 1
    Left = 145
    Top = 220
  end
end
