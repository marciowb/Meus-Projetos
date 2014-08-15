object Form1: TForm1
  Left = 117
  Top = 103
  Width = 772
  Height = 603
  Caption = 'Scripter Studio Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 764
    Height = 569
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Version number library'
      ImageIndex = 1
      object AdvMemo1: TAdvMemo
        Left = 0
        Top = 33
        Width = 756
        Height = 508
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
        BlockLineColor = clGray
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
        Font.Height = -13
        Font.Name = 'COURIER NEW'
        Font.Style = []
        HiddenCaret = False
        Lines.Strings = (
          'var'
          '  VersionNumberSeparator: string;'
          ''
          'procedure CheckVersionNumberSeparator;'
          'begin'
          '  if VersionNumberSeparator = '#39#39' then'
          '    VersionNumberSeparator := '#39'.'#39';'
          'end;'
          ''
          'function EncodeVersionNumber(A, B, C, D: integer): string;'
          'begin'
          '  CheckVersionNumberSeparator;'
          '  result :='
          '    IntToStr(A) + VersionNumberSeparator +'
          '    IntToStr(B) + VersionNumberSeparator +'
          '    IntToStr(C) + VersionNumberSeparator +'
          '    IntToStr(D);'
          'end;'
          ''
          
            'procedure DecodeVersionNumber(AVersion: string; var A, B, C, D: ' +
            'integer);'
          'begin'
          '  CheckVersionNumberSeparator;'
          '  try'
          '    P := Pos(VersionNumberSeparator, AVersion);'
          '    A := StrToInt(Copy(AVersion, 1, P - 1));'
          '    Delete(AVersion, 1, P);'
          ''
          '    P := Pos(VersionNumberSeparator, AVersion);'
          '    B := StrToInt(Copy(AVersion, 1, P - 1));'
          '    Delete(AVersion, 1, P);'
          ''
          '    P := Pos(VersionNumberSeparator, AVersion);'
          '    C := StrToInt(Copy(AVersion, 1, P - 1));'
          '    Delete(AVersion, 1, P);'
          ''
          '    D := StrToInt(AVersion);'
          '  except'
          
            '    raise('#39'Error while decoding version number: '#39' + LastExceptio' +
            'nMessage);'
          '  end;'
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
        Version = '2.1.3.3'
        WordWrap = wwNone
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 756
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Button1: TButton
          Left = 3
          Top = 3
          Width = 382
          Height = 25
          Caption = 
            'Add the script below as a library in both pascal and basic scrip' +
            'ters'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Pascal script (same scripter component)'
      object AdvMemo2: TAdvMemo
        Left = 0
        Top = 33
        Width = 756
        Height = 508
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
        BlockLineColor = clGray
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
        Font.Height = -13
        Font.Name = 'COURIER NEW'
        Font.Style = []
        HiddenCaret = False
        Lines.Strings = (
          'var'
          '  N1, N2, N3, N4: integer;'
          '  VersionNumber, NewVersionNumber: string;'
          'begin'
          '  VersionNumber := '#39'2.1.3.4'#39';'
          '  if InputQuery('#39'Scripter Studio demo'#39','
          
            '    '#39'Please type a version number with four digits, separated by' +
            ' "."'#39','
          '    VersionNumber) then'
          '  begin'
          '    VersionNumberSeparator := '#39'.'#39';'
          '    DecodeVersionNumber(VersionNumber, N1, N2, N3, N4);'
          ''
          '    VersionNumberSeparator := '#39'-'#39';'
          '    NewVersionNumber := EncodeVersionNumber(N1, N2 + 1, 0, 0);'
          ''
          
            '    ShowMessage('#39'The version number of next release is '#39' + NewVe' +
            'rsionNumber)'
          '  end;'
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
        Version = '2.1.3.3'
        WordWrap = wwNone
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 756
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Button2: TButton
          Left = 3
          Top = 3
          Width = 134
          Height = 25
          Caption = 'Run the script below'
          TabOrder = 0
          OnClick = Button2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Basic script (different scripter component)'
      ImageIndex = 2
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 756
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Button3: TButton
          Left = 3
          Top = 3
          Width = 134
          Height = 25
          Caption = 'Run the script below'
          TabOrder = 0
          OnClick = Button3Click
        end
      end
      object AdvMemo3: TAdvMemo
        Left = 0
        Top = 33
        Width = 756
        Height = 508
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
        BlockLineColor = clGray
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
        Font.Height = -13
        Font.Name = 'COURIER NEW'
        Font.Style = []
        HiddenCaret = False
        Lines.Strings = (
          'DIM N1, N2, N3, N4'
          'DIM VersionNumber, NewVersionNumber'
          ''
          'VersionNumber = "2.1.3.4"'
          'IF InputQuery("Scripter Studio demo",'
          
            '  "Please type a version number with four digits, separated by '#39 +
            '.'#39'",'
          '  VersionNumber) THEN'
          '  VersionNumberSeparator = "."'
          '  DecodeVersionNumber(VersionNumber, N1, N2, N3, N4)'
          '  VersionNumberSeparator = "-"'
          '  NewVersionNumber = EncodeVersionNumber(N1, N2 + 1, 0, 0)'
          
            '  ShowMessage("The version number of next release is " + NewVers' +
            'ionNumber)'
          'END IF')
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
        SyntaxStyles = AdvBasicMemoStyler1
        TabOrder = 1
        TabSize = 4
        TabStop = True
        TrimTrailingSpaces = False
        UndoLimit = 100
        UrlStyle.TextColor = clBlue
        UrlStyle.BkColor = clWhite
        UrlStyle.Style = [fsUnderline]
        UseStyler = True
        Version = '2.1.3.3'
        WordWrap = wwNone
      end
    end
  end
  object BasicScripter: TatBasicScripter
    SaveCompiledCode = False
    ShortBooleanEval = False
    LibOptions.SearchPath.Strings = (
      '$(CURDIR)'
      '$(APPDIR)')
    LibOptions.SourceFileExt = '.bsc'
    LibOptions.CompiledFileExt = '.bcu'
    LibOptions.UseScriptFiles = False
    CallExecHookEvent = False
    Left = 12
    Top = 120
  end
  object Scripter: TatPascalScripter
    SaveCompiledCode = False
    ShortBooleanEval = False
    LibOptions.SearchPath.Strings = (
      '$(CURDIR)'
      '$(APPDIR)')
    LibOptions.SourceFileExt = '.psc'
    LibOptions.CompiledFileExt = '.pcu'
    LibOptions.UseScriptFiles = False
    CallExecHookEvent = False
    Left = 12
    Top = 64
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
    Left = 60
    Top = 64
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
          'call'
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
    Left = 100
    Top = 64
  end
end
