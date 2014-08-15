object fmQueryEditor: TfmQueryEditor
  Left = 233
  Top = 154
  Width = 389
  Height = 170
  BorderStyle = bsSizeToolWin
  Caption = 'Query for parameter editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object VisualQuery: TatVisualQuery
    Left = 0
    Top = 0
    Width = 381
    Height = 119
    MetaSqlDefs = <
      item
        MetaSQLName = 'MetaSql1'
        Title = '(New visual query)'
      end>
    ResizeHeight = 119
    SQLSyntax = ssCustom
    SyntaxConf.ParentesisInJoins = False
    SyntaxConf.JoinSyntax = alsFrom
    SyntaxConf.SortInnerJoins = False
    SyntaxConf.CaseSensitive = False
    SyntaxConf.IndexInGroupBy = False
    SyntaxConf.IndexInOrderBy = False
    DisablePrettyText = False
    QualifiedFieldAliases = False
    FieldAliasSeparator = '_'
    AutoUpdateFieldAliases = False
    SelectionColor = clHighlight
    SelectionFontColor = clHighlightText
    ItemHeight = 20
    Align = alClient
    TabOrder = 0
    OnResize = VisualQueryResize
    object MetaSql1: TatInternalMetaSql
      SQLSyntax = ssCustom
      SQLTables = <>
      SQLFields = <>
      TableJoins = <>
      Conditions = <>
      GroupFields = <>
      OrderFields = <>
      Params = <>
      SyntaxConf.ParentesisInJoins = False
      SyntaxConf.JoinSyntax = alsFrom
      SyntaxConf.SortInnerJoins = False
      SyntaxConf.CaseSensitive = False
      SyntaxConf.IndexInGroupBy = False
      SyntaxConf.IndexInOrderBy = False
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 119
    Width = 381
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 381
      Height = 3
      Align = alTop
      Shape = bsTopLine
    end
    object Button1: TButton
      Left = 1
      Top = 5
      Width = 51
      Height = 18
      Caption = '&Ok'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
    end
    object Button2: TButton
      Left = 55
      Top = 5
      Width = 51
      Height = 18
      Caption = '&Cancel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
  end
end
