object FdxDBInspectorColumnSelect: TFdxDBInspectorColumnSelect
  Left = 431
  Top = 106
  ActiveControl = ComboBox
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Select row type'
  ClientHeight = 68
  ClientWidth = 256
  PixelsPerInch = 96
  TextHeight = 13
  object LType: TLabel
    Left = 5
    Top = 12
    Width = 24
    Height = 13
    Caption = 'Type'
  end
  object BOk: TButton
    Left = 7
    Top = 40
    Width = 75
    Height = 22
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object BCancel: TButton
    Left = 91
    Top = 40
    Width = 75
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object BHelp: TButton
    Left = 176
    Top = 40
    Width = 75
    Height = 22
    Caption = 'Help'
    TabOrder = 2
  end
  object ComboBox: TComboBox
    Left = 46
    Top = 8
    Width = 204
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
end
