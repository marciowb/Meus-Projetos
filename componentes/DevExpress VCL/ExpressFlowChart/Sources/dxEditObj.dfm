object FEditObject: TFEditObject
  Left = 368
  Top = 185
  BorderStyle = bsDialog
  Caption = 'Edit Object'
  ClientHeight = 383
  ClientWidth = 379
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object PageControl: TPageControl
    Left = 10
    Top = 10
    Width = 359
    Height = 332
    ActivePage = tsGeneral
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = 'General'
      object Label1: TLabel
        Left = 76
        Top = 67
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Text'
      end
      object Label2: TLabel
        Left = 40
        Top = 140
        Width = 58
        Height = 13
        Alignment = taRightJustify
        Caption = 'Text Layout'
      end
      object Label3: TLabel
        Left = 41
        Top = 169
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'Shape Type'
      end
      object Label4: TLabel
        Left = 48
        Top = 196
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Line Width'
      end
      object Label6: TLabel
        Left = 67
        Top = 13
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Height'
      end
      object Label7: TLabel
        Left = 70
        Top = 40
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Width'
      end
      object sbFont: TSpeedButton
        Left = 312
        Top = 64
        Width = 29
        Height = 28
        Hint = 'Font'
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
        Left = 40
        Top = 223
        Width = 58
        Height = 13
        Alignment = taRightJustify
        Caption = 'Shape Color'
      end
      object Label9: TLabel
        Left = 19
        Top = 248
        Width = 79
        Height = 13
        Alignment = taRightJustify
        Caption = 'BackGroud Color'
      end
      object memoText: TMemo
        Left = 103
        Top = 64
        Width = 203
        Height = 69
        TabOrder = 0
        OnChange = seHeightChange
      end
      object cbTextPosition: TComboBox
        Left = 103
        Top = 139
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = seHeightChange
      end
      object cbShapeStyle: TComboBox
        Left = 103
        Top = 166
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = seHeightChange
        Items.Strings = (
          'None'
          'Rectangle'
          'Ellipse'
          'Round Rect'
          'Diamond'
          'North Triangle'
          'South Triangle'
          'East Triangle'
          'West Triangle'
          'Hexagon')
      end
      object pColor: TPanel
        Left = 103
        Top = 220
        Width = 19
        Height = 19
        TabOrder = 3
        OnClick = pColorClick
      end
      object pBkColor: TPanel
        Left = 103
        Top = 245
        Width = 19
        Height = 19
        TabOrder = 4
        OnClick = pColorClick
      end
      object cbTransparent: TCheckBox
        Left = 32
        Top = 270
        Width = 84
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Transparent'
        TabOrder = 5
        OnClick = seHeightChange
      end
      object seHeight: TEdit
        Left = 103
        Top = 10
        Width = 145
        Height = 21
        TabOrder = 6
        OnChange = seHeightChange
        OnKeyPress = seHeightKeyPress
      end
      object seWidth: TEdit
        Left = 103
        Top = 37
        Width = 145
        Height = 21
        TabOrder = 7
        OnChange = seHeightChange
        OnKeyPress = seHeightKeyPress
      end
      object seShapeWidth: TEdit
        Left = 104
        Top = 193
        Width = 144
        Height = 21
        TabOrder = 8
        OnChange = seHeightChange
        OnKeyPress = seHeightKeyPress
      end
    end
    object tsImage: TTabSheet
      Caption = 'Image'
      object Label5: TLabel
        Left = 8
        Top = 275
        Width = 66
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Image Layout'
      end
      object lwImage: TListView
        Left = 8
        Top = 8
        Width = 333
        Height = 256
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <>
        HideSelection = False
        ReadOnly = True
        TabOrder = 0
        OnClick = seHeightChange
      end
      object cbImagePosition: TComboBox
        Left = 88
        Top = 272
        Width = 172
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 1
        OnChange = seHeightChange
      end
      object btnClear: TButton
        Left = 266
        Top = 270
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Clear Image'
        TabOrder = 2
        OnClick = btnClearClick
      end
    end
    object tsFrame: TTabSheet
      Caption = 'Frame'
      object GroupBox1: TGroupBox
        Left = 12
        Top = 12
        Width = 325
        Height = 77
        Caption = ' Edge Style '
        TabOrder = 0
        object cbRaisedOut: TCheckBox
          Left = 18
          Top = 23
          Width = 100
          Height = 17
          Caption = 'RaisedOut'
          TabOrder = 0
          OnClick = seHeightChange
        end
        object cbSunkenOut: TCheckBox
          Left = 18
          Top = 46
          Width = 100
          Height = 17
          Caption = 'SunkenOut'
          TabOrder = 1
          OnClick = seHeightChange
        end
        object cbRaisedIn: TCheckBox
          Left = 124
          Top = 23
          Width = 101
          Height = 17
          Caption = 'RaisedIn'
          TabOrder = 2
          OnClick = seHeightChange
        end
        object cbSunkenIn: TCheckBox
          Left = 124
          Top = 46
          Width = 101
          Height = 17
          Caption = 'SunkenIn'
          TabOrder = 3
          OnClick = seHeightChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 12
        Top = 102
        Width = 325
        Height = 123
        Caption = ' Border Style '
        TabOrder = 1
        object cbLeft: TCheckBox
          Left = 124
          Top = 22
          Width = 41
          Height = 17
          Caption = 'Left'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = seHeightChange
        end
        object cbTop: TCheckBox
          Left = 124
          Top = 45
          Width = 41
          Height = 17
          Caption = 'Top'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = seHeightChange
        end
        object cbRight: TCheckBox
          Left = 124
          Top = 68
          Width = 49
          Height = 17
          Caption = 'Right'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = seHeightChange
        end
        object cbBottom: TCheckBox
          Left = 124
          Top = 91
          Width = 57
          Height = 17
          Caption = 'Bottom'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = seHeightChange
        end
        object cbDiag: TCheckBox
          Left = 228
          Top = 91
          Width = 60
          Height = 17
          Caption = 'Diagonal'
          TabOrder = 4
          OnClick = seHeightChange
        end
        object cbMiddle: TCheckBox
          Left = 228
          Top = 68
          Width = 57
          Height = 17
          Caption = 'Middle'
          TabOrder = 5
          OnClick = seHeightChange
        end
        object cbSoft: TCheckBox
          Left = 228
          Top = 22
          Width = 41
          Height = 17
          Caption = 'Soft'
          TabOrder = 6
          OnClick = seHeightChange
        end
        object cbAdjust: TCheckBox
          Left = 228
          Top = 45
          Width = 49
          Height = 17
          Caption = 'Adjust'
          TabOrder = 7
          OnClick = seHeightChange
        end
        object cbMono: TCheckBox
          Left = 18
          Top = 45
          Width = 49
          Height = 17
          Caption = 'Mono'
          TabOrder = 8
          OnClick = seHeightChange
        end
        object cbFlat: TCheckBox
          Left = 18
          Top = 22
          Width = 41
          Height = 17
          Caption = 'Flat'
          TabOrder = 9
          OnClick = seHeightChange
        end
      end
    end
  end
  object btnOK: TButton
    Left = 213
    Top = 348
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 294
    Top = 348
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 294
    Top = 6
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen]
    Left = 334
    Top = 2
  end
end
