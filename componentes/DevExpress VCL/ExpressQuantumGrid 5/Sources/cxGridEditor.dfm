object cxGridEditor: TcxGridEditor
  Left = 457
  Top = 105
  Width = 570
  Height = 400
  HorzScrollBar.Range = 4
  VertScrollBar.Range = 34
  ActiveControl = PageControl1
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'Editing'
  Color = clBtnFace
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 558
    Height = 332
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 209
      Top = 0
      Width = 6
      Height = 332
      Cursor = crHSplit
    end
    object Panel4: TPanel
      Left = 215
      Top = 0
      Width = 343
      Height = 332
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object PViewFrame: TPanel
        Left = 0
        Top = 19
        Width = 343
        Height = 313
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 343
        Height = 19
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 3
          Width = 71
          Height = 13
          Caption = 'Selected View:'
        end
        object LSelectedView: TLabel
          Left = 86
          Top = 3
          Width = 82
          Height = 13
          Caption = '<AViewName>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = 'MS Sans Serif'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object PLeft: TPanel
      Left = 0
      Top = 0
      Width = 209
      Height = 332
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object PageControl1: TPageControl
        Left = 4
        Top = 4
        Width = 205
        Height = 328
        ActivePage = tsLevels
        Align = alClient
        TabOrder = 0
        object tsLevels: TTabSheet
          Caption = '  Levels  '
          object PLevels: TPanel
            Left = 0
            Top = 0
            Width = 197
            Height = 266
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 0
          end
          object Panel6: TPanel
            Left = 0
            Top = 266
            Width = 197
            Height = 34
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object BAddLevel: TButton
              Left = 1
              Top = 6
              Width = 80
              Height = 24
              Caption = '&Add Level'
              TabOrder = 0
              OnClick = BAddLevelClick
            end
            object BDeleteLevel: TButton
              Left = 90
              Top = 6
              Width = 80
              Height = 24
              Caption = '&Delete Level'
              TabOrder = 1
              OnClick = BDeleteLevelClick
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = '  Views  '
          ImageIndex = 1
          object PViews: TPanel
            Left = 0
            Top = 0
            Width = 197
            Height = 236
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 0
            object LBViews: TListBox
              Left = 1
              Top = 1
              Width = 195
              Height = 234
              Align = alClient
              BorderStyle = bsNone
              ItemHeight = 13
              MultiSelect = True
              PopupMenu = PMViewList
              TabOrder = 0
              OnClick = LBViewsClick
              OnKeyPress = GridStructureControlKeyPress
            end
          end
          object Panel9: TPanel
            Left = 0
            Top = 236
            Width = 197
            Height = 64
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object BAddView: TButton
              Left = 1
              Top = 6
              Width = 80
              Height = 24
              Caption = 'Add &View...'
              TabOrder = 0
              OnClick = BAddViewClick
            end
            object BDeleteView: TButton
              Left = 90
              Top = 6
              Width = 80
              Height = 24
              Caption = 'D&elete View'
              TabOrder = 1
              OnClick = BDeleteViewClick
            end
            object BEditView: TButton
              Left = 1
              Top = 36
              Width = 169
              Height = 25
              Caption = 'Edit View &Layout and Data...'
              TabOrder = 2
              OnClick = miEditLayoutClick
            end
          end
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 4
        Width = 4
        Height = 328
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 209
        Height = 4
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 332
    Width = 562
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 385
      Top = 0
      Width = 177
      Height = 34
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BClose: TButton
        Left = 93
        Top = 6
        Width = 80
        Height = 23
        Cancel = True
        Caption = '&Close'
        TabOrder = 0
        OnClick = BCloseClick
      end
    end
  end
  object Panel10: TPanel
    Left = 558
    Top = 0
    Width = 4
    Height = 332
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
  end
  object PMGridStructureControl: TPopupMenu
    Left = 86
    Top = 62
  end
  object PMViews: TPopupMenu
    Left = 80
    Top = 104
  end
  object PMViewList: TPopupMenu
    Left = 84
    Top = 150
    object miDeleteView: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteViewClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miEditLayout: TMenuItem
      Caption = '&Edit Layout and Data...'
      OnClick = miEditLayoutClick
    end
  end
end
