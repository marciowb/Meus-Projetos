object fmImageListEditor: TfmImageListEditor
  Left = 298
  Top = 204
  Width = 360
  Height = 333
  BorderIcons = [biSystemMenu]
  Caption = 'ImageList'
  Color = clBtnFace
  Constraints.MinHeight = 333
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object gbSelected: TGroupBox
    Left = 5
    Top = 155
    Width = 333
    Height = 100
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Selected image'
    TabOrder = 1
    object Label1: TLabel
      Left = 100
      Top = 15
      Width = 86
      Height = 13
      Caption = '&Transparent color:'
    end
    object Label2: TLabel
      Left = 100
      Top = 54
      Width = 41
      Height = 13
      Caption = '&Fill color:'
    end
    object pnSelected: TPanel
      Left = 5
      Top = 15
      Width = 80
      Height = 80
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clWindow
      TabOrder = 0
      object imSelected: TImage
        Left = 0
        Top = 0
        Width = 76
        Height = 76
        Align = alClient
        Stretch = True
      end
    end
    object cbTransparentColor: TComboBox
      Left = 100
      Top = 30
      Width = 130
      Height = 19
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      OnChange = cbTransparentColorChange
      OnDrawItem = cbTransparentColorDrawItem
    end
    object cbFillColor: TComboBox
      Left = 100
      Top = 69
      Width = 130
      Height = 19
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      Sorted = True
      TabOrder = 2
      OnChange = cbFillColorChange
      OnDrawItem = cbTransparentColorDrawItem
    end
    object rgOptions: TRadioGroup
      Left = 247
      Top = 15
      Width = 75
      Height = 75
      Anchors = [akTop, akRight, akBottom]
      Caption = '&Options'
      Enabled = False
      Items.Strings = (
        'Center'
        'Crop'
        'Stretch')
      TabOrder = 3
      OnClick = rgOptionsClick
    end
  end
  object gbImages: TGroupBox
    Left = 5
    Top = 5
    Width = 333
    Height = 142
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Images'
    TabOrder = 0
    object lvImages: TListView
      Left = 5
      Top = 15
      Width = 250
      Height = 122
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <>
      DragMode = dmAutomatic
      HideSelection = False
      IconOptions.AutoArrange = True
      MultiSelect = True
      ReadOnly = True
      TabOrder = 0
      OnChange = lvImagesChange
      OnDragDrop = lvImagesDragDrop
      OnDragOver = lvImagesDragOver
    end
    object btAdd: TButton
      Left = 260
      Top = 15
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Add...'
      TabOrder = 1
      OnClick = btAddClick
    end
    object btReplace: TButton
      Left = 260
      Top = 39
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Replace...'
      Enabled = False
      TabOrder = 2
      OnClick = btReplaceClick
    end
    object btDelete: TButton
      Left = 260
      Top = 63
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Delete'
      Enabled = False
      TabOrder = 3
      OnClick = btDeleteClick
    end
    object btClear: TButton
      Left = 260
      Top = 87
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Clear'
      Enabled = False
      TabOrder = 4
      OnClick = btClearClick
    end
    object btExport: TButton
      Left = 260
      Top = 111
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Export...'
      Enabled = False
      TabOrder = 5
      OnClick = btExportClick
    end
  end
  object btOK: TButton
    Left = 103
    Top = 263
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btApply: TButton
    Left = 183
    Top = 263
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'A&pply'
    Enabled = False
    TabOrder = 3
    OnClick = btApplyClick
  end
  object btCancel: TButton
    Left = 262
    Top = 263
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object ImageList: TImageList
    Left = 9
    Top = 264
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Title = 'Export images'
    Left = 72
    Top = 264
  end
  object dlgOpen: TOpenPictureDialog
    DefaultExt = 'bmp'
    Filter = 
      'All (*.bmp, *.ico)|*.bmp;*.ico|Bitmaps (*.bmp)|*.bmp|Icons (*.ic' +
      'o)|*.ico'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Add images'
    Left = 40
    Top = 264
  end
end
