inherited fmMetaSQLTableEditor: TfmMetaSQLTableEditor
  inherited atPanel1: TatPanel
    Height = 45
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 167
      Height = 13
      AutoSize = False
      Caption = 'Table name'
      FocusControl = cbTableName
    end
    object Label2: TLabel
      Tag = 1
      Left = 292
      Top = 5
      Width = 88
      Height = 13
      AutoSize = False
      Caption = 'Table Alias'
      FocusControl = edTableAlias
    end
    object cbTableName: TComboBox
      Left = 5
      Top = 19
      Width = 285
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object edTableAlias: TEdit
      Tag = 1
      Left = 292
      Top = 19
      Width = 157
      Height = 21
      TabOrder = 1
    end
  end
  inherited Panel2: TPanel
    Top = 72
    Height = 243
    inherited lvItems: TListView
      Height = 243
      Columns = <
        item
          Caption = 'Table name'
          Width = 200
        end
        item
          Caption = 'Table alias'
          Width = 100
        end>
    end
  end
end
