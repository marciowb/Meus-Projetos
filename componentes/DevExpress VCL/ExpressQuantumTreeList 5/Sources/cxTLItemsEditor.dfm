object frmItemsEditor: TfrmItemsEditor
  Left = 243
  Top = 174
  Anchors = [akLeft, akTop, akBottom]
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'Items Editor'
  ClientHeight = 401
  ClientWidth = 497
  Color = clBtnFace
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 357
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel3: TPanel
      Left = 320
      Top = 0
      Width = 177
      Height = 357
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnNewItem: TcxButton
        Tag = 4
        Left = 9
        Top = 8
        Width = 161
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '&New Item'
        TabOrder = 0
        OnClick = cxButtonPress
      end
      object btnNewSubItem: TcxButton
        Tag = 5
        Left = 9
        Top = 38
        Width = 161
        Height = 22
        Anchors = [akTop, akRight]
        Caption = 'New &SubItem'
        TabOrder = 1
        OnClick = cxButtonPress
      end
      object btnDelete: TcxButton
        Tag = 6
        Left = 9
        Top = 68
        Width = 161
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '&Delete'
        TabOrder = 2
        OnClick = cxButtonPress
      end
      object Panel5: TPanel
        Left = 0
        Top = 100
        Width = 177
        Height = 257
        Align = alBottom
        Anchors = [akTop, akRight, akBottom]
        BevelOuter = bvNone
        TabOrder = 3
        object lbCheckType: TLabel
          Left = 11
          Top = 189
          Width = 93
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Check Group Type:'
        end
        object gbIndexes: TGroupBox
          Left = 9
          Top = 5
          Width = 161
          Height = 169
          Anchors = [akTop, akRight]
          Caption = 'Image Indexes'
          TabOrder = 0
          object Label1: TLabel
            Left = 8
            Top = 44
            Width = 29
            Height = 13
            Caption = 'Image'
          end
          object Label2: TLabel
            Left = 8
            Top = 68
            Width = 42
            Height = 13
            Caption = 'Selected'
          end
          object Label3: TLabel
            Left = 8
            Top = 92
            Width = 25
            Height = 13
            Caption = 'State'
          end
          object Label7: TLabel
            Left = 8
            Top = 116
            Width = 36
            Height = 13
            Caption = 'Overlay'
          end
          object Label9: TLabel
            Left = 8
            Top = 140
            Width = 61
            Height = 13
            Caption = 'OverlayState'
          end
          object Label4: TLabel
            Left = 70
            Top = 18
            Width = 34
            Height = 13
            Caption = 'Current'
          end
          object Label5: TLabel
            Left = 117
            Top = 18
            Width = 34
            Height = 13
            Caption = 'Default'
          end
          object edtImage: TcxTextEdit
            Left = 77
            Top = 39
            TabOrder = 0
            Text = '0'
            OnExit = edtImageExit
            OnKeyDown = edtImageKeyDown
            Width = 24
          end
          object edtSelected: TcxTextEdit
            Tag = 1
            Left = 77
            Top = 63
            TabOrder = 2
            Text = '0'
            OnExit = edtImageExit
            OnKeyDown = edtImageKeyDown
            Width = 24
          end
          object edtState: TcxTextEdit
            Tag = 2
            Left = 77
            Top = 87
            TabOrder = 4
            Text = '-1'
            OnExit = edtImageExit
            OnKeyDown = edtImageKeyDown
            Width = 24
          end
          object edtOverlay: TcxTextEdit
            Tag = 3
            Left = 77
            Top = 111
            TabOrder = 6
            Text = '-1'
            OnExit = edtImageExit
            OnKeyDown = edtImageKeyDown
            Width = 24
          end
          object edtOverlayState: TcxTextEdit
            Tag = 4
            Left = 77
            Top = 135
            TabOrder = 8
            Text = '-1'
            OnExit = edtImageExit
            OnKeyDown = edtImageKeyDown
            Width = 24
          end
          object edtDefImage: TcxTextEdit
            Left = 125
            Top = 39
            TabOrder = 1
            Text = '0'
            Width = 24
          end
          object edtDefSelected: TcxTextEdit
            Tag = 1
            Left = 125
            Top = 63
            TabOrder = 3
            Text = '0'
            Width = 24
          end
          object edtDefState: TcxTextEdit
            Tag = 2
            Left = 125
            Top = 87
            TabOrder = 5
            Text = '-1'
            Width = 24
          end
          object edtDefOverlay: TcxTextEdit
            Tag = 3
            Left = 125
            Top = 111
            TabOrder = 7
            Text = '-1'
            Width = 24
          end
          object edtDefOverlayState: TcxTextEdit
            Tag = 4
            Left = 125
            Top = 135
            TabOrder = 9
            Text = '-1'
            OnExit = edtImageExit
            OnKeyDown = edtImageKeyDown
            Width = 24
          end
        end
        object cbCheckGroupType: TcxComboBox
          Left = 9
          Top = 205
          Anchors = [akTop, akRight]
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'None'
            'CheckGroup'
            'RadioGroup')
          Properties.OnEditValueChanged = cbCheckGroupTypePropertiesEditValueChanged
          TabOrder = 1
          Text = 'None'
          Width = 163
        end
        object cbEnabled: TcxCheckBox
          Left = 9
          Top = 234
          Anchors = [akTop, akRight]
          Caption = 'Enabled'
          Properties.OnEditValueChanged = cxCheckBox1PropertiesEditValueChanged
          TabOrder = 2
          Width = 161
        end
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 320
      Height = 357
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 320
        Height = 8
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel10: TPanel
        Left = 0
        Top = 8
        Width = 8
        Height = 347
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
      end
      object cxTLSite: TcxTreeList
        Left = 8
        Top = 8
        Width = 312
        Height = 347
        Align = alClient
        Bands = <
          item
            Caption.Text = 'Band + 1'
          end>
        DragMode = dmAutomatic
        OptionsSelection.HideFocusRect = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.GridLineColor = clBlack
        OptionsView.GridLines = tlglBoth
        PopupMenu = mnuEditItems
        Preview.Visible = True
        TabOrder = 2
        OnDragOver = cxTLSiteDragOver
        object cxTreeList1cxTreeListColumn1: TcxTreeListColumn
          DataBinding.ValueType = 'String'
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 355
        Width = 320
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 357
    Width = 497
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Bevel1: TBevel
      Left = 8
      Top = 6
      Width = 482
      Height = 11
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object btnCustomize: TcxButton
      Left = 8
      Top = 16
      Width = 90
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = 'C&ustomize'
      TabOrder = 0
      OnClick = cxButtonPress
    end
    object btnOk: TcxButton
      Tag = 1
      Left = 300
      Top = 16
      Width = 90
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      ModalResult = 1
      TabOrder = 1
    end
    object btnCancel: TcxButton
      Tag = 2
      Left = 400
      Top = 16
      Width = 90
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 2
    end
  end
  object mnuEditItems: TPopupMenu
    Left = 296
    Top = 8
    object NewItem1: TMenuItem
      Tag = 4
      Caption = '&New Item'
      OnClick = cxButtonPress
    end
    object NewSubItem1: TMenuItem
      Tag = 5
      Caption = 'New &SubItem'
      OnClick = cxButtonPress
    end
    object Delete1: TMenuItem
      Tag = 6
      Caption = '&Delete'
      OnClick = cxButtonPress
    end
    object N1: TMenuItem
      Caption = '-'
      OnClick = cxButtonPress
    end
    object Customize1: TMenuItem
      Caption = 'C&ustomize'
      OnClick = cxButtonPress
    end
  end
end
