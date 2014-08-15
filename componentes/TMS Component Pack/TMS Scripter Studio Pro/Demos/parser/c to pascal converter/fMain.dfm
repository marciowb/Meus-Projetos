object Form1: TForm1
  Left = 187
  Top = 110
  Width = 798
  Height = 606
  Caption = 'SQL Parser demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 29
    Width = 790
    Height = 523
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 0
      Top = 372
      Width = 790
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object Panel4: TPanel
      Left = 0
      Top = 375
      Width = 790
      Height = 148
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel4'
      TabOrder = 0
      object mmResult: TMemo
        Left = 0
        Top = 0
        Width = 790
        Height = 148
        Align = alClient
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 790
      Height = 372
      ActivePage = tsGrammar
      Align = alClient
      TabOrder = 1
      object tsSource: TTabSheet
        Caption = 'C++ source code (.cpp)'
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 344
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          TabOrder = 0
          object AdvMemo1: TAdvMemo
            Left = 0
            Top = 0
            Width = 782
            Height = 344
            Cursor = crIBeam
            ActiveLineSettings.ShowActiveLine = False
            ActiveLineSettings.ShowActiveLineIndicator = False
            Align = alClient
            AutoCompletion.Font.Charset = DEFAULT_CHARSET
            AutoCompletion.Font.Color = clWindowText
            AutoCompletion.Font.Height = -11
            AutoCompletion.Font.Name = 'MS Sans Serif'
            AutoCompletion.Font.Style = []
            AutoCorrect.Active = True
            AutoHintParameterPosition = hpBelowCode
            BorderStyle = bsSingle
            CodeFolding.Enabled = False
            CodeFolding.LineColor = clGray
            Ctl3D = False
            DelErase = True
            EnhancedHomeKey = False
            Gutter.DigitCount = 4
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -13
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'COURIER NEW'
            Font.Style = []
            HiddenCaret = False
            Lines.Strings = (
              'How to use this demo:'
              ''
              '1. Open a .cpp file using menu option "File | Open C++ file...";'
              '2. The respective .h file will be loaded automatically;'
              
                '3. Hit F9 to parse and convert the .cpp and .h files into a .pas' +
                ' file.'
              ''
              'Extra info:'
              
                'a) The grammar used to parse the C++ files is displayed in "Gram' +
                'mar" tab.'
              
                '   You can change it and see what happens when parsing is done, ' +
                'but WARNING:'
              
                '   just do small changes to it to test, you might experience Acc' +
                'ess Violations'
              
                '   and Index out of Bounds if you change it too much. For a more' +
                ' accurated'
              '   change in grammar, see the source code of this demo.'
              
                'b) The token structure of parsed file is displayed in "Syntax tr' +
                'ee" tab.'
              ''
              ''
              
                'You can use the .cpp and .h sample files provided in the "source' +
                's" folder.'
              ''
              
                'This demo is not intended to be a fully functional C++ to Pascal' +
                ' converter.'
              'The intention is to demonstrate all the power and flexibility of'
              
                'TatSyntaxParser component provided with TMS Scripter Studio pack' +
                'age.'
              ''
              'More information at http://www.tmssoftware.com site.')
            MarkerList.UseDefaultMarkerImageIndex = False
            MarkerList.DefaultMarkerImageIndex = -1
            MarkerList.ImageTransparentColor = 33554432
            PrintOptions.MarginLeft = 0
            PrintOptions.MarginRight = 0
            PrintOptions.MarginTop = 0
            PrintOptions.MarginBottom = 0
            PrintOptions.PageNr = False
            PrintOptions.PrintLineNumbers = False
            RightMarginColor = 14869218
            ScrollHint = False
            SelColor = clWhite
            SelBkColor = clNavy
            ShowRightMargin = True
            SmartTabs = False
            TabOrder = 0
            TabSize = 4
            TabStop = True
            TrimTrailingSpaces = False
            UndoLimit = 100
            UrlAware = False
            UrlStyle.TextColor = clBlue
            UrlStyle.BkColor = clWhite
            UrlStyle.Style = [fsUnderline]
            UseStyler = True
            Version = '2.1.6.0'
            WordWrap = wwNone
          end
        end
      end
      object tsInclude: TTabSheet
        Caption = 'C++ include (.h)'
        ImageIndex = 3
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 344
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          TabOrder = 0
          object AdvMemo2: TAdvMemo
            Left = 0
            Top = 0
            Width = 782
            Height = 344
            Cursor = crIBeam
            ActiveLineSettings.ShowActiveLine = False
            ActiveLineSettings.ShowActiveLineIndicator = False
            Align = alClient
            AutoCompletion.Font.Charset = DEFAULT_CHARSET
            AutoCompletion.Font.Color = clWindowText
            AutoCompletion.Font.Height = -11
            AutoCompletion.Font.Name = 'MS Sans Serif'
            AutoCompletion.Font.Style = []
            AutoCorrect.Active = True
            AutoHintParameterPosition = hpBelowCode
            BorderStyle = bsSingle
            CodeFolding.Enabled = False
            CodeFolding.LineColor = clGray
            Ctl3D = False
            DelErase = True
            EnhancedHomeKey = False
            Gutter.DigitCount = 4
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -13
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'COURIER NEW'
            Font.Style = []
            HiddenCaret = False
            Lines.Strings = (
              '')
            MarkerList.UseDefaultMarkerImageIndex = False
            MarkerList.DefaultMarkerImageIndex = -1
            MarkerList.ImageTransparentColor = 33554432
            PrintOptions.MarginLeft = 0
            PrintOptions.MarginRight = 0
            PrintOptions.MarginTop = 0
            PrintOptions.MarginBottom = 0
            PrintOptions.PageNr = False
            PrintOptions.PrintLineNumbers = False
            RightMarginColor = 14869218
            ScrollHint = False
            SelColor = clWhite
            SelBkColor = clNavy
            ShowRightMargin = True
            SmartTabs = False
            TabOrder = 0
            TabSize = 4
            TabStop = True
            TrimTrailingSpaces = False
            UndoLimit = 100
            UrlStyle.TextColor = clBlue
            UrlStyle.BkColor = clWhite
            UrlStyle.Style = [fsUnderline]
            UseStyler = True
            Version = '2.1.6.0'
            WordWrap = wwNone
          end
        end
      end
      object tsConverted: TTabSheet
        Caption = 'Converted Pascal source'
        ImageIndex = 1
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 344
          Align = alClient
          Caption = 'Panel6'
          TabOrder = 0
          object mmPascal: TAdvMemo
            Left = 1
            Top = 1
            Width = 780
            Height = 342
            Cursor = crIBeam
            ActiveLineSettings.ShowActiveLine = False
            ActiveLineSettings.ShowActiveLineIndicator = False
            Align = alClient
            AutoCompletion.Font.Charset = DEFAULT_CHARSET
            AutoCompletion.Font.Color = clWindowText
            AutoCompletion.Font.Height = -11
            AutoCompletion.Font.Name = 'MS Sans Serif'
            AutoCompletion.Font.Style = []
            AutoCorrect.Active = True
            AutoHintParameterPosition = hpBelowCode
            BorderStyle = bsSingle
            CodeFolding.Enabled = False
            CodeFolding.LineColor = clGray
            Ctl3D = False
            DelErase = True
            EnhancedHomeKey = False
            Gutter.DigitCount = 4
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -13
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'COURIER NEW'
            Font.Style = []
            HiddenCaret = False
            Lines.Strings = (
              '')
            MarkerList.UseDefaultMarkerImageIndex = False
            MarkerList.DefaultMarkerImageIndex = -1
            MarkerList.ImageTransparentColor = 33554432
            PrintOptions.MarginLeft = 0
            PrintOptions.MarginRight = 0
            PrintOptions.MarginTop = 0
            PrintOptions.MarginBottom = 0
            PrintOptions.PageNr = False
            PrintOptions.PrintLineNumbers = False
            RightMarginColor = 14869218
            ScrollHint = False
            SelColor = clWhite
            SelBkColor = clNavy
            ShowRightMargin = True
            SmartTabs = False
            SyntaxStyles = AdvPascalMemoStyler1
            TabOrder = 0
            TabSize = 4
            TabStop = True
            TrimTrailingSpaces = False
            UndoLimit = 100
            UrlStyle.TextColor = clBlue
            UrlStyle.BkColor = clWhite
            UrlStyle.Style = [fsUnderline]
            UseStyler = True
            Version = '2.1.6.0'
            WordWrap = wwNone
          end
        end
      end
      object tsTree: TTabSheet
        Caption = 'Syntax tree'
        ImageIndex = 2
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 344
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel3'
          TabOrder = 0
          object TreeView1: TTreeView
            Left = 0
            Top = 0
            Width = 782
            Height = 344
            Align = alClient
            Indent = 19
            PopupMenu = PopupMenu1
            TabOrder = 0
          end
        end
      end
      object tsGrammar: TTabSheet
        Caption = 'Grammar'
        ImageIndex = 4
        object mmGrammar: TAdvMemo
          Left = 0
          Top = 0
          Width = 782
          Height = 344
          Cursor = crIBeam
          ActiveLineSettings.ShowActiveLine = False
          ActiveLineSettings.ShowActiveLineIndicator = False
          Align = alClient
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWindowText
          AutoCompletion.Font.Height = -11
          AutoCompletion.Font.Name = 'MS Sans Serif'
          AutoCompletion.Font.Style = []
          AutoCorrect.Active = True
          AutoHintParameterPosition = hpBelowCode
          BorderStyle = bsSingle
          CodeFolding.Enabled = False
          CodeFolding.LineColor = clGray
          Ctl3D = False
          DelErase = True
          EnhancedHomeKey = False
          Gutter.DigitCount = 4
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -13
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'COURIER NEW'
          Font.Style = []
          HiddenCaret = False
          Lines.Strings = (
            '')
          MarkerList.UseDefaultMarkerImageIndex = False
          MarkerList.DefaultMarkerImageIndex = -1
          MarkerList.ImageTransparentColor = 33554432
          PrintOptions.MarginLeft = 0
          PrintOptions.MarginRight = 0
          PrintOptions.MarginTop = 0
          PrintOptions.MarginBottom = 0
          PrintOptions.PageNr = False
          PrintOptions.PrintLineNumbers = False
          RightMarginColor = 14869218
          ScrollHint = False
          SelColor = clWhite
          SelBkColor = clNavy
          ShowRightMargin = True
          SmartTabs = False
          TabOrder = 0
          TabSize = 4
          TabStop = True
          TrimTrailingSpaces = False
          UndoLimit = 100
          UrlStyle.TextColor = clBlue
          UrlStyle.BkColor = clWhite
          UrlStyle.Style = [fsUnderline]
          UseStyler = True
          Version = '2.1.6.0'
          WordWrap = wwNone
        end
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 790
    Height = 29
    Caption = 'ToolBar1'
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Action = acOpen
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Action = acConvert
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 2
      Action = acSaveCPP
    end
    object ToolButton4: TToolButton
      Left = 69
      Top = 2
      Action = acSaveH
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 92
    Top = 59
    object Collapseall1: TMenuItem
      Caption = 'Collapse all'
      OnClick = Collapseall1Click
    end
    object Expandall1: TMenuItem
      Caption = 'Expand all'
      OnClick = Expandall1Click
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 124
    Top = 61
    object File1: TMenuItem
      Caption = '&File'
      object Openfile1: TMenuItem
        Action = acOpen
      end
      object SaveCsourcecodefilecpp1: TMenuItem
        Action = acSaveCPP
      end
      object SaveCincludefileh1: TMenuItem
        Action = acSaveH
      end
    end
    object ools1: TMenuItem
      Caption = 'Tools'
      object ConvertCtoPascal1: TMenuItem
        Action = acConvert
      end
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 188
    Top = 61
    object acOpen: TAction
      Caption = 'Open C++ file...'
      Hint = 'Open C++ file...'
      ImageIndex = 0
      ShortCut = 16463
      OnExecute = acOpenExecute
    end
    object acConvert: TAction
      Caption = 'Convert C++ to Pascal'
      Hint = 'Convert C++ to Pascal'
      ImageIndex = 1
      ShortCut = 120
      OnExecute = acConvertExecute
    end
    object acSaveCPP: TAction
      Caption = 'Save C++ source code file (.cpp)'
      Hint = 'Save C++ source code file (.cpp)'
      ImageIndex = 2
      ShortCut = 16467
      OnExecute = acSaveCPPExecute
    end
    object acSaveH: TAction
      Caption = 'Save C++ include file (.h)'
      Hint = 'Save C++ include file (.h)'
      ImageIndex = 3
      ShortCut = 24659
      OnExecute = acSaveHExecute
    end
  end
  object ImageList1: TImageList
    Left = 156
    Top = 61
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000008484840084848400848484008484840000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00848484000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000848484000000
      000000000000FFFF0000FFFF0000FFFF00000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00848484000000000000000000000000000000000084848400000000008484
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000008484840000000000FFFFFF00FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF0084840000FFFF
      0000FFFF0000FFFF000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000008484000084840000FFFF
      0000FFFF0000FFFF000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000008484840084848400848484008484840000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840084848400C6C6
      C600000000000000000000000000000000000000000084840000FFFFFF00FFFF
      0000FFFF0000FFFF000084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF008484
      84000000000000000000000000000000000000000000FFFFFF00848400008484
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400848484000000
      0000000000000000000000000000000000008484840000000000848400008484
      0000FFFFFF00FFFF0000FFFF0000FFFF00000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00848400008484000000000000000000008484840000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6E1C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000081610000FF9F2A008F6F1D000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004B4B4B004B4B4B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A7007373
      73007373730059595900595959004B4B4B004B4B4B003D3D3D00303030003030
      300030303000A7A7A70000000000000000000000000000000000000000004B4B
      4B004B4B4B004B4B4B004B4B4B004B4B4B004B4B4B004B4B4B004B4B4B004B4B
      4B004B4B4B004B4B4B004B4B4B0000000000A8A8A80073737300553F2A00553F
      2A003D3D3D003D3D3D00B4B4B40080610000FF9F2A00D9A77D00FF9F2A008F6F
      1C0073737300747474003D3D3D00A7A7A700000000000000000000000000007F
      000000DF000000BF2A004B4B4B00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7A7A70063360000CDCD
      CD00E6E6E600C1C1C100C1C1C100CDCDCD00F0F0F000EDEDED00E6E6E600A7A7
      A7003333330030303000A7A7A70000000000000000000000000000000000C6C6
      C600848484008484840084848400848484008484840084848400848484008484
      84008484840084848400848484004B4B4B0091919100A9FFFF0099F8FF0099F8
      FF0055DFFF0055BFD30080610000D9A77D00D9A77D00D9A77D00D9A77D00FF9F
      2A008F6F1D0055DFFF0055C0D4003D3D3D00000000000000000000000000007F
      000000DF000000DF000000BF2A004B4B4B000000000000000000000000000000
      000000000000000000000000000000000000633600006336000063360000DADA
      DA00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600DADA
      DA00CB8C44006336000030303000303030000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600848484004B4B4B0091919100A9FFFF00A9FFFF00A9FF
      FF00A9FFFF0080610000D9A77D00FFFFC300FFFFC300D9A77D00D9A77D00D9A7
      7D00FF9F2A008F6F1D0055DFFF003D3D3D00000000000000000000000000007F
      000000DF000000DF000000DF000000BF2A004B4B4B0000000000000000000000
      00000000000000000000000000000000000063360000CB8C440063360000D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00CB8C4400CB8C4400CB8C4400CB8C
      4400CB8C4400633600007F5B0000303030000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600848484004B4B4B0091919100A9FFFF00A9FFFF00A9FF
      FF00E1BE78008F6F1C008F6F1C008F6E1C00FFFFC300FFFFC400D9A77D008F6F
      1D008F6F1C008F6F1C00E1BE780073737300000000000000000000000000007F
      000000DF000000FF090000DF000000DF000000BF2A004B4B4B00000000000000
      00000000000000000000000000000000000063360000D9A77D0063360000D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00CB8C4400CB8C4400CB8C
      4400CB8C440063360000CB8C4400303030000000000000000000000000000000
      0000C6C6C6000000FF000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600848484004B4B4B0090909000A9FFFF00A9FFFF00A9FF
      FF00A9FFFF00A9FFFF00A9FFFF009D7C3000FFFFC300FFFFC300FFF1AB009D7C
      3000B4B4B40099F8FF0055DFFF003D3D3D00000000000000000000000000007F
      000000FF2A0000DF000000FF090000DF000000DF000000BF2A004B4B4B000000
      00000000000000000000000000000000000063360000D9A77D0063360000D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00CB8C4400CB8C
      4400CB8C440063360000CB8C44003D3D3D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600000000009191910000000000A9FFFF00A9FF
      FF00A9FFFF00A9FFFF00A9FFFF00AB8A4000FFFFC300FFFFC300D9A77D00FBD7
      910098F7FF0055DFFF00AADFD5003D3D3D00000000000000000000000000007F
      000055FF000000FF2A0000DF000000FF090000DF000000DF000000BF2A004B4B
      4B000000000000000000000000000000000063360000D9A77D0063360000AA3F
      2A00633600006336000063360000633600006336000063360000633600006336
      0000CB8C440063360000CB8C44004B4B4B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000091919100A9FFFF00A9FFFF00A9FF
      FF00A9FFFF00A9FFFF00B9974F00D9A77D00FFF0AA00FFFFC300AB8A400099F7
      FF0099F7FF0099F8FF0055DFFF0059595900000000000000000000000000007F
      000055FFAA0000FF090000FF2A0000DF000000FF090000DF000000DF0000007F
      00000000000000000000000000000000000063360000D9A77D00633600009A9A
      9A00AAFFFF0099F8FF0099F8FF0099F8FF0099F8FF0099F8FF0099F8FF0099F8
      FF006336000063360000CB8C44004B4B4B00000000004B4B4B004B4B4B004B4B
      4B004B4B4B004B4B4B004B4B4B004B4B4B000000000000000000000000000000
      0000000000004B4B4B000000000000000000A8A8A80000000000A9FFFF000000
      0000A9FFFF00A8FEFF00B9974E00FFE49E00FFF0AA00E1BE7700FBD79000A9FF
      FF00A9FFFF00A9FFFF00A9FFFF0066666600000000000000000000000000007F
      000055FFAA0000FF090000FF090000FF2A0000DF000055FFAA00007F00000000
      00000000000000000000000000000000000063360000D9A77D0063360000AAFF
      FF00CDCDCD00A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700C1C1
      C10099F8FF0063360000CB8C44004B4B4B004B4B4B00DFFFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF00DFFFFF004B4B4B0000000000000000000000
      00004B4B4B004B4B4B004B4B4B0000000000B4B4B400A9FFFF0000000000A9FF
      FF00A8FEFF00AB893F00D9A77D00FBD79000E1BE7800A9FFFF00A9FFFF00A9FF
      FF00A9FFFF00A9FFFF00A9FFFF0073737300000000000000000000000000007F
      0000AAFF2A0000FF090000FF090000FF090000FF2A00007F0000000000000000
      00000000000000000000000000000000000063360000D9A77D007F5B0000AAFF
      FF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFF
      FF0099F8FF007F5B0000CB8C44004B4B4B004B4B4B0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0060DFDF0080FFFF004B4B4B0000000000000000004B4B
      4B004B4B4B004B4B4B004B4B4B004B4B4B00C1C1C10000000000A9FFFF000000
      0000D4B16A00D4B26B00D4B26B00D4B26B00EECB8400C6C6C600C6C6C600AADF
      D50055BFD30054BFD30055BFD30081818100000000000000000000000000007F
      0000AAFF2A0000FF090000FF0900AAFF2A00007F000000000000000000000000
      00000000000000000000000000000000000063360000D9A77D007F5B0000AAFF
      FF00CDCDCD00A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700C1C1
      C10099F8FF007F5B0000CB8C44004B4B4B004B4B4B0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF004B4B4B0000000000000000000000
      0000000000004B4B4B000000000000000000CCCCCC00B5B5B500B4B4B400B4B4
      B400CBCBCB00AADFD500AADFD50055DFFF0055DFFF0055DFFF0055DFFF0055DF
      FF0055DFFF0055DFFF0054BFD300C1C1C100000000000000000000000000007F
      0000AAFFAA0000FF0900AAFF2A00007F00000000000000000000000000000000
      00000000000000000000000000000000000063360000D9A77D0098989800AAFF
      FF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFF
      FF0099F8FF0098989800CB8C4400595959004B4B4B0000FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF004B4B4B0000000000000000000000
      0000000000004B4B4B00000000000000000000000000DADADA0000F2FF0000F2
      FF0000F1FF0000F1FF0055BFD300E6E6E6008D8D8D008D8D8D008D8D8D008D8D
      8D008D8D8D008D8D8D008D8D8D0000000000000000000000000000000000007F
      0000AAFFAA00AAFFAA00007F0000000000000000000000000000000000000000
      00000000000000000000000000000000000063360000D9A77D00A6A6A6000000
      0000CDCDCD00CB8C4400CB8C4400A7A7A700A7A7A700A7A7A700A7A7A700C1C1
      C10099F8FF00A6A6A600D9A77D00666666004B4B4B004B4B4B004B4B4B004B4B
      4B0010BFCF0080FFFF0080FFFF00DFFFFF004B4B4B0000000000000000000000
      0000000000004B4B4B000000000000000000000000009B9B9B0054FFFF0067F4
      FF0067F4FF0067F4FF0000F1FF00B4B4B4000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000007F
      0000AAFFAA00007F000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A700633600007F5B00000000
      000000000000AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFF
      FF00AAFFFF007F5B000063360000A7A7A7004B4B4B0000FFFF00FFFFFF0000CF
      CF004B4B4B004B4B4B004B4B4B004B4B4B00000000004B4B4B004B4B4B004B4B
      4B004B4B4B0084848400000000000000000000000000000000009B9B9B008D8D
      8D008D8D8D008D8D8D009B9B9B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000007F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A7006336
      0000633600006336000063360000633600006336000063360000633600006336
      0000633600009A9A9A000000000000000000000000004B4B4B004B4B4B004B4B
      4B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFEDB6FFFF00008007EAAA83C10000
      8007EAAA800100008007EDB683C100008007FFFFFFFF00008007F07FFFC10000
      8007C03FFF8100008007801FFF410000800F001FFEFF0000800F001981C10000
      80070010800100008003001981C1000080090019FEFF0000801F0039FF410000
      803F8061FF810000FFFFC1FFFFC10000FFBFFFFFFFFFFFFFFF1FF3FFC003E001
      0000E1FF8001E0000000E0FF0000F0000000E07F0000F0000000E03F0000F000
      0000E01F0000FFFD4000E00F0000FFFF0000E00F000080FB5000E01F00000071
      2000E03F000000605000E07F0000007B0000E0FF0000007B8001E1FF1000007B
      80FFE3FF18000083C1FFF7FFC0038FFF00000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'C++ Builder source (*.cpp)|*.cpp|Include file (*.h, *.hpp)|*.h;*' +
      '.hpp'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Open C++ file'
    Left = 220
    Top = 61
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.cpp'
    Filter = 'C++ Builder source (*.cpp)|*.cpp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save .cpp file'
    Left = 252
    Top = 61
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.h'
    Filter = 'Include file (*.h, *.hpp)|*.h;*.hpp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save .h file'
    Left = 284
    Top = 61
  end
  object AdvPascalMemoStyler1: TAdvPascalMemoStyler
    BlockStart = 'begin'
    BlockEnd = 'end'
    LineComment = '//'
    MultiCommentLeft = '{'
    MultiCommentRight = '}'
    CommentStyle.TextColor = clNavy
    CommentStyle.BkColor = clWhite
    CommentStyle.Style = [fsItalic]
    NumberStyle.TextColor = clFuchsia
    NumberStyle.BkColor = clWhite
    NumberStyle.Style = [fsBold]
    AllStyles = <
      item
        KeyWords.Strings = (
          'begin'
          'break'
          'case'
          'cdecl'
          'class'
          'class'
          'const'
          'constructor'
          'continue'
          'default'
          'destructor'
          'do'
          'else'
          'end'
          'except'
          'finalise'
          'finally'
          'for'
          'function'
          'if'
          'implementation'
          'inherited'
          'initialise'
          'interface'
          'nil'
          'not'
          'override'
          'pascal'
          'private'
          'procedure'
          'program'
          'program'
          'property'
          'protected'
          'public'
          'published'
          'raise'
          'repeat'
          'stdcall'
          'stored'
          'string'
          'then'
          'to'
          'try'
          'type'
          'unit'
          'until'
          'uses'
          'var'
          'virtual'
          'while'
          'with')
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        BGColor = clWhite
        StyleType = stKeyword
        BracketStart = #0
        BracketEnd = #0
        Info = 'Pascal Standard Default'
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        BGColor = clWhite
        StyleType = stBracket
        BracketStart = #39
        BracketEnd = #39
        Info = 'Simple Quote'
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        BGColor = clWhite
        StyleType = stBracket
        BracketStart = '"'
        BracketEnd = '"'
        Info = 'Double Quote'
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        BGColor = clWhite
        StyleType = stSymbol
        BracketStart = #0
        BracketEnd = #0
        Symbols = ' ,;:.(){}[]=-*/^%<>#'#13#10
        Info = 'Symbols Delimiters'
      end>
    AutoCompletion.Strings = (
      'ShowMessage'
      'MessageDlg')
    HintParameter.TextColor = clBlack
    HintParameter.BkColor = clInfoBk
    HintParameter.HintCharStart = '('
    HintParameter.HintCharEnd = ')'
    HintParameter.HintCharDelimiter = ';'
    HintParameter.HintCharWriteDelimiter = ','
    HintParameter.Parameters.Strings = (
      'ShowMessage(const Msg: string);'
      
        'MessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMs' +
        'gDlgButtons; HelpCtx: Longint): Integer);')
    HexIdentifier = '$'
    Description = 'Pascal'
    Filter = 'Pascal Files (*.pas,*.dpr,*.dpk,*.inc)|*.pas;*.dpr;*.dpk;*.inc'
    DefaultExtension = '.pas'
    StylerName = 'Pascal'
    Extensions = 'pas;dpr;dpk;inc'
    RegionDefinitions = <
      item
        Identifier = 'procedure'
        RegionStart = 'begin'
        RegionEnd = 'end'
        RegionType = rtClosed
        ShowComments = False
      end
      item
        Identifier = 'interface'
        RegionStart = 'interface'
        RegionType = rtOpen
        ShowComments = False
      end
      item
        Identifier = 'unit'
        RegionStart = 'unit'
        RegionType = rtFile
        ShowComments = False
      end
      item
        Identifier = 'implementation'
        RegionStart = 'implementation'
        RegionType = rtOpen
        ShowComments = False
      end
      item
        Identifier = 'case'
        RegionStart = 'case'
        RegionEnd = 'end'
        RegionType = rtIgnore
        ShowComments = False
      end
      item
        Identifier = 'try'
        RegionStart = 'try'
        RegionEnd = 'end'
        RegionType = rtIgnore
        ShowComments = False
      end
      item
        Identifier = 'function'
        RegionStart = 'begin'
        RegionEnd = 'end'
        RegionType = rtClosed
        ShowComments = False
      end
      item
        Identifier = '{$region'
        RegionStart = '{$region'
        RegionEnd = '{$endregion'
        RegionType = rtClosed
        ShowComments = False
      end>
    Left = 356
    Top = 77
  end
end
