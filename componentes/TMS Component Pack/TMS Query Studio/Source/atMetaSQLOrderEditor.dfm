inherited fmMetaSQLOrderEditor: TfmMetaSQLOrderEditor
  inherited atPanel1: TatPanel
    Height = 45
    object Label2: TLabel
      Left = 5
      Top = 5
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Order by field alias'
      FocusControl = cbFieldAlias
    end
    object Label4: TLabel
      Tag = 4
      Left = 286
      Top = 5
      Width = 84
      Height = 13
      AutoSize = False
      Caption = 'Sort type'
      FocusControl = cbSortType
    end
    object cbFieldAlias: TComboBox
      Left = 5
      Top = 19
      Width = 279
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object cbSortType: TComboBox
      Left = 286
      Top = 19
      Width = 163
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'ascending'
        'descending')
    end
  end
  inherited Panel2: TPanel
    Top = 72
    Height = 243
    inherited lvItems: TListView
      Height = 243
      Columns = <
        item
          Caption = 'Order by field alias'
          Width = 200
        end
        item
          Caption = 'Sort type'
          Width = 100
        end>
    end
  end
end
