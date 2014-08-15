object cxGridViewLayoutEditor: TcxGridViewLayoutEditor
  Left = 350
  Top = 204
  Width = 551
  Height = 384
  BorderIcons = [biSystemMenu]
  Caption = 'Layout Editor...'
  Color = clBtnFace
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 318
    Width = 543
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object pnlButtons: TPanel
      Left = 374
      Top = 0
      Width = 169
      Height = 32
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnOK: TButton
        Left = 5
        Top = 4
        Width = 75
        Height = 25
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
      object bntCancel: TButton
        Left = 88
        Top = 3
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
    object btnColumnsCustomization: TButton
      Left = 3
      Top = 3
      Width = 134
      Height = 25
      Caption = 'Columns Customization'
      TabOrder = 1
      OnClick = btnColumnsCustomizationClick
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 543
    Height = 318
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    Constraints.MinHeight = 200
    Constraints.MinWidth = 300
    TabOrder = 1
  end
end
