inherited fmSubconditionsEditor: TfmSubconditionsEditor
  Left = 274
  Top = 138
  Caption = 'Query collection condition'
  ClientHeight = 133
  ClientWidth = 286
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 93
    Width = 286
    TabOrder = 3
    inherited pnButton: TPanel
      Left = 50
    end
  end
  inherited pnOperator: TPanel
    Top = 58
    Width = 286
    TabOrder = 2
    inherited edLogicOper: TComboBox
      Width = 82
    end
  end
  inherited pnTitle: TPanel
    Width = 286
  end
  inherited pnInfo: TPanel
    Width = 286
    Height = 38
    inherited lbInfo: TLabel
      Width = 274
      Height = 26
      Caption = 
        'This condition is a group of other subconditions.'#13#10'Evaluation of' +
        ' its subconditions depends of this condition.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 254
    Top = 9
  end
end
