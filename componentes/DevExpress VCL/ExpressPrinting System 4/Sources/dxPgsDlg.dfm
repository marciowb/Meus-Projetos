object dxfmPageSetupDialog: TdxfmPageSetupDialog
  Left = 280
  Top = 218
  BorderStyle = bsDialog
  Caption = 'Page Setup'
  ClientHeight = 460
  ClientWidth = 541
  Color = clBtnFace
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False 
  object pnlStyleName: TPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnOptions: TcxButton
      Left = 433
      Top = 12
      Width = 96
      Height = 23
      Caption = '&Options ...'
      TabOrder = 1
      OnClick = btnOptionsClick
    end
    object lblStyleName: TcxLabel
      Left = 11
      Top = 14
      Caption = 'Style &Name: '
      FocusControl = edStyleName
      Transparent = True
    end
    object edStyleName: TcxTextEdit
      Left = 83
      Top = 13
      TabOrder = 0
      OnExit = edStyleNameExit
      Width = 340
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 419
    Width = 541
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnPrintPreview: TcxButton
      Left = 114
      Top = 5
      Width = 96
      Height = 23
      Caption = 'Print Preview...'
      TabOrder = 1
      OnClick = btnPrintPreviewClick
    end
    object btnPrint: TcxButton
      Left = 12
      Top = 5
      Width = 96
      Height = 23
      Caption = 'Print...'
      TabOrder = 0
      OnClick = btnPrintClick
    end
    object btnOK: TcxButton
      Left = 262
      Top = 5
      Width = 85
      Height = 23
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object btnCancel: TcxButton
      Left = 353
      Top = 5
      Width = 85
      Height = 23
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
    end
    object btnHelp: TcxButton
      Left = 444
      Top = 5
      Width = 85
      Height = 23
      Caption = '&Help'
      TabOrder = 4
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 35
    Width = 541
    Height = 384
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pgctrlMain: TcxPageControl
      Left = 12
      Top = 12
      Width = 517
      Height = 365
      ActivePage = tshPage
      MultiLine = True
      ShowFrame = True
      TabOrder = 0
      OnChange = pgctrlMainChange
      OnPageChanging = pgctrlMainPageChanging
      ClientRectBottom = 364
      ClientRectLeft = 1
      ClientRectRight = 516
      ClientRectTop = 24
      object tshPage: TcxTabSheet
        Caption = '&Page'
        object Bevel4: TBevel
          Left = 240
          Top = 9
          Width = 9
          Height = 322
          Align = alLeft
          Shape = bsSpacer
        end
        object Bevel5: TBevel
          Left = 0
          Top = 9
          Width = 9
          Height = 322
          Align = alLeft
          Shape = bsSpacer
        end
        object Bevel6: TBevel
          Left = 506
          Top = 9
          Width = 9
          Height = 322
          Align = alRight
          Shape = bsSpacer
        end
        object Bevel2: TBevel
          Left = 0
          Top = 331
          Width = 515
          Height = 9
          Align = alBottom
          Shape = bsSpacer
        end
        object Bevel8: TBevel
          Left = 0
          Top = 0
          Width = 515
          Height = 9
          Align = alTop
          Shape = bsSpacer
        end
        object gbxPaper: TcxGroupBox
          Left = 9
          Top = 9
          Align = alLeft
          Caption = ' Paper '
          TabOrder = 0
          Height = 322
          Width = 231
          object lblPaperWidth: TcxLabel
            Left = 10
            Top = 236
            Anchors = [akLeft, akBottom]
            Caption = '&Width:'
            FocusControl = sePaperWidth
            Transparent = True
            OnClick = lblMarginTopClick
          end
          object lblPaperHeight: TcxLabel
            Left = 10
            Top = 259
            Anchors = [akLeft, akBottom]
            Caption = 'H&eight:'
            FocusControl = sePaperHeight
            Transparent = True
            OnClick = lblMarginTopClick
          end
          object lbxPaperType: TcxListBox
            Left = 12
            Top = 18
            Width = 207
            Height = 208
            Anchors = [akLeft, akTop, akBottom]
            ItemHeight = 20
            ListStyle = lbOwnerDrawFixed
            Style.TransparentBorder = False
            TabOrder = 0
            OnClick = lbxPaperTypeClick
            OnDrawItem = lbxPaperTypeDrawItem
          end
          object cbxPaperSource: TcxComboBox
            Left = 83
            Top = 289
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 18
			Properties.OnChange = cbxPaperSourceChange
            Properties.OnDrawItem = cbxPaperSourcePropertiesDrawItem
            Style.TransparentBorder = False
            TabOrder = 3
            Height = 22
            Width = 136
          end
          object sePaperWidth: TcxSpinEdit
            Left = 83
            Top = 236
            Anchors = [akLeft, akBottom]
            Properties.ImmediatePost = True
            Properties.Increment = 0.100000000000000000
            Properties.LargeIncrement = 1.000000000000000000
            Properties.ValueType = vtFloat
            Properties.OnChange = PaperWidthHeightChange
            Properties.OnEditValueChanged = PaperWidthHeightUpdateInfos
            Style.TransparentBorder = False
            TabOrder = 1
            OnExit = PaperWidthHeightUpdateInfos
            Width = 136
          end
          object sePaperHeight: TcxSpinEdit
            Left = 83
            Top = 259
            Anchors = [akLeft, akBottom]
            Properties.ImmediatePost = True
            Properties.Increment = 0.100000000000000000
            Properties.LargeIncrement = 1.000000000000000000
            Properties.ValueType = vtFloat
            Properties.OnChange = PaperWidthHeightChange
            Properties.OnEditValueChanged = PaperWidthHeightUpdateInfos
            Style.TransparentBorder = False
            TabOrder = 2
            OnExit = PaperWidthHeightUpdateInfos
            Width = 136
          end
          object lblPaperSource: TcxLabel
            Left = 10
            Top = 291
            Anchors = [akLeft, akBottom]
            Caption = 'Paper so&urce'
            FocusControl = cbxPaperSource
            Transparent = True
            OnClick = lblPaperSourceClick
          end
        end
        object Panel6: TcxGroupBox
          Left = 249
          Top = 9
          Align = alClient
          PanelStyle.Active = True
          ParentBackground = False
          ParentColor = False
          Style.BorderStyle = ebsNone
          Style.Color = clBtnFace
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
          Height = 322
          Width = 257
          object Bevel1: TBevel
            Left = 0
            Top = 172
            Width = 257
            Height = 9
            Align = alTop
            Shape = bsSpacer
          end
          object Bevel7: TBevel
            Left = 0
            Top = 261
            Width = 257
            Height = 9
            Align = alTop
            Shape = bsSpacer
          end
          object gbxOrientation: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            Caption = ' Orientation '
            TabOrder = 0
            Height = 172
            Width = 257
            object bvlOrientationHolder: TBevel
              Left = 12
              Top = 18
              Width = 143
              Height = 142
              Visible = False
            end
            object rBtnLandscape: TcxRadioButton
              Tag = 1
              Left = 161
              Top = 48
              Width = 93
              Height = 17
              Caption = '&Landscape'
              TabOrder = 1
              OnClick = OrientationClick
              OnDblClick = OrientationDblClick
              Transparent = True
            end
            object rBtnPortrait: TcxRadioButton
              Left = 161
              Top = 25
              Width = 93
              Height = 17
              Caption = 'P&ortrait'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = OrientationClick
              OnDblClick = OrientationDblClick
              Transparent = True
            end
          end
          object gbxPrintOrder: TcxGroupBox
            Left = 0
            Top = 181
            Align = alTop
            Caption = ' Print Order '
            TabOrder = 1
            Height = 80
            Width = 257
            object pbxPageOrder: TPaintBox
              Left = 12
              Top = 20
              Width = 74
              Height = 49
              OnDblClick = pbxPageOrderDblClick
              OnPaint = pbxPageOrderPaint
            end
            object rbtnOverThenDown: TcxRadioButton
              Left = 102
              Top = 47
              Width = 150
              Height = 17
              Caption = 'O&ver, then down'
              TabOrder = 1
              OnClick = PageOrderClick
              Transparent = True
            end
            object rbtnDownThenOver: TcxRadioButton
              Tag = 1
              Left = 102
              Top = 24
              Width = 150
              Height = 17
              Caption = '&Down, then over'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = PageOrderClick
              Transparent = True
            end
          end
          object gbxShading: TcxGroupBox
            Left = 0
            Top = 270
            Align = alClient
            Caption = ' Shading '
            TabOrder = 2
            Height = 52
            Width = 257
            object chbxShading: TcxCheckBox
              Left = 11
              Top = 18
              Caption = 'Print using &gray shading'
              TabOrder = 0
              Transparent = True
              OnClick = chbxShadingClick
              Width = 237
            end
          end
        end
      end
      object tshMargins: TcxTabSheet
        Caption = '&Margins'
        object bvlPreviewHolder: TBevel
          Left = 245
          Top = 24
          Width = 262
          Height = 307
          Visible = False
        end
        object bvlMarginsWarningHolder: TBevel
          Left = 10
          Top = 298
          Width = 225
          Height = 33
          Visible = False
        end
        object lblPreview: TcxLabel
          Left = 242
          Top = 4
          AutoSize = False
          Caption = 'Preview'
          Properties.LineOptions.Visible = True
          Transparent = True
          Height = 19
          Width = 265
        end
        object gbxMargins: TcxGroupBox
          Left = 10
          Top = 9
          PanelStyle.Active = True
          TabOrder = 1
          Height = 210
          Width = 225
          object pnlMargins: TcxGroupBox
            Left = 2
            Top = 2
            Align = alTop
            PanelStyle.Active = True
            ParentBackground = False
            ParentColor = False
            Style.BorderStyle = ebsNone
            Style.Color = clBtnFace
            TabOrder = 0
            Transparent = True
            Height = 110
            Width = 221
            object lblMarginTop: TcxLabel
              Left = 13
              Top = 8
              Caption = '&Top:'
              Transparent = True
              OnClick = lblMarginTopClick
            end
            object lblMarginBottom: TcxLabel
              Left = 13
              Top = 34
              Caption = '&Bottom: '
              Transparent = True
              OnClick = lblMarginTopClick
            end
            object lblMarginLeft: TcxLabel
              Left = 13
              Top = 60
              Caption = 'Le&ft: '
              Transparent = True
              OnClick = lblMarginTopClick
            end
            object lblMarginRight: TcxLabel
              Left = 13
              Top = 86
              Caption = 'Ri&ght: '
              Transparent = True
              OnClick = lblMarginTopClick
            end
            object seMarginTop: TcxSpinEdit
              Tag = 1
              Left = 96
              Top = 9
              Properties.ImmediatePost = True
              Properties.Increment = 0.100000000000000000
              Properties.LargeIncrement = 1.000000000000000000
              Properties.ValueType = vtFloat
              Properties.OnChange = MarginChange
              Properties.OnEditValueChanged = MarginValueChanged
              TabOrder = 0
              OnExit = MarginExit
              Width = 118
            end
            object seMarginBottom: TcxSpinEdit
              Tag = 3
              Left = 96
              Top = 35
              Properties.ImmediatePost = True
              Properties.Increment = 0.100000000000000000
              Properties.LargeIncrement = 1.000000000000000000
              Properties.ValueType = vtFloat
              Properties.OnChange = MarginChange
              Properties.OnEditValueChanged = MarginValueChanged
              TabOrder = 1
              OnExit = MarginExit
              Width = 118
            end
            object seMarginLeft: TcxSpinEdit
              Left = 96
              Top = 61
              Properties.ImmediatePost = True
              Properties.Increment = 0.100000000000000000
              Properties.LargeIncrement = 1.000000000000000000
              Properties.ValueType = vtFloat
              Properties.OnChange = MarginChange
              Properties.OnEditValueChanged = MarginValueChanged
              TabOrder = 2
              OnExit = MarginExit
              Width = 118
            end
            object seMarginRight: TcxSpinEdit
              Tag = 2
              Left = 96
              Top = 87
              Properties.ImmediatePost = True
              Properties.Increment = 0.100000000000000000
              Properties.LargeIncrement = 1.000000000000000000
              Properties.ValueType = vtFloat
              Properties.OnChange = MarginChange
              Properties.OnEditValueChanged = MarginValueChanged
              TabOrder = 3
              OnExit = MarginExit
              Width = 118
            end
          end
          object pnlHFMargins: TcxGroupBox
            Left = 2
            Top = 112
            Align = alTop
            PanelStyle.Active = True
            ParentBackground = False
            ParentColor = False
            Style.BorderStyle = ebsNone
            Style.Color = clBtnFace
            TabOrder = 1
            Transparent = True
            Height = 58
            Width = 221
            object lblMarginHeader: TcxLabel
              Left = 13
              Top = 6
              Caption = 'H&eader: '
              Transparent = True
              OnClick = lblMarginTopClick
            end
            object lblMarginFooter: TcxLabel
              Left = 13
              Top = 33
              Caption = 'Foote&r:'
              Transparent = True
              OnClick = lblMarginTopClick
            end
            object seMarginHeader: TcxSpinEdit
              Tag = 5
              Left = 96
              Top = 4
              Properties.ImmediatePost = True
              Properties.Increment = 0.100000000000000000
              Properties.LargeIncrement = 1.000000000000000000
              Properties.ValueType = vtFloat
              Properties.OnChange = MarginChange
              Properties.OnEditValueChanged = MarginValueChanged
              TabOrder = 0
              OnExit = MarginExit
              Width = 118
            end
            object seMarginFooter: TcxSpinEdit
              Tag = 6
              Left = 96
              Top = 31
              Properties.ImmediatePost = True
              Properties.Increment = 0.100000000000000000
              Properties.LargeIncrement = 1.000000000000000000
              Properties.ValueType = vtFloat
              Properties.OnChange = MarginChange
              Properties.OnEditValueChanged = MarginValueChanged
              TabOrder = 1
              OnExit = MarginExit
              Width = 118
            end
          end
          object Panel3: TcxGroupBox
            Left = 2
            Top = 170
            Align = alTop
            PanelStyle.Active = True
            ParentBackground = False
            ParentColor = False
            Style.BorderStyle = ebsNone
            Style.Color = clBtnFace
            TabOrder = 2
            Transparent = True
            Height = 39
            Width = 221
            object btnFix: TcxButton
              Left = 7
              Top = 8
              Width = 85
              Height = 23
              Caption = 'Fi&x'
              TabOrder = 0
              OnClick = btnFixClick
            end
            object btnRestoreOriginalMargins: TcxButton
              Left = 98
              Top = 8
              Width = 116
              Height = 23
              Caption = 'Restore &Original'
              TabOrder = 1
              OnClick = btnRestoreOriginalMarginsClick
            end
          end
        end
        object chbxCenterHorz: TcxCheckBox
          Left = 15
          Top = 255
          Caption = 'Hori&zontaly'
          ParentColor = False
          TabOrder = 2
          Transparent = True
          OnClick = CenterOnPageClick
          Width = 112
        end
        object chbxCenterVert: TcxCheckBox
          Tag = 1
          Left = 137
          Top = 255
          Caption = '&Verticaly'
          TabOrder = 3
          Transparent = True
          OnClick = CenterOnPageClick
          Width = 92
        end
        object lblCenterOnPage: TcxLabel
          Left = 10
          Top = 230
          AutoSize = False
          Caption = 'Center on page '
          Properties.LineOptions.Visible = True
          Transparent = True
          Height = 17
          Width = 225
        end
      end
      object tshHeaderFooter: TcxTabSheet
        BorderWidth = 6
        Caption = '&Header\Footer'
        object pnlReverse: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 26
          Width = 503
          object chbxReverseOnEvenPages: TcxCheckBox
            Left = 2
            Top = 5
            Caption = '&Reverse on even pages'
            Style.TransparentBorder = False
            TabOrder = 0
            Transparent = True
            OnClick = chbxReverseOnEvenPagesClick
            Width = 264
          end
        end
        object pnlHeader: TcxGroupBox
          Left = 0
          Top = 26
          Align = alTop
          PanelStyle.Active = True
          ParentBackground = False
          ParentColor = False
          Style.BorderStyle = ebsNone
          Style.Color = clBtnFace
          TabOrder = 1
          Transparent = True
          Height = 127
          Width = 503
          object pnlHeaderFont: TcxGroupBox
            Left = 2
            Top = 20
            Align = alTop
            PanelStyle.Active = True
            ParentBackground = False
            ParentColor = False
            Style.BorderStyle = ebsNone
            Style.Color = clBtnFace
            TabOrder = 0
            Transparent = True
            Height = 28
            Width = 499
            object btnHeaderFont: TcxButton
              Left = 3
              Top = 1
              Width = 85
              Height = 23
              Caption = '&Font...'
              TabOrder = 0
              OnClick = btnHFFontClick
            end
            object btnHeaderBackground: TcxButton
              Left = 331
              Top = 1
              Width = 165
              Height = 23
              Anchors = [akTop, akRight]
              Caption = '&Background'
              Layout = blGlyphRight
              TabOrder = 2
              OnClick = BackgroundClick
            end
            object edHeaderFontInfo: TcxTextEdit
              Left = 96
              Top = 2
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              Properties.ReadOnly = True
              Style.Shadow = False
              TabOrder = 1
              Width = 228
            end
          end
          object pnlHeaderMemos: TcxGroupBox
            Left = 2
            Top = 48
            Align = alClient
            PanelStyle.Active = True
            ParentBackground = False
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Transparent = True
            Height = 77
            Width = 499
            object bv3: TBevel
              Left = 167
              Top = 2
              Width = 6
              Height = 73
              Align = alLeft
              Shape = bsSpacer
            end
            object bv4: TBevel
              Left = 324
              Top = 2
              Width = 6
              Height = 73
              Align = alRight
              Shape = bsSpacer
            end
            object memHeaderRight: TcxMemo
              Tag = 2
              Left = 330
              Top = 2
              Align = alRight
              Properties.Alignment = taRightJustify
              Properties.OnChange = memHeaderCenterPropertiesChange
              TabOrder = 2
              OnEnter = MemoEnter
              OnExit = MemoExit
              Height = 73
              Width = 167
            end
            object memHeaderCenter: TcxMemo
              Tag = 1
              Left = 173
              Top = 2
              Align = alClient
              Properties.Alignment = taCenter
              Properties.OnChange = memHeaderCenterPropertiesChange
              TabOrder = 1
              OnEnter = MemoEnter
              OnExit = MemoExit
              Height = 73
              Width = 151
            end
            object memHeaderLeft: TcxMemo
              Left = 2
              Top = 2
              Align = alLeft
              Properties.OnChange = memHeaderCenterPropertiesChange
              TabOrder = 0
              OnEnter = MemoEnter
              OnExit = MemoExit
              Height = 73
              Width = 165
            end
          end
          object lblHeader: TcxLabel
            Left = 2
            Top = 2
            Align = alTop
            AutoSize = False
            Caption = 'Header'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 499
          end
        end
        object pnlFooter: TcxGroupBox
          Left = 0
          Top = 153
          Align = alClient
          PanelStyle.Active = True
          ParentBackground = False
          ParentColor = False
          Style.BorderStyle = ebsNone
          Style.Color = clBtnFace
          TabOrder = 2
          Transparent = True
          Height = 109
          Width = 503
          object pnlFooterFont: TcxGroupBox
            Left = 2
            Top = 20
            Align = alTop
            PanelStyle.Active = True
            ParentBackground = False
            ParentColor = False
            Style.BorderStyle = ebsNone
            Style.Color = clBtnFace
            TabOrder = 0
            Transparent = True
            Height = 28
            Width = 499
            object btnFooterFont: TcxButton
              Tag = 1
              Left = 3
              Top = 1
              Width = 85
              Height = 23
              Caption = 'Fo&nt...'
              TabOrder = 0
              OnClick = btnHFFontClick
            end
            object btnFooterBackGround: TcxButton
              Tag = 1
              Left = 331
              Top = 1
              Width = 165
              Height = 23
              Anchors = [akTop, akRight]
              Caption = 'Back&ground'
              Layout = blGlyphRight
              TabOrder = 2
              OnClick = BackgroundClick
            end
            object edFooterFontInfo: TcxTextEdit
              Left = 96
              Top = 2
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              Properties.ReadOnly = True
              TabOrder = 1
              Width = 228
            end
          end
          object pnlFooterMemos: TcxGroupBox
            Left = 2
            Top = 48
            Align = alClient
            PanelStyle.Active = True
            ParentBackground = False
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Transparent = True
            Height = 59
            Width = 499
            object bv1: TBevel
              Left = 167
              Top = 2
              Width = 6
              Height = 55
              Align = alLeft
              Shape = bsSpacer
            end
            object bv2: TBevel
              Left = 324
              Top = 2
              Width = 6
              Height = 55
              Align = alRight
              Shape = bsSpacer
            end
            object memFooterRight: TcxMemo
              Tag = 5
              Left = 330
              Top = 2
              Align = alRight
              Properties.Alignment = taRightJustify
              Properties.OnChange = memHeaderCenterPropertiesChange
              TabOrder = 2
              OnEnter = MemoEnter
              OnExit = MemoExit
              Height = 55
              Width = 167
            end
            object memFooterLeft: TcxMemo
              Tag = 3
              Left = 2
              Top = 2
              Align = alLeft
              Properties.OnChange = memHeaderCenterPropertiesChange
              TabOrder = 0
              OnEnter = MemoEnter
              OnExit = MemoExit
              Height = 55
              Width = 165
            end
            object memFooterCenter: TcxMemo
              Tag = 4
              Left = 173
              Top = 2
              Align = alClient
              Properties.Alignment = taCenter
              Properties.OnChange = memHeaderCenterPropertiesChange
              TabOrder = 1
              OnEnter = MemoEnter
              OnExit = MemoExit
              Height = 55
              Width = 151
            end
          end
          object lblFooter: TcxLabel
            Left = 2
            Top = 2
            Align = alTop
            AutoSize = False
            Caption = 'Footer'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 499
          end
        end
        object pnlBottom: TcxGroupBox
          Left = 0
          Top = 262
          Align = alBottom
          PanelStyle.Active = True
          PanelStyle.BorderWidth = 2
          ParentBackground = False
          ParentColor = False
          Style.BorderStyle = ebsNone
          Style.Color = clBtnFace
          TabOrder = 3
          Transparent = True
          Height = 66
          Width = 503
          object Bevel3: TBevel
            Left = 109
            Top = 4
            Width = 6
            Height = 58
            Align = alLeft
            Shape = bsSpacer
          end
          object gbxFunctions: TcxGroupBox
            Left = 115
            Top = 4
            Align = alClient
            Caption = ' Predefined Functions  '
            TabOrder = 1
            Height = 58
            Width = 384
            object tbPredefined: TcxGroupBox
              Left = 7
              Top = 21
              PanelStyle.Active = True
              ParentBackground = False
              ParentShowHint = False
              ShowHint = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 0
              Transparent = True
              Height = 25
              Width = 360
            end
          end
          object gbxVertAlignment: TcxGroupBox
            Left = 4
            Top = 4
            Align = alLeft
            Caption = ' Vertical Alignment '
            TabOrder = 0
            Height = 58
            Width = 105
            object btnVertAlignTop: TcxButton
              Left = 12
              Top = 21
              Width = 25
              Height = 25
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000FF000000FF000000FF0000
                00FF000000FF0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000FF000000FF0000
                00FF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
                00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              SpeedButtonOptions.GroupIndex = 1
              SpeedButtonOptions.CanBeFocused = False
              SpeedButtonOptions.Down = True
              TabOrder = 0
              OnClick = VertTextAlignClick
            end
            object btnVertAlignCenter: TcxButton
              Tag = 1
              Left = 40
              Top = 21
              Width = 25
              Height = 25
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000FF000000FF000000FF0000
                00FF000000FF0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000FF000000FF0000
                00FF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
                00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000FF000000FF0000
                00FF000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000FF000000FF000000FF0000
                00FF000000FF0000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              SpeedButtonOptions.GroupIndex = 1
              SpeedButtonOptions.CanBeFocused = False
              TabOrder = 1
              OnClick = VertTextAlignClick
            end
            object btnVertAlignBottom: TcxButton
              Tag = 2
              Left = 68
              Top = 21
              Width = 25
              Height = 25
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
                00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00FF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000FF0000
                00FF000000FF0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000FF000000FF0000
                00FF000000FF000000FF00000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00FF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00FF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00FF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00FF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              SpeedButtonOptions.GroupIndex = 1
              SpeedButtonOptions.CanBeFocused = False
              TabOrder = 2
              OnClick = VertTextAlignClick
            end
          end
        end
      end
      object tshScaling: TcxTabSheet
        Caption = '&Scaling'
        object lblPercentOfNormalSize: TcxLabel
          Left = 118
          Top = 39
          Caption = '% normal size'
          Transparent = True
        end
        object rbtnAdjustTo: TcxRadioButton
          Left = 12
          Top = 15
          Width = 150
          Height = 17
          Caption = '&Adjust To:'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = ScalingClick
          Transparent = True
        end
        object rbtnFitTo: TcxRadioButton
          Tag = 1
          Left = 12
          Top = 68
          Width = 150
          Height = 17
          Caption = '&Fit To Page'
          TabOrder = 2
          OnClick = ScalingClick
          Transparent = True
        end
        object seAdjustTo: TcxSpinEdit
          Left = 35
          Top = 38
          Properties.MaxValue = 500.000000000000000000
          Properties.MinValue = 10.000000000000000000
          Properties.OnChange = ScaleChanged
          TabOrder = 1
          Value = 10
          OnExit = AdjustToExit
          Width = 75
        end
      end
    end
  end
  object ilPaperTypes: TcxImageList
    FormatVersion = 1
    DesignInfo = -130950
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000005000000150000002100000024000000250000
          002700000028000000290000002B000000290000001C00000007000000000000
          00000000000000000000000000116B5645CA93755FFF91745DFF90725CFF8E71
          5BFF8C7059FF8A6E58FF896C56FF886B55FF604C3CD40000001B000000000000
          0000000000000000000000000016967861FFFFFFFFFFF1EDEAFFECE8E5FFE8E3
          E0FFE5DFD9FFE1DAD4FFDDD5CFFFD9D2CAFF876C55FF00000026000000000000
          0000000000000000000000000013977963FFFFFFFFFFC38B56FFAF6018FFAD5E
          17FFAD5D15FFAC5C15FFBB804BFFDDD6D0FF896D56FF000000240000000A0000
          0011000000140000001700000026987B64FFFFFFFFFFB1631CFFF2B17BFFF0AE
          78FFECA974FFE9A470FFAC5C15FFE1DAD4FF8B6E58FF00000020085483C00B71
          B4FF0A6DB2FF0A6BAFFF0863A5FF997B64FFFFFFFFFFC58F5FFFC58E5DFFC48D
          5CFFC38B5BFFC28B5BFFC18A59FFE4DFDAFF8C6F59FF0000001B0B74B7FFA1DB
          F0FF5ABDE3FF51B6DFFF47ABD5FF997B64FFFFFFFFFFC6905FFFFBF1EAFFFAF0
          E8FFF9EFE6FFFAEEE5FFC38A5AFFFFFFFFFF8E715BFF000000150C75B7FFB7EC
          F9FF73D8F3FF6CD3F1FF63CCEDFF888D85FF997B64FFC79061FFFAF2EBFFFAF1
          E9FFFAF0E8FFFAEFE7FFC38C5BFF91745DFF6B5444C70000000C0C76B9FFC2F0
          FBFF7BDCF4FF73D7F3FF6BD3F1FF63CDEFFF5AC5EAFFC79161FFFBF2ECFFFAF2
          EBFFFAF1EAFFFAF0E8FFC48C5DFF0000001200000007000000020C76BAFFCCF4
          FCFF80E0F6FF79DBF4FF72D7F3FF6BD2F1FF62CDEFFFC79161FFC79161FFC690
          61FFC68F60FFC68F5FFFC48E5DFF0000000600000000000000000C78BBFFD6F6
          FDFF87E4F7FF80DFF5FF79DBF4FF71D6F2FF69D1F0FF62CDEFFF59C7ECFF51C1
          EAFF369ED1FF075EA4FF000000200000000100000000000000000D79BBFFDEF9
          FDFFD7F7FDFFCFF4FCFFC5F1FAFFBBECF9FFB0E8F8FFA5E3F6FF98DEF5FF8BD9
          F2FF71BEE2FF0864AAFF000000190000000000000000000000000D7CBDFF0D79
          BBFF0C76B9FF0C74B7FF0B72B5FF0B6FB3FF0A6DB2FF096BB0FF096AAFFF0969
          ADFF0967ADFF064C7FCB0000000F0000000000000000000000000C79BBFFB8EB
          F9FFB6E9F8FFB3E8F8FF0760A6FF0000000C000000090000000A0000000D0000
          000F000000100000000C000000040000000000000000000000000A5C8CBD0D76
          B8FF0A70B3FF096BAFFF074B7FC0000000030000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000100000002000000010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000500000012000000170000001700000018000000180000
          0018000000190000001400000005000000000000000000000000000000030000
          000C0000001300000020C79060FFC68F5EFFC58D5DFFC48C5BFFC48B5AFFC38A
          5AFFC38858FFC28858FF00000026000000170000000F000000040000000B705D
          4EC49A806AFF997F69FFC89161FFFAF2EBFFFBF1E9FFFAF0E7FFFAEFE6FFF9EE
          E4FFF9EDE3FFC28958FF8A6F58FF896D56FF604E3DC80000000F000000109E84
          6EFFFFFFFFFFDED8D2FFC99362FFFBF2EBFFFBF1EAFFFAF1E9FFFAF0E8FFFAF0
          E6FFF9EEE5FFC3895AFFD1C8BFFFD1C7BEFF896D57FF00000017000000109F85
          70FFFFFFFFFFEEEBE8FF9F816BFF9D7F68FF997B66FF957861FF90735DFF8B6F
          58FF876C54FF836851FFDFD9D3FFD1C8BFFF8A6E58FF000000180000000FA186
          71FFFFFFFFFFEFECEAFFEDEAE8FFECE8E4FFEAE6E2FFE8E4E0FFE6E2DDFFE5DF
          DBFFE3DDD8FFE2DCD6FFE0DAD4FFD2C8C0FF8B7059FF000000180000000EA287
          73FFFFFFFFFFC9905BFFB66921FFB5671FFFB3641CFFB1621AFFAF5F18FFAD5D
          16FFAC5C15FFAB5A13FFBA7E49FFD3CAC1FF8D725CFF000000170000000CA489
          74FFFFFFFFFFBA6D25FFF2B17BFFF0AE7AFFEEAC77FFEDA976FFEAA674FFE9A4
          70FFE8A26FFFE6A16DFFAA5A13FFD4CAC2FF8E735DFF000000170000000BA48B
          76FFFFFFFFFFBC6F27FFC47D39FFC37A36FFBF7733FFBD732EFFB96D2AFFB669
          25FFB36622FFB2631FFFAB5B14FFD4CBC3FF90755FFF0000001600000009A68C
          77FFFFFFFFFFBD7128FFC79061FFFBF2ECFFFAF2EBFFFAF1E9FFFAF0E7FFF9EE
          E5FFF9EDE3FFC28858FFAC5D15FFFFFFFFFF917661FF00000013000000057C6A
          59C3A68C77FFB8793DFFC79161FFFBF3EDFFFBF2ECFFFAF1EBFFFAF1E9FFF9EF
          E7FFFAEFE5FFC38A59FFA8662BFF957A64FF6D5A49C90000000D000000010000
          00050000000800000011C99263FFFBF3EDFFFBF3EDFFFBF2ECFFFBF1EAFFFBF0
          E9FFFAF0E7FFC38A5BFF0000001E000000100000000C00000003000000000000
          00000000000000000008C99365FFFBF3EDFFFBF3EDFFFBF3EDFFFBF2ECFFFAF2
          EBFFFAF1E9FFC48B5CFF00000010000000000000000000000000000000000000
          00000000000000000007CA9565FFFBF3EDFFFBF3EDFFFBF3EDFFFBF3EDFFFBF2
          ECFFFBF2EBFFC48C5DFF0000000F000000000000000000000000000000000000
          00000000000000000005CB9666FFCA9466FFC99464FFC89363FFC89161FFC78F
          60FFC68F5FFFC58D5DFF0000000B000000000000000000000000000000000000
          00000000000000000001000000050000000700000008000000090000000A0000
          000B0000000C0000000A00000003000000000000000000000000}
      end>
  end
  object ilBins: TcxImageList
    FormatVersion = 1
    DesignInfo = -130921
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000005000000150000002100000024000000250000
          002700000028000000290000002B000000290000001C00000007000000000000
          00000000000000000000000000116B5645CA93755FFF91745DFF90725CFF8E71
          5BFF8C7059FF8A6E58FF896C56FF886B55FF604C3CD40000001B000000000000
          0000000000000000000000000016967861FFFFFFFFFFF1EDEAFFECE8E5FFE8E3
          E0FFE5DFD9FFE1DAD4FFDDD5CFFFD9D2CAFF876C55FF00000026000000000000
          0000000000000000000000000013977963FFFFFFFFFFC38B56FFAF6018FFAD5E
          17FFAD5D15FFAC5C15FFBB804BFFDDD6D0FF896D56FF000000240000000A0000
          0011000000140000001700000026987B64FFFFFFFFFFB1631CFFF2B17BFFF0AE
          78FFECA974FFE9A470FFAC5C15FFE1DAD4FF8B6E58FF00000020085483C00B71
          B4FF0A6DB2FF0A6BAFFF0863A5FF997B64FFFFFFFFFFC58F5FFFC58E5DFFC48D
          5CFFC38B5BFFC28B5BFFC18A59FFE4DFDAFF8C6F59FF0000001B0B74B7FFA1DB
          F0FF5ABDE3FF51B6DFFF47ABD5FF997B64FFFFFFFFFFC6905FFFFBF1EAFFFAF0
          E8FFF9EFE6FFFAEEE5FFC38A5AFFFFFFFFFF8E715BFF000000150C75B7FFB7EC
          F9FF73D8F3FF6CD3F1FF63CCEDFF888D85FF997B64FFC79061FFFAF2EBFFFAF1
          E9FFFAF0E8FFFAEFE7FFC38C5BFF91745DFF6B5444C70000000C0C76B9FFC2F0
          FBFF7BDCF4FF73D7F3FF6BD3F1FF63CDEFFF5AC5EAFFC79161FFFBF2ECFFFAF2
          EBFFFAF1EAFFFAF0E8FFC48C5DFF0000001200000007000000020C76BAFFCCF4
          FCFF80E0F6FF79DBF4FF72D7F3FF6BD2F1FF62CDEFFFC79161FFC79161FFC690
          61FFC68F60FFC68F5FFFC48E5DFF0000000600000000000000000C78BBFFD6F6
          FDFF87E4F7FF80DFF5FF79DBF4FF71D6F2FF69D1F0FF62CDEFFF59C7ECFF51C1
          EAFF369ED1FF075EA4FF000000200000000100000000000000000D79BBFFDEF9
          FDFFD7F7FDFFCFF4FCFFC5F1FAFFBBECF9FFB0E8F8FFA5E3F6FF98DEF5FF8BD9
          F2FF71BEE2FF0864AAFF000000190000000000000000000000000D7CBDFF0D79
          BBFF0C76B9FF0C74B7FF0B72B5FF0B6FB3FF0A6DB2FF096BB0FF096AAFFF0969
          ADFF0967ADFF064C7FCB0000000F0000000000000000000000000C79BBFFB8EB
          F9FFB6E9F8FFB3E8F8FF0760A6FF0000000C000000090000000A0000000D0000
          000F000000100000000C000000040000000000000000000000000A5C8CBD0D76
          B8FF0A70B3FF096BAFFF074B7FC0000000030000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000100000002000000010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000500000012000000170000001700000018000000180000
          0018000000190000001400000005000000000000000000000000000000030000
          000C0000001300000020C79060FFC68F5EFFC58D5DFFC48C5BFFC48B5AFFC38A
          5AFFC38858FFC28858FF00000026000000170000000F000000040000000B705D
          4EC49A806AFF997F69FFC89161FFFAF2EBFFFBF1E9FFFAF0E7FFFAEFE6FFF9EE
          E4FFF9EDE3FFC28958FF8A6F58FF896D56FF604E3DC80000000F000000109E84
          6EFFFFFFFFFFDED8D2FFC99362FFFBF2EBFFFBF1EAFFFAF1E9FFFAF0E8FFFAF0
          E6FFF9EEE5FFC3895AFFD1C8BFFFD1C7BEFF896D57FF00000017000000109F85
          70FFFFFFFFFFEEEBE8FF9F816BFF9D7F68FF997B66FF957861FF90735DFF8B6F
          58FF876C54FF836851FFDFD9D3FFD1C8BFFF8A6E58FF000000180000000FA186
          71FFFFFFFFFFEFECEAFFEDEAE8FFECE8E4FFEAE6E2FFE8E4E0FFE6E2DDFFE5DF
          DBFFE3DDD8FFE2DCD6FFE0DAD4FFD2C8C0FF8B7059FF000000180000000EA287
          73FFFFFFFFFFC9905BFFB66921FFB5671FFFB3641CFFB1621AFFAF5F18FFAD5D
          16FFAC5C15FFAB5A13FFBA7E49FFD3CAC1FF8D725CFF000000170000000CA489
          74FFFFFFFFFFBA6D25FFF2B17BFFF0AE7AFFEEAC77FFEDA976FFEAA674FFE9A4
          70FFE8A26FFFE6A16DFFAA5A13FFD4CAC2FF8E735DFF000000170000000BA48B
          76FFFFFFFFFFBC6F27FFC47D39FFC37A36FFBF7733FFBD732EFFB96D2AFFB669
          25FFB36622FFB2631FFFAB5B14FFD4CBC3FF90755FFF0000001600000009A68C
          77FFFFFFFFFFBD7128FFC79061FFFBF2ECFFFAF2EBFFFAF1E9FFFAF0E7FFF9EE
          E5FFF9EDE3FFC28858FFAC5D15FFFFFFFFFF917661FF00000013000000057C6A
          59C3A68C77FFB8793DFFC79161FFFBF3EDFFFBF2ECFFFAF1EBFFFAF1E9FFF9EF
          E7FFFAEFE5FFC38A59FFA8662BFF957A64FF6D5A49C90000000D000000010000
          00050000000800000011C99263FFFBF3EDFFFBF3EDFFFBF2ECFFFBF1EAFFFBF0
          E9FFFAF0E7FFC38A5BFF0000001E000000100000000C00000003000000000000
          00000000000000000008C99365FFFBF3EDFFFBF3EDFFFBF3EDFFFBF2ECFFFAF2
          EBFFFAF1E9FFC48B5CFF00000010000000000000000000000000000000000000
          00000000000000000007CA9565FFFBF3EDFFFBF3EDFFFBF3EDFFFBF3EDFFFBF2
          ECFFFBF2EBFFC48C5DFF0000000F000000000000000000000000000000000000
          00000000000000000005CB9666FFCA9466FFC99464FFC89363FFC89161FFC78F
          60FFC68F5FFFC58D5DFF0000000B000000000000000000000000000000000000
          00000000000000000001000000050000000700000008000000090000000A0000
          000B0000000C0000000A00000003000000000000000000000000}
      end>
  end
  object ilPapers: TcxImageList
    FormatVersion = 1
    DesignInfo = -130892
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00070000001B0000002300000024000000250000002600000027000000270000
          0028000000290000002A00000021000000090000000000000000000000000000
          0019CA9364FFC99264FFC89162FFC79061FFC68F60FFC68E5FFFC58D5DFFC58C
          5CFFC48B5BFFC48B5BFFC38A59FF000000210000000000000000000000000000
          001ECA9466FFFAF6F0FFFAF5EFFFF9F5EEFFF9F4ECFFFAF3ECFFF9F2EAFFF9F2
          E9FFF8F1E8FFF9F0E8FFC48A5AFF000000290000000000000000000000000000
          001CCB9567FFFBF6F0FFFBF5F0FFFBF5EFFFFAF5EEFFF9F3ECFFF9F3EBFFF9F3
          EBFFF9F2E9FFF9F1E9FFC48C5CFF000000270000000000000000000000000000
          0019CB9667FFFBF6F1FFFBF6F0FFFAF6EFFFFAF4EFFFFAF4EDFFF9F4ECFFFAF3
          ECFFF9F3EBFFF9F2E9FFC58C5CFF000000260000000000000000000000000000
          0017CC9669FFFCF7F2FFFBF7F2FFCE9869FFCD9567FFCA9365FFC99162FFC890
          60FFF9F3EBFFF9F3EBFFC68D5DFF000000240000000000000000000000000000
          0015CC976AFFFBF8F4FFFCF7F3FFFBF7F2FFFBF6F1FFFBF5F0FFFAF5EFFFFAF4
          EEFFFAF4ECFFF9F3EBFFC68E5FFF000000230000000000000000000000000000
          0013CD986AFFFCF8F5FFFCF8F4FFD29D70FFD09B6DFFCF986BFFCC9667FFCB94
          65FFFAF4EDFFFAF4ECFFC78F5FFF000000210000000000000000000000000000
          0011CD996CFFFCF9F5FFFCF9F4FFFBF8F4FFFCF7F3FFFBF7F2FFFBF6F1FFFAF6
          F0FFFBF5EEFFFAF4EDFFC79061FF000000200000000000000000000000000000
          000FCD9A6CFFFDF9F6FFFCF9F6FFD6A276FFD4A073FFD29E70FFD19B6EFFCF99
          6BFFFAF5F0FFFBF5EFFFC89162FF0000001E0000000000000000000000000000
          000DCE9A6DFFFDFAF7FFFDFAF6FFFCF9F6FFFCF9F4FFFBF8F4FFFBF8F3FFFBF6
          F2FFFBF6F0FFFAF5F0FFC89263FF0000001D0000000000000000000000000000
          000CCF9B6DFFFDFBF8FFFDFAF7FFD9A67AFFD7A578FFD6A376FFD5A174FFD39E
          71FFFBF7F2FFFAF6F1FFC99364FF0000001C0000000000000000000000000000
          000ACF9B6EFFFDFBF9FFFDFBF8FFFDFAF8FFFCFAF6FFFCF9F6FFFCF9F4FFFBF8
          F3FFFCF8F3FFFBF7F2FFCA9465FF0000001B0000000000000000000000000000
          0009CF9B6EFFFEFCFAFFFDFBF9FFFDFBF9FFFCFAF7FFFDFAF7FFFCF9F6FFFCF9
          F4FFFCF8F4FFFBF8F3FFCB9567FF0000001A0000000000000000000000000000
          0006CF9B6EFFCF9B6EFFCF9B6EFFCF9B6DFFCF9A6DFFCE9A6CFFCD996CFFCD98
          6AFFCD976AFFCC9768FFCB9567FF000000130000000000000000000000000000
          00010000000500000008000000090000000B0000000C0000000E0000000F0000
          0011000000130000001400000011000000050000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00800300008003000080030000800300008003000080030000800300008003
          0000800300008003000080030000800300008003000080030000800300008003
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000B0000
          0011000000130000001300000014000000150000001500000016000000160000
          0017000000170000001800000018000000170000001000000004916A48C2C993
          64FFC89263FFC89162FFC89061FFC78F60FFC68E5FFFC68D5DFFC58C5CFFC48B
          5CFFC48B5BFFC38A59FFC38958FFC28858FF8A603EC80000000FC58957FFEAD6
          C4FFF8F2ECFFF4EAE0FFF2E6D9FFF0E3D5FFEEE1D2FFEDDFCFFFEDDCCCFFEBDB
          C9FFEAD8C6FFEAD7C4FFE9D6C2FFE0C2A9FFBD7B49FF00000016CB9567FFDFBD
          A2FFEFDFD2FFFFFFFFFFFAF7F1FFF6F1E9FFF0E9DEFFEBE1D6FFECE3D6FFF2E7
          DAFFF1E7D9FFF0E4D7FFE5CCB7FFD1A481FFC38959FF00000016CC9668FFFFFF
          FFFFDCB89BFFEFDED2FFFEFEFEFFF2EDE7FFCCA483FFBA723EFFC79D7BFFE7DD
          D0FFF0E6DAFFE6CEBAFFD4AA89FFE9D6C3FFC38A59FF00000015CD986AFFFFFF
          FFFFFAF6F1FFDBB89AFFE9D7C9FFD1AB8EFFE7D1BDFFF1E5D8FFE2C7AFFFC59B
          78FFDDC6B1FFD4AB8AFFF1E5D8FFEAD8C5FFC48B5BFF00000014CD986AFFFFFF
          FFFFFAF7F2FFF4EFE9FFC59368FFEAD6C4FFF5EDE3FFF3EADFFFF1E7DAFFE3C7
          B0FFBA855BFFE6D9CCFFF0E5D8FFEBD9C7FFC48B5BFF00000013CD996BFFFFFF
          FEFFF6F3EFFFD5B091FFEDDBCBFFF9F6EFFFF7F2EBFFF5EFE6FFF4ECE1FFF3E8
          DBFFE2C9B1FFC39875FFE5D9CBFFEAD8C8FFC48C5DFF00000012CE9A6CFFFBFA
          F9FFD8B497FFEFDECFFFFCFBF7FFFBF9F4FFFAF6F0FFF8F3EDFFF6F0E8FFF5ED
          E2FFF2E9DEFFE3CAB3FFC29773FFE1CFBDFFC48C5EFF00000011CC996DFFDCB9
          9FFFEFDFD1FFFDFDFAFFFCFCF9FFFCFBF7FFFBFAF5FFFAF7F2FFF9F5EEFFF7F2
          EAFFF5EFE5FFF4EBE0FFE4CCB4FFC39671FFBE895DFF02010114C9905FFFF1E1
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9D2C2FFB97B4CFF05040318997252C0CC99
          6DFFCC986BFFCA976BFFC9966BFFC7946AFFC59368FFC59267FFC39165FFC290
          63FFC18E63FFBF8C62FFBE8B60FFBF8B5FFF926948C90201010C000000020000
          0003000000040000000400000005000000050000000500000006000000070000
          000800000008000000090000000A0000000A0000000700000002000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF00000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FFFF0000FFFF
          0000}
      end>
  end
  object ilPrintOrders: TcxImageList
    BkColor = clWhite
    Height = 49
    Width = 74
    FormatVersion = 1
    DesignInfo = -130862
    ImageInfo = <
      item
        Image.Data = {
          DE380000424DDE3800000000000036000000280000004A000000310000000100
          200000000000A838000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000040000000C0000001000000011000000110000
          0012000000120000001300000013000000140000001400000015000000150000
          0016000000160000001600000017000000170000001800000018000000190000
          0019000000190000001A0000001A0000001A0000001500000006000000000000
          00040000000C0000001000000011000000110000001200000012000000130000
          0013000000140000001400000015000000150000001600000016000000160000
          00170000001700000018000000180000001900000019000000190000001A0000
          001A0000001A0000001500000006000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000BC89164FFC99164FFC891
          63FFC89162FFC79062FFC69061FFC68F61FFC68F61FFC68E60FFC68D5FFFC58D
          5FFFC58D5FFFC58D5EFFC48C5EFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFF0000
          0014000000000000000BC89164FFC99164FFC89163FFC89162FFC79062FFC690
          61FFC68F61FFC68F61FFC68E60FFC68D5FFFC58D5FFFC58D5FFFC58D5EFFC48C
          5EFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFF0000001400000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000EC891
          64FFFFFFFFFFF7EEE5FFF7EEE5FFF6EDE4FFF6EDE4FFF6EDE3FFF6ECE3FFF6EC
          E2FFF6ECE1FFF5EBE1FFF6ECE1FFF5ECE0FFF5EBE0FFF6EBDFFFF5EBDEFFF6EA
          DEFFF5EADEFFF5E9DEFFF5E9DDFFF5E9DDFFF5E9DDFFF4E9DDFFF5E9DDFFF5E8
          DCFFC48C5DFF0000001A000000000000000EC89164FFFFFFFFFFF7EEE5FFF7EE
          E5FFF6EDE4FFF6EDE4FFF6EDE3FFF6ECE3FFF6ECE2FFF6ECE1FFF5EBE1FFF6EC
          E1FFF5ECE0FFF5EBE0FFF6EBDFFFF5EBDEFFF6EADEFFF5EADEFFF5E9DEFFF5E9
          DDFFF5E9DDFFF5E9DDFFF4E9DDFFF5E9DDFFF5E8DCFFC48C5DFF0000001A0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000DC89164FFFFFFFFFFFDFAF4FFFDF9F4FFFDF8F4FFFCF8F3FFFCF8
          F3FFFCF8F2FFFCF7F2FFFCF7F1FFFCF7F1FFFCF7F0FFFBF6F0FFFCF6EFFFFBF6
          EFFFFBF6EEFFFBF6EEFFFBF5EDFFFBF5EDFFFBF5ECFFFBF5ECFFFBF5ECFFFAF3
          EBFFFBF4EBFFF4E9DDFFC48C5DFF00000019000000000000000DC89164FFFFFF
          FFFFFDFAF4FFFDF9F4FFFDF8F4FFFCF8F3FFFCF8F3FFFCF8F2FFFCF7F2FFFCF7
          F1FFFCF7F1FFFCF7F0FFFBF6F0FFFCF6EFFFFBF6EFFFFBF6EEFFFBF6EEFFFBF5
          EDFFFBF5EDFFFBF5ECFFFBF5ECFFFBF5ECFFFAF3EBFFFBF4EBFFF4E9DDFFC48C
          5DFF000000190000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000CC89164FFFFFFFFFFFDF9F5FFFDF9F4FFFCF9
          F4FFFCF9F3FFFDF8F3FFFDF8F2FFFCF8F2FFFCF8F2FFFCF7F1FFFCF7F1FFFCF7
          F0FFFCF7F0FFFCF6F0FFFCF6EFFFFCF5EFFFFBF5EEFFFBF6EEFFFBF5EDFFFBF4
          EDFFFBF4EDFFFAF4ECFFFBF4EBFFF5E8DDFFC48C5DFF00000019000000000000
          000CC89164FFFFFFFFFFFDF9F5FFFDF9F4FFFCF9F4FFFCF9F3FFFDF8F3FFFDF8
          F2FFFCF8F2FFFCF8F2FFFCF7F1FFFCF7F1FFFCF7F0FFFCF7F0FFFCF6F0FFFCF6
          EFFFFCF5EFFFFBF5EEFFFBF6EEFFFBF5EDFFFBF4EDFFFBF4EDFFFAF4ECFFFBF4
          EBFFF5E8DDFFC48C5DFF00000019000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000CC89164FFFFFFFFFFFDFA
          F5FFFCF9F5FFFDF9F5FFFDF9F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8
          F2FFFCF8F1FFFCF7F0FFFCF7F0FFFCF6F0FFFCF6EFFFFBF6EEFFFBF5EFFFFBF6
          EEFFFBF5EEFFFBF5EDFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000
          0018000000000000000CC89164FFFFFFFFFFFDFAF5FFFCF9F5FFFDF9F5FFFDF9
          F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F2FFFCF8F1FFFCF7F0FFFCF7
          F0FFFCF6F0FFFCF6EFFFFBF6EEFFFBF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5
          EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000001800000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000BC891
          64FFFFFFFFFFFDFAF5FFFDFAF6FFFDF9F5FFFDF9F4FFFDF9F4FFFDF8F3FFFCF8
          F3FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F1FFFCF8F1FFFCF6F0FFFCF7EFFFFCF7
          EFFFFBF6EFFFFBF5EFFFFBF5EEFFFBF5EEFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9
          DDFFC48C5DFF00000017000000000000000BC89164FFFFFFFFFFFDFAF5FFFDFA
          F6FFFDF9F5FFFDF9F4FFFDF9F4FFFDF8F3FFFCF8F3FFF9F5F0FFF1ECE7FFF0EC
          E6FFF9F4EEFFFCF8F1FFFCF6F0FFFCF7EFFFFCF7EFFFFBF6EFFFFBF5EFFFFBF5
          EEFFFBF5EEFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF000000170000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000AC89164FFFFFFFFFFFDFAF6FFFDFAF6FFFDF9F5FFFDF9F5FFFDF9
          F5FFFDF9F4FFFCF8F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F2FFFCF7F1FFFCF7
          F0FFFCF7F0FFFBF7F0FFFCF6EFFFFBF6EFFFFCF5EFFFFBF6EEFFFBF5EEFFFBF5
          EDFFFBF5ECFFF5EADDFFC48C5DFF00000017000000000000000AC89164FFFFFF
          FFFFFDFAF6FFFDFAF6FFFDF9F5FFFDF9F5FFFDF9F5FFFDF9F4FFF9F5F1FFE6E2
          DDFF458C42FF458C42FFE5E1DCFFF9F4EEFFFCF7F0FFFCF7F0FFFBF7F0FFFCF6
          EFFFFBF6EFFFFCF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5ECFFF5EADDFFC48C
          5DFF000000170000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000009C89164FFFFFFFFFFFDFBF7FFFDFBF7FFFDFA
          F6FFFDFAF6FFFDF9F5FFFDF9F4FFFCF9F4FFFDF9F4FFFDF8F3FFFCF8F3FFFAF5
          EFFFF0ECE6FFECE8E2FFECE7E2FFEDE9E3FFF3EFE9FFF9F4EDFFFBF6EFFFFBF5
          EFFFFCF6EEFFFBF5EEFFFCF5EDFFF5EADEFFC48C5DFF00000016000000000000
          0009C89164FFFFFFFFFFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDF9F5FFFAF6
          F1FFE6E3DFFF438B41FF278D30FF14841DFF428A3FFFE5E1DCFFF9F4EEFFFCF7
          F1FFFBF7F0FFFBF7F0FFFBF6EFFFFBF6EFFFFBF5EFFFFCF6EEFFFBF5EEFFFCF5
          EDFFF5EADEFFC48C5DFF00000016000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000009C89164FFFFFFFFFFFDFB
          F7FFFDFBF6FFFDFAF6FFFCFAF6FFFDFAF6FFFCF9F5FFFCFAF4FFFCF9F4FFFDF8
          F4FFFDF8F4FFF1EDE7FF007B00FF007B00FF007A00FF007A00FF7BAE75FFF0EB
          E5FFF9F4EDFFFCF6EFFFFBF6EEFFFBF5EEFFFBF5EDFFF5EADEFFC48C5DFF0000
          00150000000000000009C89164FFFFFFFFFFFDFBF7FFFDFBF6FFFDFAF6FFFCFA
          F6FFFAF7F3FFE7E4E0FF438D41FF288E30FF29983BFF29983BFF14841DFF428A
          3FFFE5E1DCFFF9F5EEFFFCF7F1FFFCF7F0FFFCF7F0FFFBF6EFFFFCF6EFFFFBF6
          EEFFFBF5EEFFFBF5EDFFF5EADEFFC48C5DFF0000001500000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000008C891
          64FFFFFFFFFFFDFBF8FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF6FFFCFAF6FFFCF9
          F5FFFDF9F4FFFCF9F4FFFCF8F4FFEEEAE5FF007C00FF80CD95FF38B057FF31A8
          4DFF07810BFF7BAC75FFEFEAE5FFF9F5EDFFFCF6EFFFFCF6EEFFFBF6EEFFF5EA
          DEFFC48C5DFF000000150000000000000008C89164FFFFFFFFFFFDFBF8FFFDFB
          F7FFFDFAF6FFFAF7F3FFE8E5E2FF448E42FF288F30FF29993DFF29983CFF2998
          3BFF28983BFF14841DFF428A3FFFE5E1DBFFF9F4EEFFFCF7F0FFFCF6F1FFFBF6
          F0FFFBF7EFFFFCF6EFFFFCF6EEFFFBF6EEFFF5EADEFFC48C5DFF000000150000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000007C89164FFFFFFFFFFFEFCF8FFFDFBF8FFFDFBF7FFFDFBF7FFFDFA
          F6FFFDFAF6FFFDFAF5FFFDFAF5FFFDF9F4FFFCF9F4FFEEECE6FF007D00FF81CE
          96FF39B159FF38B057FF40AE59FF07810BFF7BAD75FFF0EBE5FFFAF4EDFFFCF6
          EFFFFCF6EFFFF5EBDFFFC48C5DFF000000140000000000000007C89164FFFFFF
          FFFFFEFCF8FFFDFBF8FFFAF8F4FFE9E7E3FF458E43FF3C9943FF77BE84FF77BE
          84FF76BE83FF29983CFF28983BFF76BD81FF3C9641FF428B40FFE5E1DCFFF9F4
          EFFFFCF7F0FFFCF7F0FFFCF6F0FFFCF6EFFFFCF6EFFFFCF6EFFFF5EBDFFFC48C
          5DFF000000140000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000006C89164FFFFFFFFFFFEFBF8FFFDFBF8FFFEFB
          F8FFFDFBF7FFFDFBF7FFFDFBF6FFFDFAF6FFFDF9F6FFFDFAF5FFFDF9F5FFEFEC
          E7FF007C00FF82CE97FF3AB25BFF2BA445FF7DCB91FF40AE59FF07810BFF7BAD
          75FFF0ECE5FFFAF4EDFFFCF6EFFFF5EBDFFFC48C5DFF00000013000000000000
          0006C89164FFFFFFFFFFFEFBF8FFFDFBF8FFF6F3F0FF4B964AFF007300FF0073
          00FF007200FF007100FF77BE83FF29993CFF007100FF007000FF007000FF006F
          00FF4A9146FFF3EFE8FFFCF7F1FFFCF7F0FFFCF7F0FFFCF7F0FFFCF6EFFFFCF6
          EFFFF5EBDFFFC48C5DFF00000013000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000006C89164FFFFFFFFFFFDFC
          F9FFFDFBF8FFFEFCF8FFFDFBF8FFFDFBF7FFFDFAF7FFFDFAF7FFFDFAF6FFFDFA
          F5FFFDFAF5FFF0EDE9FF007D00FF82CF98FF3AB35CFF037F04FF62BA72FF7DCB
          92FF40AF59FF07810BFF7BAD75FFF0ECE5FFFAF4EDFFF6EBE0FFC48C5DFF0000
          00120000000000000006C89164FFFFFFFFFFFDFCF9FFFDFBF8FFFBF9F5FFF1F0
          EDFFEAE8E4FFE8E5E3FFD8D5D3FF007200FF77BF84FF2A9A3EFF007000FFC6CA
          C0FFE4E2DCFFE8E4DFFFEFEBE6FFF9F5EFFFFDF8F2FFFCF7F1FFFCF7F1FFFCF7
          F1FFFCF7F0FFFCF6EFFFF6EBE0FFC48C5DFF0000001200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000005C891
          64FFFFFFFFFFFEFCF9FFFDFBF8FFFDFBF9FFFDFBF8FFFDFBF7FFFDFBF7FFFEFB
          F7FFFDFAF6FFFDFAF6FFFDFAF5FFF1EEE9FF007D00FF82D098FF3BB45DFF007C
          00FF0C820DFF62BA72FF7DCB92FF40AF59FF07810BFF7BAE75FFF1ECE5FFF3E9
          DFFFC48C5DFF000000120000000000000005C89164FFFFFFFFFFFEFCF9FFFDFB
          F8FFFDFBF9FFFDFBF8FFFDFBF7FFFDFBF7FFE9E6E3FF007200FF77C084FF2B9B
          3EFF007100FFD7D9CFFFFBF7F3FFFCF9F4FFFDF9F3FFFCF8F3FFFCF8F2FFFCF7
          F2FFFCF8F2FFFCF7F1FFFCF7F0FFFCF7F0FFF5EBE1FFC48C5DFF000000120000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000005C89164FFFFFFFFFFFDFCF9FFFDFCF9FFFDFCF9FFFDFBF8FFFDFB
          F8FFFDFBF8FFFEFBF7FFFDFAF7FFFDFAF6FFFDFAF6FFF1EEEAFF007E00FF82D1
          99FF3CB65EFF007D00FF91B68BFF0D820EFF62BA72FF7DCB92FF40AF59FF0781
          0BFF7BAE75FFEBE0D7FFC38B5CFF000000110000000000000005C89164FFFFFF
          FFFFFDFCF9FFFDFCF9FFFDFCF9FFFDFBF8FFFDFBF8FFFDFBF8FFEAE7E3FF0072
          00FF77C085FF2B9B40FF007100FFD7D9D1FFFBF8F2FFFCF9F4FFFDF9F4FFFDF8
          F3FFFDF8F3FFFCF7F2FFFCF7F2FFFCF7F2FFFCF7F1FFFCF7F1FFF6EBE1FFC48C
          5DFF000000110000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000004C89164FFFFFFFFFFFEFCF9FFFEFCF9FFFEFC
          F9FFFDFCF8FFFDFCF8FFFEFBF8FFFEFBF7FFFDFBF8FFFDFBF6FFFDFAF7FFF2EF
          EBFF007F00FF84D29AFF3CB660FF007E00FFD9DED2FFA3C39DFF0D830EFF62BA
          72FF7DCB92FF40AF59FF07810BFF78A86FFFBB8659FF00000012000000000000
          0004C89164FFFFFFFFFFFEFCF9FFFEFCF9FFFEFCF9FFFDFCF8FFFDFCF8FFFEFB
          F8FFEAE7E3FF007300FF78C086FF2B9D41FF007200FFD8DBD0FFFBF7F3FFFDF9
          F5FFFCF9F4FFFCF9F4FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F2FFFCF7F1FFFBF7
          F1FFF6ECE2FFC48C5DFF00000010000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000003C99265FFFFFFFFFFFDFD
          FAFFFEFCF9FFFDFCF9FFFEFCF9FFFEFBF8FFFEFBF8FFFDFBF8FFFDFBF8FFFEFB
          F7FFFDFBF7FFF2EFEBFF007F00FF84D29BFF3EB862FF007E00FFDFE5D8FFF5F2
          EDFFA4C49FFF0D830EFF62BA72FF7DCB92FF40AF59FF07810BFF61792EFF0000
          001A0000000200000003C99265FFFFFFFFFFFDFDFAFFFEFCF9FFFDFCF9FFFEFC
          F9FFFEFBF8FFFEFBF8FFE9E8E5FF007300FF79C187FF2C9D42FF007200FFD8DB
          D2FFFBF8F5FFFCF9F6FFFDF9F5FFFCF9F4FFFCF9F4FFFCF9F4FFFCF9F3FFFCF8
          F2FFFCF8F2FFFCF7F2FFF5ECE2FFC58C5EFF0000000F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000003C993
          65FFFFFFFFFFFEFCFBFFFEFDFAFFFEFCFAFFFEFCFAFFFEFCF9FFFEFCF9FFFDFC
          F9FFFEFBF9FFFDFBF8FFFEFBF8FFF3F1EDFF008000FF84D39CFF3EB962FF007E
          00FFE1E6DAFFFBF8F3FFF6F2EDFFA4C49EFF0D830EFF62BA72FF7DCB92FF40AF
          59FF07810BFF003500890000000B00000005C99365FFFFFFFFFFFEFCFBFFFEFD
          FAFFFEFCFAFFFEFCFAFFFEFCF9FFFEFCF9FFEAE9E6FF007400FF79C287FF2C9E
          42FF007300FFD8DDD3FFFCF9F5FFFDFAF6FFFDFAF5FFFDFAF5FFFCF9F4FFFDF9
          F4FFFCF8F3FFFDF9F3FFFCF8F3FFFCF8F2FFF6EDE2FFC58C5EFF0000000E0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000003C99365FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F5FF008000FF85D4
          9DFF3FBA64FF007E00FFE4EBE4FFFEFEFEFFFEFEFEFFF8F8F8FFA6C9A6FF0D83
          0EFF62BA73FF7DCB92FF40AF59FF07800BFF003500820000000EC89264FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECECECFF0074
          00FF79C288FF2D9F44FF007300FFDAE1DAFFFEFEFEFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC58D
          5FFF0000000E0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000002CA9465FFC99366FFC99265FFC99265FFC891
          64FFC89164FFC89163FFC79062FFC79062FFC78F61FFC78F61FFC68F60FFBF89
          5CFF008000FF86D49EFF3FBB65FF007F00FFB08655FFC48E5FFFC58E5FFFC48E
          5FFFC08A5CFF80803EFF0C800AFF62BA73FF7DCB92FF40AF59FF07810BFF0035
          0083C18D61FFC89265FFC99265FFC99265FFC89164FFC89164FFC89163FFC790
          62FFB9865BFF007400FF79C389FF2DA045FF007300FFA97F51FFC48D5EFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFFC58E5FFFC58E5FFF0000000A000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0003000000030000000300000003000000040000000400000004000000050000
          0005000000050000000F008000FF86D59EFF40BC66FF007F00FF000700220000
          000900000009000000090000000B0000001000230060067C07F862BA73FF7DCB
          92FF40AF59FF07810BFF003500830000000E0000000500000003000000030000
          0003000000040000000400000016007500FF7AC489FF2FA146FF007400FF0007
          0029000000080000000700000008000000080000000800000009000000090000
          000A0000000A0000000B0000000B000000090000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000009008100FF86D59FFF40BD68FF0080
          00FF0007001A0000000100000000000000000000000000000001000000070023
          0059067C07F862BA72FF7DCB92FF40AF59FF07810BFF003500820000000B0000
          00020000000000000000000000000000000000000012007500FF7AC48AFF2FA1
          47FF007400FF0007002400000001000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000040000000C00000010000000110000001100000012000000120000
          001300000013000000140000001400000015000000150000001E008100FF86D6
          A0FF42BE6AFF008000FF0008002F000000190000001900000019000000190000
          001A0000001B0000001F00230066067B07F862BA72FF7DCC92FF40AF59FF0780
          0BFF0034008A0000001C00000014000000120000001300000013000000240076
          00FF7BC58BFF30A349FF007500FF000700370000001700000017000000170000
          0018000000180000001900000019000000190000001A0000001A0000001A0000
          0015000000060000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000BC89164FFC99164FFC89163FFC89162FFC790
          62FFC69061FFC68F61FFC68F61FFC68E60FFC68D5FFFC58D5FFFC58D5FFFBF89
          5BFF008100FF86D7A0FF43BF6AFF008100FFB18654FFC38C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC38C5DFFBF885BFF00230065067B07F862BA
          72FF7DCC92FF40B059FF07810BFF637C31FFBF8A5EFFC58F60FFC68F61FFC68F
          61FFB9855AFF007600FF7BC58CFF30A449FF007500FFA97F51FFC38B5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFF00000014000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000EC89164FFFFFFFFFFF7EE
          E5FFF7EEE5FFF6EDE4FFF6EDE4FFF6EDE3FFF6ECE3FFF6ECE2FFF6ECE1FFF5EB
          E1FFF6ECE1FFEEE5D9FF008200FF87D7A2FF43C06BFF008100FFDDDAC8FFF4E8
          DDFFF5E9DDFFF5E9DDFFF5E9DDFFF4E9DDFFF5E9DDFFF5E8DCFFC38C5DFF0000
          001F00230059067C07F863BA73FF7DCB92FF40AF59FF07800BFF79AA70FFECE3
          DAFFF4EBE2FFF6ECE3FFE6DDD4FF007700FF7CC68DFF31A54BFF007500FFD4D2
          C2FFF5EADEFFF5EBDEFFF6EADEFFF5EADEFFF5E9DEFFF5E9DDFFF5E9DDFFF5E9
          DDFFF4E9DDFFF5E9DDFFF5E8DCFFC48C5DFF0000001A00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000DC891
          64FFFFFFFFFFFDFAF4FFFDF9F4FFFDF8F4FFFCF8F3FFFCF8F3FFFCF8F2FFFCF7
          F2FFFCF7F1FFFCF7F1FFFCF7F0FFF4EFE9FF008300FF87D8A2FF44C16DFF0081
          00FFE3E6D7FFFAF4ECFFFBF5ECFFFBF5ECFFFBF5ECFFFAF3EBFFFBF4EBFFF4E9
          DDFFC48C5DFF0000001A00000006002300600C800AFF62BA73FF7DCC92FF40AF
          59FF07810BFF7DB078FFF1EDE9FFFAF6F0FFECE8E3FF007700FF7DC78DFF32A6
          4CFF007600FFDADDCFFFFAF5EEFFFBF6EEFFFBF6EEFFFBF5EDFFFBF5EDFFFBF5
          ECFFFBF5ECFFFBF5ECFFFAF3EBFFFBF4EBFFF4E9DDFFC48C5DFF000000190000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000CC89164FFFFFFFFFFFDF9F5FFFDF9F4FFFCF9F4FFFCF9F3FFFDF8
          F3FFFDF8F2FFFCF8F2FFFCF8F2FFFCF7F1FFFCF7F1FFF5F0EAFF008200FF88D8
          A2FF44C26DFF008200FFE4E6D8FFFAF5EDFFFBF5EDFFFBF4EDFFFBF4EDFFFAF4
          ECFFFBF4EBFFF5E8DDFFC48C5DFF000000190000000100000012838241FF0D83
          0EFF62BA72FF7DCB92FF40AF59FF07810BFF7DAF78FFF2EEE8FFECE8E2FF0078
          00FF7DC88EFF32A74EFF007600FFDBDED1FFFBF5EFFFFCF6EFFFFCF5EFFFFBF5
          EEFFFBF6EEFFFBF5EDFFFBF4EDFFFBF4EDFFFAF4ECFFFBF4EBFFF5E8DDFFC48C
          5DFF000000190000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000CC89164FFFFFFFFFFFDFAF5FFFCF9F5FFFDF9
          F5FFFDF9F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F2FFFCF8F1FFF6F1
          EAFF008300FF88D9A3FF44C36FFF008200FFE4E6D9FFFAF5EDFFFBF5EEFFFBF5
          EDFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF00000018000000000000
          000DC38D62FFA7CAA7FF0D820EFF62BA73FF7DCB92FF40AF59FF07800BFF7DB0
          78FFE3E0DBFF007800FF7DC990FF34A94FFF007600FFDBDED1FFFBF5EFFFFCF6
          EFFFFBF6EEFFFBF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5EDFFFBF5ECFFFBF4
          ECFFF5E9DDFFC48C5DFF00000018000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000BC89164FFFFFFFFFFFDFA
          F5FFFDFAF6FFFDF9F5FFFDF9F4FFFDF9F4FFFDF8F3FFFCF8F3FFFCF8F3FFFDF8
          F2FFFCF8F2FFF6F1EBFF008300FF89D9A4FF45C370FF008300FFE4E8D9FFFAF4
          EEFFFBF5EEFFFBF5EEFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000
          0017000000000000000BC79164FFF9F9F9FFA6C7A1FF0D830EFF62BA73FF7DCB
          92FF40B059FF07810BFF76A972FF007800FF7EC990FF34AA50FF007700FFDCDF
          D2FFFBF5EFFFFCF7EFFFFCF7EFFFFBF6EFFFFBF5EFFFFBF5EEFFFBF5EEFFFBF5
          EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000001700000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000AC891
          64FFFFFFFFFFFDFAF6FFFDFAF6FFFDF9F5FFFDF9F5FFFDF9F5FFFDF9F4FFFCF8
          F4FFFCF8F3FFFCF8F3FFFCF8F3FFF6F2EDFF008300FF89DAA4FF45C571FF0082
          00FFE6E8D9FFFAF5EFFFFCF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5ECFFF5EA
          DDFFC48C5DFF00000017000000000000000AC89164FFFEFEFEFFF7F4F0FFA6C7
          A1FF0D830EFF63BA73FF7DCB92FF40AF59FF07800BFF007A00FF75C689FF35AB
          52FF007800FFDCDFD3FFFBF6EFFFFCF7F0FFFBF7F0FFFCF6EFFFFBF6EFFFFCF5
          EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5ECFFF5EADDFFC48C5DFF000000170000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000009C89164FFFFFFFFFFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDF9
          F5FFFDF9F4FFFCF9F4FFFDF9F4FFFDF8F3FFFCF8F3FFF8F3EDFF008400FF89DB
          A5FF46C571FF008300FFE5E9DBFFFBF6EFFFFBF6EFFFFBF5EFFFFCF6EEFFFBF5
          EEFFFCF5EDFFF5EADEFFC48C5DFF000000160000000000000009C89164FFFFFF
          FFFFFCFAF6FFF7F5F1FFA6C7A1FF0D830EFF62BA73FF7DCB92FF40AF5AFF0780
          0BFF3FB15BFF36AC53FF007800FFDDE0D4FFFBF6F0FFFCF7F1FFFBF7F0FFFBF7
          F0FFFBF6EFFFFBF6EFFFFBF5EFFFFCF6EEFFFBF5EEFFFCF5EDFFF5EADEFFC48C
          5DFF000000160000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000009C89164FFFFFFFFFFFDFBF7FFFDFBF6FFFDFA
          F6FFFCFAF6FFFDFAF6FFFCF9F5FFFCFAF4FFFCF9F4FFFDF8F4FFFDF8F4FFF7F3
          EDFF008300FF89DBA6FF47C573FF008300FFE7EADBFFFCF7F0FFFBF6EFFFFCF6
          EFFFFBF6EEFFFBF5EEFFFBF5EDFFF5EADEFFC48C5DFF00000015000000000000
          0009C89164FFFFFFFFFFFDFBF7FFFCFAF5FFF7F4F0FFA6C7A1FF0D820EFF62BA
          73FF7DCB92FF40B059FF37AE56FF36AD54FF007800FFDDE0D5FFFBF6F1FFFCF8
          F1FFFCF7F1FFFCF7F0FFFCF7F0FFFBF6EFFFFCF6EFFFFBF6EEFFFBF5EEFFFBF5
          EDFFF5EADEFFC48C5DFF00000015000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000008C89164FFFFFFFFFFFDFB
          F8FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF6FFFCFAF6FFFCF9F5FFFDF9F4FFFCF9
          F4FFFCF8F4FFF7F3EEFF008400FF89DBA6FF47C673FF008300FFE7EADBFFFCF6
          F1FFFBF6F0FFFBF7EFFFFCF6EFFFFCF6EEFFFBF6EEFFF5EADEFFC48C5DFF0000
          00150000000000000008C89164FFFFFFFFFFFDFBF8FFFDFBF7FFFCF9F5FFF7F4
          F0FFA6C7A2FF0D820EFF63BA73FF7DCC92FF49B666FF37AF56FF007900FFDEE2
          D5FFFBF7F1FFFCF7F1FFFCF7F1FFFCF7F0FFFCF6F1FFFBF6F0FFFBF7EFFFFCF6
          EFFFFCF6EEFFFBF6EEFFF5EADEFFC48C5DFF0000001500000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000007C891
          64FFFFFFFFFFFEFCF8FFFDFBF8FFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFA
          F5FFFDFAF5FFFDF9F4FFFCF9F4FFF8F5EFFF008400FF8ADBA6FF8ADBA6FF0084
          00FFE8EBDEFFFCF7F0FFFCF7F0FFFCF6F0FFFCF6EFFFFCF6EFFFFCF6EFFFF5EB
          DFFFC48C5DFF000000140000000000000007C89164FFFFFFFFFFFEFCF8FFFDFB
          F8FFFDFBF7FFFCFAF6FFF7F4F0FFA6C7A2FF0D820EFF62BA73FF80CD95FF80CD
          94FF108413FFDFE1D7FFFCF7F2FFFCF8F3FFFCF7F2FFFCF7F2FFFCF7F0FFFCF7
          F0FFFCF6F0FFFCF6EFFFFCF6EFFFFCF6EFFFF5EBDFFFC48C5DFF000000140000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000006C89164FFFFFFFFFFFEFBF8FFFDFBF8FFFEFBF8FFFDFBF7FFFDFB
          F7FFFDFBF6FFFDFAF6FFFDF9F6FFFDFAF5FFFDF9F5FFF9F6F1FF008400FF0084
          00FF008400FF008400FFE8ECDFFFFCF7F1FFFCF7F0FFFCF7F0FFFCF7F0FFFCF6
          EFFFFCF6EFFFF5EBDFFFC48C5DFF000000130000000000000006C89164FFFFFF
          FFFFFEFBF8FFFDFBF8FFFEFBF8FFFDFBF7FFFCFAF6FFF7F5F0FFA7C8A2FF007B
          00FF007B00FF007B00FF007A00FFE2E6DBFFFCF9F4FFFDF8F3FFFCF8F2FFFCF8
          F1FFFCF7F1FFFCF7F0FFFCF7F0FFFCF7F0FFFCF6EFFFFCF6EFFFF5EBDFFFC48C
          5DFF000000130000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000006C89164FFFFFFFFFFFDFCF9FFFDFBF8FFFEFC
          F8FFFDFBF8FFFDFBF7FFFDFAF7FFFDFAF7FFFDFAF6FFFDFAF5FFFDFAF5FFFCF8
          F4FFF9F6F1FFF8F5EFFFF8F4EFFFF8F4EFFFFBF7F1FFFDF8F2FFFCF7F1FFFCF7
          F1FFFCF7F1FFFCF7F0FFFCF6EFFFF6EBE0FFC48C5DFF00000012000000000000
          0006C89164FFFFFFFFFFFDFCF9FFFDFBF8FFFEFCF8FFFDFBF8FFFDFBF7FFFCF9
          F6FFF9F6F3FFF4F1EDFFF1EEEAFFF1EEE9FFF3EFECFFF9F6F1FFFCF9F3FFFDF9
          F3FFFCF8F3FFFCF8F2FFFDF8F2FFFCF7F1FFFCF7F1FFFCF7F1FFFCF7F0FFFCF6
          EFFFF6EBE0FFC48C5DFF00000012000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000005C89164FFFFFFFFFFFEFC
          F9FFFDFBF8FFFDFBF9FFFDFBF8FFFDFBF7FFFDFBF7FFFEFBF7FFFDFAF6FFFDFA
          F6FFFDFAF5FFFDFAF5FFFDF9F5FFFDF9F5FFFCF9F4FFFDF9F3FFFCF8F3FFFCF8
          F2FFFCF7F2FFFCF8F2FFFCF7F1FFFCF7F0FFFCF7F0FFF5EBE1FFC48C5DFF0000
          00120000000000000005C89164FFFFFFFFFFFEFCF9FFFDFBF8FFFDFBF9FFFDFB
          F8FFFDFBF7FFFDFBF7FFFEFBF7FFFDFAF6FFFDFAF6FFFDFAF5FFFDFAF5FFFDF9
          F5FFFDF9F5FFFCF9F4FFFDF9F3FFFCF8F3FFFCF8F2FFFCF7F2FFFCF8F2FFFCF7
          F1FFFCF7F0FFFCF7F0FFF5EBE1FFC48C5DFF0000001200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000005C891
          64FFFFFFFFFFFDFCF9FFFDFCF9FFFDFCF9FFFDFBF8FFFDFBF8FFFDFBF8FFFEFB
          F7FFFDFAF7FFFDFAF6FFFDFAF6FFFDFAF5FFFDF9F6FFFDFAF4FFFCF9F4FFFDF9
          F4FFFDF8F3FFFDF8F3FFFCF7F2FFFCF7F2FFFCF7F2FFFCF7F1FFFCF7F1FFF6EB
          E1FFC48C5DFF000000110000000000000005C89164FFFFFFFFFFFDFCF9FFFDFC
          F9FFFDFCF9FFFDFBF8FFFDFBF8FFFDFBF8FFFEFBF7FFFDFAF7FFFDFAF6FFFDFA
          F6FFFDFAF5FFFDF9F6FFFDFAF4FFFCF9F4FFFDF9F4FFFDF8F3FFFDF8F3FFFCF7
          F2FFFCF7F2FFFCF7F2FFFCF7F1FFFCF7F1FFF6EBE1FFC48C5DFF000000110000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000004C89164FFFFFFFFFFFEFCF9FFFEFCF9FFFEFCF9FFFDFCF8FFFDFC
          F8FFFEFBF8FFFEFBF7FFFDFBF8FFFDFBF6FFFDFAF7FFFDFAF6FFFDFAF5FFFDF9
          F5FFFDF9F5FFFCF9F4FFFCF9F4FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F2FFFCF7
          F1FFFBF7F1FFF6ECE2FFC48C5DFF000000100000000000000004C89164FFFFFF
          FFFFFEFCF9FFFEFCF9FFFEFCF9FFFDFCF8FFFDFCF8FFFEFBF8FFFEFBF7FFFDFB
          F8FFFDFBF6FFFDFAF7FFFDFAF6FFFDFAF5FFFDF9F5FFFDF9F5FFFCF9F4FFFCF9
          F4FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F2FFFCF7F1FFFBF7F1FFF6ECE2FFC48C
          5DFF000000100000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000003C99265FFFFFFFFFFFDFDFAFFFEFCF9FFFDFC
          F9FFFEFCF9FFFEFBF8FFFEFBF8FFFDFBF8FFFDFBF8FFFEFBF7FFFDFBF7FFFDFA
          F6FFFDFAF6FFFDFAF6FFFCF9F6FFFDF9F5FFFCF9F4FFFCF9F4FFFCF9F4FFFCF9
          F3FFFCF8F2FFFCF8F2FFFCF7F2FFF5ECE2FFC58C5EFF0000000F000000000000
          0003C99265FFFFFFFFFFFDFDFAFFFEFCF9FFFDFCF9FFFEFCF9FFFEFBF8FFFEFB
          F8FFFDFBF8FFFDFBF8FFFEFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF6FFFCF9
          F6FFFDF9F5FFFCF9F4FFFCF9F4FFFCF9F4FFFCF9F3FFFCF8F2FFFCF8F2FFFCF7
          F2FFF5ECE2FFC58C5EFF0000000F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000003C99365FFFFFFFFFFFEFC
          FBFFFEFDFAFFFEFCFAFFFEFCFAFFFEFCF9FFFEFCF9FFFDFCF9FFFEFBF9FFFDFB
          F8FFFEFBF8FFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF5FFFDFAF5FFFCF9
          F4FFFDF9F4FFFCF8F3FFFDF9F3FFFCF8F3FFFCF8F2FFF6EDE2FFC58C5EFF0000
          000E0000000000000003C99365FFFFFFFFFFFEFCFBFFFEFDFAFFFEFCFAFFFEFC
          FAFFFEFCF9FFFEFCF9FFFDFCF9FFFEFBF9FFFDFBF8FFFEFBF8FFFDFBF7FFFDFB
          F7FFFDFAF6FFFDFAF6FFFDFAF5FFFDFAF5FFFCF9F4FFFDF9F4FFFCF8F3FFFDF9
          F3FFFCF8F3FFFCF8F2FFF6EDE2FFC58C5EFF0000000E00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000003C993
          65FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC58D5FFF0000000E0000000000000003C99365FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC58D5FFF0000000E0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000002CA9465FFC99366FFC99265FFC99265FFC89164FFC89164FFC891
          63FFC79062FFC79062FFC78F61FFC78F61FFC68F60FFC68E60FFC68D5FFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFF0000000A0000000000000002CA9465FFC993
          66FFC99265FFC99265FFC89164FFC89164FFC89163FFC79062FFC79062FFC78F
          61FFC78F61FFC68F60FFC68E60FFC68D5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFF0000000A0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000001000000020000000300000003000000030000
          0003000000030000000400000004000000040000000500000005000000050000
          0006000000060000000700000007000000080000000800000008000000090000
          00090000000A0000000A0000000B0000000B0000000900000003000000000000
          0001000000020000000300000003000000030000000300000003000000040000
          0004000000040000000500000005000000050000000600000006000000070000
          000700000008000000080000000800000009000000090000000A0000000A0000
          000B0000000B0000000900000003000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          DE380000424DDE3800000000000036000000280000004A000000310000000100
          200000000000A838000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000040000000C0000001000000011000000110000
          0012000000120000001300000013000000140000001400000015000000150000
          0016000000160000001600000017000000170000001800000018000000190000
          0019000000190000001A0000001A0000001A0000001500000006000000000000
          00040000000C0000001000000011000000110000001200000012000000130000
          0013000000140000001400000015000000150000001600000016000000160000
          00170000001700000018000000180000001900000019000000190000001A0000
          001A0000001A0000001500000006000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000BC89164FFC99164FFC891
          63FFC89162FFC79062FFC69061FFC68F61FFC68F61FFC68E60FFC68D5FFFC58D
          5FFFC58D5FFFC58D5EFFC48C5EFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFF0000
          0014000000000000000BC89164FFC99164FFC89163FFC89162FFC79062FFC690
          61FFC68F61FFC68F61FFC68E60FFC68D5FFFC58D5FFFC58D5FFFC58D5EFFC48C
          5EFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFF0000001400000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000EC891
          64FFFFFFFFFFF7EEE5FFF7EEE5FFF6EDE4FFF6EDE4FFF6EDE3FFF6ECE3FFF6EC
          E2FFF6ECE1FFF5EBE1FFF6ECE1FFF5ECE0FFF5EBE0FFF6EBDFFFF5EBDEFFF6EA
          DEFFF5EADEFFF5E9DEFFF5E9DDFFF5E9DDFFF5E9DDFFF4E9DDFFF5E9DDFFF5E8
          DCFFC48C5DFF0000001A000000000000000EC89164FFFFFFFFFFF7EEE5FFF7EE
          E5FFF6EDE4FFF6EDE4FFF6EDE3FFF6ECE3FFF6ECE2FFF6ECE1FFF5EBE1FFF6EC
          E1FFF5ECE0FFF5EBE0FFF6EBDFFFF5EBDEFFF6EADEFFF5EADEFFF5E9DEFFF5E9
          DDFFF5E9DDFFF5E9DDFFF4E9DDFFF5E9DDFFF5E8DCFFC48C5DFF0000001A0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000DC89164FFFFFFFFFFFDFAF4FFFDF9F4FFFDF8F4FFFCF8F3FFFCF8
          F3FFFCF8F2FFFCF7F2FFFCF7F1FFFCF7F1FFFCF7F0FFFBF6F0FFFCF6EFFFFBF6
          EFFFFBF6EEFFFBF6EEFFFBF5EDFFFBF5EDFFFBF5ECFFFBF5ECFFFBF5ECFFFAF3
          EBFFFBF4EBFFF4E9DDFFC48C5DFF00000019000000000000000DC89164FFFFFF
          FFFFFDFAF4FFFDF9F4FFFDF8F4FFFCF8F3FFFCF8F3FFF9F5EFFFF3EEE9FFF9F4
          EEFFFCF7F1FFFCF7F0FFFBF6F0FFFCF6EFFFFBF6EFFFFBF6EEFFFBF6EEFFFBF5
          EDFFFBF5EDFFFBF5ECFFFBF5ECFFFBF5ECFFFAF3EBFFFBF4EBFFF4E9DDFFC48C
          5DFF000000190000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000CC89164FFFFFFFFFFFDF9F5FFFDF9F4FFFCF9
          F4FFFCF9F3FFFDF8F3FFFDF8F2FFFCF8F2FFFCF8F2FFFCF7F1FFFCF7F1FFFCF7
          F0FFFCF7F0FFFCF6F0FFFCF6EFFFFCF5EFFFFBF5EEFFFBF6EEFFFBF5EDFFFBF4
          EDFFFBF4EDFFFAF4ECFFFBF4EBFFF5E8DDFFC48C5DFF00000019000000000000
          000CC89164FFFFFFFFFFFDF9F5FFFDF9F4FFFCF9F4FFFCF9F3FFFDF8F3FFF0EB
          E5FF4A9146FFE5E2DCFFF9F4EEFFFCF7F1FFFCF7F0FFFCF7F0FFFCF6F0FFFCF6
          EFFFFCF5EFFFFBF5EEFFFBF6EEFFFBF5EDFFFBF4EDFFFBF4EDFFFAF4ECFFFBF4
          EBFFF5E8DDFFC48C5DFF00000019000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000CC89164FFFFFFFFFFFDFA
          F5FFFCF9F5FFFDF9F5FFFDF9F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8
          F2FFFCF8F1FFFCF7F0FFFCF7F0FFFCF6F0FFFCF6EFFFFBF6EEFFFBF5EFFFFBF6
          EEFFFBF5EEFFFBF5EDFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000
          0018000000000000000CC89164FFFFFFFFFFFDFAF5FFFCF9F5FFFDF9F5FFFDF9
          F4FFFCF8F3FFE7E3DFFF006F00FF428B40FFE5E1DCFFF9F5EEFFFCF7F0FFFCF7
          F0FFFCF6F0FFFCF6EFFFFBF6EEFFFBF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5
          EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000001800000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000BC891
          64FFFFFFFFFFFDFAF5FFFDFAF6FFFDF9F5FFFDF9F4FFFDF9F4FFFDF8F3FFFCF8
          F3FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F1FFFCF8F1FFFCF6F0FFFBF6EEFFFBF6
          EEFFFAF5EEFFFAF4EEFFFAF4EDFFFAF4EDFFFAF4ECFFFAF4EBFFFAF3EBFFF4E8
          DCFFC38B5DFF00000018000000010000000CC79063FFFEFEFEFFFCF9F4FFFBF8
          F5FFFBF7F3FFFBF7F2FFFBF7F2FFE5E1DCFF007000FF3C9641FF428A3FFFE5E1
          DCFFF9F4EEFFFCF8F1FFFCF6F0FFFCF7EFFFFCF7EFFFFBF6EFFFFBF5EFFFFBF5
          EEFFFBF5EEFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF000000170000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000AC89164FFFFFFFFFFFDFAF6FFFDFAF6FFFDF9F5FFFDF9F5FFFDF9
          F5FFFDF9F4FFFCF8F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F2FFF9F4EEFFE2E4
          D8FFDEE1D4FFDDE0D4FFDDE0D2FFDCDFD2FFDCDED1FFDBDED0FFDADDCFFFDADC
          CEFFD9DCCCFFD4D1BFFFA97F50FF00070037000700240007002DAB8356FFDAE1
          DAFFD8DCD2FFD8DBD2FFD8DAD0FFD7D9D0FFD7D9CFFFC7CAC0FF007000FF76BD
          81FF14841DFF428A40FFE5E1DCFFF9F4EEFFFCF7F0FFFCF7F0FFFBF7F0FFFCF6
          EFFFFBF6EFFFFCF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5ECFFF5EADDFFC48C
          5DFF000000170000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000009C89164FFFFFFFFFFFDFBF7FFFDFBF7FFFDFA
          F6FFFDFAF6FFFDF9F5FFFDF9F4FFFCF9F4FFFDF9F4FFFDF8F3FFFCF8F3FFFDF8
          F2FFF2EEE9FF007A00FF108413FF007900FF007800FF007800FF007800FF0077
          00FF007600FF007600FF007600FF007500FF007500FF007500FF007400FF0074
          00FF007300FF007300FF007300FF007200FF007200FF007100FF007100FF0070
          00FF007100FF28983BFF28983BFF14841DFF428A3FFFE5E1DCFFF9F4EEFFFCF7
          F1FFFBF7F0FFFBF7F0FFFBF6EFFFFBF6EFFFFBF5EFFFFCF6EEFFFBF5EEFFFCF5
          EDFFF5EADEFFC48C5DFF00000016000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000009C89164FFFFFFFFFFFDFB
          F7FFFDFBF6FFFDFAF6FFFCFAF6FFFDFAF6FFFCF9F5FFFCFAF4FFFCF9F4FFFDF8
          F4FFFDF8F4FFFCF8F2FFF0ECE7FF007B00FF80CD94FF37AF56FF36AD54FF36AC
          53FF35AB52FF34AA50FF34A94FFF32A74EFF32A64CFF31A54BFF30A449FF30A3
          49FF2FA147FF2FA146FF2DA045FF2D9F44FF2C9E42FF2C9D42FF2B9D41FF2B9B
          40FF2B9B3EFF2A9A3EFF29993CFF29983CFF29983BFF29983BFF14841DFF458C
          42FFF0EBE6FFFCF8F1FFFCF7F1FFFCF7F0FFFCF7F0FFFBF6EFFFFCF6EFFFFBF6
          EEFFFBF5EEFFFBF5EDFFF5EADEFFC48C5DFF0000001500000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000008C891
          64FFFFFFFFFFFDFBF8FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF6FFFCFAF6FFFCF9
          F5FFFDF9F4FFFCF9F4FFFCF8F4FFFCF8F3FFF0EDE7FF007B00FF80CD95FF49B6
          66FF37AE56FF3FB15BFF75C689FF7EC990FF7DC990FF7DC88EFF7DC78DFF7CC6
          8DFF7BC58CFF7BC58BFF7AC48AFF7AC489FF79C389FF79C288FF79C287FF79C1
          87FF78C086FF77C085FF77C084FF77BF84FF77BE83FF76BE83FF29983CFF2998
          3BFF278D30FF458D42FFF0ECE7FFFCF7F1FFFCF7F1FFFCF7F0FFFCF6F1FFFBF6
          F0FFFBF7EFFFFCF6EFFFFCF6EEFFFBF6EEFFF5EADEFFC48C5DFF000000150000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000007C89164FFFFFFFFFFFEFCF8FFFDFBF8FFFDFBF7FFFDFBF7FFFDFA
          F6FFFDFAF6FFFDFAF5FFFDFAF5FFFDF9F4FFFCF9F4FFFCF9F3FFF4EFEAFF007B
          00FF62BA73FF7DCC92FF40B059FF07800BFF007A00FF007800FF007800FF0078
          00FF007700FF007700FF007600FF007600FF007500FF007500FF007400FF0074
          00FF007400FF007300FF007300FF007200FF007200FF007200FF007100FF77BE
          84FF29993DFF288E30FF438B40FFE7E2DDFFFAF5F0FFFCF8F3FFFCF7F2FFFCF7
          F2FFFCF7F0FFFCF7F0FFFCF6F0FFFCF6EFFFFCF6EFFFFCF6EFFFF5EBDFFFC48C
          5DFF000000140000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000006C89164FFFFFFFFFFFEFBF8FFFDFBF8FFFEFB
          F8FFFDFBF7FFFDFBF7FFFDFBF6FFFDFAF6FFFDF9F6FFFDFAF5FFFDF9F5FFFCF9
          F4FFF8F5F0FFA6C7A1FF0D820EFF63BA73FF7DCB92FF40AF5AFF07800BFF76A8
          70FFE3DFD9FFECE6E0FFECE7E0FFE5DCD1FFB78357FF00000023000000120000
          0017B9865DFFECECECFFEBE8E5FFE9E8E5FFEAE7E4FFE9E7E3FFE8E6E3FFD8D6
          D2FF007200FF77BE84FF288F30FF438C41FFE6E3DFFFF9F6F1FFFCF9F4FFFDF8
          F3FFFCF8F2FFFCF8F1FFFCF7F1FFFCF7F0FFFCF7F0FFFCF7F0FFFCF6EFFFFCF6
          EFFFF5EBDFFFC48C5DFF00000013000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000006C89164FFFFFFFFFFFDFC
          F9FFFDFBF8FFFEFCF8FFFDFBF8FFFDFBF7FFFDFAF7FFFDFAF7FFFDFAF6FFFDFA
          F5FFFDFAF5FFFDF9F5FFFBF8F3FFF6F3EDFFA6C7A0FF0D820EFF62BA73FF7DCB
          92FF40AF59FF07810BFF7DAF77FFF1EDE6FFFAF4EDFFF6EBE0FFC48C5DFF0000
          00120000000000000006C89164FFFFFFFFFFFDFCF9FFFDFBF8FFFEFCF8FFFDFB
          F8FFFDFBF7FFE8E5E3FF007300FF3C9943FF448E42FFE8E5E0FFFAF6F2FFFCF9
          F4FFFCF9F3FFFDF9F3FFFCF8F3FFFCF8F2FFFDF8F2FFFCF7F1FFFCF7F1FFFCF7
          F1FFFCF7F0FFFCF6EFFFF6EBE0FFC48C5DFF0000001200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000005C891
          64FFFFFFFFFFFEFCF9FFFDFBF8FFFDFBF9FFFDFBF8FFFDFBF7FFFDFBF7FFFEFB
          F7FFFDFAF6FFFDFAF6FFFDFAF5FFFDFAF5FFFDF9F5FFFCF8F4FFF6F3EEFFA6C7
          A0FF0D820EFF62BA73FF7DCB92FF40B059FF07800BFF7DAF77FFF1ECE6FFF3E9
          E0FFC48C5DFF000000120000000000000005C89164FFFFFFFFFFFEFCF9FFFDFB
          F8FFFDFBF9FFFDFBF8FFFDFBF7FFEAE8E4FF007300FF458E43FFE8E5E2FFFAF7
          F2FFFDFAF5FFFDF9F5FFFDF9F5FFFCF9F4FFFDF9F3FFFCF8F3FFFCF8F2FFFCF7
          F2FFFCF8F2FFFCF7F1FFFCF7F0FFFCF7F0FFF5EBE1FFC48C5DFF000000120000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000005C89164FFFFFFFFFFFDFCF9FFFDFCF9FFFDFCF9FFFDFBF8FFFDFB
          F8FFFDFBF8FFFEFBF7FFFDFAF7FFFDFAF6FFFDFAF6FFFDFAF5FFFDF9F6FFFDFA
          F4FFFBF8F3FFF7F3EEFFA6C6A0FF0D830EFF63BA73FF7DCB92FF40AF59FF0781
          0BFF7DAF77FFECE1D7FFC38B5CFF000000110000000000000005C89164FFFFFF
          FFFFFDFCF9FFFDFCF9FFFDFCF9FFFDFBF8FFFDFBF8FFF1F0EDFF4C964AFFE9E6
          E3FFFAF7F3FFFDFAF6FFFDFAF5FFFDF9F6FFFDFAF4FFFCF9F4FFFDF9F4FFFDF8
          F3FFFDF8F3FFFCF7F2FFFCF7F2FFFCF7F2FFFCF7F1FFFCF7F1FFF6EBE1FFC48C
          5DFF000000110000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000004C89164FFFFFFFFFFFEFCF9FFFEFCF9FFFEFC
          F9FFFDFCF8FFFDFCF8FFFEFBF8FFFEFBF7FFFDFBF8FFFDFBF6FFFDFAF7FFFDFA
          F6FFFDFAF5FFFDF9F5FFFDF9F5FFFBF8F3FFF6F3EEFFA6C6A0FF0D830EFF62BA
          73FF7DCB92FF40AF59FF07810BFF79A96FFFBC8659FF00000012000000000000
          0004C89164FFFFFFFFFFFEFCF9FFFEFCF9FFFEFCF9FFFDFCF8FFFDFCF8FFFBF8
          F5FFF6F3EFFFFAF8F5FFFDFBF6FFFDFAF7FFFDFAF6FFFDFAF5FFFDF9F5FFFDF9
          F5FFFCF9F4FFFCF9F4FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F2FFFCF7F1FFFBF7
          F1FFF6ECE2FFC48C5DFF00000010000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000003C99265FFFFFFFFFFFDFD
          FAFFFEFCF9FFFDFCF9FFFEFCF9FFFEFBF8FFFEFBF8FFFDFBF8FFFDFBF8FFFEFB
          F7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF6FFFCF9F6FFFDF9F5FFFBF8F3FFF6F3
          EEFFA6C7A0FF0D830EFF62BA73FF7DCB92FF40AF59FF07800BFF617A2EFF0000
          00190000000200000003C99265FFFFFFFFFFFDFDFAFFFEFCF9FFFDFCF9FFFEFC
          F9FFFEFBF8FFFEFBF8FFFDFBF8FFFDFBF8FFFEFBF7FFFDFBF7FFFDFAF6FFFDFA
          F6FFFDFAF6FFFCF9F6FFFDF9F5FFFCF9F4FFFCF9F4FFFCF9F4FFFCF9F3FFFCF8
          F2FFFCF8F2FFFCF7F2FFF5ECE2FFC58C5EFF0000000F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000003C993
          65FFFFFFFFFFFEFCFBFFFEFDFAFFFEFCFAFFFEFCFAFFFEFCF9FFFEFCF9FFFDFC
          F9FFFEFBF9FFFDFBF8FFFEFBF8FFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFA
          F5FFFDFAF5FFFBF8F3FFF7F3EEFFA5C69FFF0D820EFF62BA72FF7DCC92FF40AF
          59FF07810BFF003500880000000B00000005C99365FFFFFFFFFFFEFCFBFFFEFD
          FAFFFEFCFAFFFEFCFAFFFEFCF9FFFEFCF9FFFDFCF9FFFEFBF9FFFDFBF8FFFEFB
          F8FFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF5FFFDFAF5FFFCF9F4FFFDF9
          F4FFFCF8F3FFFDF9F3FFFCF8F3FFFCF8F2FFF6EDE2FFC58C5EFF0000000E0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000003C99365FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFF9F9F9FFA7CAA7FF0D83
          0EFF62BA73FF7DCB92FF40B059FF07800BFF003500820000000EC89264FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC58D
          5FFF0000000E0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000002CA9465FFC99366FFC99265FFC99265FFC891
          64FFC89164FFC89163FFC79062FFC79062FFC78F61FFC78F61FFC68F60FFC68E
          60FFC68D5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC48E
          5FFFC08A5DFF81803EFF0C800AFF63BA73FF7DCC92FF40AF59FF07810BFF0035
          0083C18D61FFC89265FFC99265FFC99265FFC89164FFC89164FFC89163FFC790
          62FFC79062FFC78F61FFC78F61FFC68F60FFC68E60FFC68D5FFFC58E5FFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFFC58E5FFFC58E5FFF0000000A000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0003000000030000000300000003000000040000000400000004000000050000
          0005000000050000000600000006000000070000000700000008000000080000
          000800000009000000090000000B0000001000230060067C07F862BA72FF7DCC
          92FF40AF59FF07810BFF003500830000000E0000000500000003000000030000
          0003000000040000000400000004000000050000000500000005000000060000
          0006000000070000000700000008000000080000000800000009000000090000
          000A0000000A0000000B0000000B000000090000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000001000000060023
          0059067B07F862BA72FF7DCB92FF40AF59FF07810BFF003500820000000B0000
          0002000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000040000000C00000010000000110000001100000012000000120000
          0013000000130000001400000014000000150000001500000016000000160000
          0016000000170000001700000018000000180000001900000019000000190000
          001A0000001B0000001F00230066067B07F862BA72FF7DCB92FF40AF59FF0780
          0BFF0035008B0000001C00000014000000120000001300000013000000140000
          0014000000150000001500000016000000160000001600000017000000170000
          0018000000180000001900000019000000190000001A0000001A0000001A0000
          0015000000060000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000BC89164FFC99164FFC89163FFC89162FFC790
          62FFC69061FFC68F61FFC68F61FFC68E60FFC68D5FFFC58D5FFFC58D5FFFC58D
          5EFFC48C5EFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC38C5DFFBF885BFF00230065067C07F862BA
          73FF7DCB92FF40AF59FF07810BFF627C30FFBE8A5EFFC58F60FFC68F61FFC68F
          61FFC68E60FFC68D5FFFC58D5FFFC58D5FFFC58D5EFFC48C5EFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C5DFFC48C
          5DFFC48C5DFFC48C5DFF00000014000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000EC89164FFFFFFFFFFF7EE
          E5FFF7EEE5FFF6EDE4FFF6EDE4FFF6EDE3FFF6ECE3FFF6ECE2FFF6ECE1FFF5EB
          E1FFF6ECE1FFF5ECE0FFF5EBE0FFF6EBDFFFF5EBDEFFF6EADEFFF5EADEFFF5E9
          DEFFF5E9DDFFF5E9DDFFF5E9DDFFF4E9DDFFF5E9DDFFF5E8DCFFC38C5DFF0000
          001F00230059067C07F862BA73FF7DCB92FF40AF59FF07810BFF78A86FFFEBE2
          DAFFF4EBE1FFF6ECE3FFF6ECE2FFF6ECE1FFF5EBE1FFF6ECE1FFF5ECE0FFF5EB
          E0FFF6EBDFFFF5EBDEFFF6EADEFFF5EADEFFF5E9DEFFF5E9DDFFF5E9DDFFF5E9
          DDFFF4E9DDFFF5E9DDFFF5E8DCFFC48C5DFF0000001A00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000DC891
          64FFFFFFFFFFFDFAF4FFFDF9F4FFFDF8F4FFFCF8F3FFFCF8F3FFFCF8F2FFFCF7
          F2FFFCF7F1FFFCF7F1FFFCF7F0FFFBF6F0FFFCF6EFFFFBF6EFFFFBF6EEFFFBF6
          EEFFFBF5EDFFFBF5EDFFFBF5ECFFFBF5ECFFFBF5ECFFFAF3EBFFFBF4EBFFF4E9
          DDFFC48C5DFF0000001A00000007002300610C800AFF62BA73FF7DCB92FF40AF
          59FF07810BFF7BAE77FFF1EDE8FFFAF6F0FFFCF7F2FFFCF7F1FFFCF7F1FFFCF7
          F0FFFBF6F0FFFCF6EFFFFBF6EFFFFBF6EEFFFBF6EEFFFBF5EDFFFBF5EDFFFBF5
          ECFFFBF5ECFFFBF5ECFFFAF3EBFFFBF4EBFFF4E9DDFFC48C5DFF000000190000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000CC89164FFFFFFFFFFFDF9F5FFFDF9F4FFFCF9F4FFFCF9F3FFFDF8
          F3FFFDF8F2FFFCF8F2FFFCF8F2FFFCF7F1FFFCF7F1FFFCF7F0FFFCF7F0FFFCF6
          F0FFFCF6EFFFFCF5EFFFFBF5EEFFFBF6EEFFFBF5EDFFFBF4EDFFFBF4EDFFFAF4
          ECFFFBF4EBFFF5E8DDFFC48C5DFF000000190000000100000012838241FF0D83
          0EFF62BA72FF7DCB92FF40AF59FF07810BFF7CAE77FFF1EDE7FFFAF6F0FFFCF8
          F2FFFCF7F1FFFCF7F1FFFCF7F0FFFCF7F0FFFCF6F0FFFCF6EFFFFCF5EFFFFBF5
          EEFFFBF6EEFFFBF5EDFFFBF4EDFFFBF4EDFFFAF4ECFFFBF4EBFFF5E8DDFFC48C
          5DFF000000190000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000CC89164FFFFFFFFFFFDFAF5FFFCF9F5FFFDF9
          F5FFFDF9F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F2FFFCF8F1FFFCF7
          F0FFFCF7F0FFFCF6F0FFFCF6EFFFFBF6EEFFFBF5EFFFFBF6EEFFFBF5EEFFFBF5
          EDFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF00000018000000000000
          000DC38D61FFA6C9A6FF0D830EFF62BA72FF7DCB92FF40AF59FF07810BFF7BAE
          77FFF0EDE8FFFAF6F1FFFCF8F2FFFCF8F1FFFCF7F0FFFCF7F0FFFCF6F0FFFCF6
          EFFFFBF6EEFFFBF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5EDFFFBF5ECFFFBF4
          ECFFF5E9DDFFC48C5DFF00000018000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000BC89164FFFFFFFFFFFDFA
          F5FFFDFAF6FFFDF9F5FFFDF9F4FFFDF9F4FFFDF8F3FFFCF8F3FFFCF8F3FFFDF8
          F2FFFCF8F2FFFCF7F1FFFCF8F1FFFCF6F0FFFCF7EFFFFCF7EFFFFBF6EFFFFBF5
          EFFFFBF5EEFFFBF5EEFFFBF5EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000
          0017000000000000000BC79164FFF8F8F8FFA4C59FFF0D830EFF62BA72FF7DCB
          92FF40AF59FF07810BFF7BAE76FFF0ECE8FFFBF6F0FFFCF8F2FFFCF7F1FFFCF8
          F1FFFCF6F0FFFCF7EFFFFCF7EFFFFBF6EFFFFBF5EFFFFBF5EEFFFBF5EEFFFBF5
          EDFFFBF5ECFFFBF4ECFFF5E9DDFFC48C5DFF0000001700000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000AC891
          64FFFFFFFFFFFDFAF6FFFDFAF6FFFDF9F5FFFDF9F5FFFDF9F5FFFDF9F4FFFCF8
          F4FFFCF8F3FFFCF8F3FFFCF8F3FFFCF8F2FFFCF7F1FFFCF7F0FFFCF7F0FFFBF7
          F0FFFCF6EFFFFBF6EFFFFCF5EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5ECFFF5EA
          DDFFC48C5DFF00000017000000000000000AC89164FFFEFEFEFFF6F3EFFFA4C5
          A0FF0D830EFF62BA72FF7DCB92FF40AF59FF07810BFF7BAD76FFF0ECE8FFFAF6
          F1FFFCF8F2FFFCF7F1FFFCF7F0FFFCF7F0FFFBF7F0FFFCF6EFFFFBF6EFFFFCF5
          EFFFFBF6EEFFFBF5EEFFFBF5EDFFFBF5ECFFF5EADDFFC48C5DFF000000170000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000009C89164FFFFFFFFFFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDF9
          F5FFFDF9F4FFFCF9F4FFFDF9F4FFFDF8F3FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7
          F1FFFCF7F1FFFBF7F0FFFBF7F0FFFBF6EFFFFAF5EFFFFAF4EEFFFBF5EDFFFAF4
          EDFFFBF4ECFFF4E9DDFFC38C5DFF00000017000000010000000AC79164FFFEFE
          FEFFFCFAF6FFF6F4F0FFA4C49FFF0D820EFF62BA72FF7DCB92FF40AE59FF0781
          0BFF7BAD76FFF0ECE7FFFBF6F0FFFCF8F2FFFCF7F1FFFCF7F1FFFBF7F0FFFBF7
          F0FFFBF6EFFFFBF6EFFFFBF5EFFFFCF6EEFFFBF5EEFFFCF5EDFFF5EADEFFC48C
          5DFF000000160000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000009C89164FFFFFFFFFFFDFBF7FFFDFBF6FFFDFA
          F6FFFCFAF6FFFDFAF6FFFCF9F5FFFCFAF4FFFCF9F4FFFDF8F4FFFDF8F4FFFCF8
          F2FFFBF7F1FFE8EBDFFFE8EBDDFFE7EADCFFE7EADBFFE6E9DBFFE5E8D9FFE5E8
          D9FFE4E7D8FFE4E6D8FFE3E6D7FFDDDAC8FFB18654FF0008002C0007001A0007
          0023B38959FFE4EBE4FFE1E6DCFFE0E6DAFFDADFD4FF90B88DFF0C820DFF62BA
          72FF7DCB91FF40AE59FF07810BFF7CAF77FFF4F0EBFFFCF8F2FFFCF7F2FFFCF8
          F1FFFCF7F1FFFCF7F0FFFCF7F0FFFBF6EFFFFCF6EFFFFBF6EEFFFBF5EEFFFBF5
          EDFFF5EADEFFC48C5DFF00000015000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000008C89164FFFFFFFFFFFDFB
          F8FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF6FFFCFAF6FFFCF9F5FFFDF9F4FFFCF9
          F4FFFCF8F4FFFCF8F3FFF8F5EEFF008400FF008400FF008300FF008300FF0083
          00FF008200FF008300FF008200FF008200FF008100FF008100FF008100FF0080
          00FF008000FF007F00FF007F00FF007E00FF007E00FF007E00FF007E00FF007D
          00FF007C00FF037F04FF2BA445FF38B057FF31A84DFF007A00FFEEEAE5FFFCF9
          F2FFFCF8F2FFFCF7F1FFFCF7F1FFFCF7F0FFFCF6F1FFFBF6F0FFFBF7EFFFFCF6
          EFFFFCF6EEFFFBF6EEFFF5EADEFFC48C5DFF0000001500000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000007C891
          64FFFFFFFFFFFEFCF8FFFDFBF8FFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFA
          F5FFFDFAF5FFFDF9F4FFFCF9F4FFFCF9F3FFF8F3EFFF008400FF8ADBA6FF47C6
          73FF47C573FF46C571FF45C571FF45C370FF44C36FFF44C26DFF44C16DFF43C0
          6BFF43BF6AFF42BE6AFF40BD68FF40BC66FF3FBB65FF3FBA64FF3EB962FF3EB8
          62FF3CB660FF3CB65EFF3BB45DFF3AB35CFF3AB25BFF39B159FF38B057FF007A
          00FFECE9E4FFFDF8F3FFFDF8F3FFFCF8F3FFFCF7F2FFFCF7F2FFFCF7F0FFFCF7
          F0FFFCF6F0FFFCF6EFFFFCF6EFFFFCF6EFFFF5EBDFFFC48C5DFF000000140000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000006C89164FFFFFFFFFFFEFBF8FFFDFBF8FFFEFBF8FFFDFBF7FFFDFB
          F7FFFDFBF6FFFDFAF6FFFDF9F6FFFDFAF5FFFDF9F5FFFCF9F4FFF8F5F0FF0084
          00FF8ADBA6FF89DBA6FF89DBA6FF89DBA5FF89DAA4FF89D9A4FF88D9A3FF88D8
          A2FF87D8A2FF87D7A2FF86D7A0FF86D6A0FF86D59FFF86D59EFF86D49EFF85D4
          9DFF84D39CFF84D29BFF84D29AFF82D199FF82D098FF82CF98FF82CE97FF81CE
          96FF80CD95FF007B00FFECEAE5FFFCF9F4FFFCF9F4FFFDF8F3FFFCF8F2FFFCF8
          F1FFFCF7F1FFFCF7F0FFFCF7F0FFFCF7F0FFFCF6EFFFFCF6EFFFF5EBDFFFC48C
          5DFF000000130000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000006C89164FFFFFFFFFFFDFCF9FFFDFBF8FFFEFC
          F8FFFDFBF8FFFDFBF7FFFDFAF7FFFDFAF7FFFDFAF6FFFDFAF5FFFDFAF5FFFDF9
          F5FFF9F6F1FF008400FF008400FF008400FF008300FF008400FF008300FF0083
          00FF008300FF008200FF008300FF008200FF008100FF008100FF008100FF0080
          00FF008000FF008000FF008000FF007F00FF007F00FF007E00FF007D00FF007D
          00FF007C00FF007D00FF007C00FF007B00FFF1EDE9FFFCF9F4FFFCF9F3FFFDF9
          F3FFFCF8F3FFFCF8F2FFFDF8F2FFFCF7F1FFFCF7F1FFFCF7F1FFFCF7F0FFFCF6
          EFFFF6EBE0FFC48C5DFF00000012000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000005C89164FFFFFFFFFFFEFC
          F9FFFDFBF8FFFDFBF9FFFDFBF8FFFDFBF7FFFDFBF7FFFEFBF7FFFDFAF6FFFDFA
          F6FFFDFAF5FFFDFAF5FFFCF8F4FFFAF6F2FFF8F5F0FFF8F4EEFFF7F3EEFFF7F3
          EDFFF6F2EDFFF6F2ECFFF6F1EBFFF5F0EAFFF5F0E9FFEEE4DAFFBE885AFF0000
          001A000000090000000DC08C60FFF5F5F5FFF4F2EFFFF2F0EDFFF2F0EEFFF1EF
          EDFFF1EFEBFFF0EEEBFFF1EEEAFFEFECE9FFEFECE8FFF2EFEAFFFAF7F2FFFDF9
          F5FFFDF9F5FFFCF9F4FFFDF9F3FFFCF8F3FFFCF8F2FFFCF7F2FFFCF8F2FFFCF7
          F1FFFCF7F0FFFCF7F0FFF5EBE1FFC48C5DFF0000001200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000005C891
          64FFFFFFFFFFFDFCF9FFFDFCF9FFFDFCF9FFFDFBF8FFFDFBF8FFFDFBF8FFFEFB
          F7FFFDFAF7FFFDFAF6FFFDFAF6FFFDFAF5FFFDF9F6FFFDFAF4FFFCF9F4FFFDF9
          F4FFFDF8F3FFFDF8F3FFFCF7F2FFFCF7F2FFFCF7F2FFFCF7F1FFFCF7F1FFF6EB
          E1FFC48C5DFF000000110000000000000005C89164FFFFFFFFFFFDFCF9FFFDFC
          F9FFFDFCF9FFFDFBF8FFFDFBF8FFFDFBF8FFFEFBF7FFFDFAF7FFFDFAF6FFFDFA
          F6FFFDFAF5FFFDF9F6FFFDFAF4FFFCF9F4FFFDF9F4FFFDF8F3FFFDF8F3FFFCF7
          F2FFFCF7F2FFFCF7F2FFFCF7F1FFFCF7F1FFF6EBE1FFC48C5DFF000000110000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000004C89164FFFFFFFFFFFEFCF9FFFEFCF9FFFEFCF9FFFDFCF8FFFDFC
          F8FFFEFBF8FFFEFBF7FFFDFBF8FFFDFBF6FFFDFAF7FFFDFAF6FFFDFAF5FFFDF9
          F5FFFDF9F5FFFCF9F4FFFCF9F4FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F2FFFCF7
          F1FFFBF7F1FFF6ECE2FFC48C5DFF000000100000000000000004C89164FFFFFF
          FFFFFEFCF9FFFEFCF9FFFEFCF9FFFDFCF8FFFDFCF8FFFEFBF8FFFEFBF7FFFDFB
          F8FFFDFBF6FFFDFAF7FFFDFAF6FFFDFAF5FFFDF9F5FFFDF9F5FFFCF9F4FFFCF9
          F4FFFCF8F3FFFDF8F2FFFCF8F2FFFCF7F2FFFCF7F1FFFBF7F1FFF6ECE2FFC48C
          5DFF000000100000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000003C99265FFFFFFFFFFFDFDFAFFFEFCF9FFFDFC
          F9FFFEFCF9FFFEFBF8FFFEFBF8FFFDFBF8FFFDFBF8FFFEFBF7FFFDFBF7FFFDFA
          F6FFFDFAF6FFFDFAF6FFFCF9F6FFFDF9F5FFFCF9F4FFFCF9F4FFFCF9F4FFFCF9
          F3FFFCF8F2FFFCF8F2FFFCF7F2FFF5ECE2FFC58C5EFF0000000F000000000000
          0003C99265FFFFFFFFFFFDFDFAFFFEFCF9FFFDFCF9FFFEFCF9FFFEFBF8FFFEFB
          F8FFFDFBF8FFFDFBF8FFFEFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF6FFFCF9
          F6FFFDF9F5FFFCF9F4FFFCF9F4FFFCF9F4FFFCF9F3FFFCF8F2FFFCF8F2FFFCF7
          F2FFF5ECE2FFC58C5EFF0000000F000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000003C99365FFFFFFFFFFFEFC
          FBFFFEFDFAFFFEFCFAFFFEFCFAFFFEFCF9FFFEFCF9FFFDFCF9FFFEFBF9FFFDFB
          F8FFFEFBF8FFFDFBF7FFFDFBF7FFFDFAF6FFFDFAF6FFFDFAF5FFFDFAF5FFFCF9
          F4FFFDF9F4FFFCF8F3FFFDF9F3FFFCF8F3FFFCF8F2FFF6EDE2FFC58C5EFF0000
          000E0000000000000003C99365FFFFFFFFFFFEFCFBFFFEFDFAFFFEFCFAFFFEFC
          FAFFFEFCF9FFFEFCF9FFFDFCF9FFFEFBF9FFFDFBF8FFFEFBF8FFFDFBF7FFFDFB
          F7FFFDFAF6FFFDFAF6FFFDFAF5FFFDFAF5FFFCF9F4FFFDF9F4FFFCF8F3FFFDF9
          F3FFFCF8F3FFFCF8F2FFF6EDE2FFC58C5EFF0000000E00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000003C993
          65FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC58D5FFF0000000E0000000000000003C99365FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC58D5FFF0000000E0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000002CA9465FFC99366FFC99265FFC99265FFC89164FFC89164FFC891
          63FFC79062FFC79062FFC78F61FFC78F61FFC68F60FFC68E60FFC68D5FFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFF0000000A0000000000000002CA9465FFC993
          66FFC99265FFC99265FFC89164FFC89164FFC89163FFC79062FFC79062FFC78F
          61FFC78F61FFC68F60FFC68E60FFC68D5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E5FFFC58E
          5FFF0000000A0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000001000000020000000300000003000000030000
          0003000000030000000400000004000000040000000500000005000000050000
          0006000000060000000700000007000000080000000800000008000000090000
          00090000000A0000000A0000000B0000000B0000000900000003000000000000
          0001000000020000000300000003000000030000000300000003000000040000
          0004000000040000000500000005000000050000000600000006000000070000
          000700000008000000080000000800000009000000090000000A0000000A0000
          000B0000000B0000000900000003000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end>
  end
end
