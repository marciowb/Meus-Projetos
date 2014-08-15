object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Criptografia'
  ClientHeight = 116
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 161
    Height = 13
    Caption = 'Informe o texto para criptografar'
  end
  object edtKrip: TEdit
    Left = 16
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 143
    Top = 38
    Width = 95
    Height = 25
    Caption = 'Criptografar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 143
    Top = 78
    Width = 95
    Height = 25
    Caption = 'Descriptografar'
    TabOrder = 2
    Visible = False
    OnClick = Button2Click
  end
  object edtDekrip: TEdit
    Left = 16
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 3
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 262
    Top = 0
    Width = 185
    Height = 116
    Align = alRight
    Caption = ' Resultado '
    TabOrder = 4
    ExplicitLeft = 272
    ExplicitTop = 24
    ExplicitHeight = 105
    object mmResultado: TMemo
      Left = 2
      Top = 15
      Width = 181
      Height = 99
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
