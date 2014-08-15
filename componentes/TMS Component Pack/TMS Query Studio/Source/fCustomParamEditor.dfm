inherited fmCustomParamEditor: TfmCustomParamEditor
  Left = 191
  Top = 169
  Caption = 'Custom parameter editor'
  ClientHeight = 139
  ClientWidth = 271
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 99
    Width = 271
    TabOrder = 3
    inherited pnButton: TPanel
      Left = 42
    end
  end
  object pnCaption: TPanel [1]
    Left = 0
    Top = 57
    Width = 271
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label5: TLabel
      Left = 6
      Top = 9
      Width = 39
      Height = 13
      Caption = 'Caption:'
    end
    object edCaption: TEdit
      Left = 80
      Top = 8
      Width = 176
      Height = 21
      Color = 14737632
      TabOrder = 0
    end
  end
  inherited pnTitle: TPanel
    Width = 271
  end
  inherited pnInfo: TPanel
    Width = 271
    TabOrder = 1
    inherited lbInfo: TLabel
      Width = 259
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 4
    Top = 106
  end
end
