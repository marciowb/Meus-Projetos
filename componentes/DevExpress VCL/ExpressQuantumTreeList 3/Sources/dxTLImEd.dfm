object FdxTLImageValuesEdit: TFdxTLImageValuesEdit
  Left = 506
  Top = 111
  Width = 432
  Height = 368
  BorderIcons = [biSystemMenu]
  Caption = 'Values'
  PopupMenu = PopupMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 332
    Top = 0
    Width = 92
    Height = 341
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object BOk: TButton
      Left = 10
      Top = 9
      Width = 75
      Height = 22
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
    end
    object BCancel: TButton
      Left = 10
      Top = 43
      Width = 75
      Height = 22
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 0
      Top = 300
      Width = 92
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 5
      object BHelp: TButton
        Left = 10
        Top = 11
        Width = 75
        Height = 22
        Caption = '&Help'
        TabOrder = 0
      end
    end
    object BAdd: TButton
      Left = 10
      Top = 104
      Width = 75
      Height = 22
      Caption = '&Add'
      TabOrder = 2
      OnClick = BAddClick
    end
    object BDelete: TButton
      Left = 10
      Top = 170
      Width = 75
      Height = 22
      Caption = '&Delete'
      TabOrder = 3
      OnClick = BDeleteClick
    end
    object BInsert: TButton
      Left = 10
      Top = 137
      Width = 75
      Height = 22
      Caption = '&Insert'
      TabOrder = 4
      OnClick = BInsertClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 86
    Top = 34
    object miAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BAddClick
    end
    object miInsert: TMenuItem
      Caption = '&Insert'
      OnClick = BInsertClick
    end
    object miDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 16430
      OnClick = BDeleteClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miHelp: TMenuItem
      Caption = '&Help'
    end
  end
end
