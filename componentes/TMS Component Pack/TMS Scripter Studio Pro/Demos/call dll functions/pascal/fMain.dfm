object Form1: TForm1
  Left = 203
  Top = 114
  Width = 800
  Height = 600
  ActiveControl = AdvMemo1
  Caption = 'Scripter Studio Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 792
    Height = 466
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Windows library'
      object AdvMemo1: TAdvMemo
        Left = 0
        Top = 33
        Width = 784
        Height = 405
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
        Font.Name = 'Courier New'
        Font.Style = []
        HiddenCaret = False
        Lines.Strings = (
          '{ declaration of external functions }'
          ''
          
            'function MessageBox(hwnd: pointer; text, caption: AnsiString; ms' +
            'gtype: integer): integer;'
          '  stdcall; external '#39'User32.dll'#39' name '#39'MessageBoxA'#39';'
          ''
          
            'function GetDiskFreeSpace(root: AnsiString; var secPerCluster, b' +
            'ytesPerCluster, freeClusters,'
          
            '  totalClusters: integer): boolean; stdcall; external '#39'Kernel32.' +
            'dll'#39' name '#39'GetDiskFreeSpaceA'#39';'
          ''
          'function FindWindow(className, windowName: AnsiString): integer;'
          '  stdcall; external '#39'User32.dll'#39' name '#39'FindWindowA'#39';'
          ''
          
            'function GetKeyState(virtKey: integer): short; stdcall; external' +
            ' '#39'User32.dll'#39';'
          ' '
          'function FreeSpaceInfo(drive: String): string;'
          'var a, b, c, d: word;'
          'begin'
          '  if GetDiskFreeSpace(drive, a, b, c, d) then'
          
            '    result := Format('#39'%d sections per cluster; %d bytes per clus' +
            'ter; %d free clusters; %d total clusters'#39', [a, b, c, d])'
          '  else'
          '    result := '#39'(could not get drive information)'#39';'
          'end;'
          ''
          'const { windows consts }'
          '  MB_ICONQUESTION = $20;'
          '  MB_YESNO = $4;'
          '  IDYES = 6;'
          '  VK_SHIFT = $10;'
          ''
          'begin'
          
            '  if MessageBox(nil, '#39'Are you sure?'#39', '#39'Confirmation'#39', MB_ICONQUE' +
            'STION + MB_YESNO) = IDYES then'
          '    print('#39'MessageBox: user answered YES'#39')'
          '  else'
          '    print('#39'MessageBox: user answered NO'#39');'
          ''
          '  print('#39'Drive C: free space: '#39' + FreeSpaceInfo('#39'C:'#39'));'
          ''
          '  if FindWindow('#39'TAppBuilder'#39', '#39#39') > 0 then'
          '    print('#39'Delphi is open'#39')'
          '  else'
          '    print('#39'Delphi is not open'#39');'
          ''
          '  if GetKeyState(VK_SHIFT) < 0 then'
          '    print('#39'Shift is pressed'#39')'
          '  else'
          '    print('#39'Shift is not pressed'#39');'
          ''
          '  print('#39' '#39');'
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
        Version = '2.1.5.4'
        WordWrap = wwNone
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Button1: TButton
          Left = 3
          Top = 3
          Width = 134
          Height = 25
          Caption = 'Run the script below'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Custom library'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 784
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
      object AdvMemo2: TAdvMemo
        Left = 0
        Top = 33
        Width = 784
        Height = 405
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
        Font.Name = 'Courier New'
        Font.Style = []
        HiddenCaret = False
        Lines.Strings = (
          'uses'
          '  Windows;'
          ''
          '{ declaration of external functions }'
          
            'function CreateCustomForm(caption: AnsiString; color: integer): ' +
            'TObject; stdcall; external '#39'CustomLib.dll'#39';'
          'procedure ShowForm(form: TObject); external '#39'CustomLib.dll'#39';'
          
            'procedure GetBounds(form: TObject; var l, t, w, h: integer); cde' +
            'cl; external '#39'CustomLib.dll'#39' name '#39'FormGetBounds'#39';'
          
            'function DecodeToday(var year, month, day: integer): boolean; st' +
            'dcall; external '#39'CustomLib.dll'#39';'
          
            'function tsr(x, y: double): double; external '#39'CustomLib.dll'#39' nam' +
            'e '#39'TimesSquareRoot'#39';'
          ''
          'const'
          '  clRed = $0000FF;'
          ''
          'begin'
          '  { explicit dynamic load of the library }'
          '  dll := LoadLibrary('#39'CustomLib'#39');'
          '  try'
          '    print(Format('#39'CustomLib.dll loaded: handle = %d'#39', [dll]));'
          '    frm := CreateCustomForm('#39'My form'#39', clRed);'
          '    try'
          '      ShowForm(frm);'
          '      l := 0; t := 0;'
          '      w := 0; h := 0;'
          '      GetBounds(frm, l, t, w, h);'
          
            '      print(Format('#39'Form bounds: left=%d, top=%d, width=%d, heig' +
            'ht=%d'#39', [l, t, w, h]));'
          '    finally'
          '      frm.Free;'
          '    end;'
          '  finally'
          '    FreeLibrary(dll); { unload }'
          '    print(Format('#39'DLL %d unloaded'#39', [dll]));'
          '  end;'
          ''
          '  { automatic load of the library on demand }'
          '  y := 0; m := 0; d := 0;'
          '  leap := DecodeToday(y, m, d);'
          '  print(Format('#39'Today: day=%d, month=%d, year=%d'#39', [d, m, y]));'
          '  if leap then'
          '    print(Format('#39'%d is leap'#39', [y]))'
          '  else'
          '    print(Format('#39'%d is not leap'#39', [y]));'
          
            '  print('#39'Square root of '#39' + IntToStr(m * d) + '#39' is '#39' + FloatToSt' +
            'r(tsr(m, d)));'
          ''
          '  print('#39' '#39');'
          'end;'
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
        Version = '2.1.5.4'
        WordWrap = wwNone
      end
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 466
    Width = 792
    Height = 100
    Align = alBottom
    Lines.Strings = (
      'Script log:'
      '')
    ScrollBars = ssVertical
    TabOrder = 1
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
    Left = 468
    Top = 24
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
    Left = 436
    Top = 24
  end
end
