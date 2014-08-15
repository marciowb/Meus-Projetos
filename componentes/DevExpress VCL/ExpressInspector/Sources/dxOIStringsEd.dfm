object dxfmStringsEditor: TdxfmStringsEditor
  Left = 370
  Top = 256
  Width = 486
  Height = 398
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'String List Editor'
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    000000000000000000000000000000FFFFFFFFFFFF0000FFFFFFFFFFFF0000F0
    000000000F0000FFFFFFFFFFFF0000F000000000FF0000FFFFFFFFFFFF0000F0
    0000FFFFFF0000FFFFFFFFFFFF0000F00000000FFF0000FFFFFFFFFFFF0000F0
    00000000FF0000FFFFFFFFFFFF0000000000000000000000000000000000FFFF
    0000800100008001000080010000800100008001000080010000800100008001
    0000800100008001000080010000800100008001000080010000FFFF0000}
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object pnlBottom: TPanel
    Left = 0
    Top = 321
    Width = 478
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object pnlBottomRight: TPanel
      Left = 177
      Top = 0
      Width = 301
      Height = 49
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnOK: TButton
        Left = 89
        Top = 12
        Width = 99
        Height = 29
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
      object btnCancel: TButton
        Left = 196
        Top = 12
        Width = 98
        Height = 29
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 478
    Height = 321
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object GroupBox: TGroupBox
      Left = 5
      Top = 5
      Width = 468
      Height = 311
      Align = alClient
      TabOrder = 0
      object pnlClientTop: TPanel
        Left = 2
        Top = 18
        Width = 464
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 1
          Width = 41
          Height = 16
          Caption = 'Label1'
        end
      end
      object pnlClientClient: TPanel
        Left = 2
        Top = 42
        Width = 464
        Height = 267
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        TabOrder = 1
        object Memo1: TMemo
          Left = 5
          Top = 5
          Width = 454
          Height = 257
          Align = alClient
          Lines.Strings = (
            'Memo1')
          TabOrder = 0
          OnChange = Memo1Change
        end
      end
    end
  end
end
