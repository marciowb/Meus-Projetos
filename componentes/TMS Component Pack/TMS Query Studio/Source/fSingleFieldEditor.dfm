inherited fmSingleFieldEditor: TfmSingleFieldEditor
  Left = 254
  Top = 141
  Caption = 'Query single field'
  ClientHeight = 275
  ClientWidth = 245
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 235
    Width = 245
    TabOrder = 8
    inherited pnButton: TPanel
      Left = 30
    end
  end
  object pnTableName: TPanel [1]
    Left = 0
    Top = 58
    Width = 245
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 9
      Width = 30
      Height = 13
      Caption = 'Table:'
    end
    object edTable: TComboBox
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Style = csDropDownList
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
      OnChange = edTableChange
    end
  end
  object pnFieldName: TPanel [2]
    Left = 0
    Top = 87
    Width = 245
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label2: TLabel
      Left = 6
      Top = 9
      Width = 54
      Height = 13
      Caption = 'Field name:'
    end
    object edFieldName: TComboBox
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
      OnChange = edFieldNameChange
      OnExit = edFieldNameExit
    end
  end
  object pnAggregation: TPanel [3]
    Left = 0
    Top = 145
    Width = 245
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object Label4: TLabel
      Left = 6
      Top = 9
      Width = 60
      Height = 13
      Caption = 'Aggregation:'
    end
    object edAggregation: TComboBox
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Style = csDropDownList
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '(none)'
        'Row count'
        'Sum'
        'Maximum'
        'Minimum'
        'Average')
    end
  end
  object pnFieldAlias: TPanel [4]
    Left = 0
    Top = 174
    Width = 245
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 6
    object Label3: TLabel
      Left = 6
      Top = 9
      Width = 49
      Height = 13
      Caption = 'Field alias:'
    end
    object edFieldAlias: TEdit
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Color = 14737632
      TabOrder = 0
      OnExit = edFieldAliasExit
    end
  end
  object pnDisplayLabel: TPanel [5]
    Left = 0
    Top = 203
    Width = 245
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 7
    object Label5: TLabel
      Left = 6
      Top = 9
      Width = 62
      Height = 13
      Caption = 'Display label:'
    end
    object edDisplayLabel: TEdit
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Color = 14737632
      TabOrder = 0
    end
  end
  object pnDataType: TPanel [6]
    Left = 0
    Top = 116
    Width = 245
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object Label7: TLabel
      Left = 6
      Top = 9
      Width = 49
      Height = 13
      Caption = 'Data type:'
    end
    object edDataType: TComboBox
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Style = csDropDownList
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '(none)'
        'Row count'
        'Sum'
        'Maximum'
        'Minimum'
        'Average')
    end
  end
  inherited pnTitle: TPanel
    Width = 245
  end
  inherited pnInfo: TPanel
    Width = 245
    Height = 38
    TabOrder = 1
    inherited lbInfo: TLabel
      Width = 233
      Height = 26
      Caption = 
        'This field is a single expression to an information.'#13#10'Just one d' +
        'atabase field may be indicated here.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 6
    Top = 242
  end
end
