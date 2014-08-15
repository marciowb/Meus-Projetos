inherited fmCustomOrderEditor: TfmCustomOrderEditor
  Caption = 'Query order field'
  ClientHeight = 166
  ClientWidth = 256
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 126
    Width = 256
    TabOrder = 4
    inherited pnButton: TPanel
      Left = 35
    end
  end
  object pnFieldName: TPanel [1]
    Left = 0
    Top = 59
    Width = 256
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
      Width = 150
      Height = 21
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object pnAggregation: TPanel [2]
    Left = 0
    Top = 88
    Width = 256
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label4: TLabel
      Left = 6
      Top = 9
      Width = 65
      Height = 13
      Caption = 'Sort direction:'
    end
    object edAggregation: TComboBox
      Left = 91
      Top = 7
      Width = 150
      Height = 21
      Style = csDropDownList
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'Ascending'
        'Descending')
    end
  end
  inherited pnTitle: TPanel
    Width = 256
  end
  inherited pnInfo: TPanel
    Width = 256
    Height = 39
    TabOrder = 1
    inherited lbInfo: TLabel
      Width = 244
      Height = 27
      Caption = 
        'This field may be lonely or combined with others to specify a so' +
        'rting criteria over the query result set.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 5
    Top = 131
  end
end
