object Form1: TForm1
  Left = 216
  Top = 157
  Width = 544
  Height = 375
  Caption = 'Scripter Studio example'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TAdvMemo
    Left = 0
    Top = 29
    Width = 536
    Height = 300
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
    Ctl3D = False
    DelErase = True
    EnhancedHomeKey = False
    Gutter.DigitCount = 4
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -13
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.LineNumberStart = 1
    Gutter.LineNumberTextColor = clBlack
    Gutter.ShowLineNumbers = True
    Gutter.Visible = True
    Gutter.ShowLeadingZeros = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'COURIER NEW'
    Font.Style = []
    HiddenCaret = False
    Lines.Strings = (
      'Sub btFirstClick(Sender)'
      '  ShowMessage("First button click handled by SCRIPT.")'
      'end Sub'
      ''
      'Sub btSecondClick(Sender)'
      '  ShowMessage("Second button click handled by SCRIPT.")'
      'end Sub'
      ''
      'Sub btThirdClick(Sender)'
      '  ShowMessage("Third button click handled by SCRIPT.")'
      'end Sub')
    MarkerList.UseDefaultMarkerImageIndex = False
    MarkerList.DefaultMarkerImageIndex = -1
    MarkerList.ImageTransparentColor = -1
    PrintOptions.MarginLeft = 0
    PrintOptions.MarginRight = 0
    PrintOptions.MarginTop = 0
    PrintOptions.MarginBottom = 0
    PrintOptions.PageNr = False
    PrintOptions.PrintLineNumbers = False
    ReadOnly = True
    RightMarginColor = 14869218
    ScrollHint = False
    SelColor = clWhite
    SelBkColor = clNavy
    ShowRightMargin = True
    SmartTabs = False
    SyntaxStyles = AdvBasicMemoStyler1
    TabOrder = 0
    TabSize = 4
    TabStop = True
    TrimTrailingSpaces = False
    UndoLimit = 100
    UrlStyle.TextColor = clBlue
    UrlStyle.BkColor = clWhite
    UrlStyle.Style = [fsUnderline]
    UseStyler = True
    Version = '1.6.0.8'
    WordWrap = wwNone
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 536
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 44
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 1
    object btFirst: TToolButton
      Left = 0
      Top = 2
      Caption = 'First'
      ImageIndex = 0
      OnClick = btFirstClick
    end
    object ToolButton1: TToolButton
      Left = 44
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object btSecond: TToolButton
      Left = 52
      Top = 2
      Caption = 'Second'
      ImageIndex = 1
      OnClick = btSecondClick
    end
    object ToolButton2: TToolButton
      Left = 96
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object btThird: TToolButton
      Left = 104
      Top = 2
      Caption = 'Third'
      ImageIndex = 2
      OnClick = btThirdClick
    end
    object ToolButton4: TToolButton
      Left = 148
      Top = 2
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 280
    object Script1: TMenuItem
      Caption = 'Event manipulation'
      object miSetEvents: TMenuItem
        Caption = 'Set events'
        OnClick = miSetEventsClick
      end
      object miUnsetEvents: TMenuItem
        Caption = 'Unset events'
        OnClick = miUnsetEventsClick
      end
    end
  end
  object Scripter: TatBasicScripter
    SaveCompiledCode = False
    ShortBooleanEval = False
    Left = 192
    Top = 280
  end
  object AdvBasicMemoStyler1: TAdvBasicMemoStyler
    BlockStart = 'begin'
    BlockEnd = 'end'
    LineComment = #39
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
          'alias'
          'all'
          'and'
          'as'
          'attach'
          'auto'
          'autox'
          'case'
          'cfunction'
          'clear'
          'dcomplex'
          'dec'
          'declare'
          'default'
          'dim'
          'do'
          'double'
          'each'
          'else'
          'elseif'
          'end'
          'endif'
          'error'
          'exit'
          'explicit'
          'export'
          'external'
          'false'
          'for'
          'for next'
          'funcaddr'
          'function'
          'giant'
          'goaddr'
          'gosub'
          'goto'
          'if'
          'iff'
          'ift'
          'ifz'
          'import'
          'in'
          'inc'
          'internal'
          'is'
          'librarys'
          'loop'
          'mod'
          'module'
          'new'
          'next'
          'not'
          'nothing'
          'off'
          'on'
          'option'
          'or'
          'print'
          'program'
          'protected'
          'public'
          'quit'
          'read'
          'redim'
          'return'
          'sbyte'
          'scomplex'
          'select'
          'sfunction'
          'shared'
          'shared'
          'single'
          'slong'
          'sshort'
          'static'
          'step'
          'stop'
          'string'
          'sub'
          'subaddr'
          'swap'
          'then'
          'to'
          'true'
          'type'
          'typeof'
          'ubyte'
          'ulong'
          'union'
          'until'
          'ushort'
          'version'
          'void'
          'when'
          'while'
          'write'
          'xlong'
          'xor')
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        BGColor = clWhite
        StyleType = stKeyword
        BracketStart = #0
        BracketEnd = #0
        Info = 'Basic Standard Default'
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        BGColor = clWhite
        StyleType = stBracket
        BracketStart = #0
        BracketEnd = #0
        Info = 'Double Quote'
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
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
    HexIdentifier = '0x'
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
      'ShowMessage(string Msg)'
      
        'MessageDlg(string Msg; TMsgDlgType DlgType; TMsgDlgButtons Butto' +
        'ns; LongInt: HelpCtx)')
    Description = 'MS Visual Basic'
    Filter = 'Visual Basic Files (*.bas)|*.bas'
    DefaultExtension = '.bas'
    StylerName = 'MS Visual Basic'
    Extensions = 'bas'
    Left = 224
    Top = 280
  end
end
