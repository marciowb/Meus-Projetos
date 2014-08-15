inherited fmCompareConditionEditor: TfmCompareConditionEditor
  Caption = 'Query comparing condition'
  ClientHeight = 165
  ClientWidth = 448
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 125
    Width = 448
    TabOrder = 4
    inherited pnButton: TPanel
      Left = 131
    end
  end
  object pnExpression: TPanel [1]
    Left = 0
    Top = 89
    Width = 448
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 6
      Top = 9
      Width = 54
      Height = 13
      Caption = 'Expression:'
    end
    object edField: TComboBox
      Left = 70
      Top = 7
      Width = 145
      Height = 21
      Style = csDropDownList
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
    end
    object edOperator: TComboBox
      Left = 218
      Top = 7
      Width = 71
      Height = 21
      Color = 14737632
      ItemHeight = 13
      TabOrder = 1
    end
    object edValue: TComboBox
      Left = 292
      Top = 7
      Width = 145
      Height = 21
      Color = 14737632
      ItemHeight = 13
      Sorted = True
      TabOrder = 2
    end
  end
  inherited pnOperator: TPanel
    Top = 60
    Width = 448
    TabOrder = 2
  end
  inherited pnTitle: TPanel
    Width = 448
  end
  inherited pnInfo: TPanel
    Width = 448
    Height = 40
    inherited lbInfo: TLabel
      Width = 436
      Height = 28
      Caption = 
        'This condition represents a single comparing of two informations' +
        '.'#13#10'A database field can be compared to another field, to a singl' +
        'e value or to a parameter.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 415
    Top = 27
  end
end
