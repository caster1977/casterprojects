object Form1: TForm1
  Left = 0
  Top = 0
  BorderWidth = 6
  Caption = 'Form1'
  ClientHeight = 285
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 252
    Width = 460
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MaxHeight = 33
    Constraints.MinHeight = 33
    TabOrder = 0
    ExplicitTop = 258
    object btnApply: TButton
      Left = 300
      Top = 8
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'btnApply'
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 381
      Top = 8
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'btnCancel'
      TabOrder = 1
    end
    object btnClear: TButton
      Left = 0
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'btnClear'
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 460
    Height = 111
    Align = alTop
    BevelOuter = bvNone
    Constraints.MaxHeight = 111
    Constraints.MinHeight = 111
    TabOrder = 1
    ExplicitWidth = 456
    DesignSize = (
      460
      111)
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 36
      Height = 13
      Caption = #1043#1088#1091#1087#1087#1072
    end
    object Label2: TLabel
      Left = 0
      Top = 46
      Width = 73
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 0
      Top = 92
      Width = 72
      Height = 13
      Caption = #1058#1077#1082#1089#1090' '#1079#1072#1087#1088#1086#1089#1072
    end
    object ComboBox1: TComboBox
      Left = 0
      Top = 19
      Width = 460
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'ComboBox1'
      ExplicitWidth = 456
    end
    object ComboBox2: TComboBox
      Left = 0
      Top = 65
      Width = 460
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'ComboBox1'
      ExplicitWidth = 456
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 111
    Width = 460
    Height = 141
    Align = alClient
    TabOrder = 2
    WantTabs = True
    WordWrap = False
    ExplicitWidth = 456
    ExplicitHeight = 137
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 16
    Top = 200
  end
  object ImageList: TImageList
    Left = 72
    Top = 200
  end
end
