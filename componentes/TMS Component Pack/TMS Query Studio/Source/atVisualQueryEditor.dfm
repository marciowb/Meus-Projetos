object fmVisualQueryEditor: TfmVisualQueryEditor
  Left = 187
  Top = 142
  Width = 570
  Height = 322
  Caption = 'Editing the visual-query'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 4
    Top = 4
    Width = 554
    Height = 256
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '&Visual-query preview'
      object atVisualQuery1: TatVisualQuery
        Left = 0
        Top = 0
        Width = 546
        Height = 228
        MetaSqlDefs = <
          item
            MetaSQLName = 'MetaSql1'
            Title = '(New visual query)'
          end>
        ResizeHeight = 228
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
    end
  end
  object Panel1: TPanel
    Left = 188
    Top = 265
    Width = 185
    Height = 27
    Anchors = [akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 13
      Top = 1
      Width = 75
      Height = 25
      Caption = '&Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 98
      Top = 1
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
