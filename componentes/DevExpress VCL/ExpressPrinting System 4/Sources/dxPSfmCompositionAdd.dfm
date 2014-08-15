object dxfmCompositionAddItems: TdxfmCompositionAddItems
  Left = 429
  Top = 205
  BorderStyle = bsDialog
  Caption = 'Add Items to Composition'
  ClientHeight = 390
  ClientWidth = 330
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 335
  OldCreateOrder = True
  Position = poScreenCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOK: TcxButton
    Left = 51
    Top = 356
    Width = 85
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 142
    Top = 356
    Width = 85
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TcxButton
    Left = 233
    Top = 356
    Width = 85
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Help'
    TabOrder = 3
  end
  object pgctrlItems: TcxPageControl
    Left = 12
    Top = 12
    Width = 306
    Height = 333
    ActivePage = tshItems
    Anchors = [akLeft, akTop, akRight, akBottom]
    ShowFrame = True
    TabOrder = 0
    ClientRectBottom = 332
    ClientRectLeft = 1
    ClientRectRight = 305
    ClientRectTop = 24
    object tshItems: TcxTabSheet
      BorderWidth = 10
      Caption = 'Available Items'
      ImageIndex = 0
      object lvItems: TcxListView
        Left = 0
        Top = 0
        Width = 284
        Height = 264
        Align = alClient
        ColumnClick = False
        Columns = <>
        MultiSelect = True
        ReadOnly = True
        TabOrder = 0
        OnDblClick = lvItemsDblClick
      end
      object pnlNoItems: TcxLabel
        Tag = 20
        Left = 24
        Top = 33
        TabStop = False
        AutoSize = False
        Caption = 'There are no Items do Display'
        ParentColor = False
        ParentFont = False
        Style.TextColor = clGrayText
        Properties.Alignment.Horz = taCenter
        Transparent = True
        Height = 19
        Width = 236
        AnchorX = 142
      end
      object gpOptions: TcxGroupBox
        Left = 0
        Top = 264
        Align = alBottom
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.SkinName = ''
        StyleDisabled.LookAndFeel.SkinName = ''
        StyleFocused.LookAndFeel.SkinName = ''
        StyleHot.LookAndFeel.SkinName = ''
        TabOrder = 2
        Height = 24
        Width = 284
        object chbxHideIncludedItems: TcxCheckBox
          Left = 0
          Top = 7
          Caption = 'Hide Already Included Items'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
          OnClick = chbxHideIncludedItemsClick
          Width = 281
        end
      end
    end
  end
end
