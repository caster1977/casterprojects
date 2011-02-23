object TimedBanForm: TTimedBanForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1088#1077#1084#1077#1085#1085#1099#1081' '#1079#1072#1087#1088#1077#1090' '#1088#1072#1073#1086#1090#1099
  ClientHeight = 404
  ClientWidth = 592
  Color = clBtnFace
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
  object Label1: TLabel
    Left = 3
    Top = 58
    Width = 62
    Height = 13
    Caption = 'F2: '#1055#1088#1080#1095#1080#1085#1072
  end
  object Label2: TLabel
    Left = 3
    Top = 4
    Width = 92
    Height = 13
    Caption = 'F1: '#1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
  end
  object Label3: TLabel
    Left = 45
    Top = 35
    Width = 29
    Height = 13
    Caption = #1095#1072#1089#1086#1074
  end
  object Button1: TButton
    Left = 429
    Top = 373
    Width = 75
    Height = 25
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 510
    Top = 373
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object StringGrid1: TStringGrid
    Left = 1
    Top = 77
    Width = 585
    Height = 290
    ColCount = 1
    DefaultRowHeight = 16
    FixedCols = 0
    RowCount = 40
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
    TabOrder = 2
    ColWidths = (
      563)
  end
  object Edit1: TEdit
    Left = 1
    Top = 27
    Width = 35
    Height = 21
    TabOrder = 3
    Text = '0'
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
end
