object FEditConnection: TFEditConnection
  Left = 389
  Top = 204
  BorderStyle = bsDialog
  Caption = 'Edit Connection'
  ClientHeight = 313
  ClientWidth = 424
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOK: TButton
    Left = 256
    Top = 281
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 339
    Top = 281
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox3: TGroupBox
    Left = 10
    Top = 10
    Width = 404
    Height = 265
    TabOrder = 2
    object sbFont: TSpeedButton
      Left = 363
      Top = 29
      Width = 29
      Height = 28
      Hint = 'Text Font'
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000D0000000E0000000100
        0400000000007000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        D00000DDDDDDDDDDD00000DDDDD000DDD000000DDDDD0DDDD00000DDDDDD0D0D
        D00000DDDDDD000DD0000000DDDD0D0DD000DDDDDDDD0DDD0000DDD00DD00000
        0000DDDDD0DDDDDDD000DDDDD0DDDDDDD000DDDD000DDDDDD000DDDDD0DDDDDD
        D000DDDDDD00DDDDD000}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbFontClick
    end
    object Label8: TLabel
      Left = 23
      Top = 231
      Width = 25
      Height = 13
      Caption = 'Color'
      Transparent = True
    end
    object Label9: TLabel
      Left = 23
      Top = 206
      Width = 62
      Height = 13
      Caption = 'Arrows Color'
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 12
      Width = 22
      Height = 13
      Caption = 'Text'
    end
    object pColor: TPanel
      Left = 105
      Top = 228
      Width = 19
      Height = 19
      BevelOuter = bvSpace
      TabOrder = 0
      OnClick = pColorClick
    end
    object pBkColor: TPanel
      Left = 105
      Top = 203
      Width = 19
      Height = 19
      BevelOuter = bvSpace
      TabOrder = 1
      OnClick = pColorClick
    end
    object GroupBox2: TGroupBox
      Left = 207
      Top = 92
      Width = 185
      Height = 101
      Caption = ' Destination '
      TabOrder = 2
      object Label5: TLabel
        Left = 11
        Top = 47
        Width = 51
        Height = 13
        Caption = 'Arrow Size'
      end
      object Label6: TLabel
        Left = 11
        Top = 74
        Width = 57
        Height = 13
        Caption = 'Linked Point'
      end
      object Label7: TLabel
        Left = 11
        Top = 20
        Width = 56
        Height = 13
        Caption = 'Arrow Style'
      end
      object seDPoint: TEdit
        Left = 90
        Top = 71
        Width = 84
        Height = 21
        TabOrder = 0
        OnChange = MemoTextChange
        OnKeyPress = seSPointKeyPress
      end
      object seDArrowSize: TEdit
        Left = 90
        Top = 44
        Width = 84
        Height = 21
        TabOrder = 1
        OnChange = MemoTextChange
        OnKeyPress = seSArrowSizeKeyPress
      end
      object cbDArrowStyle: TComboBox
        Left = 90
        Top = 17
        Width = 84
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = MemoTextChange
        Items.Strings = (
          'None'
          'Arrow'
          'Ellipse Arrow'
          'Rect Arrow')
      end
    end
    object GroupBox1: TGroupBox
      Left = 12
      Top = 92
      Width = 185
      Height = 101
      Caption = ' Source '
      TabOrder = 3
      object Label2: TLabel
        Left = 11
        Top = 20
        Width = 56
        Height = 13
        Caption = 'Arrow Style'
      end
      object Label3: TLabel
        Left = 11
        Top = 47
        Width = 51
        Height = 13
        Caption = 'Arrow Size'
      end
      object Label4: TLabel
        Left = 11
        Top = 74
        Width = 57
        Height = 13
        Caption = 'Linked Point'
      end
      object cbSArrowStyle: TComboBox
        Left = 90
        Top = 17
        Width = 84
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = MemoTextChange
        Items.Strings = (
          'None'
          'Arrow'
          'Ellipse Arrow'
          'Rect Arrow')
      end
      object seSArrowSize: TEdit
        Left = 90
        Top = 44
        Width = 84
        Height = 21
        TabOrder = 1
        OnChange = MemoTextChange
        OnKeyPress = seSArrowSizeKeyPress
      end
      object seSPoint: TEdit
        Left = 90
        Top = 71
        Width = 84
        Height = 21
        TabOrder = 2
        OnChange = MemoTextChange
        OnKeyPress = seSPointKeyPress
      end
    end
    object MemoText: TMemo
      Left = 12
      Top = 29
      Width = 345
      Height = 57
      Lines.Strings = (
        'MemoText')
      TabOrder = 4
      OnChange = MemoTextChange
    end
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen]
    Left = 236
    Top = 34
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 268
    Top = 34
  end
end
