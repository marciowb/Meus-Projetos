object fmMetaSQLEditor: TfmMetaSQLEditor
  Left = 114
  Top = 89
  Width = 544
  Height = 375
  Caption = 'Meta SQL Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    Left = 0
    Top = 32
    Width = 536
    Height = 316
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'Tables'
      'Fields'
      'Joins'
      'Conditions'
      'Order'
      'Group'
      'SQL'
      'Data result')
    TabIndex = 0
    OnChange = TabControl1Change
    object pnEditor: TPanel
      Left = 4
      Top = 24
      Width = 528
      Height = 288
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 8
      Width = 49
      Height = 13
      Caption = '&Database:'
      FocusControl = cbDatabases
    end
    object cbDatabases: TComboBox
      Left = 60
      Top = 5
      Width = 205
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnClick = cbDatabasesClick
    end
    object cbSaveDB: TCheckBox
      Left = 271
      Top = 7
      Width = 178
      Height = 17
      Caption = '&Save last used database'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 420
      Top = 3
      Width = 88
      Height = 23
      Action = acImportFromSQL
      TabOrder = 2
    end
  end
  object ActionList1: TActionList
    Left = 164
    Top = 128
    object acNextTab: TAction
      Caption = 'Next tab'
      ShortCut = 119
      OnExecute = acNextTabExecute
    end
    object acPreviousTab: TAction
      Caption = 'Previous tab'
      ShortCut = 118
      OnExecute = acPreviousTabExecute
    end
    object acImportFromSQL: TAction
      Caption = 'Import from SQL'
      OnExecute = acImportFromSQLExecute
    end
  end
end
