object dxInspectorCustomizeNew: TdxInspectorCustomizeNew
  Left = 669
  Top = 113
  BorderStyle = bsDialog
  Caption = 'New Category'
  ClientHeight = 87
  ClientWidth = 279
  Color = clBtnFace
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LCaption: TLabel
    Left = 11
    Top = 13
    Width = 39
    Height = 13
    Caption = '&Caption:'
    FocusControl = ECaption
  end
  object Bevel: TBevel
    Left = 11
    Top = 42
    Width = 260
    Height = 3
    Shape = bsTopLine
  end
  object ECaption: TEdit
    Left = 55
    Top = 10
    Width = 216
    Height = 21
    TabOrder = 0
    OnChange = ECaptionChange
  end
  object BOK: TButton
    Left = 113
    Top = 55
    Width = 75
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BCancel: TButton
    Left = 196
    Top = 55
    Width = 75
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
