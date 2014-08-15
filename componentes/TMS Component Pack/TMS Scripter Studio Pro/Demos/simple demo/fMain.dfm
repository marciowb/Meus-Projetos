object Form1: TForm1
  Left = 276
  Top = 148
  Width = 650
  Height = 462
  Caption = 'Running scripts'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Run script'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Open script'
    TabOrder = 1
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.pas'
    Filter = '|*.pas||*.psc'
    InitialDir = '.'
    Left = 168
    Top = 2
  end
end
