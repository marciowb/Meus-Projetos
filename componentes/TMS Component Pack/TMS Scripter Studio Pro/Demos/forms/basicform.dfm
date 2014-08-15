object fmBasicForm: TfmBasicForm
  Left = 607
  Top = 4
  Width = 325
  Height = 151
  Caption = 'This is the Basic form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 121
    Height = 97
    Caption = 'Options'
    Items.Strings = (
      'First item'
      'Second item'
      'Third item')
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 32
    Width = 113
    Height = 25
    Caption = 'Retrieve item'
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 168
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
end
