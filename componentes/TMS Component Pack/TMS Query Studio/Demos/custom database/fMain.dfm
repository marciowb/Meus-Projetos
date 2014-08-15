object Form1: TForm1
  Left = 208
  Top = 107
  Width = 544
  Height = 375
  Caption = 'Custom database example'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 200
    Width = 536
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object atVisualQuery1: TatVisualQuery
    Left = 0
    Top = 0
    Width = 536
    Height = 200
    MetaSqlDefs = <
      item
        MetaSql = atVisualQuery1.MetaSql1
        Title = '(New visual query)'
      end>
    OnMetaSqlChange = atVisualQuery1MetaSqlChange
    ResizeHeight = 200
    ShowParamEditors = False
    Database = atCustomDatabase1
    SQLSyntax = ssBdeLocal
    DisablePrettyText = False
    QualifiedFieldAliases = True
    FieldAliasSeparator = '_'
    AutoUpdateFieldAliases = False
    SelectionColor = clHighlight
    SelectionFontColor = clHighlightText
    ItemHeight = 20
    Align = alTop
    TabOrder = 0
    object MetaSql1: TatInternalMetaSql
      SQLSyntax = ssBdeLocal
      SQLTables = <>
      SQLFields = <>
      TableJoins = <>
      Conditions = <>
      GroupFields = <>
      OrderFields = <>
      Params = <>
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 203
    Width = 536
    Height = 145
    Align = alClient
    TabOrder = 1
  end
  object atCustomDatabase1: TatCustomDatabase
    OnRetrieveTablenameListEvent = atCustomDatabase1RetrieveTablenameListEvent
    OnRetrieveFieldNameListEvent = atCustomDatabase1RetrieveFieldNameListEvent
    OnWriteSqlPropertyEvent = atCustomDatabase1WriteSqlPropertyEvent
    Left = 290
    Top = 58
  end
end
