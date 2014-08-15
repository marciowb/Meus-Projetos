inherited fmMetaSQLDataResult: TfmMetaSQLDataResult
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 515
    Height = 312
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Query1: TQuery
    Left = 72
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 104
    Top = 16
  end
end
