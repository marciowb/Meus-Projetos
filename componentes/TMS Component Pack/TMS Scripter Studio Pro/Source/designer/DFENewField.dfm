object fmDFENewField: TfmDFENewField
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'New field'
  ClientHeight = 233
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbProperties: TGroupBox
    Left = 10
    Top = 10
    Width = 393
    Height = 70
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Field properties'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 20
      Width = 31
      Height = 13
      Caption = '&Name:'
    end
    object Label2: TLabel
      Left = 200
      Top = 20
      Width = 57
      Height = 13
      Caption = 'C&omponent:'
    end
    object Label3: TLabel
      Left = 10
      Top = 45
      Width = 27
      Height = 13
      Caption = '&Type:'
    end
    object Label4: TLabel
      Left = 200
      Top = 45
      Width = 23
      Height = 13
      Caption = '&Size:'
    end
    object edName: TEdit
      Left = 45
      Top = 15
      Width = 145
      Height = 21
      TabOrder = 0
      OnChange = edNameChange
    end
    object edComponent: TEdit
      Left = 260
      Top = 15
      Width = 125
      Height = 21
      TabOrder = 1
    end
    object cbType: TComboBox
      Left = 45
      Top = 40
      Width = 145
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 2
      OnChange = cbTypeChange
    end
    object edSize: TEdit
      Left = 260
      Top = 40
      Width = 60
      Height = 21
      TabOrder = 3
    end
  end
  object rgKind: TRadioGroup
    Left = 10
    Top = 85
    Width = 393
    Height = 35
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Field type'
    Columns = 3
    Items.Strings = (
      '&Data'
      '&Calculated'
      '&Lookup')
    TabOrder = 1
    OnClick = rgKindClick
  end
  object gbLookup: TGroupBox
    Left = 10
    Top = 125
    Width = 393
    Height = 70
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Lookup definition'
    TabOrder = 2
    object lbKeyField: TLabel
      Left = 10
      Top = 20
      Width = 48
      Height = 13
      Caption = '&Key fields:'
    end
    object lbLookupDataset: TLabel
      Left = 200
      Top = 20
      Width = 40
      Height = 13
      Caption = 'D&ataset:'
    end
    object lbLookupKey: TLabel
      Left = 10
      Top = 45
      Width = 64
      Height = 13
      Caption = 'Look&up keys:'
    end
    object lbResultField: TLabel
      Left = 200
      Top = 45
      Width = 55
      Height = 13
      Caption = '&Result field:'
    end
    object cbKeyField: TComboBox
      Left = 77
      Top = 15
      Width = 115
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object cbLookupDataset: TComboBox
      Left = 260
      Top = 15
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnChange = cbLookupDatasetChange
    end
    object cbLookupKey: TComboBox
      Left = 77
      Top = 40
      Width = 115
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
    object cbResultField: TComboBox
      Left = 260
      Top = 40
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 3
    end
  end
  object btOk: TButton
    Left = 248
    Top = 202
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btCancel: TButton
    Left = 328
    Top = 202
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
