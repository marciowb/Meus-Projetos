object fmSchedulerTaskDependencyEditor: TfmSchedulerTaskDependencyEditor
  Left = 494
  Top = 254
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'fmSchedulerTaskDependencyEditor'
  ClientHeight = 120
  ClientWidth = 292
  Color = clBtnFace
  Constraints.MinHeight = 154
  Constraints.MinWidth = 300
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object cxGroupBox1: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 120
    Width = 292
    object lbTo: TcxLabel
      Left = 8
      Top = 35
      Caption = 'lbTo'
      Transparent = True
    end
    object lbType: TcxLabel
      Left = 8
      Top = 60
      Caption = 'lbType'
      FocusControl = cbTypeRelation
      Transparent = True
    end
    object lbToName: TcxLabel
      Left = 70
      Top = 35
      AutoSize = False
      Caption = 'lbToName'
      Properties.ShowAccelChar = False
      Style.TransparentBorder = False
      Transparent = True
      Height = 17
      Width = 214
    end
    object lbFromName: TcxLabel
      Left = 70
      Top = 8
      AutoSize = False
      Caption = 'lbFromName'
      Properties.ShowAccelChar = False
      Style.TransparentBorder = False
      Transparent = True
      Height = 17
      Width = 214
    end
    object cbTypeRelation: TcxComboBox
      Left = 70
      Top = 60
      Anchors = [akLeft, akTop, akRight]
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = cbTypeRelationPropertiesChange
      TabOrder = 3
      OnKeyDown = FormKeyDown
      Width = 214
    end
    object btnOk: TcxButton
      Left = 106
      Top = 89
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'btnOk'
      Default = True
      ModalResult = 1
      TabOrder = 4
      OnKeyDown = FormKeyDown
    end
    object btnDelete: TcxButton
      Left = 13
      Top = 89
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'btnDelete'
      ModalResult = 1
      TabOrder = 5
      OnClick = btnDeleteClick
      OnKeyDown = FormKeyDown
    end
    object btnCancel: TcxButton
      Left = 199
      Top = 89
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'btnCancel'
      ModalResult = 2
      TabOrder = 6
      OnKeyDown = FormKeyDown
    end
    object lbFrom: TcxLabel
      Left = 8
      Top = 8
      Caption = 'lbFrom'
      Transparent = True
    end
  end
end
