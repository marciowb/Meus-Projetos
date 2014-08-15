object fmSelectLanguage: TfmSelectLanguage
  Left = 354
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Select language'
  ClientHeight = 99
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 14
    Width = 157
    Height = 13
    Caption = 'Select the script language for %s:'
  end
  object ComboBox1: TComboBox
    Left = 15
    Top = 31
    Width = 217
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'Pascal'
      'Basic')
  end
  object Button1: TButton
    Left = 40
    Top = 60
    Width = 80
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 126
    Top = 60
    Width = 79
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
