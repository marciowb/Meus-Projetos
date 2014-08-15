object Form1: TForm1
  Left = 141
  Top = 132
  Width = 688
  Height = 520
  Caption = 'WebScripter demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 41
    Align = alTop
    TabOrder = 0
    object Button2: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Process'
      TabOrder = 0
      OnClick = Button2Click
    end
    object ChkShowBasic: TCheckBox
      Left = 144
      Top = 16
      Width = 185
      Height = 17
      Caption = 'Do the thing in VBScript'
      TabOrder = 1
      OnClick = ChkShowBasicClick
    end
  end
  object PC: TPageControl
    Left = 0
    Top = 41
    Width = 680
    Height = 445
    ActivePage = TSSource
    Align = alClient
    TabOrder = 1
    object TSSource: TTabSheet
      Caption = 'Pascal Source'
      object EditVB: TAdvMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 417
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
          '<%@Language=VBScript%>'
          '<%'
          ''
          ''
          'function WriteTable(NumRows)'
          ''
          '  dim i, sl            '
          ''
          '  sl = TStringList.Create'
          '  try'
          
            '    sl.Add("    <TABLE border='#39'1'#39' cellspacing='#39'0'#39' cellpadding='#39'2' +
            #39' style='#39'border-collapse;'#39'>")'
          '    for i = 1 to NumRows'
          '      sl.Add("      <TR>")'
          '      sl.Add("        <TD>Row:</TD>")'
          '      sl.Add(Format("        <TD>%d</TD>", [i]))'
          '      sl.Add("      </TR>")'
          '    next'
          ''
          '    sl.Add("    </TABLE>")'
          '    WriteTable = sl.Text'
          '  finally'
          '    sl.Free'
          '  end'
          'end function'
          ''
          'function WriteDB'
          ''
          '  dim sl'
          ''
          '  sl = TStringList.Create'
          ''
          '  t = Table1'
          '  t.DatabaseName = "DBDEMOS"'
          '  t.TableName ="customer"'
          '  t.Open'
          ''
          '  '#39'scan it to find the most recent invoice contact'
          '  t.First'
          
            '  sl.Add("    <TABLE border='#39'1'#39' cellspacing='#39'0'#39' cellpadding='#39'2'#39' ' +
            'style='#39'border-collapse;'#39'>")'
          
            '  sl.Add("<TR><TD><B>Company</B></TD><TD><B>Contact</B></TD></TR' +
            '>")'
          '  do while not t.Eof'
          '    sl.Add("      <TR><TD>")'
          ''
          '    sl.Add(t.FieldByName("Company").AsString)'
          '    sl.Add("</TD><TD>")'
          '    sl.Add(t.FieldByName("Contact").AsString)'
          ''
          '    sl.Add("      </TD></TR>")'
          '    t.Next'
          '  loop'
          '  WriteDB = sl.Text'
          '  sl.Free'
          '  t.Close'
          'end function'
          ''
          ''
          'dim sPageTitle'
          'dim StyleSheetPath'
          'dim SScriptGenTitle'
          'dim SScriptDBCodeTitle'
          'dim SScriptDBFuncTitle'
          ''
          'sPageTitle = "This is some TestPage"'
          'StyleSheetPath = "/css/stylesheet.css"'
          ''
          'SScriptGenTitle = "A scripter generated table"'
          'SScriptDBCodeTitle = "Scripter database integration (in code)"'
          
            'SScriptDBFuncTitle = "Scripter database integration (through a f' +
            'unction)"'
          ''
          ''
          '%>'
          ''
          '<HTML>'
          '  <HEAD>'
          '    <TITLE><%= sPageTitle %></TITLE>'
          '    {$I metablock.inc}'
          '  <BODY>'
          '  <B><%= SScriptGenTitle %></B><BR>'
          '  <%= WriteTable(10) %>'
          '  <BR><B><%= SScriptDBCodeTitle %></B><BR>'
          ''
          '  <TABLE BORDER="0" CELLSPACING="3" CELLPADDING="0">'
          '<%'
          
            '    WriteLn(Format("<TR><TD><B>%s</B></TD><TD><B>%s</B></TD></TR' +
            '>", [Table1.FieldByName("Company").FieldName, Table1.FieldByName' +
            '("Contact").FieldName]))'
          '    Table1.Active = True    '
          '    Table1.First'
          '    do while not Table1.Eof'
          '%>'
          '      <TR>'
          '        <TD><%= Table1.FieldByName("Company").AsString %></TD>'
          '        <TD><%= Table1.FieldByName("Contact").AsString %></TD>'
          '      </TR>'
          '<%'
          '      Table1.Next'
          '    loop'
          '    Table1.Active = False'
          '%>'
          '  </TABLE>'
          '  <BR><B><%= SScriptDBFuncTitle %></B><BR>'
          '  <%= WriteDB %>'
          '  </BODY>'
          '</HTML>')
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
        Version = '2.1.5.4'
        Visible = False
        WordWrap = wwNone
      end
      object EditSource: TAdvMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 417
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
          '<%@Language=Pascal%>'
          '<%'
          ''
          'const'
          '  SScriptGenTitle = '#39'A scripter generated table'#39';'
          
            '  SScriptDBCodeTitle = '#39'Scripter database integration (in code)'#39 +
            ';'
          
            '  SScriptDBFuncTitle = '#39'Scripter database integration (through a' +
            ' function)'#39';'
          ''
          'function WriteTable(NumRows);'
          'var'
          '  i, sl;'
          'begin'
          '  sl := TStringList.Create;'
          '  try'
          
            '    sl.Add('#39'    <TABLE border="1" cellspacing="0" cellpadding="2' +
            '" style="border-collapse;">'#39');'
          '    for i := 1 to NumRows do'
          '    begin'
          '      sl.Add('#39'      <TR>'#39');'
          '      sl.Add('#39'        <TD>Row:</TD>'#39');'
          '      sl.Add(Format('#39'        <TD>%d</TD>'#39', [i]));'
          '      sl.Add('#39'      </TR>'#39');'
          '    end;'
          '    sl.Add('#39'    </TABLE>'#39');'
          '    Result := sl.Text;'
          '  finally'
          '    sl.Free;'
          '  end;'
          'end;'
          ''
          'function WriteDB;'
          'var'
          '  sl: TStringList;'
          'begin'
          '  sl := TStringList.Create;'
          ''
          '  t := Table1;'
          '  t.DatabaseName := '#39'DBDEMOS'#39';'
          '  t.TableName:='#39'customer'#39';'
          '  t.Open;'
          ''
          '  { scan it to find the most recent invoice contact }'
          '  t.First;'
          
            '  sl.Add('#39'    <TABLE border="1" cellspacing="0" cellpadding="2" ' +
            'style="border-collapse;">'#39');'
          
            '  sl.Add('#39'<TR><TD><B>Company</B></TD><TD><B>Contact</B></TD></TR' +
            '>'#39');'
          '  While not t.Eof do'
          '  begin'
          '    sl.Add('#39'      <TR><TD>'#39');'
          ''
          '    sl.Add(t.FieldByName('#39'Company'#39').AsString);'
          '    sl.Add('#39'</TD><TD>'#39');'
          '    sl.Add(t.FieldByName('#39'Contact'#39').AsString);'
          ''
          '    sl.Add('#39'      </TD></TR>'#39');'
          '    t.Next;'
          '  end;'
          '  Result := sl.Text;'
          '  sl.Free;'
          '  t.Close;'
          'end;'
          ''
          ''
          'var sPageTitle;'
          'var StyleSheetPath;'
          ''
          'begin'
          '  sPageTitle := '#39'This is some TestPage'#39';'
          '  StyleSheetPath := '#39'/css/stylesheet.css'#39';'
          '%>'
          '<HTML>'
          '  <HEAD>'
          '    <TITLE><%= sPageTitle %></TITLE>'
          '    {$I metablock.inc}'
          '  <BODY>'
          '  <B><%= SScriptGenTitle %></B><BR>'
          '  <%= WriteTable(10) %>'
          '  <BR><B><%= SScriptDBCodeTitle %></B><BR>'
          ''
          '  <TABLE BORDER="0" CELLSPACING="3" CELLPADDING="0">'
          '<%'
          
            '    WriteLn(Format('#39'<TR><TD><B>%s</B></TD><TD><B>%s</B></TD></TR' +
            '>'#39', [Table1.FieldByName('#39'Company'#39').FieldName, Table1.FieldByName' +
            '('#39'Contact'#39').FieldName]));'
          '    Table1.Active := True;'
          '    Table1.First;'
          '    while not Table1.Eof do'
          '    begin'
          '%>'
          '      <TR>'
          '        <TD><%= Table1.FieldByName('#39'Company'#39').AsString %></TD>'
          '        <TD><%= Table1.FieldByName('#39'Contact'#39').AsString %></TD>'
          '      </TR>'
          '<%'
          '      Table1.Next;'
          '    end;'
          '    Table1.Active := False;'
          '%>'
          '  </TABLE>'
          '  <BR><B><%= SScriptDBFuncTitle %></B><BR>'
          '  <%= WriteDB %>'
          '  </BODY>'
          '</HTML>'
          '<%'
          'end;'
          '%>'
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
    object TSPreCompiled: TTabSheet
      Caption = 'Pre Compiled'
      object EditPre: TAdvMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 417
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
    object TSResult: TTabSheet
      Caption = 'Result'
      object EditResult: TAdvMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 417
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
    object TabSheet1: TTabSheet
      Caption = 'Include'
      ImageIndex = 3
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 417
        Align = alClient
        TabOrder = 0
        WordWrap = False
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
    Left = 528
    Top = 288
  end
  object Table1: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'customer.db'
    Left = 472
    Top = 224
    object Table1CustNo: TFloatField
      FieldName = 'CustNo'
    end
    object Table1Company: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object Table1Addr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object Table1Addr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object Table1City: TStringField
      FieldName = 'City'
      Size = 15
    end
    object Table1State: TStringField
      FieldName = 'State'
    end
    object Table1Zip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object Table1Country: TStringField
      FieldName = 'Country'
    end
    object Table1Phone: TStringField
      FieldName = 'Phone'
      Size = 15
    end
    object Table1FAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object Table1TaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object Table1Contact: TStringField
      FieldName = 'Contact'
    end
    object Table1LastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
  end
  object WebScript: TatWebScripter
    Language = alPascal
    AfterPreCompile = WebScriptAfterPreCompile
    OnDirective = WebScriptDirective
    OnInitScripter = WebScriptInitScripter
    Left = 396
    Top = 313
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
    Left = 236
    Top = 273
  end
end
