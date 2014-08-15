object cxGridViewLayoutEditor: TcxGridViewLayoutEditor
  Left = 350
  Top = 204
  Width = 698
  Height = 384
  BorderIcons = [biSystemMenu]
  Caption = 'Layout and Data Editor'
  Color = clBtnFace
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 315
    Width = 690
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object pnlButtons: TPanel
      Left = 521
      Top = 0
      Width = 169
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object btnOK: TButton
        Left = 4
        Top = 5
        Width = 75
        Height = 25
        Caption = 'OK'
        ModalResult = 1
        TabOrder = 0
      end
      object btnCancel: TButton
        Left = 88
        Top = 5
        Width = 75
        Height = 25
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
    object pnlLayoutCustomization: TPanel
      Left = 0
      Top = 0
      Width = 153
      Height = 35
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object btnLayoutCustomization: TButton
        Left = 8
        Top = 5
        Width = 134
        Height = 25
        TabOrder = 0
        OnClick = btnLayoutCustomizationClick
      end
    end
    object pnlSaveOptions: TPanel
      Left = 153
      Top = 0
      Width = 192
      Height = 35
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object chbSaveLayout: TCheckBox
        Left = 11
        Top = 9
        Width = 81
        Height = 17
        Caption = 'Save layout'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chbSaveData: TCheckBox
        Left = 107
        Top = 9
        Width = 81
        Height = 17
        Caption = 'Save data'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 690
    Height = 315
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    Constraints.MinHeight = 200
    Constraints.MinWidth = 300
    TabOrder = 1
  end
  object pmGrid: TcxGridPopupMenu
    PopupMenus = <>
    Left = 400
    Top = 319
  end
end
