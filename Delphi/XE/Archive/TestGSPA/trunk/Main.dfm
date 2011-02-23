object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TestGSPA'
  ClientHeight = 104
  ClientWidth = 232
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 104
    Align = alLeft
    TabOrder = 0
    object btnGetProsessAffinity: TButton
      Left = 6
      Top = 8
      Width = 115
      Height = 25
      Caption = 'Get Process Affinity'
      Default = True
      TabOrder = 0
      OnClick = btnGetProsessAffinityClick
    end
    object btnExit: TButton
      Left = 6
      Top = 72
      Width = 115
      Height = 25
      Caption = 'Exit'
      TabOrder = 2
      OnClick = btnExitClick
    end
    object btnSetProsessAffinity: TButton
      Left = 6
      Top = 40
      Width = 115
      Height = 25
      Caption = 'Set Process Affinity'
      Enabled = False
      TabOrder = 1
      OnClick = btnSetProsessAffinityClick
    end
  end
  object cbProcessor1: TCheckBox
    Left = 136
    Top = 8
    Width = 89
    Height = 17
    Caption = 'Processor #1'
    Enabled = False
    TabOrder = 1
  end
  object cbProcessor2: TCheckBox
    Left = 136
    Top = 32
    Width = 89
    Height = 17
    Caption = 'Processor #2'
    Enabled = False
    TabOrder = 2
  end
  object cbProcessor3: TCheckBox
    Left = 136
    Top = 56
    Width = 89
    Height = 17
    Caption = 'Processor #3'
    Enabled = False
    TabOrder = 3
  end
  object cbProcessor4: TCheckBox
    Left = 136
    Top = 80
    Width = 89
    Height = 17
    Caption = 'Processor #4'
    Enabled = False
    TabOrder = 4
  end
end
