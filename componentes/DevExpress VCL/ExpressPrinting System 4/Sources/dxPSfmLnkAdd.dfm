object dxfmAddComponent: TdxfmAddComponent
  Left = 412
  Top = 157
  BorderStyle = bsDialog
  ClientHeight = 484
  ClientWidth = 406
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 398
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000000000000000000000FFFFFFFFF0000000F
    FFFFFFFF0000000FFFFFFFFF0000000FFFFFFFFF0000000FFFFFFFFF0000000F
    FFFFFFFF0000000FFFFFFFFF0000000FFFFFFFFF0000000FFFFFF0000000000F
    FFFFF0F00000000FFFFFF000000000000000000000000000000000000000FFFF
    0000FFFF0000C0070000C0070000C0070000C0070000C0070000C0070000C007
    0000C0070000C0070000C0070000C00F0000C01F0000C03F0000FFFF0000}
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object pnlHost: TPanel
    Left = 12
    Top = 12
    Width = 382
    Height = 427
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 4
    object pgctrlItems: TcxPageControl
      Left = 0
      Top = 107
      Width = 382
      Height = 320
      ActivePage = tbsItems
      Align = alClient
      ShowFrame = True
      TabOrder = 3
      ClientRectBottom = 319
      ClientRectLeft = 1
      ClientRectRight = 381
      ClientRectTop = 24
      object tbsItems: TcxTabSheet
        BorderWidth = 10
        Caption = '&Available Components'
        ImageIndex = 0
        object lvItems: TcxListView
          Left = 0
          Top = 0
          Width = 360
          Height = 201
          Align = alClient
          Columns = <>
          HideSelection = False
          MultiSelect = True
          PopupMenu = pmItems
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnChange = lvItemsChange
          OnColumnClick = lvItemsColumnClick
          OnCompare = lvItemsCompare
          OnDblClick = lvItemsDblClick
        end
        object pnlNoItems: TcxLabel
          Left = 8
          Top = 66
          TabStop = False
          AutoSize = False
          Caption = 'There are no Items in this View'
          ParentColor = False
          ParentFont = False
          Style.TextColor = clBtnShadow
          Properties.Alignment.Horz = taCenter
          Transparent = True
          Height = 19
          Width = 345
          AnchorX = 181
        end
        object pnlBottomHost: TcxGroupBox
          Left = 0
          Top = 201
          Align = alBottom
          PanelStyle.Active = True
          ParentBackground = False
          ParentColor = False
          Style.BorderStyle = ebsNone
          Style.Color = clBtnFace
          Style.TransparentBorder = False
          TabOrder = 2
          Height = 74
          Width = 360
          object bvlOnlyUnLinked: TBevel
            Left = 0
            Top = 50
            Width = 360
            Height = 24
            Align = alTop
            Shape = bsSpacer
          end
          object bvlHideCustomContainers: TBevel
            Left = 0
            Top = 0
            Width = 360
            Height = 26
            Align = alTop
            Shape = bsSpacer
          end
          object bvlOnlyInCurrentModule: TBevel
            Left = 0
            Top = 26
            Width = 360
            Height = 24
            Align = alTop
            Shape = bsSpacer
          end
          object chbxOnlyUnLinked: TcxCheckBox
            Left = -1
            Top = 53
            Caption = 'Only Components &without Existing ReportLinks'
            Style.TransparentBorder = False
            TabOrder = 2
            Transparent = True
            OnClick = chbxClick
            Width = 368
          end
          object chbxOnlyInCurrentModule: TcxCheckBox
            Left = -1
            Top = 29
            Caption = 'Only Components in the Active &Form'
            Style.TransparentBorder = False
            TabOrder = 1
            Transparent = True
            OnClick = chbxClick
            Width = 368
          end
          object chbxHideCustomContainers: TcxCheckBox
            Left = -1
            Top = 5
            Caption = 'Hide Custom Containers'
            Style.TransparentBorder = False
            TabOrder = 0
            Transparent = True
            OnClick = chbxClick
            Width = 368
          end
        end
      end
    end
    object bvlSeparator: TcxLabel
      Left = 0
      Top = 90
      Align = alTop
      AutoSize = False
      Properties.LineOptions.Visible = True
      Transparent = True
      Height = 17
      Width = 382
    end
    object pnlNameHost: TPanel
      Left = 0
      Top = 0
      Width = 382
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblName: TcxLabel
        Left = 6
        Top = 5
        Caption = '&Name:'
        Transparent = True
      end
      object edName: TcxTextEdit
        Left = 55
        Top = 5
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Width = 236
      end
    end
    object pnlCreatorHost: TPanel
      Left = 0
      Top = 60
      Width = 382
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object lblCreator: TcxLabel
        Left = 6
        Top = 7
        Caption = 'Creato&r:'
        Transparent = True
      end
      object btnDescription: TcxButton
        Left = 299
        Top = 5
        Width = 83
        Height = 23
        Anchors = [akTop, akRight]
        Caption = '&Description...'
        TabOrder = 2
        OnClick = btnDescriptionClick
      end
      object edCreator: TcxTextEdit
        Left = 55
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Width = 236
      end
    end
    object pnlCaptionHost: TPanel
      Left = 0
      Top = 30
      Width = 382
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblCaption: TcxLabel
        Left = 6
        Top = 6
        Caption = '&Caption:'
        Transparent = True
      end
      object edCaption: TcxTextEdit
        Left = 55
        Top = 5
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Width = 236
      end
    end
  end
  object btnOK: TcxButton
    Left = 36
    Top = 449
    Width = 85
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TcxButton
    Left = 127
    Top = 449
    Width = 85
    Height = 23
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'OK'
    ModalResult = 2
    TabOrder = 1
  end
  object btnHelp: TcxButton
    Left = 309
    Top = 449
    Width = 85
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 3
  end
  object btnDesign: TcxButton
    Left = 218
    Top = 449
    Width = 85
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnDesignClick
  end
  object pmItems: TPopupMenu
    Images = ilItems
    OnPopup = pmItemsPopup
    Left = 142
    Top = 323
    object miAdd: TMenuItem
      Caption = '&Add'
      Default = True
      OnClick = lvItemsDblClick
    end
    object miLine1: TMenuItem
      Caption = '-'
    end
    object miDesign: TMenuItem
      Caption = 'Add and D&esign Report...'
      ImageIndex = 0
      OnClick = btnDesignClick
    end
  end
  object ilColumns: TImageList
    AllocBy = 2
    Height = 8
    Width = 8
    Left = 170
    Top = 323
    Bitmap = {
      494C010102000400200008000800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000200000000800000001002000000000000004
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800000000000000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000020000000080000000100010000000000200000000000000000000000
      000000000000000000000000FFFFFF00FFFF0000FFFF000080F70000C1E30000
      E3C10000F7800000FFFF0000FFFF000000000000000000000000000000000000
      000000000000}
  end
  object ilItems: TcxImageList
    FormatVersion = 1
    DesignInfo = 21168242
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000001000000010000000A0000001B0000001D0000
          000C000000020000000100000000000000000000000000000000000000000000
          00000000000100000005000000060000000B0A08053A624C35E2604B34E30C09
          0749000000110000000A00000009000000030000000000000000000000000000
          00010000000916120D431C1610560907053D544635BFA99A8AFF9D8D7AFF5241
          30CB0806045118130D6814100A59000000160000000300000000000000000000
          000318130E41917C63FD947F68FF7D654BFAA89887FFC2B9AFFFB6ACA0FF9D8D
          7BFF765E44FB816B51FF7D654BFD17120C5F0000000A00000001000000000000
          00031C16104798836CFFE7E4E0FFC5BDB3FFCEC6BDFFCCC3BAFFC2BAAFFFB6AC
          A0FFB6AA9FFFB6AA9FFF826B52FF1A140D6B0000000B00000001000000000000
          000409070626876E54F9D9D3CEFFD1C9C1FFCFC7BFFFD9D3CCFFE7E2DEFFE5E1
          DDFFD5CFC7FFB6AB9FFF765E44FB080604510000001000000002000000020A08
          061C615040B4BEB2A4FFD3CCC6FFD2CBC4FFB5A89AFF98846EFF99846FFFC9BE
          B3FFE6E1DDFFB6ACA1FF9E8E7DFF534331CD0806043F0000000B000000046853
          3FC5CABFB4FFE0DCD8FFD5CFC9FFCBC5BDFF917B64FF2019123F1F19123F9984
          70FFE7E3DEFFC4BAB1FFB6ACA1FF9E8E7CFF584530D60000001B00000003725C
          46D5CEC3B9FFF1EFEDFFE0DCD8FFC4BDB5FF917B64FF2019133F1F19123F9883
          6EFFD9D3CCFFCCC4BBFFC4BAB1FFAB9D8DFF624C35E20000001A000000010D0B
          081D645543B1CEC3B8FFF1EFEDFFC6BFB9FFAA9D8EFF917C65FF917C64FFB6A8
          9AFFCFC7C0FFCEC6BDFFAC9E8DFF594938C60D0A07400000000A000000000000
          00010A0806198D775EF8EAE7E4FFCFCAC5FFC6C0B9FFC4BDB6FFCBC6BEFFD2CC
          C5FFD1CAC3FFC6BEB6FF7D654BFA0907053E0000000C00000002000000000000
          00001E19123AA18D77FFEFEDEBFFEBE7E4FFF1EFEDFFE1DED9FFD5CFCAFFD3CD
          C7FFD9D4CFFFE7E4E1FF95806AFF1D1710590000000700000001000000000000
          000019150F2F9D8971FDA18D77FF8D775DF8C9BEB2FFF1EFEDFFE1DEDAFFBEB2
          A5FF876E54F998836BFF927C65FD19140E490000000500000000000000000000
          0000000000001915102F1E19123A0A0806195F5040A8C9BEB2FFCAC0B5FF6151
          40B4090706261C16104718130E41000000090000000200000000000000000000
          0000000000000000000000000000000000010D0B081D766048DD766047DE0E0B
          0826000000040000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000003000000050000
          0002000000010000000000000000000000000000000000000000}
      end>
  end
end
