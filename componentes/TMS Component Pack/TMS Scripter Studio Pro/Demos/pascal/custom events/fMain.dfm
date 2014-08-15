object Form1: TForm1
  Left = 533
  Top = 183
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
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TAdvMemo
    Left = 0
    Top = 0
    Width = 536
    Height = 321
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
      'procedure Memo1GutterClick(Sender, LineNo);'
      'begin'
      '  ShowMessage('#39'Gutter clicked at line '#39'+IntToStr(LineNo+1));'
      'end;'
      ''
      'begin'
      '  Memo1.OnGutterClick:='#39'Memo1GutterClick'#39';'
      '  ShowMessage('#39'Click on the memo gutter to fire event.'#39');'
      'end;')
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
    Version = '1.6.0.8'
    WordWrap = wwNone
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
          'finalise'
          'for'
          'function'
          'if'
          'implementation'
          'inherited'
          'initialise'
          'interface'
          'not'
          'override'
          'private'
          'procedure'
          'property'
          'protected'
          'public'
          'published'
          'repeat'
          'stored'
          'then'
          'to'
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
        Font.Style = []
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
        BracketStart = #0
        BracketEnd = #0
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
    Left = 88
    Top = 280
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 280
    object Script1: TMenuItem
      Caption = 'Script'
      object Run1: TMenuItem
        Caption = 'Run'
        ShortCut = 120
        OnClick = Run1Click
      end
      object Debug1: TMenuItem
        Caption = 'Debug'
        ShortCut = 121
        OnClick = Debug1Click
      end
    end
  end
  object Scripter: TatPascalScripter
    SaveCompiledCode = False
    ShortBooleanEval = False
    Left = 152
    Top = 280
  end
  object Debugger: TatScriptDebugger
    Scripter = Scripter
    UpdateSourceCode = True
    MemoReadOnly = False
    Left = 56
    Top = 280
  end
end
