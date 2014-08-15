object frmRB: TfrmRB
  Left = 152
  Top = 145
  Width = 771
  Height = 401
  Caption = 'Gnostice eDocEngine - ReportBuilder Interface Demo'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 763
    Height = 57
    Align = alTop
    TabOrder = 0
    object btnLoadFile: TButton
      Left = 16
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Load RAF File...'
      TabOrder = 0
      OnClick = btnLoadFileClick
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
    Width = 763
    Height = 310
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object ppViewer1: TppViewer
      Left = 0
      Top = 0
      Width = 763
      Height = 310
      Align = alClient
      PageColor = clWindow
      Report = ppArchiveReader1
      ZoomPercentage = 100
      ZoomSetting = zsWholePage
    end
  end
  object btnNextPage: TButton
    Left = 259
    Top = 16
    Width = 110
    Height = 25
    Caption = 'Next Page'
    TabOrder = 2
    OnClick = btnNextPageClick
  end
  object btnPrevPage: TButton
    Left = 380
    Top = 16
    Width = 112
    Height = 25
    Caption = 'Previous Page'
    TabOrder = 3
    OnClick = btnPrevPageClick
  end
  object OpenDialog1: TOpenDialog
    Filter = 'RAF Files (*.raf) | *.raf'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 597
    Top = 336
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 629
    Top = 336
  end
  object gtRBExportInterface1: TgtRBExportInterface
    DoBeginDoc = True
    DoEndDoc = True
    Left = 662
    Top = 336
  end
  object gtDocSettings1: TgtDocSettings
    BackgroundImageDisplayType = dtCenter
    MeasurementUnit = muPixels
    Page.Width = 793.6992
    Page.Height = 1122.5184
    Page.BinNumber = 0
    Left = 695
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    FontEncoding = feWinAnsiEncoding
    Left = 8
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.GraphicDataInBinary = False
    DocumentEncodingType = etPositionalAccuracy
    Left = 40
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    TOCPageSettings.ItemFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.ItemFont.Color = clWindowText
    TOCPageSettings.ItemFont.Height = -10
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -10
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 73
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    TOCPageSettings.ItemFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.ItemFont.Color = clWindowText
    TOCPageSettings.ItemFont.Height = -10
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -10
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 106
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    ImageSettings.SourceDPI = 86
    ImageSettings.OutputImageFormat = ifMetafile
    Left = 138
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    PageEndLines = True
    ColumnSpacing = 1
    Left = 171
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 204
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 237
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 269
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 302
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 433
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 466
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 498
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 531
    Top = 336
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
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 564
    Top = 336
  end
  object ppArchiveReader1: TppArchiveReader
    DeviceType = 'Screen'
    SuppressOutline = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 728
    Top = 336
    Version = '7.04'
  end
end
