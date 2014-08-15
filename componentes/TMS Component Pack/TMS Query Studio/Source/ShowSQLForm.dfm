object fmShowSQL: TfmShowSQL
  Left = 189
  Top = 140
  Width = 454
  Height = 308
  Caption = 'Show SQL'
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
  object Panel1: TPanel
    Left = 0
    Top = 245
    Width = 446
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel3: TPanel
      Left = 367
      Top = 0
      Width = 79
      Height = 29
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Button1: TButton
        Left = 4
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Close'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 446
    Height = 245
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 446
      Height = 245
      Align = alClient
      TabOrder = 0
    end
  end
end
