object Form1: TForm1
  Left = 577
  Top = 179
  Width = 690
  Height = 517
  ActiveControl = btRunThread
  Caption = 'Thread demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 528
    Height = 483
    Align = alClient
    TabOrder = 0
    object AdvMemo1: TAdvMemo
      Left = 1
      Top = 1
      Width = 526
      Height = 481
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
        '{ screen represented by a cartesian plan,'
        '  bounded to -1 and +1 cordinates on both x and y axes }'
        'len := 10;'
        'x := VarArrayCreate([0,len],12);'
        'y := VarArrayCreate([0,len],12);'
        ''
        'i := 0;'
        'tail := 1;'
        'x[i] := random*2-1;'
        'y[i] := random*2-1;'
        ''
        'for c:=1 to len do'
        'begin'
        '  x[c] := x[i];'
        '  y[c] := y[i];'
        'end;'
        ''
        'a := random*2*pi;'
        'ra := 2;'
        'r := 0.05;'
        'red := random*0.5+0.5;'
        'gre := random*0.5+0.5;'
        'blu := random*0.5+0.5;'
        'while not Terminated do'
        'begin'
        '  cx := Round((x[i] + 1) / 2 * CanvasWidth - 1);'
        '  cy := Round((1 - y[i]) / 2 * CanvasHeight - 1);'
        
          '  c := (Round(blu * 255) * 256 + round(gre * 255)) * 256 + Round' +
          '(red * 255);'
        '  PrepareEllipse(cx, cy, c, 5);'
        '  PlotEllipse;'
        ''
        '  cx := Round((x[tail] + 1) / 2 * CanvasWidth - 1);'
        '  cy := Round((1 - y[tail]) / 2 * CanvasHeight - 1);'
        '  PrepareEllipse(cx, cy, 0, 5);'
        '  PlotEllipse;'
        ''
        '  dx := cos(a)*r;'
        '  dy := sin(a)*r;'
        '  a := a + (random-0.5)*ra;'
        '  { next position }'
        '  ii := i;'
        '  if i<len then Inc(i) else i:=0;'
        '  if tail<len then Inc(tail) else tail:=0;'
        '  x[i] := x[ii] + dx;'
        '  y[i] := y[ii] + dy;'
        '  { revert direction when touchs screen limits }'
        '  if (x[i]<-1) or (x[i]>1) then'
        '    x[i] := -x[i]+dx;'
        '  if (y[i]<-1) or (y[i]>1) then'
        '    y[i] := -y[i]+dy;'
        '  sleep(20);'
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
  end
  object Panel3: TPanel
    Left = 528
    Top = 0
    Width = 154
    Height = 483
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object Panel1: TPanel
      Left = 5
      Top = 5
      Width = 145
      Height = 137
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clBlack
      TabOrder = 0
      object PaintBox1: TPaintBox
        Left = 0
        Top = 0
        Width = 141
        Height = 133
        Align = alClient
      end
    end
    object btStopThread: TButton
      Left = 5
      Top = 171
      Width = 144
      Height = 25
      Caption = 'Sto&p last thread'
      TabOrder = 1
      OnClick = btStopThreadClick
    end
    object btRunThread: TButton
      Left = 5
      Top = 145
      Width = 144
      Height = 25
      Caption = '&Start new thread'
      TabOrder = 2
      OnClick = btRunThreadClick
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
          'program'
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
    Left = 264
    Top = 392
  end
end
