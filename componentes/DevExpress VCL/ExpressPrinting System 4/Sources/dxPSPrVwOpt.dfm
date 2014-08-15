object dxfmOptions: TdxfmOptions
  Left = 303
  Top = 247
  ActiveControl = chbxShowMargins
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 266
  ClientWidth = 540
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOk: TcxButton
    Left = 291
    Top = 231
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 372
    Top = 231
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TcxButton
    Left = 453
    Top = 231
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 3
  end
  object pcMain: TcxPageControl
    Left = 12
    Top = 12
    Width = 516
    Height = 208
    ActivePage = tshGeneral
    Anchors = [akLeft, akTop, akRight, akBottom]
    ShowFrame = True
    TabOrder = 0
    ClientRectBottom = 207
    ClientRectLeft = 1
    ClientRectRight = 515
    ClientRectTop = 24
    object tshGeneral: TcxTabSheet
      ImageIndex = 0
      object gbxShow: TcxGroupBox
        Left = 10
        Top = 6
        Caption = ' &Show '
        Style.TransparentBorder = True
        TabOrder = 0
        Height = 102
        Width = 244
        object chbxShowMarginsHintsWhileDragging: TcxCheckBox
          Left = 9
          Top = 66
          Caption = 'Margins hints while &dragging'
          TabOrder = 2
          Transparent = True
          OnClick = FormChanged
          Width = 224
        end
        object chbxShowMargins: TcxCheckBox
          Left = 9
          Top = 22
          Caption = '&Margins'
          TabOrder = 0
          Transparent = True
          OnClick = FormChanged
          Width = 224
        end
        object chbxShowMarginsHints: TcxCheckBox
          Left = 9
          Top = 44
          Caption = 'Margins &hints'
          TabOrder = 1
          Transparent = True
          OnClick = FormChanged
          Width = 224
        end
      end
      object gbxZoomOpt: TcxGroupBox
        Left = 262
        Top = 6
        Style.TransparentBorder = True
        TabOrder = 1
        Height = 102
        Width = 243
        object chbxZoomOnRoll: TcxCheckBox
          Left = 10
          Top = 20
          Caption = '&Zoom on roll with IntelliMouse'
          TabOrder = 0
          Transparent = True
          OnClick = FormChanged
          Width = 230
        end
        object lblZoomStep: TcxLabel
          Left = 15
          Top = 46
          Caption = 'Zoom &Step :'
          FocusControl = seZoomStep
          Transparent = True
          OnClick = lblMarginsColorClick
        end
        object seZoomStep: TcxSpinEdit
          Left = 103
          Top = 45
          Properties.DisplayFormat = '0 %'
          Properties.MaxValue = 20.000000000000000000
          Properties.MinValue = 1.000000000000000000
          Properties.OnChange = FormChanged
          TabOrder = 2
          Value = 1
          Width = 67
        end
      end
      object gbxMarginsColor: TcxGroupBox
        Left = 262
        Top = 112
        Style.TransparentBorder = True
        TabOrder = 2
        Height = 62
        Width = 243
        object cbxMarginColor: TcxColorComboBox
          Left = 10
          Top = 31
          Properties.CustomColors = <>
          Properties.OnChange = FormChanged
          TabOrder = 0
          Width = 222
        end
        object lblMarginsColor: TcxLabel
          Left = 9
          Top = 13
          Caption = '&Margins color:'
          FocusControl = cbxMarginColor
          Transparent = True
          OnClick = lblMarginsColorClick
        end
      end
      object gbxMeasurementUnits: TcxGroupBox
        Left = 10
        Top = 112
        Style.TransparentBorder = True
        TabOrder = 3
        Height = 62
        Width = 244
        object cbxMeasurementUnits: TcxComboBox
          Left = 9
          Top = 31
          Properties.DropDownListStyle = lsFixedList
          Properties.OnChange = FormChanged
          TabOrder = 0
          Width = 224
        end
        object lblMeasurementUnits: TcxLabel
          Left = 9
          Top = 13
          Caption = '&Measurement units:'
          FocusControl = cbxMeasurementUnits
          Transparent = True
          OnClick = lblMarginsColorClick
        end
      end
    end
  end
end
