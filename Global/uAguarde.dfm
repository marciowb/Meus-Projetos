object frmAguarde: TfrmAguarde
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 230
  BorderStyle = bsNone
  ClientHeight = 101
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCanResize = FormCanResize
  PixelsPerInch = 96
  TextHeight = 13
  object LblMsg: TJvLabel
    Left = 127
    Top = 24
    Width = 116
    Height = 25
    Caption = 'Aguarde ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    Layout = tlCenter
    ParentFont = False
    ShadowSize = 3
    ShadowPos = spLeftTop
    Transparent = True
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -21
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
  end
  object lblStatus: TLabel
    Left = 0
    Top = 88
    Width = 369
    Height = 13
    Align = alBottom
    Alignment = taCenter
    ExplicitWidth = 3
  end
  object ProgressBar: TcxProgressBar
    Left = 9
    Top = 56
    TabOrder = 0
    Width = 350
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 80
    Top = 16
  end
end
