inherited fmMetaSQLConditionEditor: TfmMetaSQLConditionEditor
  Width = 800
  Height = 553
  inherited atPanel1: TatPanel
    Width = 800
    Height = 72
    object Label2: TLabel
      Tag = 4
      Left = 491
      Top = 0
      Width = 121
      Height = 13
      AutoSize = False
      Caption = 'Value'
      FocusControl = cbValue
    end
    object lbLinkType: TLabel
      Tag = 3
      Left = 422
      Top = 0
      Width = 53
      Height = 13
      AutoSize = False
      Caption = 'Operator'
      FocusControl = cbOperator
    end
    object Label1: TLabel
      Tag = 2
      Left = 245
      Top = 0
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Field alias'
      FocusControl = cbFieldAlias
    end
    object Label3: TLabel
      Left = 5
      Top = 0
      Width = 113
      Height = 13
      AutoSize = False
      Caption = 'Condition name'
      FocusControl = edName
    end
    object Label8: TLabel
      Tag = 1
      Left = 141
      Top = 0
      Width = 84
      Height = 13
      AutoSize = False
      Caption = 'Condition type'
      FocusControl = cbConditionType
    end
    object Label7: TLabel
      Tag = 6
      Left = 5
      Top = 37
      Width = 160
      Height = 13
      AutoSize = False
      Caption = 'Expression'
      FocusControl = edExpression
    end
    object Label4: TLabel
      Tag = 5
      Left = 636
      Top = 0
      Width = 132
      Height = 13
      AutoSize = False
      Caption = 'Subconds operator'
      FocusControl = cbSubLogicalOper
    end
    object cbValue: TComboBox
      Left = 491
      Top = 14
      Width = 143
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnEnter = cbValueEnter
    end
    object cbOperator: TComboBox
      Left = 422
      Top = 14
      Width = 67
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        '='
        'LIKE'
        '>'
        '<'
        '<>'
        '>='
        '<=')
    end
    object cbFieldAlias: TComboBox
      Left = 245
      Top = 14
      Width = 175
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      OnEnter = cbFieldAliasEnter
    end
    object edName: TEdit
      Left = 5
      Top = 14
      Width = 134
      Height = 21
      TabOrder = 0
    end
    object cbConditionType: TComboBox
      Left = 141
      Top = 14
      Width = 102
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnClick = cbConditionTypeClick
      Items.Strings = (
        'ctValueCompare'
        'ctFieldCompare'
        'ctSubConditions'
        'ctCustomExpr'
        'ctParamCompare'
        'ctTrueExpr'
        'ctFalseExpr')
    end
    object edExpression: TEdit
      Left = 5
      Top = 51
      Width = 790
      Height = 21
      TabOrder = 6
    end
    object cbSubLogicalOper: TComboBox
      Left = 636
      Top = 14
      Width = 159
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnClick = cbConditionTypeClick
      Items.Strings = (
        'And'
        'Or')
    end
  end
  inherited Panel1: TatPanel
    Width = 800
  end
  inherited Panel2: TPanel
    Left = 229
    Top = 99
    Width = 571
    Height = 454
    object Splitter1: TSplitter [0]
      Left = 0
      Top = 0
      Width = 3
      Height = 454
      Cursor = crHSplit
    end
    inherited lvItems: TListView
      Left = 3
      Width = 568
      Height = 454
      Columns = <
        item
          Caption = 'Condition name'
          Width = 150
        end
        item
          Caption = 'Field alias'
          Width = 150
        end
        item
          Caption = 'Operator'
        end
        item
          Caption = 'Value'
          Width = 130
        end
        item
          Caption = 'Connector'
        end
        item
          Caption = 'Condition type'
        end
        item
          Caption = 'Expression'
          Width = 150
        end>
    end
  end
  object TreeView: TTreeView [3]
    Left = 0
    Top = 99
    Width = 229
    Height = 454
    Align = alLeft
    HideSelection = False
    Indent = 19
    TabOrder = 3
    OnChange = TreeViewChange
    Items.Data = {
      01000000230000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      0A436F6E646974696F6E73}
  end
  inherited ActionList1: TActionList
    Left = 272
    Top = 96
  end
end
