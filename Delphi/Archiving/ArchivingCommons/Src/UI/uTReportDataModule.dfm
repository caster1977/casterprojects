object ReportDataModule: TReportDataModule
  OldCreateOrder = False
  Height = 150
  Width = 215
  object frxArchiveBoxSticker10x10: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41509.694903032400000000
    ReportOptions.LastChange = 41509.694903032400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnAfterPrintReport = frxArchiveBoxSticker10x10AfterPrintReport
    Left = 47
    Top = 6
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 100.000000000000000000
      PaperHeight = 100.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object CompanyName: TfrxMemoView
        Left = -0.000219690000000000
        Width = 340.157480310000000000
        Height = 103.937007870000000000
        GroupIndex = 1
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Shape1: TfrxShapeView
        Left = 1.889763780000000000
        Top = 1.889763780000000000
        Width = 336.377952760000000000
        Height = 100.157480310000000000
        GroupIndex = 1
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Number: TfrxMemoView
        Top = 236.220472440000000000
        Width = 340.157480310000000000
        Height = 103.937007870000000000
        GroupIndex = 4
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Shape2: TfrxShapeView
        Left = 1.889983470000000000
        Top = 238.110236220000000000
        Width = 336.377952760000000000
        Height = 100.157480310000000000
        GroupIndex = 4
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Shape3: TfrxShapeView
        Left = 1.889763780000000000
        Top = 120.421259850000000000
        Width = 100.157480310000000000
        Height = 100.157480310000000000
        GroupIndex = 3
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Shape4: TfrxShapeView
        Left = 224.882033780000000000
        Top = 120.421259850000000000
        Width = 113.385682760000000000
        Height = 100.157480310000000000
        GroupIndex = 1
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Shape5: TfrxShapeView
        Left = 113.385900000000000000
        Top = 120.421259850000000000
        Width = 100.157480310000000000
        Height = 100.157480310000000000
        GroupIndex = 2
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object TypeCode: TfrxMemoView
        Top = 118.531496070000000000
        Width = 103.937007870000000000
        Height = 103.937007870000000000
        GroupIndex = 3
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object CompanyCode: TfrxMemoView
        Left = 113.385900000000000000
        Top = 118.531496070000000000
        Width = 103.937007870000000000
        Height = 103.937007870000000000
        GroupIndex = 2
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Year: TfrxMemoView
        Left = 222.992270000000000000
        Top = 118.531496070000000000
        Width = 117.165354330000000000
        Height = 103.937007870000000000
        GroupIndex = 1
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 100.000000000000000000
      PaperHeight = 100.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object BarCode: TfrxBarCodeView
        Align = baClient
        Width = 340.067000000000000000
        Height = 340.157700000000000000
        ShowHint = False
        BarType = bcCode128C
        Rotation = 0
        Text = '050313000001'
        WideBarRatio = 2.000000000000000000
        Zoom = 3.367000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
    end
  end
  object frxArchiveBoxSticker20x10: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41509.694903032400000000
    ReportOptions.LastChange = 41509.694903032400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnAfterPrintReport = frxArchiveBoxSticker10x10AfterPrintReport
    Left = 47
    Top = 62
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 200.000000000000000000
      PaperHeight = 100.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object CompanyName: TfrxMemoView
        Left = -0.000219690000000000
        Width = 340.157480310000000000
        Height = 103.937007870000000000
        GroupIndex = 1
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Shape1: TfrxShapeView
        Left = 1.889763780000000000
        Top = 1.889763780000000000
        Width = 336.377952760000000000
        Height = 100.157480310000000000
        GroupIndex = 1
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Number: TfrxMemoView
        Top = 236.220472440000000000
        Width = 340.157480310000000000
        Height = 103.937007870000000000
        GroupIndex = 4
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Shape2: TfrxShapeView
        Left = 1.889983470000000000
        Top = 238.110236220000000000
        Width = 336.377952760000000000
        Height = 100.157480310000000000
        GroupIndex = 4
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Shape3: TfrxShapeView
        Left = 1.889763780000000000
        Top = 120.421259850000000000
        Width = 100.157480310000000000
        Height = 100.157480310000000000
        GroupIndex = 3
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Shape4: TfrxShapeView
        Left = 224.882033780000000000
        Top = 120.421259850000000000
        Width = 113.385682760000000000
        Height = 100.157480310000000000
        GroupIndex = 1
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object Shape5: TfrxShapeView
        Left = 113.385900000000000000
        Top = 120.421259850000000000
        Width = 100.157480310000000000
        Height = 100.157480310000000000
        GroupIndex = 2
        ShowHint = False
        Frame.Width = 5.000000000000000000
      end
      object TypeCode: TfrxMemoView
        Top = 118.531496070000000000
        Width = 103.937007870000000000
        Height = 103.937007870000000000
        GroupIndex = 3
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object CompanyCode: TfrxMemoView
        Left = 113.385900000000000000
        Top = 118.531496070000000000
        Width = 103.937007870000000000
        Height = 103.937007870000000000
        GroupIndex = 2
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Year: TfrxMemoView
        Left = 222.992270000000000000
        Top = 118.531496070000000000
        Width = 117.165354330000000000
        Height = 103.937007870000000000
        GroupIndex = 1
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object BarCode: TfrxBarCodeView
        Align = baRight
        Left = 378.043700000000000000
        Width = 340.067000000000000000
        Height = 340.157700000000000000
        ShowHint = False
        BarType = bcCode128C
        Rotation = 0
        Text = '050313000001'
        WideBarRatio = 2.000000000000000000
        Zoom = 3.367000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
    end
  end
end
