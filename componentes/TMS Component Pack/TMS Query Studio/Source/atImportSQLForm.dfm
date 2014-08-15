object fmImportSQL: TfmImportSQL
  Left = 144
  Top = 91
  Width = 544
  Height = 375
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Import from SQL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 536
    Height = 316
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 316
    Width = 536
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btCheck: TButton
      Left = 3
      Top = 5
      Width = 97
      Height = 25
      Caption = '&Check syntax'
      TabOrder = 0
      OnClick = btCheckClick
    end
    object btOk: TButton
      Left = 103
      Top = 5
      Width = 85
      Height = 25
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = btOkClick
    end
    object btcancel: TButton
      Left = 192
      Top = 5
      Width = 85
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
  end
end
