object dxInspectorCustomizeForm: TdxInspectorCustomizeForm
  Left = 490
  Top = 111
  Width = 188
  Height = 247
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Customize'
  Color = clBtnFace
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 180
    Height = 220
    ActivePage = tsRows
    Align = alClient
    TabOrder = 0
    object tsRows: TTabSheet
      Caption = '  Rows  '
    end
    object tsCategories: TTabSheet
      Caption = '  Categories  '
      ImageIndex = 1
      object Panel: TPanel
        Left = 0
        Top = 157
        Width = 172
        Height = 35
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object BNew: TButton
          Left = 7
          Top = 7
          Width = 75
          Height = 23
          Caption = '&New...'
          TabOrder = 0
          OnClick = BNewClick
        end
        object BDelete: TButton
          Left = 90
          Top = 7
          Width = 75
          Height = 23
          Caption = '&Delete'
          TabOrder = 1
          OnClick = BDeleteClick
        end
      end
    end
  end
end
