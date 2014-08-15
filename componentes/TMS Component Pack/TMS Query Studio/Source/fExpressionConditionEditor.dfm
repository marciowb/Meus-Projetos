inherited fmExpressionConditionEditor: TfmExpressionConditionEditor
  Caption = 'Query expression condition'
  ClientHeight = 163
  ClientWidth = 306
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 123
    Width = 306
    TabOrder = 4
    inherited pnButton: TPanel
      Left = 60
    end
  end
  object pnCustomExpr: TPanel [1]
    Left = 0
    Top = 89
    Width = 306
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label5: TLabel
      Left = 6
      Top = 9
      Width = 54
      Height = 13
      Caption = 'Expression:'
    end
    object edExpression: TEdit
      Left = 70
      Top = 7
      Width = 220
      Height = 21
      Color = 14737632
      TabOrder = 0
    end
  end
  inherited pnOperator: TPanel
    Top = 60
    Width = 306
    TabOrder = 2
    inherited edLogicOper: TComboBox
      Width = 80
    end
  end
  inherited pnTitle: TPanel
    Width = 306
  end
  inherited pnInfo: TPanel
    Width = 306
    Height = 40
    inherited lbInfo: TLabel
      Width = 294
      Height = 28
      Caption = 
        'This condition may be represented by any valid meta-sql logic ex' +
        'pression. Parameter names may be used prefixed by a colon.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 273
    Top = 5
  end
end
