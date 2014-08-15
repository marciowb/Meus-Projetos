object dxfmAutoText: TdxfmAutoText
  Left = 324
  Top = 212
  ActiveControl = cbxAutoEntries
  BorderStyle = bsDialog
  Caption = 'AutoText'
  ClientHeight = 375
  ClientWidth = 402
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOK: TcxButton
    Left = 123
    Top = 340
    Width = 85
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 214
    Top = 340
    Width = 85
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TcxButton
    Left = 305
    Top = 340
    Width = 85
    Height = 23
    Caption = '&Help'
    TabOrder = 3
  end
  object gbxEnterAutoTextEntriesHere: TcxGroupBox
    Left = 12
    Top = 12
    Caption = ' Enter A&utoText Entries Here: '
    Style.TransparentBorder = False
    TabOrder = 0
    Height = 317
    Width = 378
    object pbxPreview: TPaintBox
      Left = 11
      Top = 231
      Width = 356
      Height = 74
      Anchors = [akLeft, akBottom]
      Color = clBtnFace
      ParentColor = False
      OnPaint = pbxPreviewPaint
    end
    object btnAdd: TcxButton
      Left = 282
      Top = 21
      Width = 85
      Height = 23
      Caption = '&Add'
      Default = True
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnDelete: TcxButton
      Left = 282
      Top = 49
      Width = 85
      Height = 23
      Caption = '&Delete'
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object lblPreview: TcxLabel
      Left = 8
      Top = 212
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Preview'
      Properties.LineOptions.Visible = True
      Transparent = True
      Height = 19
      Width = 361
    end
    object cbxAutoEntries: TcxTextEdit
      Left = 11
      Top = 23
      Properties.OnChange = cbxAutoEntriesPropertiesChange
      Style.TransparentBorder = False
      TabOrder = 0
      OnEnter = cbxAutoEntriesEnter
      OnExit = cbxAutoEntriesExit
      OnKeyDown = cbxAutoEntriesKeyDown
      Width = 265
    end
    object cbxAutoEntriesList: TcxListBox
      Left = 11
      Top = 48
      Width = 265
      Height = 128
      ItemHeight = 13
      Style.TransparentBorder = False
      TabOrder = 1
      OnClick = cbxAutoEntriesListClick
      OnKeyDown = cbxAutoEntriesListKeyDown
    end
    object ToolBar: TcxGroupBox
      Left = 11
      Top = 181
      PanelStyle.Active = True
      ParentBackground = False
      ParentShowHint = False
      ShowHint = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 4
      Height = 28
      Width = 267
    end
  end
end
