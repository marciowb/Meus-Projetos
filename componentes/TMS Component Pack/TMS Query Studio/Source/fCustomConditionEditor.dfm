inherited fmCustomConditionEditor: TfmCustomConditionEditor
  Left = 155
  Top = 163
  Caption = 'Custom condition editor'
  ClientHeight = 134
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 94
    TabOrder = 2
  end
  object pnOperator: TPanel [1]
    Left = 0
    Top = 57
    Width = 336
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label3: TLabel
      Left = 6
      Top = 9
      Width = 46
      Height = 13
      Caption = 'Conector:'
    end
    object edLogicOper: TComboBox
      Left = 70
      Top = 7
      Width = 114
      Height = 21
      Style = csDropDownList
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'Campo 1'
        'Campo 2'
        'Campo exemplo')
    end
  end
  inherited pnInfo: TPanel
    TabOrder = 1
  end
  inherited PopupMenu1: TPopupMenu
    Left = 5
    Top = 88
  end
end
