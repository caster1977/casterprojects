object BanReasonForm: TBanReasonForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1088#1080#1095#1080#1085#1072' '#1079#1072#1087#1088#1077#1090#1072
  ClientHeight = 259
  ClientWidth = 256
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
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 256
    Height = 259
    Align = alClient
    ColCount = 1
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 40
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRangeSelect, goDrawFocusSelected]
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnKeyPress = StringGrid1KeyPress
    ExplicitWidth = 254
    ExplicitHeight = 257
    ColWidths = (
      235)
  end
end
