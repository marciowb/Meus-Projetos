inherited fmMetaSQLGroupEditor: TfmMetaSQLGroupEditor
  inherited atPanel1: TatPanel
    Height = 35
    object Label2: TLabel
      Left = 5
      Top = 0
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Group by field alias'
      FocusControl = cbFieldAlias
    end
    object cbFieldAlias: TComboBox
      Left = 5
      Top = 14
      Width = 444
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  inherited Panel2: TPanel
    Top = 62
    Height = 253
    inherited lvItems: TListView
      Height = 253
      Columns = <
        item
          Caption = 'Group by field alias'
          Width = 200
        end
        item
          Caption = ''
        end>
    end
  end
end
