object Form3: TForm3
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = 'Form3'
  ClientHeight = 233
  ClientWidth = 470
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 470
    Height = 105
    Align = alTop
    Caption = 'GroupBox1'
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 105
    Width = 470
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 202
    Width = 470
    Height = 31
    Align = alTop
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      470
      29)
    object Button1: TButton
      Left = 336
      Top = 2
      Width = 134
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Delete Last Document'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 0
      Top = 2
      Width = 134
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Create Document in GB'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 140
      Top = 2
      Width = 134
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Create Document in Panel'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
end
