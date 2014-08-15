object frmFR: TfrmFR
  Left = 229
  Top = 186
  Width = 690
  Height = 490
  Caption = 'Gnostice eDocEngine - FastReport Interface Demo'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 57
    Align = alTop
    TabOrder = 0
    object btnLoadfile: TButton
      Left = 16
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Load FRP File...'
      TabOrder = 0
      OnClick = btnLoadfileClick
    end
    object btnExportfile: TButton
      Left = 138
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Export Report...'
      TabOrder = 1
      OnClick = btnExportfileClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 682
    Height = 406
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object frPreview1: TfrPreview
      Left = 1
      Top = 1
      Width = 680
      Height = 404
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      ScrollBars = ssBoth
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'FRP Files (*.frp) | *.frp'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 648
    Top = 426
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 386
    Top = 426
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    Preview = frPreview1
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 618
    Top = 426
    ReportForm = {19000000}
  end
  object gtFRFilter: TgtFRExportInterface
    DoBeginDoc = True
    DoEndDoc = True
    Left = 589
    Top = 426
  end
  object gtDocSettings1: TgtDocSettings
    BackgroundImageDisplayType = dtCenter
    MeasurementUnit = muPixels
    Page.Width = 801.36
    Page.Height = 1133.3472
    Page.BinNumber = 0
    Left = 531
    Top = 426
  end
  object gtPDFEngine1: TgtPDFEngine
    FileExtension = 'pdf'
    FileDescription = 'Adobe PDF Files'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    FontEncoding = feWinAnsiEncoding
    Left = 9
    Top = 426
  end
  object gtRTFEngine1: TgtRTFEngine
    FileExtension = 'rtf'
    FileDescription = 'Rich Text Format'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.GraphicDataInBinary = False
    DocumentEncodingType = etPositionalAccuracy
    Left = 38
    Top = 426
  end
  object gtHTMLEngine1: TgtHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'HyperText Markup Language'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    Left = 67
    Top = 426
  end
  object gtXHTMLEngine1: TgtXHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'Extended HyperText Markup Language'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    Left = 96
    Top = 426
  end
  object gtExcelEngine1: TgtExcelEngine
    FileExtension = 'xls'
    FileDescription = 'Microsoft Excel Workbook'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText, irImage]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 125
    Top = 426
  end
  object gtTextEngine1: TgtTextEngine
    FileExtension = 'txt'
    FileDescription = 'Text Document'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -11
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    PageEndLines = True
    ColumnSpacing = 1
    Left = 154
    Top = 426
  end
  object gtQuattroProEngine1: TgtQuattroProEngine
    FileExtension = 'wb1'
    FileDescription = 'Quattro Pro for Windows'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 183
    Top = 426
  end
  object gtLotusEngine1: TgtLotusEngine
    FileExtension = 'WK1'
    FileDescription = 'Lotus 1-2-3'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 212
    Top = 426
  end
  object gtDIFEngine1: TgtDIFEngine
    FileExtension = 'DIF'
    FileDescription = 'Data Interchange Format'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 241
    Top = 426
  end
  object gtSYLKEngine1: TgtSYLKEngine
    FileExtension = 'slk'
    FileDescription = 'Symbolic Link'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 270
    Top = 426
  end
  object gtJPEGEngine1: TgtJPEGEngine
    FileExtension = 'jpg'
    FileDescription = 'JPEG File Interchange Format'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 415
    Top = 426
  end
  object gtGIFEngine1: TgtGIFEngine
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 444
    Top = 426
  end
  object gtBMPEngine1: TgtBMPEngine
    FileExtension = 'bmp'
    FileDescription = 'Windows Bitmap'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 473
    Top = 426
  end
  object gtEMFEngine1: TgtEMFEngine
    FileExtension = 'emf'
    FileDescription = 'Enhanced Metafiles'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 502
    Top = 426
  end
  object gtWMFEngine1: TgtWMFEngine
    FileExtension = 'wmf'
    FileDescription = 'Windows Metafiles'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.3475
    Page.Height = 11.8057
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 560
    Top = 426
  end
end
