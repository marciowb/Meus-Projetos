inherited fmCustomGroupEditor: TfmCustomGroupEditor
  Left = 264
  Top = 205
  Caption = 'Query group field'
  ClientHeight = 145
  ClientWidth = 279
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 105
    Width = 279
    TabOrder = 3
    inherited pnButton: TPanel
      Left = 47
    end
  end
  object pnFieldName: TPanel [1]
    Left = 0
    Top = 72
    Width = 279
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label2: TLabel
      Left = 6
      Top = 9
      Width = 78
      Height = 13
      Caption = 'Field expression:'
    end
    object edFieldExpr: TComboBox
      Left = 91
      Top = 7
      Width = 176
      Height = 21
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
    end
  end
  inherited pnTitle: TPanel
    Width = 279
  end
  inherited pnInfo: TPanel
    Width = 279
    Height = 52
    TabOrder = 1
    inherited lbInfo: TLabel
      Width = 267
      Height = 40
      Caption = 
        'This field will be used to break aggregation functions. Generall' +
        'y, all visible fields that have not aggregation function should ' +
        'be grouped like this.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Top = 101
  end
end
