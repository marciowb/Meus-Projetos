object Form1: TForm1
  Left = 165
  Top = 186
  Width = 123
  Height = 240
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Edit form'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 40
    Width = 97
    Height = 25
    Caption = 'Stop editing'
    TabOrder = 1
    OnClick = Button3Click
  end
  object Button1: TButton
    Left = 8
    Top = 72
    Width = 97
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button4: TButton
    Left = 8
    Top = 104
    Width = 97
    Height = 25
    Caption = 'Load'
    TabOrder = 3
    OnClick = Button4Click
  end
  object IDEEngine1: TIDEEngine
    Options.AutoHideTabControl = True
    FileExtPascalUnit = '.psc'
    FileExtForm = '.sfm'
    FileExtBasicUnit = '.bsc'
    Left = 216
    Top = 64
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.dfm'
    Filter = 'Form files (*.dfm)|*.dfm|Any file (*.*)|*.*'
    Left = 8
    Top = 136
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dfm'
    Filter = 'Form files (*.dfm)|*.dfm|Any file (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 40
    Top = 136
  end
end
