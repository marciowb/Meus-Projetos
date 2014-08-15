object dxfmPictureEditor: TdxfmPictureEditor
  Left = 295
  Top = 158
  Width = 464
  Height = 384
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Picture Editor'
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0007EEE700000000074EEEEE00000000747EEEEE60000004447EEEEE66007400
    4470EEE776604474C47068F8776004474C70068F877000C7C4703068F870000C
    CC70BB3667000000CC70BB33370000003C70BB33300000003B80BB3330000000
    3BBBBB333000000038888883300000000388888830000000003000000000FE0F
    0000F8070000F0030000E0010000300000000000000080800000C0000000E001
    0000F0030000F0030000F0030000F0030000F0030000F8030000FC030000}
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox: TGroupBox
    Left = 0
    Top = 0
    Width = 456
    Height = 316
    Align = alClient
    TabOrder = 0
    object pnlRight: TPanel
      Left = 344
      Top = 18
      Width = 110
      Height = 296
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnLoad: TButton
        Left = 7
        Top = 7
        Width = 98
        Height = 29
        Caption = '&Load...'
        TabOrder = 0
        OnClick = btnLoadClick
      end
      object btnSave: TButton
        Left = 7
        Top = 42
        Width = 98
        Height = 28
        Caption = '&Save...'
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnCopy: TButton
        Left = 7
        Top = 76
        Width = 98
        Height = 28
        Caption = '&Copy'
        TabOrder = 2
        OnClick = btnCopyClick
      end
      object btnPaste: TButton
        Left = 7
        Top = 111
        Width = 98
        Height = 28
        Caption = '&Paste'
        TabOrder = 3
        OnClick = btnPasteClick
      end
      object btnClear: TButton
        Left = 7
        Top = 145
        Width = 98
        Height = 28
        Caption = 'C&lear'
        TabOrder = 4
        OnClick = btnClearClick
      end
    end
    object pnlClient: TPanel
      Left = 2
      Top = 18
      Width = 342
      Height = 296
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 6
      Caption = 'pnlClient'
      TabOrder = 1
      object Panel3: TPanel
        Left = 6
        Top = 6
        Width = 330
        Height = 284
        Align = alClient
        BevelOuter = bvLowered
        Caption = '(None)'
        Color = clWindow
        TabOrder = 0
        object Image: TImage
          Left = 1
          Top = 1
          Width = 328
          Height = 282
          Align = alClient
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 316
    Width = 456
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnlBottomRight: TPanel
      Left = 211
      Top = 0
      Width = 245
      Height = 40
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnCancel: TButton
        Left = 138
        Top = 8
        Width = 99
        Height = 28
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 0
      end
      object btnOk: TButton
        Left = 28
        Top = 8
        Width = 99
        Height = 28
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 1
      end
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Filter = 
      'All (*.gif;*.bmp;*.ico;*.emf;*.wmf)|*.gif;*.bmp;*.ico;*.emf;*.wm' +
      'f|CompuServe GIF Image (*.gif)|*.gif|Bitmaps (*.bmp)|*.bmp|Icons' +
      ' (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf' +
      ')|*.wmf'
    Left = 6
    Top = 240
  end
  object SavePictureDialog: TSavePictureDialog
    Filter = 
      'All (*.gif;*.bmp;*.ico;*.emf;*.wmf)|*.gif;*.bmp;*.ico;*.emf;*.wm' +
      'f|CompuServe GIF Image (*.gif)|*.gif|Bitmaps (*.bmp)|*.bmp|Icons' +
      ' (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf' +
      ')|*.wmf'
    Left = 34
    Top = 240
  end
  object pmImage: TPopupMenu
    OnPopup = pmImagePopup
    Left = 62
    Top = 240
    object miLoad: TMenuItem
      Caption = '&Load...'
      OnClick = btnLoadClick
    end
    object miSave: TMenuItem
      Caption = '&Save...'
      ShortCut = 16467
      OnClick = btnSaveClick
    end
    object miLine: TMenuItem
      Caption = '-'
    end
    object miCopy: TMenuItem
      Caption = '&Copy'
      ShortCut = 16451
      OnClick = btnCopyClick
    end
    object miPaste: TMenuItem
      Caption = '&Paste'
      ShortCut = 16464
      OnClick = btnPasteClick
    end
    object miLne2: TMenuItem
      Caption = '-'
    end
    object miClear: TMenuItem
      Caption = 'C&lear'
      OnClick = btnClearClick
    end
  end
end
