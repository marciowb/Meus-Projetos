inherited fmFreeEditParamEditor: TfmFreeEditParamEditor
  Left = 281
  Top = 187
  Caption = 'Free parameter editor'
  ClientHeight = 164
  ClientWidth = 291
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 124
    Width = 291
    TabOrder = 4
    inherited pnButton: TPanel
      Left = 52
    end
  end
  inherited pnCaption: TPanel
    Top = 88
    Width = 291
    TabOrder = 3
    inherited edCaption: TEdit
      Left = 79
      Width = 200
      OnEnter = edCaptionEnter
    end
  end
  object pnParamName: TPanel [2]
    Left = 0
    Top = 59
    Width = 291
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label2: TLabel
      Left = 6
      Top = 9
      Width = 62
      Height = 13
      Caption = 'Param name:'
    end
    object edParamName: TComboBox
      Left = 79
      Top = 7
      Width = 200
      Height = 21
      Color = 14737632
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
    end
  end
  inherited pnTitle: TPanel
    Width = 291
  end
  inherited pnInfo: TPanel
    Width = 291
    Height = 39
    inherited lbInfo: TLabel
      Width = 279
      Height = 27
      Caption = 
        'This parameter editor allow user to type values that corresponds' +
        ' to the parameters used by query conditions.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 9
    Top = 127
  end
end
