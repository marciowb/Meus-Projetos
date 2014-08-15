object frmConnectionDesigner: TfrmConnectionDesigner
  Left = 289
  Top = 153
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'OLAP Connection'
  ClientHeight = 188
  ClientWidth = 383
  Color = clBtnFace
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOk: TcxButton
    Left = 193
    Top = 154
    Width = 85
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 289
    Top = 154
    Width = 85
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object gbSite: TcxGroupBox
    Left = 8
    Top = 5
    PanelStyle.Active = True
    TabOrder = 0
    Transparent = True
    Height = 140
    Width = 366
    object lbConnectType: TcxLabel
      Left = 9
      Top = 15
      Caption = 'Connect using'
      Transparent = True
    end
    object rbAnalysisServer: TcxRadioButton
      Left = 105
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Analysis server'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rbAnalysisServerClick
      Transparent = True
    end
    object rbCubeFile: TcxRadioButton
      Left = 233
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Cube file'
      TabOrder = 2
      OnClick = rbCubeFileClick
      Transparent = True
    end
    object edtServer: TcxButtonEdit
      Left = 104
      Top = 40
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = edtServerPropertiesButtonClick
      Properties.OnEditValueChanged = edtServerChanged
      TabOrder = 3
      Width = 249
    end
    object edtDatabase: TcxComboBox
      Left = 104
      Top = 72
      Properties.DropDownListStyle = lsFixedList
      Properties.OnEditValueChanged = edtDatabaseChanged
      TabOrder = 4
      Width = 249
    end
    object lbServer: TcxLabel
      Left = 9
      Top = 40
      Caption = 'Server'
      FocusControl = edtServer
      Transparent = True
    end
    object lbDatabase: TcxLabel
      Left = 9
      Top = 72
      Caption = 'Database'
      FocusControl = edtDatabase
      Transparent = True
    end
    object lbCube: TcxLabel
      Left = 9
      Top = 106
      Caption = 'Cube'
      FocusControl = edtCube
      Transparent = True
    end
    object edtCube: TcxComboBox
      Left = 104
      Top = 104
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = edtDatabaseChanged
      TabOrder = 8
      Width = 249
    end
  end
  object dlgOpen: TOpenDialog
    Filter = 'Cube files|*.cub|All files|*.*'
    Left = 16
    Top = 149
  end
end
