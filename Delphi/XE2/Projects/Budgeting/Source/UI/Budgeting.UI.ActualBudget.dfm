inherited frmActualBudget: TfrmActualBudget
  ClientHeight = 515
  ExplicitWidth = 400
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvl1: TBevel
    Top = 479
  end
  inherited pnlButtons: TPanel
    Top = 490
    TabOrder = 18
    inherited pbProgress: TcxProgressBar
      ExplicitHeight = 23
    end
  end
  object cxlblBudgetItem: TcxLabel [2]
    AlignWithMargins = True
    Left = 3
    Top = 6
    Margins.Top = 6
    Align = alTop
    Caption = #1057'&'#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072':'
    FocusControl = cbbBudgetItem
  end
  object cbbBudgetItem: TcxComboBox [3]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbBudgetItemPropertiesEditValueChanged
    TabOrder = 1
    ExplicitLeft = 8
    Width = 376
  end
  object cxlblDocument: TcxLabel [4]
    AlignWithMargins = True
    Left = 3
    Top = 271
    Margins.Top = 6
    Align = alTop
    Caption = #1054#1087'&'#1088#1072#1074#1076#1072#1090#1077#1083#1100#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090':'
    FocusControl = edtDocument
    ExplicitTop = 59
  end
  object edtDocument: TcxTextEdit [5]
    AlignWithMargins = True
    Left = 3
    Top = 294
    Align = alTop
    Properties.OnChange = edtDocumentPropertiesChange
    Properties.OnEditValueChanged = edtDocumentPropertiesEditValueChanged
    TabOrder = 11
    ExplicitTop = 82
    Width = 376
  end
  object cxlblDescription: TcxLabel [6]
    AlignWithMargins = True
    Left = 3
    Top = 377
    Margins.Top = 6
    Align = alTop
    Caption = #1054'&'#1087#1080#1089#1072#1085#1080#1077':'
    FocusControl = edtDescription
    ExplicitTop = 112
  end
  object edtDescription: TcxTextEdit [7]
    AlignWithMargins = True
    Left = 3
    Top = 400
    Align = alTop
    Properties.OnChange = edtDescriptionPropertiesChange
    Properties.OnEditValueChanged = edtDescriptionPropertiesEditValueChanged
    TabOrder = 15
    ExplicitTop = 135
    Width = 376
  end
  object cxlblAccountingCenter: TcxLabel [8]
    AlignWithMargins = True
    Left = 3
    Top = 59
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1062#1077#1085#1090#1088' '#1092#1080#1085#1072#1085#1089#1086#1074#1086#1081' '#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080':'
    FocusControl = cbbAccountingCenter
    ExplicitLeft = 11
    ExplicitTop = 14
    ExplicitWidth = 7
  end
  object cbbAccountingCenter: TcxComboBox [9]
    AlignWithMargins = True
    Left = 3
    Top = 82
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbAccountingCenterPropertiesEditValueChanged
    TabOrder = 3
    ExplicitLeft = 6
    ExplicitTop = 37
    Width = 376
  end
  object cxlblCosignatory: TcxLabel [10]
    AlignWithMargins = True
    Left = 3
    Top = 112
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1050#1086#1085#1090#1088#1072#1075#1077#1085#1090':'
    FocusControl = cbbCosignatory
    ExplicitLeft = 8
    ExplicitTop = 160
  end
  object cbbCosignatory: TcxComboBox [11]
    AlignWithMargins = True
    Left = 3
    Top = 135
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbCosignatoryPropertiesEditValueChanged
    TabOrder = 5
    ExplicitLeft = 8
    ExplicitTop = 161
    Width = 376
  end
  object cxlblProduct: TcxLabel [12]
    AlignWithMargins = True
    Left = 3
    Top = 165
    Margins.Top = 6
    Align = alTop
    Caption = #1058#1086'&'#1074#1072#1088':'
    FocusControl = cbbProduct
    ExplicitLeft = 27
    ExplicitTop = 218
  end
  object cbbProduct: TcxComboBox [13]
    AlignWithMargins = True
    Left = 3
    Top = 188
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbProductPropertiesEditValueChanged
    TabOrder = 7
    ExplicitLeft = 19
    ExplicitTop = 208
    Width = 376
  end
  object cxlblCurrency: TcxLabel [14]
    AlignWithMargins = True
    Left = 3
    Top = 218
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1042#1072#1083#1102#1090#1072':'
    FocusControl = cbbCurrency
    ExplicitLeft = 19
    ExplicitTop = 264
  end
  object cbbCurrency: TcxComboBox [15]
    AlignWithMargins = True
    Left = 3
    Top = 241
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbCurrencyPropertiesEditValueChanged
    TabOrder = 9
    ExplicitLeft = 8
    ExplicitTop = 256
    Width = 376
  end
  object pnlDocumentDate: TPanel [16]
    AlignWithMargins = True
    Left = 3
    Top = 347
    Width = 376
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 13
    ExplicitLeft = -2
    object deDocumentDate: TcxDateEdit
      Left = 0
      Top = 0
      Align = alLeft
      Properties.DisplayFormat = 'dd.mm.yyyy'
      Properties.EditFormat = 'dd.mm.yyyy'
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.OnChange = deDocumentDatePropertiesChange
      Properties.OnEditValueChanged = deDocumentDatePropertiesEditValueChanged
      TabOrder = 0
      ExplicitLeft = 24
      ExplicitTop = 8
      Width = 121
    end
  end
  object cxlblDocumentDate: TcxLabel [17]
    AlignWithMargins = True
    Left = 3
    Top = 324
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1044#1072#1090#1072' '#1086#1087#1088#1072#1074#1076#1072#1090#1077#1083#1100#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
    FocusControl = deDocumentDate
    ExplicitLeft = 19
    ExplicitTop = 337
  end
  object cxlblAmount: TcxLabel [18]
    AlignWithMargins = True
    Left = 3
    Top = 430
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1057#1091#1084#1084#1072':'
    FocusControl = edtDescription
    ExplicitLeft = -2
  end
  object pnlAmount: TPanel [19]
    AlignWithMargins = True
    Left = 3
    Top = 453
    Width = 376
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 17
    ExplicitLeft = -29
    ExplicitTop = 470
    object cxcrncydtAmount: TcxCurrencyEdit
      Left = 0
      Top = 0
      Align = alLeft
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.OnChange = cxcrncydtAmountPropertiesChange
      Properties.OnEditValueChanged = cxcrncydtAmountPropertiesEditValueChanged
      TabOrder = 0
      Width = 121
    end
  end
end
