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
          #39' declaration of external functions'
          ''
          
            'function MessageBox lib "User32.dll" alias "MessageBoxA" (hwnd a' +
            's pointer,'
          
            '  text as AnsiString, caption as AnsiString, msgtype as integer)' +
            ' as integer'
          ''
          
            'function GetDiskFreeSpace lib "Kernel32.dll" alias "GetDiskFreeS' +
            'paceA" (root as AnsiString,'
          
            '  ByRef secPerCluster as integer, ByRef bytesPerClusters as inte' +
            'ger,'
          
            '  ByRef freeClusters as integer, ByRef totalClusters as integer)' +
            ' as boolean'
          ''
          
            'function FindWindow lib "User32.dll" alias "FindWindowA" (classN' +
            'ame as AnsiString,'
          '  windowName as AnsiString) as integer'
          ''
          'function GetKeyState lib "User32.dll" (virtKey as integer)'
          ''
          'function FreeSpaceInfo(drive)'
          'dim a, b, c, d'
          '  if GetDiskFreeSpace(drive, a, b, c, d) then'
          
            '    FreeSpaceInfo = Format("%d sections per cluster; %d bytes pe' +
            'r cluster; %d free clusters; %d total clusters", [a, b, c, d])'
          '  else'
          '    FreeSpaceInfo = "(could not get drive information)"'
          '  end if'
          'end function'
          ''
          #39' windows consts'
          'MB_ICONQUESTION = 0x20'
          'MB_YESNO = 0x4'
          'IDYES = 6'
          'VK_SHIFT = 0x10'
          ''
          
            'if MessageBox(null, "Are you sure?", "Confirmation", MB_ICONQUES' +
            'TION + MB_YESNO) = IDYES then'
          '  print("MessageBox: user answered YES")'
          'else'
          '  print("MessageBox: user answered NO")'
          'end if'
          ''
          'print("Drive C: free space: " + FreeSpaceInfo("C:"))'
          ''
          'if FindWindow("TAppBuilder", "") > 0 then'
          '  print("Delphi is open")'
          'else'
          '  print("Delphi is not open")'
          'end if'
          ''
          'if GetKeyState(VK_SHIFT) < 0 then'
          '  print("Shift is pressed")'
          'else'
          '  print("Shift is not pressed")'
          'end if'
          ''
          'print(" ")'
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
          '  Windows'
          ''
          #39' declaration of external functions'
          
            'function CreateCustomForm lib "CustomLib.dll" (caption as AnsiSt' +
            'ring, color as integer) as TObject'
          'sub ShowForm lib "CustomLib.dll" register (form as TObject)'
          
            'sub GetBounds lib "CustomLib.dll" alias "FormGetBounds" cdecl (f' +
            'orm as TObject, ByRef l as integer, ByRef t as integer, ByRef w ' +
            'as integer, ByRef h as integer)'
          
            'function DecodeToday lib "CustomLib.dll" (ByRef year as integer,' +
            ' ByRef month as integer, ByRef day as integer)'
          
            'function tsr lib "CustomLib.dll" alias "TimesSquareRoot" registe' +
            'r (x as double, y as double) as double'
          ''
          'clRed = 0x0000FF'
          ''
          #39' explicit dynamic load of the library'
          'dll = LoadLibrary("CustomLib")'
          'try'
          '  print(Format("CustomLib.dll loaded: handle = %d", [dll]))'
          '  frm = CreateCustomForm("My form", clRed)'
          '  try'
          '    ShowForm(frm)'
          '    l = 0'
          '    t = 0'
          '    w = 0'
          '    h = 0'
          '    GetBounds(frm, l, t, w, h)'
          
            '    print(Format("Form bounds: left=%d, top=%d, width=%d, height' +
            '=%d", [l, t, w, h]))'
          '  finally'
          '    frm.Free'
          '  end'
          'finally'
          '  FreeLibrary(dll) '#39' unload'
          '  print(Format("DLL %d unloaded", [dll]))'
          'end'
          ''
          #39' automatic load of the library on demand'
          'y = 0'
          'm = 0'
          'd = 0'
          'leap = DecodeToday(y, m, d)'
          'print(Format("Today: day=%d, month=%d, year=%d", [d, m, y]))'
          'if leap then'
          '  print(Format("%d is leap", [y]))'
          'else'
          '  print(Format("%d is not leap", [y]))'
          'end if'
          
            'print("Square root of " + IntToStr(m * d) + " is " + FloatToStr(' +
            'tsr(m, d)))'
          ''
          'print(" ")'
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
  object Scripter: TatBasicScripter
    SaveCompiledCode = False
    ShortBooleanEval = False
    LibOptions.SearchPath.Strings = (
      '$(CURDIR)'
      '$(APPDIR)')
    LibOptions.SourceFileExt = '.bsc'
    LibOptions.CompiledFileExt = '.bcu'
    LibOptions.UseScriptFiles = False
    CallExecHookEvent = False
    Left = 380
    Top = 24
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
          'finally'
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
          'try'
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
    Left = 412
    Top = 24
  end
end
