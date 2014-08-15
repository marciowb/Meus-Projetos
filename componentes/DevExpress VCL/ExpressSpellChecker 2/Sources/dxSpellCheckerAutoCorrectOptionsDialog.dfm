object fmSpellCheckerAutoCorrectOptionsForm: TfmSpellCheckerAutoCorrectOptionsForm
  Left = 311
  Top = 75
  BorderStyle = bsDialog
  ClientHeight = 452
  ClientWidth = 455
  Color = clBtnFace
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOk: TcxButton
    Left = 295
    Top = 421
    Width = 73
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'btnOk'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TcxButton
    Left = 374
    Top = 421
    Width = 73
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'btnCancel'
    ModalResult = 2
    TabOrder = 1
  end
  object gbCapitalize: TcxGroupBox
    Left = 8
    Top = 8
    Anchors = [akLeft, akTop, akRight]
    Caption = 'gbCapitalize'
    Style.TransparentBorder = False
    TabOrder = 2
    Height = 123
    Width = 439
    object cbCorrectInitialCaps: TcxCheckBox
      Left = 8
      Top = 16
      Caption = 'cbCorrectInitialCaps'
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      Width = 425
    end
    object cbCorrectSentenceCaps: TcxCheckBox
      Left = 8
      Top = 41
      Caption = 'cbCorrectSentenceCaps'
      Style.TransparentBorder = False
      TabOrder = 1
      Transparent = True
      Width = 425
    end
    object cbCorrectCapsLock: TcxCheckBox
      Left = 8
      Top = 66
      Caption = 'cbCorrectCapsLock'
      Style.TransparentBorder = False
      TabOrder = 2
      Transparent = True
      Width = 257
    end
    object btnExceptions: TcxButton
      Left = 8
      Top = 91
      Width = 85
      Height = 23
      Caption = 'btnExceptions'
      TabOrder = 3
      OnClick = btnExceptionsClick
    end
    object cbDisableCapsLock: TcxCheckBox
      Left = 265
      Top = 66
      Caption = 'cbDisableCapsLock'
      Style.TransparentBorder = False
      TabOrder = 4
      Transparent = True
      Width = 168
    end
  end
  object gbReplaceTextAsYouType: TcxGroupBox
    Left = 8
    Top = 139
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'gbReplaceTextAsYouType'
    Style.TransparentBorder = False
    TabOrder = 3
    Height = 274
    Width = 439
    object cbReplaceTextAsYouType: TcxCheckBox
      Left = 8
      Top = 16
      Caption = 'cbReplaceTextAsYouType'
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      Width = 425
    end
    object lbReplace: TcxLabel
      Left = 8
      Top = 41
      Caption = 'lbReplace'
      FocusControl = teReplace
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbWith: TcxLabel
      Left = 91
      Top = 41
      Caption = 'lbWith'
      FocusControl = teWith
      Style.TransparentBorder = False
      Transparent = True
    end
    object teReplace: TcxTextEdit
      Left = 8
      Top = 62
      Properties.OnChange = teReplacePropertiesChange
      Style.TransparentBorder = False
      TabOrder = 3
      Width = 83
    end
    object teWith: TcxTextEdit
      Left = 91
      Top = 62
      Anchors = [akLeft, akTop, akRight]
      Properties.OnChange = teReplacePropertiesChange
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 339
    end
    object lvReplacements: TcxListView
      Left = 8
      Top = 89
      Width = 422
      Height = 121
      Anchors = [akLeft, akTop, akRight]
      ColumnClick = False
      Columns = <
        item
          MaxWidth = 81
          MinWidth = 81
          Width = 81
        end
        item
          AutoSize = True
        end>
      HideSelection = False
      IconOptions.WrapText = False
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      SortType = stText
      Style.TransparentBorder = False
      TabOrder = 5
      ViewStyle = vsReport
      OnClick = lvReplacementsClick
    end
    object btnDelete: TcxButton
      Left = 357
      Top = 223
      Width = 73
      Height = 23
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'btnDelete'
      TabOrder = 6
      OnClick = btnDeleteClick
    end
    object btnOperation: TcxButton
      Left = 278
      Top = 223
      Width = 73
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'btnOperation'
      TabOrder = 7
      OnClick = btnOperationClick
    end
    object cbAutomaticallyUseSuggestions: TcxCheckBox
      Left = 8
      Top = 249
      Caption = 'cbAutomaticallyUseSuggestions'
      Style.TransparentBorder = False
      TabOrder = 8
      Transparent = True
      Width = 425
    end
  end
end
