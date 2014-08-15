inherited fmDistinctListParamEditor: TfmDistinctListParamEditor
  Caption = 'Distinct list parameter editor'
  ClientHeight = 177
  ClientWidth = 294
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 137
    Width = 294
    TabOrder = 4
    inherited pnButton: TPanel
      Left = 53
    end
  end
  inherited pnCaption: TPanel
    Top = 101
    Width = 294
    TabOrder = 3
    inherited edCaption: TEdit
      Width = 200
      OnEnter = edCaptionEnter
    end
  end
  object pnParamName: TPanel [2]
    Left = 0
    Top = 72
    Width = 294
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
      Left = 80
      Top = 7
      Width = 200
      Height = 21
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
    end
  end
  inherited pnTitle: TPanel
    Width = 294
  end
  inherited pnInfo: TPanel
    Width = 294
    Height = 52
    inherited lbInfo: TLabel
      Width = 282
      Height = 40
      Caption = 
        'This parameter brings to the user a list of all distinctive valu' +
        'es contained on related table. The used table is the owner of fi' +
        'eld compared to this parameter.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 7
    Top = 130
  end
end
