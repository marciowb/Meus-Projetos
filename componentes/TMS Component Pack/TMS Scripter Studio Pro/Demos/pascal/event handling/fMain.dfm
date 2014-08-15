object fmMain: TfmMain
  Left = 462
  Top = 191
  Width = 549
  Height = 462
  Caption = 'Scripter Studio demo'
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
  object mmSource: TAdvMemo
    Left = 0
    Top = 0
    Width = 541
    Height = 416
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
      'procedure miOption1Click(Sender);'
      'begin'
      '  ShowMessage('#39'Current date is '#39'+DateToStr(Date));'
      'end;'
      ''
      'procedure miOption3Click(Sender);'
      'begin'
      '  miOption3.Checked:=not miOption3.Checked;'
      '  mmSource.ReadOnly:=miOption3.Checked;'
      'end;'
      ''
      'procedure SetEvents;'
      'begin'
      '  miCustomMenu.Caption:='#39'My menu'#39';'
      '  miOption1.Caption:='#39'Show current date'#39';'
      '  miOption1.OnClick:='#39'miOption1Click'#39';'
      '  miOption2.Caption:='#39'-'#39';'
      '  miOption3.Caption:='#39'Read-only memo'#39';'
      '  miOption3.OnClick:='#39'miOption3Click'#39';'
      '  ShowMessage('#39'Now you can use menu option "My Menu"'#39');'
      'end;')
    MarkerList.UseDefaultMarkerImageIndex = False
    MarkerList.DefaultMarkerImageIndex = -1
    MarkerList.ImageTransparentColor = -1
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
  object MainMenu1: TMainMenu
    Left = 88
    Top = 16
    object Arquivo1: TMenuItem
      Caption = '&Script'
      object Run1: TMenuItem
        Caption = '&Run'
        ShortCut = 120
        OnClick = Run1Click
      end
    end
    object miCustomMenu: TMenuItem
      Caption = '&Custom menu'
      object miOption1: TMenuItem
        Caption = 'Option 1'
      end
      object miOption2: TMenuItem
        Caption = 'Option 2'
      end
      object miOption3: TMenuItem
        Caption = 'Option 3'
      end
    end
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
    Left = 280
    Top = 16
  end
  object Scripter: TatPascalScripter
    SaveCompiledCode = False
    ShortBooleanEval = False
    Left = 248
    Top = 16
  end
end
