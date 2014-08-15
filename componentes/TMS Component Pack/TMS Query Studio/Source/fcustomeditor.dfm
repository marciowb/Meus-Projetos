object fmCustomEditor: TfmCustomEditor
  Left = 249
  Top = 220
  BorderStyle = bsToolWindow
  Caption = 'fmCustomEditor'
  ClientHeight = 159
  ClientWidth = 336
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnBottom: TPanel
    Left = 0
    Top = 119
    Width = 336
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object pnButton: TPanel
      Left = 75
      Top = 2
      Width = 185
      Height = 31
      Anchors = [akTop]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object btOk: TBitBtn
        Left = 13
        Top = 3
        Width = 75
        Height = 25
        Caption = '&Ok'
        ModalResult = 1
        TabOrder = 0
        OnClick = btOkClick
        NumGlyphs = 2
      end
      object btCancel: TBitBtn
        Left = 96
        Top = 3
        Width = 75
        Height = 25
        Cancel = True
        Caption = '&Cancel'
        ModalResult = 2
        TabOrder = 1
        NumGlyphs = 2
      end
    end
  end
  object pnTitle: TPanel
    Left = 0
    Top = 0
    Width = 336
    Height = 20
    Align = alTop
    BorderWidth = 3
    TabOrder = 0
  end
  object pnInfo: TPanel
    Left = 0
    Top = 20
    Width = 336
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 6
    ParentColor = True
    TabOrder = 2
    object lbInfo: TLabel
      Left = 6
      Top = 6
      Width = 324
      Height = 25
      Align = alClient
      Caption = 'lbInfo'
      WordWrap = True
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 8
    Top = 123
  end
end
