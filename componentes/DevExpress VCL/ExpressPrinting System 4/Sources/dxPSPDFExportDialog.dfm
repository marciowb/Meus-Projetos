object dxPSPDFExportDialogForm: TdxPSPDFExportDialogForm
  Left = 397
  Top = 229
  BorderStyle = bsDialog
  Caption = 'PDF Export Options'
  ClientHeight = 365
  ClientWidth = 313
  Color = clBtnFace
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  Position = poScreenCenter
  object cxPageControl: TcxPageControl
    Left = 12
    Top = 12
    Width = 289
    Height = 307
    ActivePage = tbsExport
    ShowFrame = True
    TabOrder = 0
    ClientRectBottom = 306
    ClientRectLeft = 1
    ClientRectRight = 288
    ClientRectTop = 24
    object tbsExport: TcxTabSheet
      Caption = '&Export'
      ImageIndex = 0
      object gbExportSettings: TcxGroupBox
        Left = 8
        Top = 7
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' Export Settings '
        TabOrder = 0
        Height = 245
        Width = 270
        object cbEmbedFonts: TcxCheckBox
          Left = 11
          Top = 42
          Caption = 'Embed Fonts'
          TabOrder = 1
          Transparent = True
          Width = 246
        end
        object cbCompressed: TcxCheckBox
          Left = 11
          Top = 20
          Caption = 'Compressed'
          TabOrder = 0
          Transparent = True
          Width = 246
        end
        object cbJpgCompress: TcxCheckBox
          Left = 11
          Top = 86
          Caption = 'Use JPEG Compression for images'
          TabOrder = 3
          Transparent = True
          OnClick = cbJpgCompressClick
          Width = 246
        end
        object tbJpgCompression: TcxTrackBar
          Left = 20
          Top = 110
          Anchors = [akLeft, akTop, akRight]
          Properties.Frequency = 5
          Properties.Max = 100
          Properties.TickMarks = cxtmBoth
          TabOrder = 4
          Transparent = True
          Height = 25
          Width = 237
        end
        object lbMaxCompression: TcxLabel
          Left = 26
          Top = 139
          AutoSize = False
          Caption = 'Max Compression'
          Transparent = True
          Height = 17
          Width = 119
        end
        object lbMaxQuality: TcxLabel
          Left = 140
          Top = 139
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Max Quality'
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 17
          Width = 110
          AnchorX = 250
        end
        object cbUseCIDFonts: TcxCheckBox
          Left = 11
          Top = 64
          Caption = 'Use CID Fonts'
          TabOrder = 2
          Transparent = True
          Width = 246
        end
      end
      object cbOpenAfterExport: TcxCheckBox
        Left = 6
        Top = 255
        Caption = 'Open after export'
        TabOrder = 1
        Transparent = True
        Width = 270
      end
    end
    object tbsPageRange: TcxTabSheet
      Caption = '&Pages'
      ImageIndex = 1
      object lbDescription: TcxLabel
        Left = 14
        Top = 81
        AutoSize = False
        Caption = 
          'Enter page number and/or page ranges'#13#10'separated by commes. For e' +
          'xample : 1,3,5-12'
        Transparent = True
        Height = 31
        Width = 251
      end
      object edPageRanges: TcxTextEdit
        Left = 88
        Top = 56
        TabOrder = 4
        OnKeyPress = edPageRangesKeyPress
        Width = 177
      end
      object rbtnPageRanges: TcxRadioButton
        Tag = 2
        Left = 14
        Top = 58
        Width = 67
        Height = 17
        Caption = 'Pa&ges: '
        TabOrder = 3
        OnClick = rbtnPageRangesClick
        Transparent = True
      end
      object rbtnCurrentPage: TcxRadioButton
        Tag = 1
        Left = 14
        Top = 35
        Width = 104
        Height = 17
        Caption = 'Curr&ent page'
        TabOrder = 2
        OnClick = rbtnPageRangesClick
        Transparent = True
      end
      object rbtnAllPages: TcxRadioButton
        Left = 14
        Top = 12
        Width = 58
        Height = 17
        Caption = '&All'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rbtnPageRangesClick
        Transparent = True
      end
    end
    object tbsDocInfo: TcxTabSheet
      Caption = '&Document Information'
      ImageIndex = 2
      object teTitle: TcxTextEdit
        Left = 100
        Top = 8
        Anchors = [akTop, akRight]
        TabOrder = 0
        Width = 175
      end
      object lbTitle: TcxLabel
        Left = 11
        Top = 9
        Caption = 'Title'
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object lbAuthor: TcxLabel
        Left = 11
        Top = 36
        Caption = 'Author'
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object teAuthor: TcxTextEdit
        Left = 100
        Top = 35
        Anchors = [akTop, akRight]
        TabOrder = 1
        Width = 175
      end
      object lbSubject: TcxLabel
        Left = 11
        Top = 63
        Caption = 'Subject'
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object teSubject: TcxTextEdit
        Left = 100
        Top = 62
        Anchors = [akTop, akRight]
        TabOrder = 2
        Width = 175
      end
      object lbKeywords: TcxLabel
        Left = 11
        Top = 90
        Caption = 'Keywords'
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object teKeywords: TcxTextEdit
        Left = 100
        Top = 89
        Anchors = [akTop, akRight]
        TabOrder = 3
        Width = 175
      end
      object lbCreator: TcxLabel
        Left = 11
        Top = 117
        Caption = 'Creator'
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object teCreator: TcxTextEdit
        Left = 100
        Top = 116
        Anchors = [akTop, akRight]
        TabOrder = 4
        Width = 175
      end
    end
    object tbsSecurity: TcxTabSheet
      Caption = '&Security'
      ImageIndex = 3
      object gbSecuritySettings: TcxGroupBox
        Left = 8
        Top = 32
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' Security Settings '
        TabOrder = 1
        Height = 241
        Width = 270
        object cbAllowChanging: TcxCheckBox
          Left = 10
          Top = 120
          Caption = 'Allow Changing the document'
          TabOrder = 4
          Transparent = True
          Width = 249
        end
        object cbAllowPrinting: TcxCheckBox
          Left = 10
          Top = 98
          Caption = 'Allow Printing'
          TabOrder = 3
          Transparent = True
          Width = 249
        end
        object cbAllowComments: TcxCheckBox
          Left = 10
          Top = 164
          Caption = 'Allow Comments'
          TabOrder = 6
          Transparent = True
          Width = 249
        end
        object cbAllowContentCopying: TcxCheckBox
          Left = 10
          Top = 142
          Caption = 'Allow Content copying and extraction'
          TabOrder = 5
          Transparent = True
          Width = 249
        end
        object lbUserPassword: TcxLabel
          Left = 12
          Top = 19
          Caption = 'User Password:'
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object edUserPassword: TcxTextEdit
          Left = 137
          Top = 18
          Anchors = [akTop, akRight]
          Properties.EchoMode = eemPassword
          Properties.PasswordChar = '*'
          TabOrder = 0
          Width = 117
        end
        object lbOwnerPassword: TcxLabel
          Left = 12
          Top = 46
          Caption = 'Owner Password:'
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object edOwnerPassword: TcxTextEdit
          Left = 137
          Top = 45
          Anchors = [akTop, akRight]
          Properties.EchoMode = eemPassword
          Properties.PasswordChar = '*'
          TabOrder = 1
          Width = 117
        end
        object cbAllowDocumentAssembly: TcxCheckBox
          Left = 10
          Top = 186
          Caption = 'Allow Document assembly'
          TabOrder = 7
          Transparent = True
          Width = 249
        end
        object cbAllowPrintingHiResolution: TcxCheckBox
          Left = 10
          Top = 208
          Caption = 'Allow Printing with high resolution'
          TabOrder = 8
          Transparent = True
          Width = 249
        end
        object lbMethod: TcxLabel
          Left = 12
          Top = 74
          Caption = 'Method:'
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cbxMethod: TcxComboBox
          Left = 137
          Top = 72
          Anchors = [akTop, akRight]
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'RC4: 40 Bit '
            'RC4: 128 Bit ')
          Properties.OnChange = cbxMethodPropertiesChange
          TabOrder = 2
          Text = 'RC4: 40 Bit '
          Width = 117
        end
      end
      object cbSecurityEnable: TcxCheckBox
        Left = 8
        Top = 7
        Caption = 'Enable'
        TabOrder = 0
        Transparent = True
        OnClick = cbSecurityEnableClick
        Width = 270
      end
    end
  end
  object btnOk: TcxButton
    Left = 125
    Top = 330
    Width = 85
    Height = 23
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 216
    Top = 330
    Width = 85
    Height = 23
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
