object fmResourcesLayoutEditor: TfmResourcesLayoutEditor
  Left = 249
  Top = 230
  ActiveControl = clbResources
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'Resource editor'
  ClientHeight = 227
  ClientWidth = 301
  Color = clBtnFace
  Constraints.MinHeight = 224
  Constraints.MinWidth = 220
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TcxButton
    Left = 210
    Top = 196
    Width = 85
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 0
  end
  object btnUp: TcxButton
    Left = 210
    Top = 8
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Up'
    TabOrder = 1
    OnClick = BtnClick
  end
  object btnDown: TcxButton
    Tag = 1
    Left = 210
    Top = 40
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Down'
    TabOrder = 2
    OnClick = BtnClick
  end
  object clbResources: TcxCheckListBox
    Left = 8
    Top = 8
    Width = 195
    Height = 212
    Anchors = [akLeft, akTop, akRight, akBottom]
    EditValueFormat = cvfIndices
    Items = <>
    TabOrder = 5
    OnClick = clbResourcesClick
    OnDragOver = clbResourcesDragOver
    OnEditValueChanged = clbResourcesEditValueChanged
    OnKeyDown = clbResourcesKeyDown
    OnMouseDown = clbResourcesMouseDown
  end
  object btnSelectAll: TcxButton
    Tag = 2
    Left = 210
    Top = 72
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Select all'
    TabOrder = 3
    OnClick = BtnClick
  end
  object btnSelectNone: TcxButton
    Tag = 3
    Left = 210
    Top = 104
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Select none'
    TabOrder = 4
    OnClick = BtnClick
  end
end
