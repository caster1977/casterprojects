inherited frmProductType: TfrmProductType
  ClientHeight = 119
  ExplicitWidth = 400
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvl1: TBevel
    Top = 83
    ExplicitTop = 83
  end
  inherited pnlButtons: TPanel
    Top = 94
    TabOrder = 3
    ExplicitTop = 94
    inherited pbProgress: TcxProgressBar
      ExplicitHeight = 23
    end
  end
  object cxlblName: TcxLabel [2]
    AlignWithMargins = True
    Left = 3
    Top = 6
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    FocusControl = edtName
  end
  object edtName: TcxTextEdit [3]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Align = alTop
    Properties.OnChange = edtNamePropertiesChange
    Properties.OnEditValueChanged = edtNamePropertiesEditValueChanged
    TabOrder = 0
    Width = 376
  end
  object chkActivity: TcxCheckBox [4]
    AlignWithMargins = True
    Left = 3
    Top = 59
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
    Properties.OnChange = chkActivityPropertiesChange
    Properties.OnEditValueChanged = chkActivityPropertiesEditValueChanged
    TabOrder = 1
    Width = 376
  end
end
