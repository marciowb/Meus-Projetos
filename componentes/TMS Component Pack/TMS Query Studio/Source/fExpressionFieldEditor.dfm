inherited fmExpressionFieldEditor: TfmExpressionFieldEditor
  Left = 261
  Top = 162
  Caption = 'Query expression field'
  ClientHeight = 252
  ClientWidth = 293
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 212
    Width = 293
    TabOrder = 7
    inherited pnButton: TPanel
      Left = 54
    end
  end
  object pnAggregation: TPanel [1]
    Left = 0
    Top = 118
    Width = 293
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
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
  object pnExpression: TPanel [2]
    Left = 0
    Top = 60
    Width = 293
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label6: TLabel
      Left = 6
      Top = 9
      Width = 54
      Height = 13
      Caption = 'Expression:'
    end
    object edExpression: TEdit
      Left = 79
      Top = 7
      Width = 199
      Height = 21
      Color = 14737632
      TabOrder = 0
    end
  end
  object pnFieldAlias: TPanel [3]
    Left = 0
    Top = 147
    Width = 293
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
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
  object pnDisplayLabel: TPanel [4]
    Left = 0
    Top = 176
    Width = 293
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 6
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
  object pnDataType: TPanel [5]
    Left = 0
    Top = 89
    Width = 293
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
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
    Width = 293
  end
  inherited pnInfo: TPanel
    Width = 293
    Height = 40
    TabOrder = 1
    inherited lbInfo: TLabel
      Width = 281
      Height = 28
      Caption = 
        'This field acts like a calculated information, which data expres' +
        'sion may be any valid meta-sql field expression.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 6
    Top = 219
  end
end
