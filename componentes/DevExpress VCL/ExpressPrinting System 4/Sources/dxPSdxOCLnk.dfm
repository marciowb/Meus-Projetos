object dxOCReportLinkDesignWindow: TdxOCReportLinkDesignWindow
  Left = 318
  Top = 256
  BorderStyle = bsDialog
  Caption = 'Report Designer'
  ClientHeight = 312
  ClientWidth = 569
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object PageControl1: TcxPageControl
    Left = 12
    Top = 12
    Width = 545
    Height = 254
    ActivePage = tshOptions
    MultiLine = True
    ShowFrame = True
    TabOrder = 0
    OnChange = PageControl1Change
    ClientRectBottom = 253
    ClientRectLeft = 1
    ClientRectRight = 544
    ClientRectTop = 24
    object tshOptions: TcxTabSheet
      Caption = '&Options'
      object stDrawBorder: TcxLabel
        Left = 23
        Top = 28
        TabStop = False
        AutoSize = False
        Caption = ' Draw Border '
        FocusControl = chbxDrawBorder
        Properties.LineOptions.Visible = True
        Transparent = True
        OnClick = stDrawBorderClick
        Height = 18
        Width = 209
      end
      object lblPreview: TcxLabel
        Left = 242
        Top = 3
        Caption = 'Preview'
        Transparent = True
      end
      object lblGridLinesColor: TcxLabel
        Left = 27
        Top = 51
        Caption = '&Border Color: '
        FocusControl = ccbxGridLineColor
        Transparent = True
        OnClick = lblColorClick
      end
      object chbxFullExpand: TcxCheckBox
        Left = 8
        Top = 7
        Caption = 'Full &Expand'
        TabOrder = 0
        Transparent = True
        OnClick = chbxFullExpandClick
        Width = 217
      end
      object chbxDrawBorder: TcxCheckBox
        Left = 8
        Top = 27
        TabOrder = 1
        Transparent = True
        OnClick = chbxDrawBorderClick
        Width = 21
      end
      object ccbxGridLineColor: TcxColorComboBox
        Tag = 1
        Left = 103
        Top = 50
        Properties.AllowSelectColor = True
        Properties.CustomColors = <>
        Properties.OnChange = ccbxColorChange
        TabOrder = 2
        Width = 128
      end
      object chbxTransparent: TcxCheckBox
        Left = 8
        Top = 74
        TabOrder = 3
        Transparent = True
        OnClick = chbxTransparentClick
        Width = 21
      end
      object stTransparent: TcxLabel
        Left = 23
        Top = 75
        TabStop = False
        AutoSize = False
        Caption = ' &Transparent '
        FocusControl = chbxTransparent
        Properties.LineOptions.Visible = True
        Transparent = True
        OnClick = stTransparentClick
        Height = 18
        Width = 209
      end
      object lblColor: TcxLabel
        Left = 27
        Top = 99
        Caption = 'Co&lor : '
        FocusControl = ccbxColor
        Transparent = True
        OnClick = lblColorClick
      end
      object ccbxColor: TcxColorComboBox
        Left = 103
        Top = 97
        Properties.AllowSelectColor = True
        Properties.CustomColors = <>
        Properties.OnChange = ccbxColorChange
        TabOrder = 4
        Width = 128
      end
    end
  end
  object pnlPreview: TPanel
    Left = 255
    Top = 58
    Width = 290
    Height = 198
    BevelInner = bvLowered
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 1
    object ocPreview: TdxOrgChart
      Left = 6
      Top = 5
      Width = 279
      Height = 192
      DefaultImageAlign = iaLT
      BorderStyle = bsNone
      Options = [ocDblClick, ocEdit, ocCanDrag, ocShowDrag, ocRect3D]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Visible = False
      Items = {
        564552312E3055000001005A000000FFFFFF1F0100020001160043006F007200
        70006F0072006100740065002000480065006100640071007500610072007400
        650072007300020050000000FFFFFF1F01000100011300530061006C00650073
        00200061006E00640020004D00610072006B006500740069006E006700010050
        000000FFFFFF1F010003000117004600690065006C00640020004F0066006600
        6900630065003A002000430061006E006100640061000D000A00090000005000
        0000FFFFFF1F01000000010B0045006E00670069006E0065006500720069006E
        0067000000}
    end
  end
end
