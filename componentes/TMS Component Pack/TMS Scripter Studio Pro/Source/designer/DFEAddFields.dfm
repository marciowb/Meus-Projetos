object fmDFEAddFields: TfmDFEAddFields
  Left = 409
  Top = 333
  Width = 250
  Height = 250
  BorderIcons = []
  Caption = 'Add fields'
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gbFields: TGroupBox
    Left = 10
    Top = 10
    Width = 223
    Height = 169
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Available fields'
    TabOrder = 0
    object lsFieldDefs: TListBox
      Left = 2
      Top = 15
      Width = 219
      Height = 152
      Align = alClient
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
      OnClick = lsFieldDefsClick
    end
  end
  object btOk: TButton
    Left = 78
    Top = 185
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 158
    Top = 185
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
