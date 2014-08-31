object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'KeyGen'
  ClientHeight = 171
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 72
    Width = 74
    Height = 14
    Caption = 'Chave gerada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 17
    Top = 127
    Width = 113
    Height = 25
    Caption = 'Gerar serial'
    TabOrder = 0
    OnClick = Button1Click
  end
  object EdtSerial: TMaskEdit
    Left = 8
    Top = 91
    Width = 369
    Height = 26
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object edtString: TLabeledEdit
    Left = 8
    Top = 24
    Width = 368
    Height = 26
    EditLabel.Width = 55
    EditLabel.Height = 14
    EditLabel.Caption = 'String key'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object Button2: TButton
    Left = 140
    Top = 127
    Width = 113
    Height = 25
    Caption = 'Copiar Serial'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 263
    Top = 127
    Width = 113
    Height = 25
    Caption = 'Colar String key'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Computer: TJvComputerInfoEx
    Left = 272
    Top = 48
  end
  object Serial: TJvSerialMaker
    Base = 0
    Left = 240
    Top = 48
  end
end
