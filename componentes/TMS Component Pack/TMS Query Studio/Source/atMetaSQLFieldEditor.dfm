inherited fmMetaSQLFieldEditor: TfmMetaSQLFieldEditor
  Width = 520
  inherited atPanel1: TatPanel
    Width = 520
    Height = 109
    object Label1: TLabel
      Tag = 3
      Left = 5
      Top = 37
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Display label'
      FocusControl = edDisplayLabel
    end
    object Label2: TLabel
      Left = 5
      Top = 0
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Table Alias'
      FocusControl = cbTableAlias
    end
    object Label3: TLabel
      Tag = 1
      Left = 175
      Top = 0
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Field Name'
      FocusControl = cbFieldName
    end
    object Label4: TLabel
      Tag = 7
      Left = 5
      Top = 74
      Width = 84
      Height = 13
      AutoSize = False
      Caption = 'Group function'
      FocusControl = cbGroupFunction
    end
    object Label5: TLabel
      Tag = 4
      Left = 166
      Top = 37
      Width = 84
      Height = 13
      AutoSize = False
      Caption = 'Data type'
      FocusControl = cbDataType
    end
    object Label6: TLabel
      Tag = 2
      Left = 345
      Top = 0
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Field Alias'
      FocusControl = edFieldAlias
    end
    object Label7: TLabel
      Tag = 6
      Left = 354
      Top = 37
      Width = 150
      Height = 13
      AutoSize = False
      Caption = 'Field expression'
      FocusControl = edFieldExpression
    end
    object Label8: TLabel
      Tag = 5
      Left = 260
      Top = 37
      Width = 84
      Height = 13
      AutoSize = False
      Caption = 'Expression type'
      FocusControl = cbExpressionType
    end
    object Label10: TLabel
      Tag = 9
      Left = 125
      Top = 74
      Width = 84
      Height = 13
      AutoSize = False
      Caption = 'Visible'
      FocusControl = cbVisible
    end
    object lbOptions: TLabel
      Tag = 15
      Left = 245
      Top = 74
      Width = 200
      Height = 13
      AutoSize = False
      Caption = 'Options'
      FocusControl = ceOptions
    end
    object edDisplayLabel: TEdit
      Left = 5
      Top = 51
      Width = 159
      Height = 21
      TabOrder = 3
    end
    object cbTableAlias: TComboBox
      Left = 5
      Top = 14
      Width = 168
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnEnter = cbTableAliasEnter
      OnExit = cbTableAliasExit
    end
    object cbFieldName: TComboBox
      Left = 175
      Top = 14
      Width = 168
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnEnter = cbFieldNameEnter
      OnExit = cbFieldNameExit
    end
    object cbGroupFunction: TComboBox
      Left = 5
      Top = 88
      Width = 118
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
      Items.Strings = (
        '(none)'
        'Count'
        'Sum'
        'Max'
        'Min')
    end
    object cbDataType: TComboBox
      Left = 166
      Top = 51
      Width = 92
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        'ftString'
        'ftInteger'
        'ftDateTime'
        'ftBoolean'
        'ftFloat')
    end
    object edFieldAlias: TEdit
      Left = 345
      Top = 14
      Width = 170
      Height = 21
      TabOrder = 2
      OnEnter = edFieldAliasEnter
      OnExit = edFieldAliasExit
    end
    object edFieldExpression: TEdit
      Left = 354
      Top = 51
      Width = 161
      Height = 21
      TabOrder = 6
      OnEnter = edFieldAliasEnter
      OnExit = edFieldAliasExit
    end
    object cbExpressionType: TComboBox
      Left = 260
      Top = 51
      Width = 92
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnClick = cbExpressionTypeClick
      Items.Strings = (
        'etStandard'
        'etCustomExpr')
    end
    object cbVisible: TComboBox
      Left = 125
      Top = 88
      Width = 118
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 8
      Items.Strings = (
        'False'
        'True')
    end
    object ceOptions: TatCheckListEdit
      Left = 245
      Top = 88
      Width = 270
      Height = 21
      AutoDropWidthSize = False
      TabOrder = 9
      DropWidth = 121
      DropHeight = 100
      DropColumns = 0
      DropColor = clWindow
      DropFlat = True
      DropFont.Charset = DEFAULT_CHARSET
      DropFont.Color = clWindowText
      DropFont.Height = -11
      DropFont.Name = 'MS Sans Serif'
      DropFont.Style = []
      DropDirection = ddDown
      DropSorted = False
      TextDelimiter = ','
      TextEndChar = ']'
      TextStartChar = '['
      Version = '1.2.0.0'
    end
  end
  inherited Panel1: TatPanel
    Width = 520
    WrapControls = False
    object btLoad: TButton
      Tag = 4
      Left = 313
      Top = 5
      Width = 120
      Height = 20
      Action = acAppendDataset
      TabOrder = 4
      TabStop = False
    end
    object Button1: TButton
      Tag = 5
      Left = 435
      Top = 5
      Width = 120
      Height = 20
      Action = acAppendTable
      TabOrder = 5
      TabStop = False
    end
  end
  inherited Panel2: TPanel
    Top = 136
    Width = 520
    Height = 179
    inherited lvItems: TListView
      Width = 520
      Height = 179
      Columns = <
        item
          Caption = 'Field alias'
          Width = 150
        end
        item
          Caption = 'Table alias'
          Width = 70
        end
        item
          Caption = 'Field Name'
          Width = 150
        end
        item
          Caption = 'Data type'
          Width = 60
        end
        item
          Caption = 'Display label'
          Width = 150
        end
        item
          Caption = 'Group function'
          Width = 85
        end
        item
          Caption = 'Expression'
        end
        item
          Caption = 'Field expression'
          Width = 150
        end
        item
          Caption = 'Visible'
        end
        item
          Caption = 'Hidden from user'
        end
        item
          Caption = 'Always in select'
        end
        item
          Caption = 'Can order by'
        end
        item
          Caption = 'Can use in condition'
        end>
      MultiSelect = True
    end
  end
  inherited ActionList1: TActionList
    Left = 216
    Top = 144
    object acAppendDataset: TAction [4]
      Caption = '&Append from dataset'
      OnExecute = acAppendDatasetExecute
      OnUpdate = acAppendDatasetUpdate
    end
    object acAppendTable: TAction [5]
      Caption = 'Append from &table'
      OnExecute = acAppendTableExecute
      OnUpdate = acAppendTableUpdate
    end
    object acTableAlias: TAction
      Caption = 'Set table alias'
      OnExecute = acTableAliasExecute
      OnUpdate = acTableAliasUpdate
    end
  end
  inherited pmList: TPopupMenu
    object Settablealias1: TMenuItem
      Action = acTableAlias
    end
  end
  object ldPickDataset: TatListBoxDlg
    CancelCaption = 'Cancel'
    OkCaption = 'Ok'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DragAndDrop = True
    ExtendedSelect = False
    MultiSelect = False
    Sorted = False
    Title = 'Choose dataset'
    WindowHeight = 250
    WindowWidth = 400
    Left = 186
    Top = 145
  end
end
