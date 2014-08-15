inherited fmMetaSQLJoinEditor: TfmMetaSQLJoinEditor
  inherited atPanel1: TatPanel
    Height = 45
    object Label2: TLabel
      Tag = 2
      Left = 274
      Top = 5
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Foreign table alias'
      FocusControl = cbForeignTable
    end
    object Label4: TLabel
      Tag = 1
      Left = 180
      Top = 5
      Width = 76
      Height = 13
      AutoSize = False
      Caption = 'Link type'
      FocusControl = cbLinkType
    end
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Primary table alias'
      FocusControl = cbPrimaryTable
    end
    object cbForeignTable: TComboBox
      Left = 274
      Top = 19
      Width = 175
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
    object cbLinkType: TComboBox
      Left = 180
      Top = 19
      Width = 92
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'Inner join'
        'Left join'
        'Right join')
    end
    object cbPrimaryTable: TComboBox
      Left = 5
      Top = 19
      Width = 173
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  inherited Panel1: TatPanel
    object btSubConditions: TButton
      Tag = 5
      Left = 313
      Top = 5
      Width = 113
      Height = 20
      Action = acSubConditions
      Cancel = True
      TabOrder = 4
      TabStop = False
    end
  end
  inherited Panel2: TPanel
    Top = 72
    Height = 243
    inherited lvItems: TListView
      Height = 243
      Columns = <
        item
          Caption = 'Prim. table'
          Width = 80
        end
        item
          Caption = 'For. Table'
          Width = 85
        end
        item
          Caption = 'Link description'
          Width = 300
        end
        item
          Caption = 'SubConditions'
          Width = 100
        end>
      OnDblClick = lvItemsDblClick
    end
  end
  inherited ActionList1: TActionList
    Left = 272
    Top = 112
    object acSubConditions: TAction
      Caption = 'Edit &subconditions'
      OnExecute = acSubConditionsExecute
      OnUpdate = acSubConditionsUpdate
    end
  end
  inherited pmList: TPopupMenu
    object Editsubconditions1: TMenuItem
      Action = acSubConditions
    end
  end
end
