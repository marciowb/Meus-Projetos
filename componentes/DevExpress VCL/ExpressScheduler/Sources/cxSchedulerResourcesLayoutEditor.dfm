object fmResourcesLayoutEditor: TfmResourcesLayoutEditor
  Left = 249
  Top = 230
  ActiveControl = clbResources
  AutoScroll = False
  BorderStyle = bsSizeToolWin
  Caption = 'Resource editor'
  ClientHeight = 227
  ClientWidth = 212
  Color = clBtnFace
  Constraints.MinHeight = 160
  Constraints.MinWidth = 220
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TcxButton
    Left = 121
    Top = 194
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 0
  end
  object btnUp: TcxButton
    Left = 121
    Top = 8
    Width = 85
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Up'
    TabOrder = 1
    OnClick = BtnClick
  end
  object btnDown: TcxButton
    Tag = 1
    Left = 121
    Top = 40
    Width = 85
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Down'
    TabOrder = 2
    OnClick = BtnClick
  end
  object clbResources: TcxCheckListBox
    Left = 8
    Top = 8
    Width = 106
    Height = 212
    Anchors = [akLeft, akTop, akRight, akBottom]
    Items = <>
    TabOrder = 3
    OnClick = clbResourcesClick
    OnDragOver = clbResourcesDragOver
    OnEditValueChanged = clbResourcesEditValueChanged
    OnKeyDown = clbResourcesKeyDown
    OnMouseDown = clbResourcesMouseDown
  end
end
