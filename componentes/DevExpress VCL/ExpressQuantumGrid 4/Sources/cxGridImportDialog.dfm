object ImportDialog: TImportDialog
  Left = 414
  Top = 214
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import'
  ClientHeight = 367
  ClientWidth = 250
  Color = clBtnFace
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 141
    Top = 0
    Width = 113
    Height = 367
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 12
      Top = 8
      Width = 89
      Height = 25
      Caption = 'Import'
      Enabled = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 12
      Top = 40
      Width = 89
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 12
      Top = 332
      Width = 89
      Height = 25
      Caption = 'Options >>'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 141
    Height = 367
    Align = alLeft
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
  end
  object Panel2: TPanel
    Left = 254
    Top = 0
    Width = 321
    Height = 367
    Align = alClient
    TabOrder = 2
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 319
      Height = 365
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      TabStop = False
      object TabSheet1: TTabSheet
        Caption = 'Levels'
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 311
          Height = 280
          Align = alTop
          Caption = ' Destination Level '
          TabOrder = 0
          object lbCurrentLevelName: TLabel
            Left = 78
            Top = 256
            Width = 5
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label1: TLabel
            Left = 4
            Top = 256
            Width = 73
            Height = 13
            Caption = 'Selected level: '
          end
          object Panel3: TPanel
            Left = 2
            Top = 15
            Width = 307
            Height = 234
            Align = alTop
            BevelInner = bvLowered
            BevelOuter = bvLowered
            TabOrder = 0
          end
        end
        object cbDeleteAllSublevels: TCheckBox
          Left = 4
          Top = 315
          Width = 125
          Height = 17
          Caption = 'Delete All Sublevels'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Styles'
        ImageIndex = 1
        OnShow = TabSheet2Show
        object GroupBox2: TGroupBox
          Left = 0
          Top = 36
          Width = 311
          Height = 301
          Align = alBottom
          Caption = ' StyleRepository Options '
          TabOrder = 1
          object RadioButton1: TRadioButton
            Left = 16
            Top = 28
            Width = 169
            Height = 17
            Caption = 'Create New StyleRepository'
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = RadioButton1Click
          end
          object RadioButton2: TRadioButton
            Left = 16
            Top = 100
            Width = 173
            Height = 17
            Caption = 'Use Existing StyleRepository'
            TabOrder = 2
            OnClick = RadioButton2Click
          end
          object Edit1: TEdit
            Left = 36
            Top = 52
            Width = 229
            Height = 21
            TabOrder = 1
          end
          object ComboBox1: TComboBox
            Left = 36
            Top = 124
            Width = 229
            Height = 21
            Style = csDropDownList
            Color = clBtnFace
            Enabled = False
            ItemHeight = 13
            TabOrder = 3
          end
        end
        object cbImportStyles: TCheckBox
          Left = 4
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Import Styles'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbImportStylesClick
        end
      end
    end
  end
end
