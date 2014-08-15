object Form1: TForm1
  Left = 159
  Top = 112
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 137
    Width = 536
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object atVisualQuery1: TatVisualQuery
    Left = 0
    Top = 0
    Width = 536
    Height = 137
    MetaSqlDefs = <
      item
        MetaSQLName = 'MetaSql1'
        Title = 'Events with price greater than $8.00'
      end>
    ResizeHeight = 137
    TargetDataset = Query1
    Database = atBdeDatabase1
    SQLSyntax = ssInterbase
    DisablePrettyText = False
    QualifiedFieldAliases = True
    FieldAliasSeparator = '_'
    AutoUpdateFieldAliases = True
    SelectionColor = clInfoBk
    SelectionFontColor = clNavy
    ItemHeight = 18
    Align = alTop
    TabOrder = 0
    object MetaSql1: TatInternalMetaSql
      SQLSyntax = ssInterbase
      SQLTables = <
        item
          TableName = 'Events.db'
          TableAlias = 'Events'
        end>
      SQLFields = <
        item
          FieldAlias = 'Eventno'
          DataType = ftAutoInc
          FieldName = 'Eventno'
          TableAlias = 'Events'
        end
        item
          FieldAlias = 'Venueno'
          Active = False
          DataType = ftInteger
          FieldName = 'Venueno'
          TableAlias = 'Events'
        end
        item
          FieldAlias = 'Event_name'
          DataType = ftString
          FieldName = 'Event_name'
          TableAlias = 'Events'
        end
        item
          FieldAlias = 'Event_date'
          DataType = ftDate
          FieldName = 'Event_date'
          TableAlias = 'Events'
        end
        item
          FieldAlias = 'Event_time'
          Active = False
          DataType = ftTime
          FieldName = 'Event_time'
          TableAlias = 'Events'
        end
        item
          FieldAlias = 'Event_description'
          Active = False
          DataType = ftMemo
          FieldName = 'Event_description'
          TableAlias = 'Events'
        end
        item
          FieldAlias = 'Ticket_price'
          DataType = ftCurrency
          FieldName = 'Ticket_price'
          TableAlias = 'Events'
        end
        item
          FieldAlias = 'Event_photo'
          Active = False
          DataType = ftGraphic
          FieldName = 'Event_photo'
          TableAlias = 'Events'
        end>
      TableJoins = <>
      Conditions = <
        item
          Name = 'Condition0'
          FieldAlias = 'Ticket_price'
          Operator = '>'
          Value = '8'
          SubConditions = <>
        end>
      GroupFields = <>
      OrderFields = <
        item
          FieldAlias = 'Eventno'
          SortType = ortAscending
        end>
      Params = <>
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 140
    Width = 536
    Height = 208
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object atBdeDatabase1: TatBdeDatabase
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    Left = 280
    Top = 32
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 216
    Top = 32
  end
  object Query1: TQuery
    Active = True
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    SQL.Strings = (
      'SELECT'
      '   Events.Eventno  Eventno,'
      '   Events.Event_name  Event_name,'
      '   Events.Event_date  Event_date,'
      '   Events.Ticket_price  Ticket_price'
      'FROM'
      '   Events.db  Events'
      'WHERE'
      '   Events.Ticket_price > 8'
      ''
      'ORDER BY'
      '   Events.Eventno')
    Left = 248
    Top = 32
  end
end
